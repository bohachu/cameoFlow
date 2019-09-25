import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class TestAll{
  static test(){
    FileReadWrite fileReadWrite=FileReadWrite();
    fileReadWrite.test();
    HttpFetch httpFetch=HttpFetch();
    httpFetch.test();
  }
}

class HttpFetch {
  test(){
    fetchTrello();
  }
  static Future<http.Response> fetchPost() async{
    print('main.dart/Future<http.Response> fetchPost() async');
    var response=await http.get('https://jsonplaceholder.typicode.com/posts/1');
    print('main.dart/HttpFetch/fetchPost/response'+response.body.toString());
    return response;
  }
  static void fetchTrello() async{
    var strUrl = "https://api.trello.com/1/boards/5d62808da5dc7510aefef8b2?actions=all&boardStars=none&cards=none&card_pluginData=false&checklists=none&customFields=false&fields=name%2Cdesc%2CdescData%2Cclosed%2CidOrganization%2Cpinned%2Curl%2CshortUrl%2Cprefs%2ClabelNames&lists=open&members=none&memberships=none&membersInvited=none&membersInvited_fields=all&pluginData=false&organization=false&organization_pluginData=false&myPrefs=false&tags=false&key=876733968653dd64a9e7f983f92be18a&token=ce642d0028b550014df0a911ce9750e6078abf7d3cb1caec459a2df215ff097c";
    var response=await http.get(strUrl);
    print('main.dart/fetchTrello:\n'+response.body);
  }
}

class FileReadWrite{
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
  Future<File> get _localFile async {
    final path = await _localPath;
    // iOS Simulator File Location: ~/Library/Developer/CoreSimulator/Devices
    // ./B49E38F8-33DD-49BF-BCDC-E8B0866E2DAE/data/Containers/Data/Application/D2FAFAA1-E47C-48B1-9234-F1AB35F3D333/Documents/flutterWriteFileTest.txt
    // find . -name "flutterWriteFileTest.txt" -exec cat {} +
    return File('$path/flutterWriteFileTest.txt');
  }
  Future<File> writeFile(String strFileContent) async {
    final file = await _localFile;
    return file.writeAsString('$strFileContent');
  }
  test(){
    /*
    var file = new File('20190925 Dart File.txt');
    var ioSink = file.openWrite();
    ioSink.write('FILE ACCESSED ${new DateTime.now()}\n');
    ioSink.close();
    */
    String strFileContent='很棒棒喔 馬上可以看到 中文系統功勞多 babalala hahaha';
    writeFile(strFileContent);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    TestAll.test();
    return MaterialApp(
      title: 'Cameo AiFlow',
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
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(title: 'Cameo AiFlow v0.1'),
    );
  }
}
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
