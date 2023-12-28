require 'http'
require 'json'
require 'tty-prompt'


BASE_URL = 'https://api.nytimes.com/svc/books/v3/lists/full-overview.json'

response = HTTP.get("#{BASE_URL}?api-key=#{ENV['API_KEY']}")

if response.code == 200
  data = JSON.parse(response.body)
  lists = data['results']['lists']

  prompt = TTY::Prompt.new
  choices = lists.map { |list| { name: list['list_name'], value: list } }
  
  selected_list = prompt.select('Select a book list:', choices)

  selected_list['books'].each do |book|
    puts "Title: #{book['title']}"
    puts "Author: #{book['author']}"
    puts "Description: #{book['description']}"
    puts "Publisher: #{book['publisher']}"
    puts '----------------------'
  end
else
  puts "Error: #{response.code}, #{response.body}"
end


