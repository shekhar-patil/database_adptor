require 'rspec'
require 'pry'
require './lib/postgres'

describe Postgres do
  let (:conf) do
    [
      'ec2-54-158-190-214.compute-1.amazonaws.com',
      'cbiqfkhkpxqrvh',
      '8e40d404f011a1df6694bc94937719216b262c06278d09f83548b629fa7e01b8',
      'd2v7s2k8a202dq',
      5432
    ]
  end

  context '#initialize' do
    it 'should be of postgres class' do
      pg = Postgres.new(*conf)

      expect(pg).to be_a Postgres
    end
  end

  context '#connect' do
    it 'should return connection object' do
      conn = Postgres.new(*conf).connect

      expect(conn).to be_a PG::Connection
    end

    it 'should return error for wrong credentials' do
      conf = ['abc', 'abc', 'abc', 'abc', 5432]
      conn = Postgres.new(*conf).connect

      expect(conn).to be_a Array
      expect(conn[1]).to eq 'Actual thrown error is:'
    end
  end

  context '#execute' do
    it 'should execute query' do
      pg = Postgres.new(*conf)
      conn = pg.connect
      binding.pry
      query_str = 'SELECT email FROM users;'

      expect(pg.execute(conn, query_str).to_a).to include({'email'=> 'shekhar+admin@gmail.com'})
    end
  end
end
