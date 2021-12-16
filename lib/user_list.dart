// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserList extends StatelessWidget {
  final String apiUrl =
      "https://teletraan.co/api/service-provider-profile?pagination=true&user_detail=true&is_approved=approved&filter_by_top_providers=true&filter_by_service=drain-repair&zip=10501&from_explore=truehttps://teletraan.co/api/service-provider-profile?pagination=true&user_detail=true&is_approved=approved&filter_by_top_providers=true&filter_by_service=drain-repair&zip=10501&from_explore=true";

  Future<List<dynamic>> fetchUsers() async {
    var result = await http.get(apiUrl);
    return json.decode(result.body)['data'];
  }

  String _name(dynamic user) {
    return user['business_name'] + " ";
  }

  int _isVerified(dynamic user) {
    return user['is_verified'];
  }

  String _image(dynamic user) {
    return user['user_detail']['profile_image'];
  }
  String _reviews(dynamic user) {
    if(user['reviewed_by']==null){
      return '0';
    }
    return user['reviewed_by'];
  }
  String _jobs(dynamic user) {
    if(user['finished_jobs']==0){
      return 'No';
    }

    return user['reviewed_by'];
  }
  String _city(dynamic user) {
    return user['profile_request']['approved_by_user']['city'];
  }
  String _created(dynamic user) {
    return user['formatted_created_at'];
  }
  String _buisnessDetails(dynamic user) {
    return user['business_details'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: fetchUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              //print(_age(snapshot.data[0]));
              return ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 40,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 50,
                                width: 50,
                                child: Image.network(
                                  _image(snapshot.data[index]),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Text(
                                  _name(snapshot.data[index]),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    fontSize: 20

                                  ),
                                ),
                                Icon(Icons.verified_user_outlined,
                                color: Colors.blueAccent,)

                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.star_border),
                                  Icon(Icons.star_border),Icon(Icons.star_border),Icon(Icons.star_border),Icon(Icons.star_border),
                                ],
                              ),
                            ),
                            SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsets.only(left:8.0,top: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_reviews(snapshot.data[index])+' Feedback Reviews',
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 18,
                                ),
                                ),
                                Text(_jobs(snapshot.data[index])+' Jobs Finished',
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 20,),
                                TextButton(onPressed: (){}, child: Text('Post Job & invite to Bid',
                                style: TextStyle(
                                  color: Colors.white
                                ),),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent)

                                ),
                                ),
                                SizedBox(height: 20,),
                                Divider(
                                  color: Colors.black45,
                                ),
                                SizedBox(height: 20,),
                                Row(
                                  children: [
                                    Icon(Icons.location_on,
                                    color: Colors.blueAccent),
                                    SizedBox(width: 10,),
                                    Text('Location ',
                                    style: TextStyle(fontSize: 18),),
                                    Text(_city(snapshot.data[index]),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),),


                                  ],
                                ),
                                SizedBox(height: 8,),
                                Row(
                                  children: [
                                    Icon(Icons.location_on,
                                        color: Colors.blueAccent),
                                    SizedBox(width: 10,),
                                    Text('Member Since ',
                                      style: TextStyle(fontSize: 18),),
                                    Text(_created(snapshot.data[index]),
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                      ),),


                                  ],
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(_buisnessDetails(snapshot.data[index]),
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),),
                                )
                              ],
                            ),
                          ),
                          ],
                        ),
                      ),

                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
