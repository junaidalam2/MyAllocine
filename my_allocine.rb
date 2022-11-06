require 'sqlite3'

=begin 
requests['Display all actors'] = "SELECT * FROM actors;"
requests['Display all genres'] = ""s
requests['Display the name and year of the movies'] = ""
requests['Display reviewer name from the reviews table'] = ""

requests["Find the year when the movie American Beauty released"] = ""
requests["Find the movie which was released in the year 1999"] = ""
requests["Find the movie which was released before 1998"] = ""
requests["Find the name of all reviewers who have rated 7 or more stars to their rating order by reviews rev_name (it might have duplicated names :-))"] = ""
requests["Find the titles of the movies with ID 905, 907, 917"] = ""
requests["Find the list of those movies with year and ID which include the words Boogie Nights"] = ""
requests["Find the ID number for the actor whose first name is 'Woody' and the last name is 'Allen'"] = ""

requests["Find the actors with all information who played a role in the movies 'Annie Hall'"] = ""
requests["Find the first and last names of all the actors who were cast in the movies 'Annie Hall', and the roles they played in that production"] = ""

requests["Find the name of movie and director who directed a movies that casted a role as Sean Maguire"] = ""
requests["Find all the actors who have not acted in any movie between 1990 and 2000 (select only actor first name, last name, movie title and release year)"] = "" 
=end


db = SQLite3::Database.open "movies.db"
db.results_as_hash = true

# requests['Display all actors']
output = db.execute "SELECT * FROM actors;"
# puts output

# requests['Display all genres']
output = db.execute "SELECT * FROM genres;"
# puts output

# requests['Display the name and year of the movies'] = ""
output = db.execute "SELECT mov_title, mov_year FROM movies;"
# puts output

# requests['Display reviewer name from the reviews table'] = ""
output = db.execute "SELECT rev_name FROM reviews;"
# puts output

# requests["Find the year when the movie American Beauty released"] = ""
output = db.execute "SELECT mov_year FROM movies WHERE mov_title = 'American Beauty';"
# puts output

# requests["Find the movie which was released in the year 1999"] = ""
output = db.execute "SELECT mov_title FROM movies WHERE mov_year = 1999;"
# puts output

# requests["Find the movie which was released before 1998"] = ""
output = db.execute "SELECT mov_title FROM movies WHERE mov_year < 1998;"
# puts output

output = db.execute "SELECT rev_name FROM reviews JOIN movies_ratings_reviews ON reviews.id = movies_ratings_reviews.rev_id WHERE movies_ratings_reviews.rev_stars >= 7 ORDER BY reviews.rev_name;"
# puts output

# requests["Find the titles of the movies with ID 905, 907, 917"] = ""
output = db.execute "SELECT mov_title FROM movies WHERE id IN (905, 907, 917);"
# puts output

# requests["Find the list of those movies with year and ID which include the words Boogie Nights"] = ""
output = db.execute "SELECT id, mov_title, mov_year FROM movies WHERE mov_title LIKE '%Boogie%' AND mov_title LIKE '%Nights%';"
# puts output

# requests["Find the ID number for the actor whose first name is 'Woody' and the last name is 'Allen'"] = ""
output = db.execute "SELECT id FROM actors WHERE act_fname ='Woody' AND act_lname = 'Allen';"
# puts output

# requests["Find the actors with all information who played a role in the movies 'Annie Hall'"] = ""
output = db.execute "SELECT actors.id, actors.act_fname, actors.act_lname, actors.act_gender FROM actors, movies, movies_actors WHERE actors.id = movies_actors.act_id AND movies_actors.mov_id = movies.id AND movies.mov_title ='Annie Hall';"
# puts output

# requests["Find the first and last names of all the actors who were cast in the movies 'Annie Hall', and the roles they played in that production"] = ""
output = db.execute "SELECT actors.act_fname, actors.act_lname, movies_actors.role FROM actors, movies_actors, movies WHERE actors.id = movies_actors.act_id AND movies.id = movies_actors.mov_id AND movies.mov_title = 'Annie Hall';"
# puts output

# requests["Find the name of movie and director who directed a movies that casted a role as Sean Maguire"] = ""
output = db.execute "SELECT directors.dir_fname, directors.dir_lname, movies.mov_title FROM movies, directors, movies_actors, directors_movies WHERE directors_movies.dir_id = directors.id AND directors_movies.mov_id = movies.id AND movies.id = movies_actors.mov_id AND movies_actors.role = 'Sean Maguire';"
# puts output

# requests["Find all the actors who have not acted in any movie between 1990 and 2000 (select only actor first name, last name, movie title and release year)"] = ""
output = db.execute "SELECT actors.act_fname, actors.act_lname, movies.mov_title, movies.mov_year FROM actors, movies, movies_actors WHERE actors.id = movies_actors.act_id AND movies_actors.mov_id = movies.id AND (movies.mov_year NOT BETWEEN 1990 AND 2000);"
# puts output

db.close 