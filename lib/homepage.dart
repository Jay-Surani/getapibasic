import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'modelpage.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  List<SamplePost> samplePost = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: samplePost.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 130,
                    color: Colors.greenAccent,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("User Id: ${samplePost[index].userId}"),
                        Text("Id: ${samplePost[index].id}"),
                        Text("Title: ${samplePost[index].title}",maxLines: 1,),
                        Text("Body: ${samplePost[index].body}",maxLines: 1,),
                      ],
                    ),
                  );
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Future<List<SamplePost>> getData() async {
    final responce =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(responce.body.toString());
    if (responce.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        samplePost.add(SamplePost.fromJson(index));
      }
      return samplePost;
    } else {
      return samplePost;
    }
  }
}
