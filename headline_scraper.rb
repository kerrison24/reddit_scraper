require 'nokogiri'
require 'open-uri'

class HeadlineScraper
	def initialize(url)
		@doc = Nokogiri::HTML(open(url))
	end

	def get_headlines
		@doc.css('a.title')
	end

	def get_headingbox
		@doc.css('.thing')
	end
end