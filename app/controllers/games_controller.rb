require "open-uri"
require "nokogiri"
require "json"
class GamesController < ApplicationController
  def display
    session[:random_array] = generate
  end

    def generate
      return @random_array = ("a".."z").to_a.sample(7)
    end

  def score
    @random_array = session[:random_array]
    word = params[:word]
    if english_word?(word)
      puts "true its english"
      if matches_grid?(word, @random_array)
        puts "true matches the grid"
        real_word(word) ? @response = "You got it!" : @response = "It's not a real word"
      else
        @response = "It didnt match the grid that you have. :("
      end
    else
      @response = "It is not an english word"
    end
  end

  def matches_grid?(attempt, random_array)
    attempt = attempt.downcase.chars
    random_array.each do |letter|
      attempt.delete_at(attempt.index(letter)) if attempt.include?(letter)
    end
    attempt.empty?
  end

  def english_word?(attempt)
    attempt.match?(/[a-zA-Z]/)
  end

  def real_word(word)
    url = "https://dictionary.lewagon.com/#{word}"
    JSON.parse(URI.open(url).read)["found"]
  end
end
