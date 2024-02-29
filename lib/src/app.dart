import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' show get;
import 'models/image_model.dart';
import 'widgets/image_list.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppStore();
  }
}

class AppStore extends State<App> {
  int count = 0;
  List<ImageModel> images = [];

  void fetchImage() async {
    count++;
    var url = Uri.parse('https://jsonplaceholder.typicode.com/photos/$count');
    var response = await get(url);
    var imageModel = ImageModel.fromJSON(json.decode(response.body));
    setState(() {
      images.add(imageModel);
    });
  }

  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Let's See Images!"),
          backgroundColor: Colors.blue.shade50,
        ),
        body: ImageList(images),
        floatingActionButton: FloatingActionButton(
          onPressed: fetchImage,
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
