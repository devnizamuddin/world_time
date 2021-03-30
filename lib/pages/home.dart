import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {}; //World time map data

  @override
  void initState() {
    super.initState();
    print(' Home init state');
  }

  @override
  Widget build(BuildContext context) {
    print('Home build state');
    data = data.isEmpty? ModalRoute.of(context).settings.arguments:data;//getting data from previous layout
    String backgroundImage = data['isDayTime'] ? 'day.png' : 'night.png';//setting background image as time.
    Color backgroundColor = data['isDayTime'] ? Colors.blue : Colors.indigo;//setting background color as time
    print(data);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        //setting background image
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/$backgroundImage'),
                fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 128, 0, 0),
          child: Column(
            children: [
              //======================= Choose location Button ======================//
              FlatButton.icon(
                label: Text('Choose Location',style: TextStyle(color: Colors.grey[200]),),
                icon: Icon(Icons.edit_location ,color: Colors.grey[200],),
                onPressed: () async {//onclick choose location button
                  //get data after back to this layout
                  dynamic worldTime = await Navigator.pushNamed(context, '/location');
                  setState(() {
                    data={
                      'time': worldTime['time'],
                      'location': worldTime['location'],
                      'flag': worldTime['flag'],
                      'isDayTime':worldTime['isDayTime']
                    };
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data['location'],
                    style: TextStyle(fontSize: 28, letterSpacing: 2 ,color: Colors.white),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                data['time'],
                style: TextStyle(fontSize: 48,color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
