import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: SafeArea(
      child: Scaffold(body: HomePage()),
    ));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Client client = http.Client();
  String myText = "hello, I'm here!";

  List<dynamic> response = [];

  void changeText (String text){
    setState(() {
      myText = text;
    });
  }


  Future<void> fetchData() async {
    final url = Uri.parse('http://192.168.1.7:8000/test');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      response = [json.decode(res.body)];
      print(response);
      //changeText(response[0]['age'].toString());
    } else {
      // Handle the error
      print('Failed to load data');
    }
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("helloooooo "+response[0]['hello']),
          const SizedBox(height: 30,),
          ElevatedButton(onPressed: fetchData
          , child: const Text("change the text"))
        ],
      ),
    );
  }
}
