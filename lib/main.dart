import 'package:flutter/material.dart';
void main(){
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My App",
      theme: ThemeData(
        primaryColor: Colors.red
      ),
      home: HomePage(),
    );
  }
}


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  String mytext= "For the thoughts you fail to put in words";
  Map<String, dynamic> thoughts = {
    "items": 0,
    "posts": []
  };


  Widget noThoughtScreen(){
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(
              height: 32,
            ),
            Text(
              "No thoughts yet",
              style: TextStyle(
                fontSize: 20
              ),
            ),
          ],
        )
      ),
    );
  }

  Widget detailsScreen(){
    List<Widget> postDetailsList = List();
    for (var item in thoughts["posts"]) {
      var tile = Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12
        ),
        child: Card(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 24
            ),
            child: Text(
              item["thought"]
            ),
          ),
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.black
            ),
            borderRadius: BorderRadius.circular(2)
          ),
        )
      );
      postDetailsList.add(tile);
    }
    return ListView(
      children: postDetailsList,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Writer home')
      ),
      body: thoughts["items"] == 0 ? noThoughtScreen() : detailsScreen(),
      floatingActionButton: FloatingActionButton(
        child:Icon(Icons.add),
        onPressed: () async {
          Map<String, dynamic> details = await Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) => WriterThoughtScreen(
              idx: thoughts["items"].toString(),
            )
          ));
          thoughts["posts"].add(details);
          thoughts["items"] = thoughts["items"] + 1;

          setState(() {
          });
        },
      ),
    );
  }
}




class WriterThoughtScreen extends StatefulWidget{
  final String idx;
  WriterThoughtScreen({Key key, @required this.idx}): super(key:key);

  _WriterThoughtScreenState createState() => _WriterThoughtScreenState();
  
}

class _WriterThoughtScreenState extends State<WriterThoughtScreen> {

  TextEditingController keywordsController = TextEditingController();
  @override
   Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
      title: Text(
        "Here for you"
      ),
     ),
     body: Container(
      child: Form(
       child: Column(
        children:<Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height / 12,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 32
            ),
            child: TextFormField(
              controller: keywordsController,
              decoration: InputDecoration(
                labelText: 'Keywords',
                hintText: 'Here goes your words in transit',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0)
                ),
              ),
            ),
          ),
        ],
       ),
      ),
     ),
     floatingActionButton: FloatingActionButton(
        onPressed: (){
          Map<String, dynamic> post = {
            "thought": keywordsController.text
          };
          Navigator.pop(context, post);
        },
       child: Icon(Icons.done)
      ),
    );
   }
}