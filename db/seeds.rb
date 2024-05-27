require "json"
require "open-uri"

puts "Cleaning database..."
Bookmark.destroy_all
Movie.destroy_all

url = "https://tmdb.lewagon.com/movie/top_rated"
movies_serialized = URI.open(url).read
movies = JSON.parse(movies_serialized)

puts "Creating movies..."
movies["results"].each do |result|
  Movie.create!(title: result["title"], overview: result["overview"], poster_url: "https://image.tmdb.org/t/p/w500#{result["poster_path"]}", rating: result["vote_average"])
end
puts "Finished!"
