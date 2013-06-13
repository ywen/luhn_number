#!/usr/bin/env ruby

require_relative "classes"

puts LuhnNumber::Output.new(ARGV[0]).result
