import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      theme: ThemeData(
     
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Home Page'),
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

Future<List<Countries>> _getCountries() async {
  var data =await http.get(Uri.parse('https://countriesnow.space/api/v0.1/countries/info?returns=currency,flag,unicodeFlag,dialCode'));
  var jsonData =json.decode(data.body);
  List<Countries> country=[];
  for(var i in jsonData){
    Countries countries=Countries(i['name'],i['currency'],i['unicodeFlag'],i['flag'],i['dialcode']);
    country.add(countries);
  }
  return country;
}
 
  @override
  Widget build(BuildContext context) {
  
    
    return Scaffold(
      appBar: AppBar(
     
        title: Text(widget.title),
      ),
      body: Container(
        child: FutureBuilder(
          future: _getCountries(),
        builder: (context,snapshot){
          if(snapshot.data==null){
            return Container(
              child: Center(child: Text('Loading...')),
            );
          }else{
          return ListView.builder(itemCount: snapshot.data.length,
          itemBuilder: (context, index){
            return ListTile(
              leading: CircleAvatar(backgroundImage: NetworkImage(snapshot.data[index].flag)),
              title: Text(snapshot.data![index].name),
              subtitle: Text(snapshot.data[index].currency),
            
            );
          },

          
          );
          }
        },
        
        ),

      ),
    );
  }
}


class Countries {
  late final String name;
   late final String currency;
   late final String unicodeFlag;
   late final String flag;
   late final String dialcode;

Countries(this.name,this.currency,this.unicodeFlag,this.flag,this.dialcode);

}
