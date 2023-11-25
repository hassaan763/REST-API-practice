import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rest_api_practice/Models/user_model.dart';
import 'package:http/http.dart' as http;

class Screen3 extends StatefulWidget {
  const Screen3({super.key});

  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {


  List<UserModel> userList=[];

  Future<List<UserModel>> getUserApi()async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode==200){
      for(Map i in data){
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    }else
      {
        return userList;
      }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('screen3'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUserApi(),
              builder: (context,snapshot){
                if(!snapshot.hasData){
                  return CircularProgressIndicator();
                }else{
                  return ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (context,index)
                      {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child:Column(
                              children: [
                                ReuseableRow(title: 'name', value: snapshot.data![index].name.toString()),

                                ReuseableRow(title: 'username', value: snapshot.data![index].username.toString()),

                                ReuseableRow(title: 'email', value: snapshot.data![index].email.toString()),
                                ReuseableRow(title: 'Address', value: snapshot.data![index].address!.city.toString()+
                                    snapshot.data![index].address!.geo!.lat.toString()
                                ),
                                ReuseableRow(title: 'Phone #', value: snapshot.data![index].phone.toString()),
                              ],
                            ),
                          ),
                        );
                      });
                }
              },
            ),
          )
        ],
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value)
        ],
      ),
    );
  }
}
