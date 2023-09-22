import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'second.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String secondPageRoute = '/second';
  static const String mainPageRoute = '/main';

  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter v1',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 255, 0, 0),
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter v1'),
      routes: {
        MyApp.mainPageRoute: (context) => const MyHomePage(title: 'Flutter v1'),
        MyApp.secondPageRoute: (context) => const Second(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _imageUrl = '';

  @override
  void initState() {
    super.initState();
    showImage();
  }

  Future<String> fetchImageUrl() async {
    final response =
        await http.get(Uri.parse('https://api.thecatapi.com/v1/images/search'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final imageUrl = data[0]["url"];
      return imageUrl;
    } else {
      throw Exception('Failed to load image');
    }
  }

  void showImage() {
    // Fetch a new image URL when the button is pressed
    fetchImageUrl().then((imageUrl) {
      setState(() {
        _imageUrl = imageUrl;
      });
    }).catchError((error) {
      print('Error: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Cat superiority',
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: screenHeight / 1.5,
                ),
                child: _imageUrl.isNotEmpty
                    ? Image.network(
                        _imageUrl,
                        fit: BoxFit.cover,
                      )
                    : const CircularProgressIndicator(),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 1,
          right: 0,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, MyApp.secondPageRoute);
            },
            child: const Text('Go to Second Page'),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: OutlinedButton(
            onPressed: showImage,
            child: Ink(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('New cat image'),
              ),
            ),
          ),
        )
      ],
    ));
  }
}
