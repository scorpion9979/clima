import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';
import '../services/location.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

final apiKey = DotEnv().env['API_KEY'];

class _LoadingScreenState extends State<LoadingScreen> {
  Location location = Location();

  Future<void> getLocationData() async {
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper(url: 'http://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey');

    final decodedData = await networkHelper.getData();
    double temp = decodedData['main']['temp'];
    int condition = decodedData['weather'][0]['id'];
    String cityName = decodedData['name'];

    print([temp, condition, cityName]);
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
        child: RaisedButton(
          onPressed: () {
            getLocationData();
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
