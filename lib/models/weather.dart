import 'package:hive/hive.dart';

part 'weather.g.dart';

@HiveType(typeId: 0)
class Weather extends HiveObject {
  @HiveField(0)
  final num windSpeed;

  @HiveField(1)
  final int windDegrees;

  @HiveField(2)
  final num temp;

  @HiveField(3)
  final int humidity;

  @HiveField(4)
  final int sunset;

  @HiveField(5)
  final num minTemp;

  @HiveField(6)
  final int cloudPct;

  @HiveField(7)
  final num feelsLike;

  @HiveField(8)
  final int sunrise;

  @HiveField(9)
  final num maxTemp;

  Weather({
    required this.windSpeed,
    required this.windDegrees,
    required this.temp,
    required this.humidity,
    required this.sunset,
    required this.minTemp,
    required this.cloudPct,
    required this.feelsLike,
    required this.sunrise,
    required this.maxTemp,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      windSpeed: json['wind_speed'],
      windDegrees: json['wind_degrees'],
      temp: json['temp'],
      humidity: json['humidity'],
      sunset: json['sunset'],
      minTemp: json['min_temp'],
      cloudPct: json['cloud_pct'],
      feelsLike: json['feels_like'],
      sunrise: json['sunrise'],
      maxTemp: json['max_temp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'wind_speed': windSpeed,
      'wind_degrees': windDegrees,
      'temp': temp,
      'humidity': humidity,
      'sunset': sunset,
      'min_temp': minTemp,
      'cloud_pct': cloudPct,
      'feels_like': feelsLike,
      'sunrise': sunrise,
      'max_temp': maxTemp,
    };
  }
}






// class Weather {
//   final num windSpeed;
//   final int windDegrees;
//   final num temp;
//   final int humidity;
//   final int sunset;
//   final num minTemp;
//   final int cloudPct;
//   final num feelsLike;
//   final int sunrise;
//   final num maxTemp;

//   Weather({
//     required this.windSpeed,
//     required this.windDegrees,
//     required this.temp,
//     required this.humidity,
//     required this.sunset,
//     required this.minTemp,
//     required this.cloudPct,
//     required this.feelsLike,
//     required this.sunrise,
//     required this.maxTemp,
//   });

//   factory Weather.fromJson(Map<String, dynamic> json) {
//     return Weather(
//       windSpeed: json['wind_speed'],
//       windDegrees: json['wind_degrees'],
//       temp: json['temp'],
//       humidity: json['humidity'],
//       sunset: json['sunset'],
//       minTemp: json['min_temp'],
//       cloudPct: json['cloud_pct'],
//       feelsLike: json['feels_like'],
//       sunrise: json['sunrise'],
//       maxTemp: json['max_temp'],
//     );
//   }
// }
