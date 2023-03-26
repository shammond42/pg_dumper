# frozen_string_literal: true

require_relative "pg_dumper/version"

module PgDumper
  class Error < StandardError; end
  
  require 'my_gem/railtie' if defined?(Rails)
end
