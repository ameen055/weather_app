import 'package:flutter/cupertino.dart';
import '../../Data/model/weather_model.dart';
import '../../Data/service/weather_service.dart';

class WeatherProvider extends ChangeNotifier{
  Weather? weather;
  bool isLoading = false;

  final WeatherService _weatherService =WeatherService();

  Future<void> getWeather(String city) async{
    isLoading =true;
    notifyListeners();

    try{
      weather =await _weatherService.fetchWeather(city);
    } catch (e){
      weather = null;
    }
    isLoading=false;
    notifyListeners();
  }
}