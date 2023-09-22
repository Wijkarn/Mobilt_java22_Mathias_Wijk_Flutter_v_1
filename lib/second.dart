import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Second extends StatefulWidget {
  const Second({Key? key});

  @override
  _SecondState createState() => _SecondState();
}

class _SecondState extends State<Second> {
  String? selectedOption;
  String? feedbackText;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
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
            const SizedBox(height: 16),
            const Text(
              'Is the Venator-Class Republic Attack Cruiser #75367 the best lego set of all time? (all facts, no opinions)',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Radio<String>(
                  value: 'Correct!',
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value;
                      feedbackText = 'Of course it is!';
                    });
                  },
                ),
                const Text('Yes, I am smart!'),
                Radio<String>(
                  value: 'No',
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value;
                      feedbackText = 'Are you fucking dumb?';
                    });
                  },
                ),
                const Text('No, I am stupid.'),
              ],
            ),
            const SizedBox(height: 16),
            if (feedbackText != null)
              Text(
                feedbackText!,
                style: TextStyle(
                  fontSize: 16,
                  color: feedbackText == 'Of course it is!'
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            const SizedBox(height: 16),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: screenHeight / 2,
              ),
              child: Image.network(
                'https://www.lego.com/cdn/cs/set/assets/bltcfe4c209d7b5b7d2/75367_alt2.png',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                const url =
                    'https://www.lego.com/en-se/product/venator-class-republic-attack-cruiser-75367';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
              child: const Text('Venator Link'),
            ),
          ],
        ),
      ),
    );
  }
}
