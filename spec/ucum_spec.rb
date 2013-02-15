require 'spec_helper'

describe Ucum do
  subject { Ucum }

  it "prefix" do
    puts "prefixes units"
    p subject.prefixes

    subject.prefixes.should_not be_empty
    pr =  subject.prefix('deci')
    pr.name.should == 'deci'
    pr.code.should == 'd'
    pr.value.should == '1e-1'
    pr.print_symbol.should == 'd'
  end

  it "base_unit" do
    puts "base units"
    p subject.base_units

    bu = subject.base_unit('second')
    bu.name.should == 'second'
    bu.print_symbol.should == 's'
    bu.property.should == 'time'
  end

  it "unit" do
    p subject.units
    puts "units"
    bu = subject.unit('degree Fahrenheit')
    p bu
  end
end
