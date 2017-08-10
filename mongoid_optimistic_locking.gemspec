# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mongoid/optimistic_locking/version"

Gem::Specification.new do |s|
  s.name        = "mongoid_optimistic_locking"
  s.version     = Mongoid::OptimisticLocking::VERSION
  s.authors     = ["Alon Burg", "John Nishinaga"]
  s.email       = ["burgalon@gmail.com", "jingoro@casa-z.org"]
  s.homepage    = "https://github.com/burgalon/mongoid_optimistic_locking"
  s.summary     = %q{Allows optimisitic locking for Mongoid models}
  s.description = %q{Allows optimisitic locking for Mongoid models. See https://github.com/burgalon/mongoid_optimistic_locking}

  s.add_dependency 'mongoid', '~> 5.0'
  s.add_development_dependency 'rake', '~> 0.9.0'
  s.add_development_dependency 'rspec', '~> 2.6'

  s.rubyforge_project = "mongoid_optimistic_locking"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
