def adjacent_words(word, dictionary)
  dictionary.select! { |dict_word| dict_word.length == word.length }

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

dict = intake_dict('./dictionary.txt')
p adjacent_words("test", dict)