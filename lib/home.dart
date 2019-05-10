import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


class HomeScreen extends StatefulWidget {
  
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int itemCount = 10;
  var shardowCard = 10.0;

  List<Photo> list = List();
  var isLoading = false;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPost();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text('Home'),   
      ),
      body:  getHomeListView(),
    );
  }

 getHomeListView() {
    return  isLoading ? Center(child: CircularProgressIndicator(),) : ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context,int position){
        return Container (
          // 
          height: 270,
          child :Card(          
            margin: EdgeInsets.only(top:1,left: 2,right: 2),
            shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey)),
            color: Colors.white,
            elevation: shardowCard,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  
                  Expanded(
            flex: 1,
            child: Image.network(list[position].thumbnailUrl,fit: BoxFit.cover,)
          ),
          Container(
            height: 20,
            child: Padding(
              padding: EdgeInsets.only(left: 8,top: 4),
              child: Text(list[position].title,
                    style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,),
            ) 
          ),
          Container(
            height: 20,
            child: Padding(
              padding: EdgeInsets.only(left: 9),
              child:Text(list[position].id.toString(),
                    style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[700]
                    ),
                    overflow: TextOverflow.ellipsis,),) 
          )
                  
                ],
    
             )
            ),
          )
        
        );
        
      },
    );
  }
  fetchDataFromServer() async{
    var url = "https://www.googleapis.com/books/v1/volumes?q={http}";

  // Await the http get response, then decode the json-formatted responce.
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    var itemCount = jsonResponse['totalItems'];
    print("Number of books about http: $itemCount.");
  } else {
    print("Request failed with status: ${response.statusCode}.");
  }
  }

  Future fetchPost() async {
    setState(() {
      isLoading = true;
    });
  final response =
      await http.get('https://jsonplaceholder.typicode.com/photos');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
     list = (convert.json.decode(response.body) as List)
          .map((data) => new Photo.fromJson(data)).toList();

          setState(() {
            isLoading = false;
          });
    // return Post.fromJson(convert.json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

}

class Photo {
  final String title;
  final String thumbnailUrl;
  final int id;

Photo._({this.title, this.thumbnailUrl,this.id});

factory Photo.fromJson(Map<String, dynamic> json) {
    return new Photo._(
      title: json['title'],
      thumbnailUrl: json['thumbnailUrl'],
      id: json['id']
    );
  }
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}