import 'dart:convert';

import 'package:api_fetch/resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Resources> apiData = [];
  List<bool> isClick = [];

  void _fetchResources() async {
    final response = await http.get(Uri.parse('https://api.sampleapis.com/codingresources/codingResources'));

    if (response.statusCode == 200) {
      // Decode the response as a list of dynamic objects
      List<dynamic> data = json.decode(response.body);

      setState(() {
        data.forEach ((item) {
          apiData.add(Resources.fromJson(item));
        });
        isClick = List.generate(apiData.length, (_) => false);
      });
    } else {
      throw Exception('Failed to load resources');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchResources();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("   Api Fetch Data", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: apiData.isEmpty ? const Center(child: CircularProgressIndicator(),) : Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: apiData.length,
          itemBuilder: (context, index) {
            final resource = apiData[index];

            // String S = "";
            // for (int i = 0; i < resource.types.length; i++){
            //   S += resource.types[i] + " ";
            // }

            String S = resource.types.join(' ');

            return InkWell(
              onTap: () => {},
              child: Card(
                color: Color(0xffe6e6e6),
                child: ExpansionTile(
                  title: Text(resource.description),
                  subtitle: Text(resource.url),
                  leading: const CircleAvatar(backgroundImage: NetworkImage("https://images.unsplash.com/photo-1547721064-da6cfb341d50")),
                  trailing: Icon(isClick[index]? Icons.keyboard_arrow_up: Icons.keyboard_arrow_down),
                  // We can also use this format
                  // trailing: Text(resource.types.join(', ')),

                  onExpansionChanged: (bool expanded){
                    setState(() {
                      isClick[index] = expanded;
                      // true: The ExpansionTile is expanded (i.e., the child widgets are visible).
                      // false: The ExpansionTile is collapsed (i.e., the child widgets are hidden).
                    });
                  },

                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Colors.yellowAccent,
                        child: Column(
                          children: [
                            ListTile(title: Text(S)),
                            Divider(color: Colors.red, thickness: 2),
                            ListTile(title: Text(resource.topic.join(', '))),
                            Divider(color: Colors.red, thickness: 2),
                            ListTile(title: Text(resource.types.join(', '))),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              )
            );
          }
        ),
      ),
    ));
  }
}
