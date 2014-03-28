require 'nokogiri'
require 'open-uri'


doc = Nokogiri::HTML(open('http://www.reddit.com/r/ruby/'))

doc.css('a.title').each do |heading|
	puts heading.content
end