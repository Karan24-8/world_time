import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{

  String? location; //location name for UI
  String? time; //time at the location
  String? flag; //url to an asset flag icon
  String? url; //location url for api endpoints
  bool? isDayTime;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {

    try{
    //make the request
    Response response = await get(Uri.parse(
    'https://timeapi.io/api/time/current/zone?timeZone=$url'));
    Map data = jsonDecode(response.body);
    //print(data);

    //get properties from data
    String dateTime = data['dateTime'];
    //String offset = data['utc_offset'].substring(1,3);
    //print(datetime);
    //print(offset);

    DateTime now = DateTime.parse(dateTime);
    //now = now.add(Duration(hours: int.parse(offset)));

    //set the time property
    isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
    time = DateFormat.jm().format(now);
    }
    catch(e){
      print('caught error $e');
      time = 'could not get time';
    }


  }

}

