import 'package:flutter/material.dart';
import '../services/location.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

final apiKey = DotEnv().env['API_KEY'];

class _LoadingScreenState extends State<LoadingScreen> {
  Location location = Location();

  Future<void> getLocation() async {
    await location.getCurrentLocation();
  }

  void getData() async {
    await getLocation();
    try {
      http.Response response = await http.get(
          'http://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey');
      if (response.statusCode == 200) {
        print(response.body);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            getData();
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
