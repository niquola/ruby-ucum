module Ucum
  # See http://unitsofmeasure.org/trac/
  # The Unified Code for Units of Measure is a code system intended to include all units of measures being contemporarily used in international science, engineering, and business.
  # The purpose is to facilitate unambiguous electronic communication of quantities together with their units.
  # The focus is on electronic communication, as opposed to communication between humans.
  # A typical application of The Unified Code for Units of Measure are electronic data interchange (EDI) protocols, but there is nothing that prevents it from being used in other types of machine communication.
  autoload :ActiveXML, 'ucum/active_xml'

  class << self
    attr_accessor :meta_path

    class Prefix < Ucum::ActiveXML
      map_attribute :code, 'Code'
      map_attribute :coded, 'CODE'
      map_node :name
      map_node :value, 'value', 'value'
      map_node :print_symbol, 'printSymbol'

      def inspect
	"#{self.name}"
      end
    end

    class BaseUnit < Ucum::ActiveXML
      map_attribute :code, 'Code'
      map_attribute :coded, 'CODE'
      map_attribute :dim
      map_attribute :isMetric
      map_attribute :isSpecial
      map_attribute :heat
      map_node :name
      map_node :property
      map_node :print_symbol, 'printSymbol'
      map_node :value, 'value'

      def inspect
	"#{self.name} (#{self.property})"
      end
    end

    def prefixes
      prefix_index.values
    end

    def prefix(name)
      prefix_index[name]
    end

    def base_units
      base_unit_index.values
    end

    def base_unit(name)
      base_unit_index[name]
    end

    def units
      unit_index.values
    end

    def unit(name)
      unit_index[name]
    end

    def meta
      require 'nokogiri'
      @meta ||= Nokogiri::XML(File.read(meta_path))
      .tap do |doc|
	doc.remove_namespaces!
      end
    end


    private

    def prefix_index
      meta.xpath('root/prefix')
      .each_with_object({}) do |node, acc|
	p = Prefix.new(node)
	acc[p.name] = p
      end
    end

    def base_unit_index
      meta.xpath('root/base-unit')
      .each_with_object({}) do |node, acc|
	p = BaseUnit.new(node)
	acc[p.name] = p
      end
    end

    def unit_index
      meta.xpath('root/unit')
      .each_with_object({}) do |node, acc|
	p = BaseUnit.new(node)
	acc[p.name] = p
      end
    end
  end
end
