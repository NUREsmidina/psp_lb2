
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lb2/weather.dart';


class WeatherDetailScreen extends StatefulWidget {
  const WeatherDetailScreen({super.key, required this.city});

  final String city;

  @override
  WeatherDetailScreenState createState() => WeatherDetailScreenState();

}


class WeatherDetailScreenState extends State<WeatherDetailScreen>{

  late Future<WeatherInfo> weatherInfo;

  @override
  void initState() {
    super.initState();

    weatherInfo = fetchWeather(widget.city);
    weatherInfo.then((value) => {
      log("$value")
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Weather: ${widget.city}"),
        ),
        body: Center(
          child: FutureBuilder<WeatherInfo>(
            future: weatherInfo,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text("Temperature: ${snapshot.data!.temperature}, wind: ${snapshot.data!.wind} ");
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        )
    );
  }
}