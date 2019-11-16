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
    
    profile_page = Nokogiri::HTML(open(profile_url))
    
    student_profile = {}
    
    profile_page.css("div.social-icon-container").xpath("//div/a/@href").each do |icon|
    
    if icon.value.include?("twitter")
       student_profile[:twitter] = icon.value 
    elsif icon.value.include?("linkedin")
      student_profile[:linkedin] = icon.value
    elsif icon.value.include?("github")
      student_profile[:github] = icon.value
    else icon.value.include?("blog")
      student_profile[:blog] = icon.value
    end 
  end 
    
  student_profile[:profile_quote] = profile_page.css("div.vitals-text-container div.profile-quote").text
  student_profile[:bio] = profile_page.css("div.description-holder p").text
  student_profile
  end
end

