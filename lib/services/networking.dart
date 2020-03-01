import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final String url;

  NetworkHelper({this.url});

  Future getData() async {
    try {
      http.Response response = await http.get(this.url);
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        return decodedData;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }
}
