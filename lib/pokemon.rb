class Pokemon

attr_accessor :name, :type, :id
attr_reader :db

def initialize(name:, type:, db:, id: nil)
    @name = name
    @type = type
    @id = id
    @db = db
end

def self.save(name, type, db)
    pokemon = self.new(name: name, type: type, db: db)
    sql = <<-SQL
        INSERT INTO pokemon (name, type)
        VALUES (?, ?)
    SQL
    db.execute(sql, name, type)
    pokemon.id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
end

def self.find(num, db)
    array = db.execute("SELECT * FROM pokemon WHERE id = ?", num)[0]
    id = array[0]
    name = array[1]
    type = array[2]
    self.new(name: name, type: type, db: db, id: id)
end

end
