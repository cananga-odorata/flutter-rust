import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'package:my_app/src/rust/frb_generated.dart/api/simple.dart';
import 'package:my_app/src/rust/frb_generated.dart/frb_generated.dart';

Future<void> main() async {
  if (Platform.isMacOS) {
    // For local development without Xcode configuration, load the dylib directly.
    // TODO: Change this to a relative path or configure Xcode to embed the framework for production/other machines.
    await RustLib.init(
      externalLibrary: ExternalLibrary.open(
        '/Users/anusornsriprom/Desktop/lllToTolll_Mac2024/learn/rust/flutter-rust/my_app/rust_core/target/release/librust_core.dylib',
      ),
    );
  } else {
    await RustLib.init();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _greeting = "Press the button to greet Rust!";

  void _incrementCounter() {
    setState(() {
      _counter++;
      _greeting = greet(name: "User $_counter");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            Text(
              _greeting,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
