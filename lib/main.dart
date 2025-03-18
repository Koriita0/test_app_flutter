import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Colors App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: Colors.black,
      ),
      home: MyHomePage(title: 'Inicio'),
    );
  }
}

class FullScreenComponent extends StatelessWidget {
  final String title;
  final String description;

  const FullScreenComponent({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detalles")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(description, style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

class NoDataComponent extends StatelessWidget {
  const NoDataComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sin Información')),
      body: Center(child: Text('Este es el componente sin datos')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> cardData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        cardData =
            data
                .take(5)
                .map(
                  (post) => {
                    'title': post['title'],
                    'description': post['body'],
                    'link': FullScreenComponent(
                      title: post['title'],
                      description: post['body'],
                    ),
                  },
                )
                .toList();
      });
    } else {
      throw Exception('Error al cargar los datos');
    }
  }

  Widget _buildCard(
    BuildContext context,
    String title,
    String description, [
    Widget? link,
  ]) {
    return Card(
      margin: EdgeInsets.all(10.0),
      color: const Color.fromARGB(255, 36, 36, 36),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          height: 200.0,
          child: InkWell(
            onTap:
                link != null
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => link),
                        );
                      }
                    : null,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  description,
                  maxLines: 6,
                  style: TextStyle(
                    fontSize: 16,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Inicio")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(
                bottom: 5,
                top: 10,
                start: 10,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Información desde la API',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    cardData.map((data) {
                      return Container(
                        width: 300,
                        child: _buildCard(
                          context,
                          data['title']!,
                          data['description']!,
                          data['link'] ?? NoDataComponent(),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
