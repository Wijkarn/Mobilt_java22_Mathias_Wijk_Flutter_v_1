import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
                  : const CircularProgressIndicator(), // Display a loading indicator if _imageUrl is empty
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showImage,
        tooltip: 'Get new cat image!',
        child: const Icon(Icons.add),
      ),
    );
  }
}
