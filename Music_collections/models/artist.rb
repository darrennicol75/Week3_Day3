require('pg')
require_relative("../db/sql_runner")
require_relative("../models/album")

class Artist

attr_reader :id
attr_accessor :name

  def initialize(musicians)
    @id = musicians['id'].to_i if musicians['id']
    @name = musicians['name']
  end

  def albums()
    sql = "SELECT * FROM albums WHERE customer_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    musicians = results.map{|musician| Album.new(musician)}
    return musicians
  end

  def save()
    sql = "INSERT INTO artists (name) VALUES ($1) RETURNING *"
    values = [@name]
    result = SqlRunner.run(sql, values)
    id_string = result[0]['id']
    @id = id_string.to_i
  end

  def self.delete_all()
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end

  # def self.all()
  #   sql = "SELECT * FROM artists"
  #   artist_hashes = SqlRunner.run(sql)
  #   artist_objects = artist_hashes.map{|person| Artist.new(person)}
  #  return artist_objects
  # end

  def self.all()
    sql = "Select * FROM artists;"
    all_artists =SqlRunner.run(sql)
    return all_artists.map{ |person| Artist.new(person)}
  end

end
