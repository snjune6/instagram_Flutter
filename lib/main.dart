import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:instagram/style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';


void main() {
    runApp(
        MaterialApp(
            theme: style.theme,
            home: MyApp()
    ));
}


class MyApp extends StatefulWidget {
    const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    var tab = 0;
    var data = [];

    getData() async {
        var result = await http.get(Uri.parse('https://codingapple1.github.io/app/data.json'));

        if (result.statusCode == 200) {
            var result2 = jsonDecode(result.body);
            setState(() {
                data = result2;
            });
        } else {
            setState(() {
                data = [];
            });
        }

    }

    @override
      void initState() {
            // TODO: implement initState
            super.initState();
            getData();
      }

    @override
    Widget build(BuildContext context) {
        return  Scaffold(
            appBar: AppBar(
                title: Text("Instagram"),
                actions: [
                    IconButton(
                        icon: Icon(Icons.add_box_outlined),
                        onPressed: (){},
                        iconSize: 30,
                    )
                ],
            ),
            body: [Home(data : data), Text('샵페이지')][tab],
            bottomNavigationBar: BottomNavigationBar(
                showSelectedLabels: false,
                showUnselectedLabels: false,
                onTap: (i){
                    setState(() {
                        tab = i;
                    });
                },
                items: [
                    BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
                    BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: '샵')
                ],
            ),

        );
    }
}

class Home extends StatelessWidget {
    const Home({Key? key, this.data}) : super(key: key);
    final data;

    @override
    Widget build(BuildContext context) {

        if (data.isNotEmpty) {
            return ListView.builder(itemCount: 3, itemBuilder: (c, i){
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Image.network(data[i]['image']),
                        Text('좋아요 100'),
                        Text('글쓴이'),
                        Text(data[i]['content']),
                    ]
                );
            });
        } else {
            return Text('로딩중');
        }

    }
}

