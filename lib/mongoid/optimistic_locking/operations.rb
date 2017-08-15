module Mongoid
  module OptimisticLocking
    module Operations

      def insert(options = {})
        return super unless !unlocked? && valid?
        increment_lock_version do
          super
        end
      end

      def update_document(options = {})
        return super unless !unlocked? && valid?
        raise Errors::ReadonlyDocument.new(self.class) if readonly?
        set_lock_version_for_selector do
          increment_lock_version do
            prepare_update(options) do
              updates, conflicts = init_atomic_updates
              unless updates.empty?
                coll = _root.collection
                selector = atomic_selector
                result = coll.find(selector).update_one(positionally(selector, updates))
                getlasterror = mongo_client.command({:getlasterror => 1})
                if result && !getlasterror.to_a[0]['updatedExisting']
                  raise Mongoid::Errors::StaleDocument.new('update', self)
                end
                conflicts.each_pair do |key, value|
                  coll.find(selector).update_one(positionally(selector, { key => value }))
                end
              end
            end
          end
        end
      end

      def delete(options = {})
        return super unless !unlocked? && persisted?
        # we need to just see if the document exists and got updated with
        # a higher lock version
        existing = _reload # get the current root or embedded document
        if existing.present? && existing['_lock_version'] &&
           existing['_lock_version'].to_i > _lock_version.to_i
          raise Mongoid::Errors::StaleDocument.new('destroy', self)
        end
        super
      end

      def atomic_selector
        result = super
        if !unlocked? && lock_version_for_selector
          key =
            if __metadata && __metadata.embedded?
              path = __metadata.path(self)
              "#{path.path}._lock_version"
            else
              '_lock_version'
            end
          result[key] = lock_version_for_selector
        end
        result
      end

    end
  end
end
