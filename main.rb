require 'sinatra'
require 'slim'
require 'json'
require 'open-uri'
require 'openssl'

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

get '/donkeykong' do
  @results = []
  (1..100).each do |i|
    @results << donkeykong(i)
  end
  slim :donkeykong
end

get '/roman' do
  slim :roman
end

get '/appnet' do
  appnet_global_feed = 'https://alpha-api.app.net/stream/0/posts/stream/explore/posts'
  begin
    result = JSON.parse(open(appnet_global_feed, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read)
  rescue
    @error = 'Error retrieving global feed.'
  end
  
  unless result.nil?
    @posts = []
    result['data'].each do |post|
      @posts << {username: post['user']['username'], text: post['text']}
    end
  end
  
  slim :appnet
end

helpers do
  def donkeykong(number)
    output = ''
    output << 'Donkey' if number % 3 == 0
    output << 'Kong' if number % 5 == 0
    output = number if output.empty?
    output
  end
end
