import 'package:flutter/material.dart';
import 'package:flutter_movie/models/movie.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    super.key,
    required Movie? movie,
  }) : _movie = movie;

  final Movie? _movie;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Card(
          child: Column(
            children: [
              Row(children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Image.network(
                    _movie!.posterUrl != 'N/A'
                        ? _movie!.posterUrl
                        : 'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg',
                    width: 150,
                    height: 230,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        _movie!.title,
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        _movie!.imdbrating,
                        style: const TextStyle(fontSize: 15),
                      ),
                      Text(
                        '${_movie!.rated} ${_movie!.year}  N/A',
                        style: TextStyle(fontSize: 15, color: Colors.black38),
                      ),
                      Column(
                          children: _movie!.genre
                              .map((genre) => Chip(label: Text(genre)))
                              .toList()),
                    ],
                  ),
                ),
              ]),
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Plot:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _movie!.plot,
                      style: TextStyle(fontSize: 15, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cast:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _movie!.actors,
                      style: TextStyle(fontSize: 15, color: Colors.black54),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
