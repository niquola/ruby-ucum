require 'rubygems'
$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'..','lib')
require 'bundler'
Bundler.setup
require 'ucum'
Ucum.meta_path = File.dirname(__FILE__) + '/../ucum-essence.xml'
