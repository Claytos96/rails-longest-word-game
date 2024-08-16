require "open-uri"
class GamesController < ApplicationController
  def new

    @grid = []
    9.times do
      @grid << ('a'..'z').to_a.sample
    end
  end

  def score
    @grid = params[:grid].split(',')
    word = params[:word]
    letters = word.split('')
    grid_check = true
    letters.each do |x|
      t = @grid.include?(x)
      @grid.delete_at(@grid.index(x)) if t == true
      if t == false
        grid_check = false
        break
      end
     end
     url = "https://dictionary.lewagon.com/#{word}"
     user_serialized = URI.open(url).read
     user = JSON.parse(user_serialized)
     if user['found'] == true && grid_check == true
      @result = "Valid word, #{word.length} letters"
     elsif user['found'] == true && grid_check == false
      @result = "Word not in grid"
     else
      @result = "Not real word"
     end
  end
end
