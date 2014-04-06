require 'set'

def adjacent_words(word, dictionary)
  adj_words = []
  word_array = word.split("")
  alpha = ("a".."z").to_a
  word_array.each_with_index do |letter, index|
    alpha.each do |new_letter|
      next if new_letter == letter
      adj_words << (word_array.take(index) + [new_letter] + word_array.drop(index+1)).join
    end
  end

  adj_words.select { |adj_word| dictionary.include?(adj_word)}
end

def intake_dict(file)
  File.readlines(file).map { |word| word.chomp }.to_set
end

def explore_words(source, dictionary)
  words_to_expand = [source]
  all_reachable_words = [source]
  dict = intake_dict(dictionary)
  candidate_words = dict.select { |dict_word| dict_word.length == source.length }

  until words_to_expand.empty?
    word = words_to_expand.pop
    adj_words = adjacent_words(word, candidate_words)

    words_to_expand += adj_words
    all_reachable_words += adj_words
    candidate_words -= adj_words
  end

  all_reachable_words
end

p explore_words("hello", './dictionary.txt')