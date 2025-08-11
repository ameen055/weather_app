import 'package:flutter/material.dart';
import 'package:task01/View/weather_screen.dart';
import 'package:provider/provider.dart';

import 'controller/provider/weather_provider.dart';

void main() {
  runApp(
      ChangeNotifierProvider(
          create: (_) => WeatherProvider(),
        child: MyApp()
      )
  );
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherScreen(),
    );
  }
}
