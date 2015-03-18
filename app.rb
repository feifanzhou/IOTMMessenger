require 'sinatra'
require 'sinatra/activerecord'
require './config/environments'
require './models/band'

get '/' do
  "Hello World"
end