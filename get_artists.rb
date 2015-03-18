require 'sinatra/activerecord'
require './models/band'
require 'nokogiri'
require 'open-uri'
require 'net/http'
require 'json'

# ARTIST_COUNT = 36270
ARTIST_COUNT = 14
(0..ARTIST_COUNT).step(15) do |i|
  p "Processing artists starting at #{ i }"
  # url = "https://www.indieonthemove.com/bands#url=page/#{ i }"
  uri = URI.parse("https://www.indieonthemove.com")
  path = "/bands/index/page/#{ i }"
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  request = Net::HTTP::Post.new(path)
  request["Accept"] = "application/json, text/javascript, */*; q=0.01"
  request["Referer"] = "https://www.indieonthemove.com/bands"
  request["User-Agent"] = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:35.0) Gecko/20100101 Firefox/35.0"
  request["X-Requested-With"] = "XMLHttpRequest"
  response = http.request(request)
  # p JSON.parse(response.body)["table"]

  data = Nokogiri::HTML(JSON.parse(response.body)["table"])
  marker_json = data.css('#marker_json').text
  marker_json = marker_json[marker_json.index('{')...marker_json.index(';')]
  parsed_json = JSON.parse(marker_json)
  parsed_json.each do |k, v|
    band_id = k.to_i
    band_name = v['title']
    username = v['url'].split('/')[2]
    Band.create(band_id: band_id, name: band_name, user_name: username)
  end
end