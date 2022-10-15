require 'open-uri'

class GamesController < ApplicationController
  def new
    # display a new random grid
    # display input form

    @letters = ('A'..'Z').to_a.sample(9)
  end

  def score
    # use POST to submit form
    # params(word value)
    @word = params[:word]
    @letters = params[:letters]

    @check = check_word(@word, @letters)
    @english = check_validity(@word)
  end

  private

  def check_word(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def check_validity(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
