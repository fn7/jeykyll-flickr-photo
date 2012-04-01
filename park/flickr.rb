require 'flickraw'

FlickRaw.api_key="776be23ca583511c4828b1ee4304eb5a"
FlickRaw.shared_secret="eb435af88342eadd"

list = flickr.photos.getRecent

id = list[0].id
secret = list[0].secret

#info = flickr.photos.getInfo :photo_id => id, :secret => secret
info = flickr.photos.getInfo :photo_id => '7020736111'

puts info.title
puts info.dates.taken
p info;
puts '---'

sizes = flickr.photos.getSizes :photo_id => id

#original = sizes.find{|s| puts s.label; s.label == 'Original' }
sizes.each{|s|
  p s;
  puts '---';
}

#puts original.width
