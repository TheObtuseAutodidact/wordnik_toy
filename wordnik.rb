%w(rubygems wordnik).each {|lib| require lib}

Wordnik.configure do |config|
	config.api_key = ENV['wordnik_key']
end

file = "test.txt"
in_dict = "indict.txt"
not_in_dict = "notindict.txt"

f = File.open(file, "r")
id = File.open(in_dict, "w")
nid = File.open(not_in_dict, "w")


f.each_line do |word|
    if Wordnik.word.get_definitions(word, :source_dictionaries => "century")[0]
      id.puts "#{word}: #{Wordnik.word.get_definitions(word, :source_dictionaries => "century")[0]["text"]}"
    else
      nid.puts word
    end
end

f.close
id.close
nid.close

# Definitions
# Wordnik.word.get_definitions('hysterical')
# Wordnik.word.get_definitions('lemurs', :use_canonical => true)
# Wordnik.word.get_definitions('fish', :part_of_speech => 'verb,noun')
# Wordnik.word.get_definitions('scoundrel', :limit => 20, :source_dictionaries => "ahd,wiktionary,wordnet")