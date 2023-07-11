import 'package:flutter/material.dart';
import 'package:my_weather_app/weatherScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: WeatherScreen(),
    );
  }
}
