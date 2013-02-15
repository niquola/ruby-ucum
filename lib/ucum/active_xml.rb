module Ucum
  class ActiveXML
    attr :_xml
    def initialize(xml)
      @_xml = xml
    end

    def self.map_attribute(method_name, attr_name = nil, &block)
      attr_name = attr_name || method_name
      define_method method_name do
	_xml[attr_name]
      end
    end

    def self.map_node(method_name, xpath = nil, attr_name = nil, &block)
      xpath = xpath || method_name.to_s
      define_method method_name do
	node = _xml.xpath(xpath).first
	return nil unless node
	if attr_name
	  res = node[attr_name]
	else
	  res = node.text
	end
	if block_given?
	  block.call(res)
	else
	  res
	end
      end
    end
  end
end
