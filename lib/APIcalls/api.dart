import 'dart:convert';

import 'package:brewapps/MODELS/now_playing_model.dart';
import 'package:brewapps/MODELS/top_rated.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

class ApiCalls with ChangeNotifier {
  Movie movie;
  Topmovie topmovie;
  Future<Movie> fetchPost() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed'));

    if (response.statusCode == 200) {
      Movie movie = Movie.fromJson(json.decode(response.body));
      for (var e in movie.results) {
        print("Ajay" + e.title);
      }

      return movie;
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<Topmovie> topratedpost() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/top_rated?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed'));

    if (response.statusCode == 200) {
      Topmovie topmovie = Topmovie.fromJson(json.decode(response.body));
      for (var e in topmovie.results) {
        print("AjaAAAAAy" + e.title);
      }

      return topmovie;
    } else {
      throw Exception('Failed to load post');
    }
  }
}
