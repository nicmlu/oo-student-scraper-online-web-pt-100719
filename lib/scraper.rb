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
  
# main page: 
# :twitter => 
# :linkedin => 
# :github => 
# :blog =>
# :profile_quote => 
# :bio => 

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    
    profile_page = Nokogiri::HTML(html)
    
    profile_page.css("div.vitals-container div.details-container a").collect do |student|
      student = {:twitter => students.css("div.social-icon-container").attribute("href"), :linkedin => students.css("").text, :github => students.attribute("href").value, :blog => student.attribute("href").value, :profile_quote => student.css("div.profile-quote").text, :bio => student.css("div.bio-block details-block div.bio-content content-holder").text}
    end
    student
  end
  
end

