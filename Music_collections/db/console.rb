require("pry")
require_relative("../models/album")
require_relative("../models/artist")

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({'name' => 'Bob Dylan'})
artist1.save()

artist2 = Artist.new({'name' => 'Jimi Hendrix'})
artist2.save()

artist3 = Artist.new({'name' => 'Elton John'})
artist3.save()

all_artists = Artist.all()

album1 = Album.new ({
  'artist_id' => artist1.id,
  'genre' => 'folk_rock',
  'title' => 'Times are a changing'
  })

album1.save()

album2 = Album.new ({
  'artist_id' => artist2.id,
  'genre' => '60s_rock',
  'title' => 'Along the watch tower'
  })

album2.save()

album3 = Album.new ({
  'artist_id' => artist2.id,
  'genre' => '60s_rock',
  'title' => 'Voodoo Child'
  })

album3.save()

album4 = Album.new ({
  'artist_id' => artist1.id,
  'genre' => 'folk_rock',
  'title' => 'Tamboreen_Man'
  })

album4.save()

album5 = Album.new ({
  'artist_id' => artist3.id,
  'genre' => 'popular',
  'title' => 'Rocket Man'
  })

album5.save()


album5.delete()
album4.update()

returned_album = Album.find(230)

binding.pry
nil
