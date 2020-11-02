require "open-uri"

class GamesController < ApplicationController

    def new
        @letters = (0...10).map { ('A'..'Z').to_a[rand(26)] }
    end

    def score
       @word = params[:word].upcase.split("")
       @letters = params[:letters].split.join
       @included = included?(@word, @letters)
       @english_word = english_word?(@word)
    end

    private

    def included?(word, letters)
      word.all? { |letter| word.count(letter) <= letters.count(letter) }
    end
  
    def english_word?(word)
      response = open("https://wagon-dictionary.herokuapp.com/#{params[:word]}")
      json = JSON.parse(response.read)
      json['found']
    end

end
