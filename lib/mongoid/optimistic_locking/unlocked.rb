module Mongoid
  module OptimisticLocking
    module Unlocked

      extend ActiveSupport::Concern

      def unlocked
        Threaded.unlocked = true
        self
      end

      def optimistic_locking?
        Threaded.optimistic_locking?
      end

      def clear_options!
        Threaded.unlocked = false
        self
      end

      module ClassMethods

        def unlocked
          Threaded.unlocked = true
        end

        def clear_options!
          Threaded.unlocked = false
        end

      end

    end
  end
end
