module Mongoid
  module OptimisticLocking
    module Unlocked
      attr_writer :unlocked

      def unlocked
        @unlocked = true
        self
      end

      def unlocked?
        @unlocked || false
      end
    end
  end
end
