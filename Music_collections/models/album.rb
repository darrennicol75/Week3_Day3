require('pg')
require_relative('../models/artist')
require_relative('../db/sql_runner')

class Album

  attr_accessor :genre, :title, :id


  def initialize(musicians)
    @artist_id = musicians['artist_id'].to_i
    @genre = musicians['genre']
    @title = musicians['title']
    @id = musicians['id'].to_i if musicians['id']
  end

  def artist()
      sql = "SELECT * FROM artists
      WHERE id = $1"
      values = [@artist_id]
      results = SqlRunner.run(sql, values)
      artist_hash = results[0]
      artist = Artist.new(artist_hash)
      return artist
    end

  def save()
    sql = "INSERT INTO albums
    (
      artist_id,
      genre,
      title
    ) VALUES
    (
      $1, $2, $3
    )
    RETURNING id"
    values = [@artist_id, @genre,  @title]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end


  def update()
    sql = "UPDATE albums SET
    (
      artist_id,
      genre,
      title
   ) =
   (
     $1,$2,$3
   )
   WHERE id = $4"
   values = [@artist_id, @genre, @title, @id]
   SqlRunner.run(sql, values)
  end

    #I'm not sure how to change individual elements, (line 61) it states from console its upated but not sure what as output is still the same.

  def self.delete_all()
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

  #This deletes all entries to ensure that the database is not repetitive.

  def delete()
    sql = "DELETE FROM albums where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  #The above deletes an invidiual entry in conjunction with line 60 in the console.

  def self.find(id)
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [id]
    results =SqlRunner.run(sql,values)
    order_hash = results[0]
    order = Album.new(order_hash)
    return order
  end

  #The above finds the album requested in line 63 of the console and returns it in the cmd line under ls. 

end
