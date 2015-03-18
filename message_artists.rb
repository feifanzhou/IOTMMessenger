require 'sinatra/activerecord'
require './models/band'
require 'nokogiri'
require 'open-uri'
require 'net/http'
require 'json'

COOKIE = "www_pyrocms=3FK19UxwBk5MfdGCEKAH7RGCFg4TAwB2n%2FojgQ7j%2FBlyXns6V2rudF6z2o9ms4qdd6opKvfADapIBaqdRAa2YmCkRgRWUKyDoXFGnbLeDT9S9637T0MeDeosvyygy04efEcUyI1VqhLDSuvr0M3ESVzsYBCW8dkdWT%2BxcdZmzG%2BqhKOCKLIQTtpBF35HwvwrsCP3C18az8XtLVb4wRFCvnFyryVHexFEBKwYEzEQ7HZ1OpBJFYzJtV9hAtCvCo90DTtVvNdZLL1K%2BzoUXR%2F5R8Tp4OdXPM2CZDzVimetzC%2BhRwCPe3lpZcdQRcq2Rs08p%2BQJOIIoj2UX0Pn12dZ7XfOW4lbe%2Ba%2FO8IR0BG7Z%2F56abIrJuzucTMzobaoxKGkI; www_identity=feifan%40me.com; www_remember_code=5619c9e4fd2ce6562ff1f83b2d1edef3e3b604fd;"
Band.all.each do |band|
  next if band.message_sent
  params[:band_id] = band.band_id
  params[:username] = band.user_name
  params[:subject] = SUBJECT
  params[:message] = MESSAGE
  uri = URI.parse("https://www.indieonthemove.com")
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  request = Net::HTTP::Post.new("/user/#{ band.user_name }")
  request.body = params
  response = http.request(request)
end