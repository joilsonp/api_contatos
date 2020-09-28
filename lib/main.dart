import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'api.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Api> _api;

  Future<List<Api>> _getUser() async {
    try {
      List<Api> listUser = List();
      final response =
          await http.get('https://jsonplaceholder.typicode.com/users');
      if (response.statusCode == 200) {
        var decoderJson = jsonDecode(response.body);
        decoderJson.forEach((item) => listUser.add(Api.fromJson(item)));
        return listUser;
      } else {
        print('Erro ao carregar a lista');
        return null;
      }
    } catch (e) {
      print('Erro ao carregar a lista');
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _getUser().then((map) {
      _api = map;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ListView.builder(
          itemCount: _api.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: 80,
                    color: Colors.yellow,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            _api[index].id.toString(),
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Text(_api[index].name),
                          Text(_api[index].email),
                          Text(_api[index].phone)
                          //Text('_api[index].name')
                        ],
                      ),
                    )));
          }),
    ));
  }
}
