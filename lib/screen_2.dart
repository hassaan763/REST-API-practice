import 'dart:convert';
import 'package:rest_api_practice/Models/photos_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {

  List<Photos> photosList = [] ;
  Future<List<Photos>> getPhotos()async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data= jsonDecode(response.body.toString());
    if(response.statusCode==200){
      for(Map i in data) {
        Photos photos = Photos(title: i['title'], url: i['url'],ID: i['id']);
        photosList.add(photos);
      }
      return photosList;
    }
    else
    {
    return photosList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('screen2'),
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: getPhotos(),
                  builder: (context,AsyncSnapshot <List<Photos>> snapshot){
                return ListView.builder(
                    itemCount: photosList.length,
                    itemBuilder: (context,index){
                  return ListTile(
                    style: ListTileStyle.list,
                    subtitle: Text(snapshot.data![index].ID.toString()),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                    ),
                    title: Text(

                      snapshot.data![index].title.toString()
                  ) ,);
                });
              }),
            )
          ],
        ),
      ),
    );
  }
}

class Photos{
  String title,url;
  int ID ;
  Photos({
    required this.title,
    required this.ID,
    required this.url});
}