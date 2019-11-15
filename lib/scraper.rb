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
    scraped_student = Nokogiri::HTML(open(profile_url))
  end

end

