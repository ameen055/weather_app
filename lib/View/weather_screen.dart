import 'dart:async';

import 'package:animated_hint_textfield/animated_hint_textfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../controller/provider/weather_provider.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  WeatherScreenState createState() => WeatherScreenState();
}
class WeatherScreenState extends State<WeatherScreen>{
  late String _currentTime;
  late Timer _timer;

  @override
  void initState(){
    super.initState();
    _updateTime();
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) => _updateTime());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateTime() {
    final now = DateTime.now();
    final formatter = DateFormat('hh:mm:ss a');
    setState(() {
      _currentTime = formatter.format(now);
    });
  }

  final cityController = TextEditingController();
 static const Map<String,dynamic> weather = const {
    'Sunny': 'https://img.icons8.com/?size=96&id=8LM7-CYX4BPD&format=png',
    'Rain':'https://img.icons8.com/?size=96&id=15360&format=png',
    'Mist':'https://img.icons8.com/?size=160&id=67556&format=png',
   'Cloudy':'https://img.icons8.com/?size=96&id=aXgIQg8m0A4o&format=png',
   'Partly cloudy':'https://img.icons8.com/?size=96&id=aXgIQg8m0A4o&format=png',
   'Overcast':'https://img.icons8.com/?size=160&id=XI84tMwq1z56&format=png',
  };

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeatherProvider>(context);

    String condition = provider.weather?.description ?? '';
    String? imageUrl = weather[condition];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
          title: Text(
          'Weather app',style:TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://i.pinimg.com/736x/d5/ad/45/d5ad45d528c41dc8cb4cb753e0981b47.jpg',
                ), // make sure this image is in your assets
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AnimatedTextField(
                    animationType: Animationtype.fade,
                    controller: cityController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      contentPadding: EdgeInsets.all(12),
                      filled: true,
                      fillColor: Colors.white.withOpacity(
                        0.8,
                      ), // input box background
                    ),
                    hintTexts: [
                      'Search for "Paris"',
                      'Search for "London"',
                      'Search for "Thrissur"',
                      'Search for "America"',
                      'Search for "New Delhi"'
                    ],
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    
                    onPressed: () {
                      provider.getWeather(cityController.text);
                    },
                    child: Text('Get Weather'),
                  ),
                  SizedBox(height: 20),
                  provider.isLoading
                      ? CircularProgressIndicator()
                      : provider.weather == null
                      ? Text(
                          'Enter a city name',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Container(
                          height: 330,
                          width: 350,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white38,
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'City: ${provider.weather!.city}',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 30,
                                  ),
                                ),
                                Text(
                                  'Temperature: ${provider.weather!.temperature}°C',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                  ),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Description: ${provider.weather!.description}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    if (imageUrl != null)
                                      Image.network(
                                        imageUrl,
                                        width: 100,
                                        height: 100,
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                  SizedBox(height: 20),
                  Container(
                    height: 145,
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white38,
                    ),
                    child: Center(
                      child: Text('Time: $_currentTime',
                      style: TextStyle(fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 40,
                      ),),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,onPressed: (){}, child: Icon(Icons.location_on, color: Colors.white,),),
    );
  }
}
