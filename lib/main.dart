import 'package:flutter/material.dart';
import 'package:shuftipro_flutter_sdk/ShuftiPro.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    String clientId = "";
    String secretKey = "";

    var authObject = {
      "auth_type": "basic_auth",
      "client_id": clientId,
      "secret_key": secretKey,
      // "access_token": accessToken,
    };

    // Default values for accessing the Shufti API
    Map<String, Object> createdPayload = {
      "country": "",
      "language": "EN",
      "email": "",
      "callback_url": "http://www.example.com",
      "redirect_url": "https://www.dummyurl.com/",
      "show_consent": 1,
      "show_results": 1,
      "show_privacy_policy": 1,
      "open_webView": false,
    };

    // Template for Shufti API verification object
    Map<String, Object?> verificationObj = {
      "face": {},
      "background_checks": {},
      "phone": {},
      "document": {
        "supported_types": [
          "passport",
          "id_card",
          "driving_license",
        ],
        "name": {
          "first_name": "",
          "last_name": "",
          "middle_name": "",
        },
        "dob": "",
        "document_number": "",
        "expiry_date": "",
        "issue_date": "",
        "fetch_enhanced_data": "",
        "gender": "",
        "backside_proof_required": "1",
      },
      "document_two": {
        "supported_types": ["passport", "id_card", "driving_license"],
        "name": {"first_name": "", "last_name": "", "middle_name": ""},
        "dob": "",
        "document_number": "",
        "expiry_date": "",
        "issue_date": "",
        "fetch_enhanced_data": "",
        "gender": "",
        "backside_proof_required": "0",
      },
      "address": {
        "full_address": "",
        "name": {
          "first_name": "",
          "last_name": "",
          "middle_name": "",
          "fuzzy_match": "",
        },
        "supported_types": ["id_card", "utility_bill", "bank_statement"],
      },
      "consent": {
        "supported_types": ["printed", "handwritten"],
        "text": "My name is John Doe and I authorize this transaction of \$100/-",
      },
    };

    createdPayload["reference"] = 'asdf';
    createdPayload["document"] = verificationObj['document']!;
    createdPayload["face"] = verificationObj['face']!;
    createdPayload["verification_mode"] = "image_only";
    createdPayload['country'] = 'BE';
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Container(
          child:
            ShuftiPro(
                authObject: authObject,
                createdPayload: createdPayload,
                async: false,
                callback: (res) async {
                  print(res);
                },
                homeClass: const MyHomePage(
                  title: 'yuw',
                )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
