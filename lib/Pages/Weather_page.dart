import 'package:flutter/material.dart';
import 'package:weather/Models/Weather_model.dart';
import 'package:weather/services/Weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // apik Key
  final _weatherService = WeatherService('bb49cc5dab815ec2fc6061c304d836fb');
  Weather? _weather;

  //Fetch  Weather
  _fetchWeather() async {
    // get current city
    String cityName = await _weatherService.getCurrentCity();

    //get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_weather?.cityName ?? "loading city..."),
          Text('${_weather?.temperature.round()}°C')
        ],
      ),
    ));
  }
}
