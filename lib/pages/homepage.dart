import 'package:flutter/material.dart';
import 'package:news_app/models/newsInfo.dart';
import 'package:news_app/services/api_manager.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<NewsModel> _newsModel;

  @override
  void initState() {
    _newsModel = API_Manager().getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
        centerTitle: true,
      ),
      body: Container(
        child: FutureBuilder<NewsModel>(
          future: _newsModel,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.articles!.length,
                  itemBuilder: (context, index) {
                    var article = snapshot.data!.articles![index];
                    // var formattedTime = DateFormat('dd MMM - HH:mm')
                    //     .format(article.publishedAt);
                    return Container(
                      height: 100,
                      margin: const EdgeInsets.all(8),
                      child: Row(
                        children: <Widget>[
                          Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: AspectRatio(
                                aspectRatio: 1,
                                child: Image.network(
                                  article.urlToImage.toString(),
                                  fit: BoxFit.cover,
                                )),
                          ),
                          SizedBox(width: 16),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // Text(formattedTime),
                                Text(
                                  article.title.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  article.description.toString(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            } else
              return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
