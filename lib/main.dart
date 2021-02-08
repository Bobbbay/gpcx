import 'dart:convert';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;

import 'structs.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyApp> {
  Future<Status> status;

  @override
  void initState() {
    super.initState();
    status = fetchCryptocurrencyStatus();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called,
    return MaterialApp(
      title: 'Greg Points',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
       backgroundColor: Colors.black,
       primarySwatch: Colors.blue,
      ),
    home: Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Home"),
      ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      '1',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Greg Points: ',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          Text(
                            'Cryptocurrency: ',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          Text(
                            '10th place',
                            style: Theme.of(context).textTheme.headline4,
                          )
                        ]
                      ),
                    ),
                    Container(
                      // TODO: Find a more responsive method
                      height: 300,
                      width: 500,
                      child: FutureBuilder<Status>(
                        future: status,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) { return Text("${snapshot.data.json["jeffreyt"]["points"]}"); }
                          else if (snapshot.hasError) { return Text("${snapshot.error}"); }

                          return Center (
                            child: SizedBox(
                              height: 100,
                              width: 100,
                              child: CircularProgressIndicator()
                            )
                          );
                        }
                      )
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      '4',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Text(
                      '5',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Text(
                      '6',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
  }
}


Future<Status> fetchCryptocurrencyStatus() async {
  // TODO: Use a Client session over one-off requests using
  // the `http` library.
  final response = await http.get('http://localhost:10000/status');

  if (response.statusCode == 200) {
    return Status.fromString(response.body);
  } else {
    throw Exception('Network request failed.');
  }
}
