# frozen_string_literal: true

require 'thor'
require 'net/http'
require 'json'
require 'date'

class WeatherApi < Thor

  API_KEY="41b9199f9c6cb90538ef26c71b7b68a3"

  desc "get_weather", "an example"
  desc "api_response", "an example"
  desc "get_weather", "an example"
  desc "goecode_city", "an example"
  method_option :city, aliases: '-c', desc: 'gets the weather of a given city'

  def get_weather=(city)
    puts "****************** Hello you will get the weather of #{city} ******************"

    data = api_response(city) 

    unless data.dig('data')&.dig('weather')
      puts 'the weather is not available'
      return
    end

    main_temper = data.dig('data')&.dig('weather')[0].dig('main')
    description = data.dig('data')&.dig('weather')[0].dig('description')

    puts "The weather tommorw in #{city} will be mainly #{main_temper} with #{description}"
  end


  def api_response(city_name)
    lat, lon = goecode_city(city_name)

    get_weather(lat,lon)
  end

  def get_weather(lat, lon)
    date = (Date.today + 1).iso8601 
    url = "https://api.openweathermap.org/data/3.0/onecall?lat=#{lat}&lon=#{lon}&date=#{date}&appid=#{API_KEY}"
    response = Net::HTTP.get(URI(url))
    parsed_response = JSON.parse(response)
  end


  def goecode_city(city_name)
    url = "http://api.openweathermap.org/geo/1.0/direct?q=#{city_name}&limit=1&appid=#{API_KEY}"
    response = Net::HTTP.get(URI(url))
    parsed_response = JSON.parse(response)

    [parsed_response[0].dig('lat'), parsed_response[0].dig('lon')]
  end
end

