import 'package:flutter/material.dart';

class Second extends StatelessWidget {
  const Second({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Venator-Class Republic Attack Cruiser #75367',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Image.network(
              'https://www.lego.com/cdn/cs/set/assets/bltcfe4c209d7b5b7d2/75367_alt2.png', // Replace with your image URL
              fit: BoxFit.cover, // Adjust the fit property as needed
            ),
          ],
        ),
      ),
    );
  }
}
