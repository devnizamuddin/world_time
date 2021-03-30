
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location; // location of the Ui
  String flag; // flag of that location
  String url; // location url for api end point
  String time; // time of that location will be gotten from server
  bool isDayTime; //user location day or night

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTimeData() async {

    try{

      //calling the api
      Response response = await get(
          Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      // decode json
      Map dateTimeMap = jsonDecode(response.body);
      //get time from map
      String datetime = dateTimeMap['datetime'];
      //get offset from map and using substring
      String utc_offset = dateTimeMap['utc_offset'].substring(1, 3);
      //creating date time object
      DateTime dateTime = DateTime.parse(datetime);
      // adding offset to datetime to get original time of that location
      dateTime = dateTime.add(Duration(hours: int.parse(utc_offset)));
      //setting date time to string
      time = DateFormat.jm().format(dateTime);
      isDayTime = dateTime.hour>5 && dateTime.hour<19?true:false;

    }
    catch(e){
      time = e.toString();
    }

  }
}
