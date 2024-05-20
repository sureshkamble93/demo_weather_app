import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import '../models/weather.dart';

class WeatherService {
  static const String apiKey = 'i8PbNnG5oTyqomsYc7vXbA==OpCyhZSZGNfmpr5f';
  static const String baseUrl = 'https://api.api-ninjas.com/v1/weather?city=';
 final Box<Weather> weatherBox = Hive.box<Weather>('weatherBox');
 
  Future<Weather> fetchWeather(String city) async {
    final response = await http.get(
      Uri.parse('$baseUrl$city'),
      headers: {'X-Api-Key': apiKey},
    );

    if (response.statusCode == 200) {
       final weather = Weather.fromJson(jsonDecode(response.body));
        await weatherBox.put(city, weather);
        return weather;
    } else {
     // Attempt to load data from the Hive database if network request fails
      final weather = weatherBox.get(city);
      if (weather != null) {
        return weather;
      } else {
        throw Exception('Failed to load weather data and no local data available');
      }
    }
  }


 Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    } 

    return await Geolocator.getCurrentPosition();
  }




}
