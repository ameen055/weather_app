
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/weather_model.dart';


class WeatherService {
  final String apiKey = '3ff7d57d17ca4e47a7d60741250107';

  Future<Weather> fetchWeather(String city) async {
    final url ='http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$city&aqi=no';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
