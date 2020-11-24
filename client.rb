require './lib/my_error'
require './lib/postgres'
require 'pry'

class Client
  # getter and setter method to update wrong attributes
  attr_accessor :user, :password, :host, :dbname, :port

  # constructor method
  def initialize(host = '', user = '', password = '', dbname = '')
    @host     = host
    @user     = user
    @password = password
    @dbname   = dbname
    @port     = 5432
  end

  def get_adaptor(adaptor = 'Postgres')
    conf = [host, user, password, dbname, port]

    Object.const_get(adaptor).new(*conf)
  end
end

# In future we can add more adpator to connect different database

puts 'Enter user'
user = gets.chomp

puts 'Enter password'
password = gets.chomp

puts 'Enter host path'
host = gets.chomp

puts 'Enter database name'
dbname = gets.chomp

client = Client.new(host, user, password, dbname)
pg = client.get_adaptor('Postgres')

connect = pg.connect
if Array === connect && connect[1] == 'Actual thrown error is:'
  return (puts "#{connect[1]}: #{connect[0]}")
end

puts "\n\n\nConnection is established!"

retry_attempt = true
while(retry_attempt)
  puts "Enter postgres query\n\n"
  query = gets.chomp

  puts pg.execute(connect, query).to_a

  puts '\nDo you want to continue y/n'
  input = gets.chomp

  retry_attempt = (input == 'y' || input == 'Y')
end

