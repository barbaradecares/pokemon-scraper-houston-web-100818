require_relative '../bin/environment.rb'
class Pokemon
    attr_accessor :id, :name, :type, :db, :hp

    def initialize(id:, name:, type:, db:, hp: nil)
        @id = id 
        @name = name
        @type = type
        @db = db 
    end
    
    def self.save(name, type, db)
        sql = <<-SQL 
        INSERT INTO pokemon (name, type) VALUES (?, ?)
        SQL
        db.execute(sql, name, type)
    end   
    
    def self.find(id, db)
        sql = <<-SQL
        SELECT * FROM pokemon WHERE id = ?
        SQL
        
        row = db.execute(sql, id)
            new_poke_id = row[0][0]
            new_poke_name= row[0][1]
            new_poke_type = row[0][2]
            new_poke = self.new(id: new_poke_id,name: new_poke_name, type: new_poke_type, db: db)
        
        end

    def alter_hp(hp, db)
        sql = <<-SQL
        UPDATE pokemon SET hp = ? WHERE id = ?
        SQL

        db.execute(sql, hp, self.id)
        #binding.pry
       
    end

end
