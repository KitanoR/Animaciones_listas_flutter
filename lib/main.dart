import 'package:flutter/material.dart';
import 'package:list_animate/src/flare_page.dart';
import 'package:list_animate/src/home_page.dart';
import 'package:list_animate/src/wheels_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final opciones = <Widget>[
              Text('hola'),
              Text('hola'),
            ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BodyApp()
    );
  }
}


class BodyApp extends StatefulWidget {
  @override
  _BodyAppState createState() => _BodyAppState();
}

class _BodyAppState extends State<BodyApp> {
  final opciones = <Widget> [
    HomePage(),
    WhelsPage(),
    FlarePage()
  ];

  int _indexTab = 0;

   void _onItemTapped(int index) {
    setState(() {
      _indexTab = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Shrink top list',
          style: TextStyle(
            color: Colors.black
          ),
        ),
      ),
      body: Center(child: opciones[_indexTab],),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indexTab,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('Lista')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rounded_corner),
            title: Text('Circular')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.satellite),
            title: Text('Circular')
          )
        ],
      ),
    );

  }
}