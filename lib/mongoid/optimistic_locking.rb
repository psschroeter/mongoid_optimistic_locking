require 'mongoid'
require 'mongoid/errors/stale_document'
require 'mongoid/optimistic_locking/lock_version'
require 'mongoid/optimistic_locking/operations'
require 'mongoid/optimistic_locking/unlocked'
require 'mongoid/optimistic_locking/version'

# add english load path to translations
I18n.load_path << File.expand_path('../../config/locales/en.yml', __FILE__)

module Mongoid
  # == What is Optimistic Locking
  #
  # See <http://api.rubyonrails.org/classes/ActiveRecord/Locking/Optimistic.html>.
  #
  # == Usage
  #
  # TODO ...
  module OptimisticLocking

    extend ActiveSupport::Concern

    include LockVersion
    include Operations
    include Unlocked

    included do
      field LOCKING_FIELD, :type => Integer, :default => 0
    end

  end
end
