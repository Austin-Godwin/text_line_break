import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textController = TextEditingController();
  String editedText = "";

  void capitalizeText() {
    setState(() {
      editedText = _textController.text
          .toUpperCase()
          .split('\n')
          .map((e) => '$e\n')
          .join('\n');
    });
  }

  void clearText() {
    setState(() {
      _textController.clear();
      editedText = _textController.text;
    });
  }

  void lineBreak() {
    if (_textController.text.isNotEmpty) {
      setState(() {
        editedText =
            _textController.text.split('\n').map((e) => '$e\n').join('\n');
      });
    }
  }

  void copyText() {
    if (editedText.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: editedText));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blue,
          content: Text('Successfully Copied'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: const BorderSide(),
              ),
            ),
            child: TextFormField(
              controller: _textController,
              decoration: const InputDecoration(border: InputBorder.none),
              maxLines: 15,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: capitalizeText,
                child: const Text("Capitalize Text"),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: lineBreak,
                child: const Text("Line Break"),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: clearText,
                child: const Text("Clear Text"),
              ),
            ],
          ),
          const SizedBox(height: 50),
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
            height: 250.0,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: const BorderSide(),
              ),
            ),
            child: SingleChildScrollView(
              child: Text(
                editedText,
                softWrap: true,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: copyText,
                child: const Text("Copy Text"),
              ),
            ],
          ),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
