# Add a declarative step here for populating the DB with movies.


number = 0
Given /the following movies exist/ do |movies_table|
    number = 0
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
    
    number = number + 1
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  page.body =~ /#{e1}.+#{e2}/m 
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.delete!("\"")
  if uncheck.nil?
    rating_list.split(", ").each do |rating|
      check("ratings["+rating.strip+"]")
    end
  else
    rating_list.split(',').each do |rating|
      uncheck("ratings["+rating.strip+"]")
    end
  end
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  
end

Then /I should see all the movies/ do
  page.should have_css("table#movies tbody tr",:count => number.to_i)
  # Make sure that all the movies in the app are visible in the table
  
end
