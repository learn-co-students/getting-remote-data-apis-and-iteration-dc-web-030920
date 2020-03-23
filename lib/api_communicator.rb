require 'rest-client'
require 'json'
require 'pry'

# iterate over the response hash to find the collection of `films` for the given
# `character`
def film_urls(response_hash, character)
  films = response_hash["results"].find do |data|
  data["name"] == character
  end
  films["films"]
end

# collect those film API urls, make a web request to each URL to get the info
#  for that film
# return value of this method should be collection of info about each film.
#  i.e. an array of hashes in which each hash reps a given film
def request_films_url(film_urls)
  film_urls.map do |film_url|
  response_string = RestClient.get(film_url)
  response_hash = JSON.parse(response_string)
  end
end

def get_character_movies_from_api(character_name)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)
  urls = film_urls(response_hash, character_name)
  films_hash = request_films_url(urls)
end

# this collection will be the argument given to `print_movies`
# and that method will do some nice presentation stuff like puts out a list
# of movies by title. Have a play around with the puts with other info about a given film.
def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  # films_array = films["films"]
  puts "Titles of Movies"
  films.each_with_index do |film, index|
    puts "*******************"
    puts "#{index+1}. #{film["title"]}" 
    puts "directed by #{film["director"]}"  
  end
end 

def show_character_movies(character)
  puts "Searching for #{character}..."
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS
# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
