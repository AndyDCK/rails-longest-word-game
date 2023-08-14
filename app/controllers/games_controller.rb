require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = []
    10.times { @letters << ("A".."Z").to_a.sample }
    return @letters
  end

  def word
    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    word_dictionary = URI.open(url).read
    word = JSON.parse(word_dictionary)
    return word['found']
  end

  def letter_in_grid
    @answer.upcase.chars.sort.all? { |letter| @grid.include?(letter) }
  end

  def score
    @grid = params[:grid]
    @answer = params[:word]
    grid_letters = @grid.each_char { |letter| print letter, ''}
    if !letter_in_grid
      @result = "Sorry, but #{@answe.upcase} can't be built out of #{grid_letters}.😒"
    elsif !word
      @result = "Sorry but #{@answer.upcase} does not seem to be a valid word🥱."
    elsif letter_in_grid && !word
      @result = "Sorry but #{@answer.upcase} does not seem to be a valid word.🥱"
    else
      @result = "Congratulation! #{@answer.upcase} is valid🥳."
    end
  end
end
