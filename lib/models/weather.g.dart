// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeatherAdapter extends TypeAdapter<Weather> {
  @override
  final int typeId = 0;

  @override
  Weather read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Weather(
      windSpeed: fields[0] as num,
      windDegrees: fields[1] as int,
      temp: fields[2] as num,
      humidity: fields[3] as int,
      sunset: fields[4] as int,
      minTemp: fields[5] as num,
      cloudPct: fields[6] as int,
      feelsLike: fields[7] as num,
      sunrise: fields[8] as int,
      maxTemp: fields[9] as num,
    );
  }

  @override
  void write(BinaryWriter writer, Weather obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.windSpeed)
      ..writeByte(1)
      ..write(obj.windDegrees)
      ..writeByte(2)
      ..write(obj.temp)
      ..writeByte(3)
      ..write(obj.humidity)
      ..writeByte(4)
      ..write(obj.sunset)
      ..writeByte(5)
      ..write(obj.minTemp)
      ..writeByte(6)
      ..write(obj.cloudPct)
      ..writeByte(7)
      ..write(obj.feelsLike)
      ..writeByte(8)
      ..write(obj.sunrise)
      ..writeByte(9)
      ..write(obj.maxTemp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
