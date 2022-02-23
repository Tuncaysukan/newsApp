import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsapp/models/News.dart';
import 'package:newsapp/models/newsModel.dart';

class NewsService {
  static NewsService _singleton = NewsService._internal();
  NewsService._internal();
  factory NewsService() {
    return _singleton;
  }

  static Future<List<Articles>?> getNews() async {
    String adress =
        'https://newsapi.org/v2/top-headlines?country=tr&apiKey=389a295e4afb4e90b213ec619e568073';
    final response = await http.get(Uri.parse(adress));

    if (response.body.isNotEmpty) {
      final responseJson = jsonDecode(response.body);
      print(responseJson);
      News haber = News.fromJson(responseJson);
      print(haber);
      return haber.articles;
    }
    return null;
  }
}
