import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Screen4 extends StatefulWidget {
  const Screen4({super.key});

  @override
  State<Screen4> createState() => _Screen4State();
}

class _Screen4State extends State<Screen4> {
  var data;
  Future<void> getUserApi()async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if(response.statusCode==200){
       data =jsonDecode(response.body.toString());
    }else {
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('screen4'),backgroundColor: Colors.blue,),
        body: Column(
          children: [
            Expanded(
                child: FutureBuilder(
                  future: getUserApi(),
                    builder: (context,snapshot){

                    if(snapshot.connectionState==ConnectionState.waiting){
                      return Text('loading');
                    }else{
                      return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context ,index){
                        return Card(
                          child: Column(
                            children: [
                              ReuseableRow(title: 'name', value: data[index]['name'].toString()),
                              ReuseableRow(title: 'username', value:data[index]['username'].toString()),
                              ReuseableRow(title: 'location', value: data[index]['address']['street'].toString()),
                            ],
                          ) ,
                        );
                      });
                    
                    
                    
                    
                    
                    }})
            )
          ],
        ),
      ),
    );
  }
}


class ReuseableRow extends StatelessWidget {

  String title,value;
  ReuseableRow({super.key, required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween ,
        children: [
          Text(title),
          Text(value)
        ],
      ),
    );
  }
}
