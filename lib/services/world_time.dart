import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'dart:convert';


class WorldTime{

  String location; // location name for UI
  String time = ""; //time in that location
  String flag; //url to an assets image icon
  String url; //location url for api
  bool isDaytime = false; // true or false if daytime or not

  WorldTime({ required this.location, required this.flag, required this.url});


  Future<void> getTime() async{

    try {
      Response response = await get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      //print(data);

      //get properties from data
      String dataTime = data["utc_datetime"];
      String offset = data["utc_offset"].substring(0, 3);
      String sign = data['utc_offset'].substring(0,1);
      print("sign is $sign");

      DateTime now = DateTime.parse(dataTime).add(Duration(hours: int.parse(offset)));
      now = now.add(Duration(hours: int.parse(offset)));

      //set time property
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch (e) {
      print('caught error: $e');
      time = 'could not get time data';
    }


  }

}

