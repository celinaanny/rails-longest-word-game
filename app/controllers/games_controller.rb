require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    alphabet = ('A'..'Z').to_a
    @letters = alphabet.sample(10)
  end

  def score
    @input = params[:question]
    @letters = params[:letters]
    @included = include?(@input, @letters)
    @exists = exist?(@input)
  end

  def include?(input, letters)
    input = input.downcase
    letters = letters.downcase
    input.chars.all? { |letter| input.count(letter) <= letters.count(letter)}
  end
  def exist?(input)
    url = "https://wagon-dictionary.herokuapp.com/#{input.to_sym}"
    info = JSON.parse( open(url).read)
    info[:found]
  end
end
