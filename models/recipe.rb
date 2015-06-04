require 'pg'
require 'pry'


def db_connection
  begin
    connection = PG.connect(dbname: "recipes")
    yield(connection)
  ensure
    connection.close
  end
end

class Recipe

  def initialize
    @recipes = recipe_list
  end

  def self.all
    recipe_list = []
    db_connection do |conn|
      recipe_list = conn.exec("SELECT * FROM recipes LIMIT 50")
      binding.pry
      recipes = []
      recipe_list.each do |item|
        Recipe.new
      end
      []
    end
  end

  def name
    #pseudo
  end

  def id
    #pseudo
  end

end




# Recipe.all
#
# new_test = Recipe.new
# puts new_test.recipes.to_a




  # class << self
  #   def all
  #   end
  # end
