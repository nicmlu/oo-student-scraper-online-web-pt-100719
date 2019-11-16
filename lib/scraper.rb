require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html")
    
    index_page = Nokogiri::HTML(html)
    
    student_index_array = []
    
    index_page.css("div.roster-cards-container div.student-card a").collect do |students|
      student_index_array << {:name => students.css("h4.student-name").text, :location => students.css("p.student-location").text, :profile_url => students.attribute("href").value}
    end
    student_index_array
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    
    profile_scrape = Nokogiri::HTML(html)
    
    profile_page = profile_scrape.css("div.vitals-container div.details-container a")
    
    {
      :twitter => profile_page.css("div.social-icon-container").attribute("href").value, 
      :linkedin => profile_page.css("div.social-icon-container").attribute("href").value,
      :github => profile_page.css("div.social-icon-container").attribute("href").value,
      :blog => profile_page.css("div.social-icon-container").attribute("href").value,
      :profile_quote => profile_page.css("div.profile-quote").text, 
      :bio => profile_page.css("div.bio-block details-block div.bio-content content-holder").text
    }
  end
end

