import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
              'DeFi Tracker',
              style: TextStyle(fontSize: 24)),
          backgroundColor: const Color(0xFF3A7CA5),
        ),
        body: const Center(
          child: HomePage(),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textFieldController = TextEditingController();

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Enter Token Ticker'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: "\$TICKER"),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: const Text('Cancel'),
                onPressed: () {
                  setState(() {
                    _textFieldController.clear();
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: const Text('OK'),
                onPressed: () {
                  if (valueText != "") {
                    userTokens.add(valueText);
                  }
                  setState(() {
                    _textFieldController.clear();
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  late String codeDialog;
  late String valueText;
  List<String> userTokens = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      backgroundColor: const Color(0xFF272635),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF3A7CA5),
        icon: const Icon(Icons.add),
        onPressed: () {
          _displayTextInputDialog(context);
        },
        label: const Text('Token'),
      ),
      body: _buildTokens(),
    );
  }

  Widget _buildTokens() {
    return ListView.separated(
        itemCount: userTokens.length,
        padding: const EdgeInsets.all(10),
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemBuilder: (BuildContext _context, int i) {
          return _buildRow(userTokens[i]);
        }
    );
  }

  Widget _buildRow(String token) {
    return ListTile(
      title: Text(
        token,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
      tileColor: const Color(0xFF9B1D20),
      leading: const Icon(Icons.attach_money),
      dense: true,
      minLeadingWidth: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    );
  }
}