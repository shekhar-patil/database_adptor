require 'pg'
require './lib/my_error'

class Postgres
  #
  # constructor method
  # @params host [String]
  # @params port [String]
  # @params user [String]
  # @params password [String]
  # @params dbname [String]
  #
  def initialize(host, user, password, dbname, port= 5432)
    @host     = host
    @port     = port
    @user     = user
    @password = password
    @dbname   = dbname
  end

  #
  # connects remote postgress database
  # returns PG::Connection if everything works fine
  # returns [actual_raised_error, custom_error_message] if exception is raised
  #
  def connect
    conf = {
      host:     @host,
      port:     @port,
      user:     @user,
      password: @password,
      dbname:   @dbname
    }

    PG.connect(conf)
  rescue StandardError => e
    MyError.new(e).message
  end

  #
  # executes postgres queries
  # return [query_result]
  #
  def execute(conn, query)
    conn.exec(query)
  rescue StandardError => e
    MyError.new(e).message
  end
end
