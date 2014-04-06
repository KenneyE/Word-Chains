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
  File.readlines(file).map { |word| word.chomp }
end

def find_chain(source, target, dictionary)
  words_to_expand = [source]
  parents = {}
  dict = intake_dict(dictionary)
  candidate_words = dict.select! { |dict_word| dict_word.length == source.length }

  until words_to_expand.empty?
    word = words_to_expand.pop
    adj_words = adjacent_words(word, candidate_words)

    adj_words.each do |adj_word|
      parents[adj_word] = word
      break if adj_word == target
      words_to_expand << adj_word
    end
    candidate_words -= adj_words
  end

  all_reachable_words
end

def build_path_from_breadcrumbs

end

p explore_words("cat", './dictionary.txt')