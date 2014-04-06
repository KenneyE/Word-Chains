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

def find_chain(source, target, dictionary)
  target.downcase!
  source.downcase!
  words_to_expand = [source]
  parents = {}
  dict = intake_dict(dictionary)
  candidate_words = dict.select { |dict_word| dict_word.length == source.length }

  until words_to_expand.empty? || parents.has_key?(target)
    word = words_to_expand.pop
    adj_words = adjacent_words(word, candidate_words)

    adj_words.each do |adj_word|
      parents[adj_word] = word
    end
    words_to_expand += adj_words
    candidate_words -= adj_words
  end

  build_path_from_breadcrumbs(source, target, parents)
end

def build_path_from_breadcrumbs(source, target, parents)

  unless parents.has_key?(target)
    puts "No link exists."
    return nil
  end

  path = [target]

  p parents[target]
  until path.include?(source)
    parent = parents[target]
    path << parent
    target = parent
  end

  path.reverse
end

p find_chain("hello", "saggy", './dictionary.txt')