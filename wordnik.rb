%w(rubygems wordnik).each {|lib| require lib}

Wordnik.configure do |config|
	config.api_key = ENV['wordnik_key']
end

file = "test.txt"
in_dict = "indict.txt"
not_in_dict = "notindict.txt"

id = File.open(in_dict, "w")
nid = File.open(not_in_dict, "w")

File.open('test.txt', 'r').each do |word|
  unless Wordnik.word.get_definitions(word.strip, :source_dictionaries => "century").empty?
    id.puts "#{word.strip}=\n"
    Wordnik.word.get_definitions(word.strip, :source_dictionaries => "century").each do |definition|
      id.puts "\t#{definition['text']}"
    end
  else
    nid.puts word
  end
end

id.close
nid.close

# Definitions
# Wordnik.word.get_definitions('hysterical')
# Wordnik.word.get_definitions('lemurs', :use_canonical => true)
# Wordnik.word.get_definitions('fish', :part_of_speech => 'verb,noun')
# Wordnik.word.get_definitions('scoundrel', :limit => 20, :source_dictionaries => "ahd,wiktionary,wordnet")