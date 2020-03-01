import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';
import '../services/location.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

final apiKey = DotEnv().env['API_KEY'];

class _LoadingScreenState extends State<LoadingScreen> {
  Location location = Location();

  Future<void> getLocationData() async {
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper(
        url:
            'http://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey');

    final weatherData = await networkHelper.getData();
    // double temp = weatherData['main']['temp'];
    // int condition = weatherData['weather'][0]['id'];
    // String cityName = weatherData['name'];
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LocationScreen()));
  }

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitRotatingCircle(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
