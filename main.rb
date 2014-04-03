require 'csv'
require 'mailgun'
require_relative 'headline_scraper'

#email client
Mailgun.configure do |config|
  config.api_key = 'key-9u1wnwp8c6d-5lby830nm6xz8gaixik7'
  config.domain  = 'sandbox92031.mailgun.org'
end
@mailgun = Mailgun()


#web scraper
the_scraper = HeadlineScraper.new('http://www.reddit.com/r/ruby/')

CSV.open("reddit_headlines.csv", "w") do |csv|
  csv << ["TOP RECENT RUBY POSTS OF TODAY"]
	csv << ["","HEADLINE", "LINK", "SCORE", "NUMBER OF COMMENTS"]
	the_scraper.get_headingbox.each do |heading_box|
       	csv << [heading_box.css('.rank').first.content, 
                heading_box.css('a.title').first.content,
                heading_box.css('a.title').first["href"],
                heading_box.css('.score').first.content, 
                heading_box.css('a.comments').first.content]
    end
end


#sending email with csv attached
parameters = {
  :to => "email@gmail.com",
  :subject => "Recent /r/ruby posts",
  :text => "Here is the most recent 25 posts from reddit/r/ruby. It contains the title, link of the thread or article, number of upvotes and number of comments.",
  :from => "kerrisongarcia@sandbox92031.mailgun.org",
  :attachment => File.open("reddit_headlines.csv")
}
@mailgun.messages.send_email(parameters)
