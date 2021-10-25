class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  attr_accessor :word_with_guesses
  attr_accessor :check_win_or_lose
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
    @guesses=''
    @wrong_guesses=''
    @word_with_guesses=''
    @check_win_or_lose=''
    for i in 0..word.length-1
      @word_with_guesses[i]='-'
    end
  end

  def word_display(guess_word)
    for i in 0..@word.length-1
      if guess_word==@word[i]
        @word_with_guesses[i]=guess_word
      end
    end
    #puts @word_with_guesses
  end
  def check()
    if @word_with_guesses==@word
      @check_win_or_lose=:win
    elsif @guesses.length+@wrong_guesses.length>=7
      @check_win_or_lose=:lose
    else
      @check_win_or_lose=:play
    end
  end

  def guess(guess_word)
    if guess_word=='' or guess_word=='%' or guess_word==nil or !(guess_word=~/[a-zA-Z]/)
      raise ArgumentError
    end
    guess_word=guess_word.downcase
    if word.index(guess_word)
      if @guesses.index(guess_word)
        return false
      else
        @guesses=@guesses+guess_word
        word_display(guess_word)
        check()
      	return true
      end
    else
      if @wrong_guesses.index(guess_word)
        return false
      else
        @wrong_guesses=@wrong_guesses+guess_word
        #word_display(guess_word)
        check()
        return true
      end
    end 
  end
  

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end
