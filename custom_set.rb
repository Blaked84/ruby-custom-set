require 'byebug'
class CustomSet
  attr_reader :values

  def initialize(enum=nil)
    @values = []
    @values.concat(enum) unless enum.nil?
  end

  def empty?
    @values.empty?
  end

  def member?(arg)
    @values.include?(arg)
  end

  def subset?(custom_set)
    self.values.each do |val|
      return false unless custom_set.member? val
    end
    true
  end

  def disjoint?(custom_set)
    self.values.each do |val|
      return false if custom_set.member? val
    end
    true
  end

  def ==(custom_set)
    self.subset?(custom_set) && custom_set.subset?(self)
  end

  def add(val)
    @values << val unless @values.include? val
    self
  end

  def intersection(custom_set)
    inter = CustomSet.new
    @values.each do |val|
      inter.add(val) if custom_set.member? val
    end
    inter
  end

  def difference(custom_set)
    CustomSet.new((@values.+(custom_set.values)).keep_if { |x| (self.member?(x) && !custom_set.member?(x)) || (!self.member?(x) && custom_set.member?(x))})
    # diff = CustomSet.new
    # @values.each do |val|
    #   diff.add(val) unless custom_set.member? val
    # end
    # diff
  end

  def union2(custom_set)
    to_add = custom_set.values
    union = custom_set
    to_add.each do |val|
      union.add val
    end
    self.values.each do |val|
      union.add val
    end
    union
  end

  def union(cs)
    CustomSet.new(
        self.values.concat(cs.values).uniq
    )
  end
end

class BookKeeping
  VERSION = 1
end