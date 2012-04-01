require 'flickraw'
require 'cgi'
require 'pit'

config = Pit.get('flickr.com')

FlickRaw.api_key=config['api_key']
FlickRaw.shared_secret=config['shared_secret']

module Jekyll
  class FlickrPhotoTag < Liquid::Tag
    def initialize(tag_name, text, tokens)
      if text =~ /(?<photo_id>\S+)\s(?<size>\S+)/;
        @photo_id = $~['photo_id']
        @size = $~['size']
      end
      super
    end
    def render(context)
      info = flickr.photos.getInfo :photo_id => @photo_id
      sizes = flickr.photos.getSizes :photo_id => @photo_id
      title = CGI.escapeHTML info.title
     
      page_url = info.urls[0]._content
      size = sizes.find{|s| s.label == @size }
      if size 
        photo_url = size.source
        <<-HTML
<p>
  <a href="#{page_url}"><img src="#{photo_url}" alt="#{title}" /></a><br />
  <a href="#{page_url}">#{title}</a><br />
</p>
        HTML
      else
        available = sizes.map{|s| s.label }.join(', ');
        <<-HTML
<p>
  <a href="#{page_url}">#{title}</a><br />
  size: #{available}
</p>
        HTML
      end
    end
  end
end

Liquid::Template.register_tag('flickr', Jekyll::FlickrPhotoTag)
