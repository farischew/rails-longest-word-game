require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    if session[:score].nil?
      session[:score] = 0
    end
    @array = []
    10.times { @array << (65 + rand(25)).chr }
  end

  def score
    @input = params[:answer]
    @given = params[:letters]
    @input_array = @input.upcase.split('')
    @given_array = @given.split('')

    @data = check_word(@input)

    @output = check_score(@input_array, @given_array, @input, @data, @given)
  end

  def check_word(input)
    url = "https://wagon-dictionary.herokuapp.com/#{@input}"
    user_attempt = URI.open(url).read
    @data = JSON.parse(user_attempt)
  end

  def check_score(input_array, given_array, input, data, given)
    if (input_array - given_array).any?
      "Sorry but the #{input} cannot be built from #{given}"
    elsif data['found'] == false
      "Sorry but #{input} does not seem to be an English word"
    else
      session[:score] += data['length']
      "Congratulations, you got a score of #{data['length']} letters!"
    end
  end
end
