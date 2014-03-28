require 'csv'
require 'nokogiri'
require 'open-uri'
require_relative 'headline_scraper'



the_scraper = HeadlineScraper.new('http://www.reddit.com/r/ruby/')


CSV.open("reddit_headlines.csv", "w") do |csv|
	csv << ["HEADLINE", "LINK", "SCORE"]
	the_scraper.get_headlines_score.each do |heading_box|
       	csv << [heading_box.css('a.title').first.content,heading_box.css('a.title').first["href"],heading_box.css('.score').first.content]
    end
end

