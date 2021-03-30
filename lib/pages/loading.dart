import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';//loading animation

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  //getting time data from server
  void setupTimeData() async {
    //creating world time instance
    WorldTime worldTime =
        WorldTime(location: 'Dhaka', flag: 'bangladesh.png', url: 'Asia/Dhaka');
    //getting time from server
    await worldTime.getTimeData();
    //going to home page with data
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'time': worldTime.time,
      'location': worldTime.location,
      'flag': worldTime.flag,
      'isDayTime':worldTime.isDayTime
    });
  }

  @override
  void initState() {
    super.initState();
    //getting time data and moving into next layout
    setupTimeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
        body: Center(
            child: SpinKitWave(//loading animation
      color: Colors.white,
      size: 80.0,
    )));
  }
}
