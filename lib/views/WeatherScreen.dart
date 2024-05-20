import 'dart:developer';

import 'package:flutter/material.dart';

import '../models/weather.dart';
import '../services/weather_service.dart';
import 'package:geocoding/geocoding.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService();
  Weather? _weather;
  bool _isLoading = false;
  String _city = 'Mumbai'; // Default city is Mumbai, India
  bool _isCelsius = true; // Default to Celsius

  final TextEditingController _controller = TextEditingController();

  void _fetchWeather() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final weather = await _weatherService.fetchWeather(_city);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      // Handle error
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  num _convertTemperature(num temp) {
    if (_isCelsius) {
      return temp;
    } else {
      return (temp * 9 / 5) + 32;
    }
  }

  void _fetchWeatherForCurrentLocation() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final position = await _weatherService.getCurrentLocation();
      log(position.latitude.toString());
      log(position.longitude.toString());
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        setState(() {
          _city = placemarks[0].locality ?? 'Unknown';
          log(_city);
          _fetchWeather();
        });
      }
    } catch (e) {
      // Handle error
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // _fetchWeather();
    _fetchWeatherForCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: [
          IconButton(
            icon:
                Icon(_isCelsius ? Icons.thermostat_outlined : Icons.thermostat),
            onPressed: () {
              setState(() {
                _isCelsius = !_isCelsius;
              });
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Enter city name',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        _city = _controller.text;
                        _fetchWeather();
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _isLoading
                  ? Center(child: const CircularProgressIndicator())
                  : _weather == null
                      ? Center(child: Text('No data'))
                      : Column(
                          children: [
                            Center(
                              child: Image.asset(
                                "assets/images/sun.png",
                                width: 150,
                                height: 150,
                              ),
                            ),
                            Text('City: $_city',
                                style: const TextStyle(fontSize: 24)),
                            const SizedBox(height: 16),
                            Text(
                                'Temperature: ${_convertTemperature(_weather!.temp).toStringAsFixed(1)}°${_isCelsius ? 'C' : 'F'}',
                                style: const TextStyle(fontSize: 18)),
                            Row(children: [
                              DisplayCard(
                                'Feels Like',
                                '${_convertTemperature(_weather!.feelsLike).toStringAsFixed(1)}°${_isCelsius ? 'C' : 'F'}',
                              ),
                              DisplayCard(
                                'Min Temp',
                                '${_convertTemperature(_weather!.minTemp).toStringAsFixed(1)}°${_isCelsius ? 'C' : 'F'}',
                              ),
                              DisplayCard(
                                'Max Temp',
                                '${_convertTemperature(_weather!.maxTemp).toStringAsFixed(1)}°${_isCelsius ? 'C' : 'F'}',
                              ),
                            ]),
                            Row(children: [
                              DisplayCard(
                                'Humidity',
                                '${_weather!.humidity}%',
                              ),
                              DisplayCard(
                                'Cloud Percentage',
                                '${_weather!.cloudPct}%',
                              ),
                              DisplayCard(
                                'Wind Speed',
                                '${_weather!.windSpeed} m/s',
                              ),
                            ]),
                            Text('Wind Degrees: ${_weather!.windDegrees}°',
                                style: const TextStyle(fontSize: 18)),
                            Text(
                                'Sunrise: ${DateTime.fromMillisecondsSinceEpoch(_weather!.sunrise * 1000)}',
                                style: const TextStyle(fontSize: 18)),
                            Text(
                                'Sunset: ${DateTime.fromMillisecondsSinceEpoch(_weather!.sunset * 1000)}',
                                style: const TextStyle(fontSize: 18)),
                          ],
                        ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchWeather,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

Widget DisplayCard(String label, dynamic value) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.grey[300]),
      child: Column(
        children: [Text(label), Text(value)],
      ),
    ),
  );
}
