import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:template/user_list.dart';

Future<Album> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('https://teletraan.co/api/service-provider-profile?pagination=true&user_detail=true&is_approved=approved&filter_by_top_providers=true&filter_by_service=drain-repair&zip=10501&from_explore=truehttps://teletraan.co/api/service-provider-profile?pagination=true&user_detail=true&is_approved=approved&filter_by_top_providers=true&filter_by_service=drain-repair&zip=10501&from_explore=true'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  Album({
    this.userId,
    this.id,
    this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['business_details'],
      id: json['business_type'],
      title: json['business_name'],
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  //const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: UserList());
  }
}