import 'package:flutter/material.dart';
import 'package:newsapp/data/newsServices.dart';
import 'package:newsapp/models/newsModel.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const MyHomePage(title: ' Haberler'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Articles>articles=[];

  @override
  void initState(){
    NewsService.getNews().then((value){

      setState(() {
        articles=value!;
      });
    });
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            return Card(
              child: Column(
                children: [
                  Image.network(
                      articles[index].urlToImage!),
                   ListTile(
                    leading: Icon(
                      Icons.arrow_drop_down_circle,
                      color: Colors.amber,
                    ),
                    title: Text(
                      articles[index].title!,
                      style: TextStyle(color: Colors.amber),
                    ),
                    subtitle: Text(
                      articles[index].author!,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:   [
                      Text(
                        articles[index].description!,
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                          onPressed: () async {
                           await  launch(articles[index].url!);
                          },
                          child:  Text(
                            'Haber Detayı',
                            style: TextStyle(color: Colors.blue),
                          ))
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
