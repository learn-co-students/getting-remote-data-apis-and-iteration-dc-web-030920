     require 'rest-client'
require 'json'
require 'pry'
require 'rest-client'

# def web_request
#   response_string = RestClient.get('http://www.swapi.co/api/people/')
#   response_hash = JSON.parse(response_string)
# end 

def get_character_movies_from_api(character_name)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)
  # response_hash = web_request
  # iterate over the response hash to find the collection of `films` for the given
  #   `character`

  character_info = response_hash["results"].find{|data| data["name"] == character_name}
    # binding.pry
  film_info = character_info["films"].map do |film|
     url_response = RestClient.get(film)
    #  binding.pry
     hash_of_response = JSON.parse(url_response)
    #  puts hash_of_response["title"]
  end
    
# def film_info
# #   character_info = get_character_movies_from_api(character)
# #   film_info = character_info["films"].map do |film|
# #     url_response = RestClient.get(film)
# #    #  binding.pry
# #     hash_of_response = JSON.parse(url_response)
# #    #  puts hash_of_response["title"]
# #  #    binding.pry
# end
    



  # binding.pry
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
end

def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  # films.each {|film| puts film["title"]}
  # films.map {|film| film["title"]}.join(\n)
  # films.map {|film| film["title"]}.lines.map(&:chomp)
  thing = films.map {|film| film["title"]}
  i = 0
  while i < thing.length do
    puts thing[i]
    i += 1
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
