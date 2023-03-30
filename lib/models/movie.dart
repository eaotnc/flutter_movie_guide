class Movie {
  final String title;
  final String year;
  final String posterUrl;
  final String imdbrating;
  final String rated;
  final List<String> genre;
  final String director;
  final String actors;
  final String plot;

  Movie({
    required this.title,
    required this.year,
    required this.posterUrl,
    required this.rated,
    required this.genre,
    required this.director,
    required this.actors,
    required this.imdbrating,
    required this.plot,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['Title'],
      year: json['Year'],
      posterUrl: json['Poster'],
      rated: json['Rated'],
      imdbrating: json['imdbRating'],
      genre: (json['Genre']).split(','),
      director: json['Director'],
      actors: json['Actors'],
      plot: json['Plot'],
    );
  }
}
