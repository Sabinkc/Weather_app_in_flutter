import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/services/weather_service.dart';

import '../models/weather_model.dart';
class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('d1d30e22d8947d6b9a2d3a7d74191780');
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'lib/assets/sunny.json.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'lib/assets/cloudy.json.json';
      case 'rain':
      case 'dizzle':
        return 'lib/assets/rainy.json.json';
      case 'thunderstorm':
        return 'lib/assets/thunder.json.json';
      case 'clear':
        return 'lib/assets/sunny.json.json';
      default:
        return 'lib/assets/sunny.json.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 18, 23, 26),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.place,
            color: Colors.grey,
            size: 40,
          ),

          Text(
            _weather?.cityName ?? "Loading city....",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(
            height: 150,
          ),
          Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
          SizedBox(
            height: 100,
          ),

          Text(
            '${_weather?.temperature.round()}°C',
            style: TextStyle(
                color: Colors.grey, fontSize: 50, fontWeight: FontWeight.bold),
          ),

          // Text(_weather?.mainCondition ?? ""),
        ],
      )),
    );
  }
}

