import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_movie/MovieCard.dart';
import 'package:flutter_movie/models/movie.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:loading_elevated_button/loading_elevated_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorSchemeSeed: Color.fromARGB(255, 255, 251, 0),
          useMaterial3: true),
      home: const MyHomePage(title: 'Movie Guide'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MovieScreen(),
    );
  }
}

class MovieScreen extends StatefulWidget {
  const MovieScreen({
    super.key,
  });

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  String searchTitle = '';
  bool isLoading = false;
  bool submiting = false;
  Movie? _movie;

  Future<void> _fetchData() async {
    try {
      setState(() {
        isLoading = true;
      });
      final response = await http.get(
        Uri.parse('http://www.omdbapi.com/?apikey=535eb641&t=$searchTitle'),
      );
      if (response.statusCode == 200) {
        final jsonMap = jsonDecode(response.body);

        setState(() {
          _movie = Movie.fromJson(jsonMap);
          isLoading = false;
        });
        print(_movie!.genre);
      }
    } catch (e) {
      print(e);
      setState(() {
        _movie = null;
      });
    } finally {
      setState(() {
        submiting = true;
        isLoading = false;
      });
    }
  }

  void handleChangeTitle(value) {
    print(value);
    setState(() {
      searchTitle = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.all(20),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 40,
                          width: 230,
                          child: TextField(
                            onEditingComplete: () {
                              print('onEditingComplete:');
                              _fetchData();
                            },
                            onChanged: (text) {
                              if (text != '') {
                                print(text);
                                handleChangeTitle(text);
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 30),
                        const Icon(
                          Icons.search,
                          color: Colors.black45,
                          size: 30.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (_movie != null && searchTitle != '')
                MovieCard(movie: _movie)
              else if (searchTitle == '')
                Card(
                  margin: EdgeInsets.all(30),
                  elevation: 0,
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  child: SizedBox(
                    width: double.infinity - 30,
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Text(
                            'Movie Guid App',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.black54),
                          ),
                          Text('Please enter your movie name',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.black87)),
                        ],
                      ),
                    )),
                  ),
                )
              else if (_movie == null && submiting == true)
                Card(
                  margin: EdgeInsets.all(30),
                  elevation: 0,
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  child: const SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: Center(child: Text('No Movie Found')),
                  ),
                )
              else if (isLoading == true)
                Card(
                  margin: EdgeInsets.all(30),
                  elevation: 0,
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  child: const SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: Center(
                        child: Text(
                      'Loading',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.black54),
                    )),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
