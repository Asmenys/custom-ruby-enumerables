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
  


end

%w[ant bear cat].my_all?(/t/)
binding.pry
arr=[1,2,3]
something = 'something'