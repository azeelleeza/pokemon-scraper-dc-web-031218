require "pry"
class Pokemon
attr_accessor :name, :type, :db, :id

def initialize(poke)
  @name = poke[:name]
  @type = poke[:type]
  @db = poke[:db]
end


def self.save(name,type,db)
  @db = SQLite3::Database.new('db/pets.db')
  db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)",name, type)
  @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
end

def self.find(id,db)
  poke = db.execute("SELECT * FROM pokemon WHERE id = ?",id)[0]
  found = new({:name => poke[1],:type => poke[2], :db => @db})
  found.id = id
  found
end


end
