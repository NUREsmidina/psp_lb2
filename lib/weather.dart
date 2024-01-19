import 'dart:convert';

import 'package:http/http.dart' as http;

Future<WeatherInfo> fetchWeather(String city) async {
  final response = await http.get(Uri.parse("https://goweather.herokuapp.com/weather/$city"));

  if (response.statusCode == 200) {
    return WeatherInfo.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception("Failed to load WeatherInfo. Status code: ${response.statusCode}, response: ${response.body}.");
  }
}


class WeatherInfo {

  final String temperature;
  final String wind;
  final String description;

  const WeatherInfo({
    required this.temperature,
    required this.wind,
    required this.description,
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return switch(json) {
      {
      "temperature": String temperature,
      "wind": String wind,
      "description": String description
      } =>
          WeatherInfo(
            temperature: temperature,
            wind: wind,
            description: description,
          ),
      _ =>
      throw const FormatException(
          "Failed to load JSON response for WeatherInfo."),
    };
  }

  @override
  String toString(){
    return "WeatherInfo(temperature: $temperature, wind: $wind)";
  }
}