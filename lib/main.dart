import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

void main() {
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
        useMaterial3: true,
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
  final player = AudioPlayer();
  String? playerFilePath;
  bool finished = true;

  final Set<String> audios = {
    'audios/file_example_MP3_1MG.mp3',
    'audios/file_example_MP3_700KB.mp3'
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        padding: const EdgeInsets.all(8),
        itemCount: audios.length,
        itemBuilder: (context, index) {
          final audio = audios.elementAt(index);
          return Material(
            color: Colors.blue,
            child: InkWell(
              onTap: () async {
                try {
                  await player.stop();
                  if (playerFilePath == audio) {
                    setState(() => playerFilePath = null);
                    return;
                  }
                  setState(() {
                    playerFilePath = audio;
                  });
                  await player.setAsset(audio);
                  await player.play();
                } catch (e) {
                  print('Error $e');
                  setState(() => playerFilePath = null);
                }
              },
              child: Icon(
                playerFilePath == audio ? Icons.pause : Icons.play_arrow,
                size: 48,
              ),
            ),
          );
        },
      ),
    );
  }
}
