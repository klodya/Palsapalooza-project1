require_relative('../db/sql_runner')

class client

attr_reader :id, :name

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO clients (name) VALUES ('#{@name}') RETURNING *"
    client = SqlRunner.run(sql).first
    @id = client['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM clients"
    return Client.map_items(sql)
  end

  def self.map_items(sql)
    clients = SqlRunner.run(sql)
    result = clients.map {|client| Client.new( client )}
    return result
  end

  def self.map_item(sql)
    result = Client.map_items(sql)
    return result.first
  end

end
