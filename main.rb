require 'sinatra'
require 'slim'

class Integer
  def to_roman
    raise RangeError, 'no roman numeral for this' if (self <= 0 || self >= 5000)
    raise NotImplementedError if self > 400
    
    n = self
    output = ''
    while n > 0
      if n >= 100 then output << 'C'; n -= 100
      elsif n >= 90 then output << 'XC'; n -= 90
      elsif n >= 50 then output << 'L'; n -= 50
      elsif n >= 40 then output << 'XL'; n -= 40
      elsif n >= 10 then output << 'X'; n -= 10
      elsif n >= 9 then output << 'IX'; n -= 9
      elsif n >= 5 then output << 'V'; n -= 5
      elsif n >= 4 then output << 'IV'; n -= 4
      else output << 'I'; n -= 1
      end
    end
    output
  end
end


get '/' do
  slim :index
end
