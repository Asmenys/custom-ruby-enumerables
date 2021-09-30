# frozen_string_literal: false

require 'pry-byebug'

# shut up
module Enumerable
  def my_each
    if block_given?
      ary = self
      for i in ary
        yield i
      end
    end
  end

  def my_each_with_index
    if block_given?
    ary = self
    for i in ary
      yield i, ary.index(i)
    end
    else
      'No block given'
    end
  end

  def my_select
    ary = self
    result = []
    ary.my_each do |member|
      result << member unless yield(member).nil? || yield(member) == false
    end
    result
  end

  def my_all?(*argument)
    ary = self
    if block_given?
      result = true
      ary.my_each do |member|
        if yield(member) == false || yield(member).nil?
          result = false
          break
        end
      end
    else
      if argument[0].nil?
        result = ary.my_all?{|member| member == nil}
      else
        case argument[0].class.name
          in 'Regexp'
            result = ary.my_all? {|member| argument[0].match?(member)}
        else result = ary.my_all? {|member| member.is_a?(argument[0])}
        end
      end
    end
    result
  end
  
  def my_any?(*argument)
    result = false
    ary = self
    if block_given?
      ary.my_each do |value|
        if yield(value) == true
          result = true
          break
        end
      end
    else
      if argument[0].nil?
        result = ary.my_any?{|member| member == nil}
      else
        case argument[0].class.name
          in 'Regexp'
            result = ary.my_any? {|member| argument[0].match?(member)}
        else result = ary.my_any? {|member| member.is_a?(argument[0])}
        end
      end
    end
    result
  end

  def my_none?(*argument)
    result = true
    ary = self
    if block_given?
      ary.my_each do |value|
        if yield(value) == true
          result = false
          break
        end
      end
    else
      if argument[0].nil?
        result = ary.my_any?{|member| member == nil}
      else
        case argument[0].class.name
          in 'Regexp'
            result = ary.my_none? {|member| argument[0].match?(member)}
        else result = ary.my_none? {|member| member.is_a?(argument[0])}
        end
      end
    end
    result
  end

  def my_count(*argument)
    result = 0
    ary = self
    if block_given?
      ary.my_each do |value|
        if yield(value) == true
          result+=1
        end
      end
    else
      if argument[0].nil?
        result = ary.length
      else
        result = ary.my_count{|value| value == argument[0] }
      end
    end
    result
  end

  def my_map
    result = []
    ary = self
    if block_given?
      ary.my_each do |memeber|
        result << yield(member)
      end
    end
    result
  end

  def my_inject(*argument)
    result = 0
    ary = self.to_a
    if block_given?
      if argument[0].nil?
        temp_result = ary.shift
      else
        temp_result = argument[0]
      end
      ary.each do |member|
       temp_result = yield(temp_result, member)
      end
      result = temp_result
    end
    result
  end

end

binding.pry 

something = 'something'