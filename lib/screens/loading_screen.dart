import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Future<Position> getLocation() {
    Future<Position> position =
        Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    return position;
  }

  void printLocation() async {
    Position position = await getLocation();
    print(position);
  }

  @override
  void initState() {
    super.initState();
    printLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            printLocation();
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
