require 'sinatra'

get '/' do
  "Hello Heather"
end

get'/secret' do
  "Shhhhhhhhh!"
end

get '/sleepy' do
  "So tired"
end
