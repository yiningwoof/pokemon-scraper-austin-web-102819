class Pokemon

    attr_accessor :id, :name, :type, :db

    def initialize(name:, type:, db:, id: nil)
        @id = id
        @name = name
        @type = type
        @db = db
    end

    def self.save(name, type, db)
        new_pokemon = Pokemon.new(name: name, type: type, db: db)
        sql = 
        <<-SQL
        insert into pokemon(name, type)
        values(?, ?)
        SQL
        db.execute(sql, name, type)
        new_pokemon.id = db.execute("select last_insert_rowid() from pokemon")[0][0]
    end

    def self.find(id, db)
        sql = 
        <<-SQL
        select * from pokemon where id = ?
        SQL
        row = db.execute(sql, id)[0]
        new_pokemon = self.new(name: row[1], type: row[2], id: row[0], db: db)
    end

end
