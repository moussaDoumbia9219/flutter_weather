import 'package:flutter/material.dart';
import 'package:my_weather_app/ui/Weather.dart';
import 'package:my_weather_app/model/WeatherData.dart';
import 'package:my_weather_app/api/MapApi.dart';
import 'package:my_weather_app/api/LocationApi.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  WeatherData _weatherData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.lightBlue,
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: _weatherData != null ? Weather(weatherData: _weatherData) :
            Center(
              child: CircularProgressIndicator(
                strokeWidth: 4.0,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            )

    );
  }

  getCurrentLocation() async{
    LocationApi locationApi = LocationApi.getInstance();
    final location = await locationApi.getLocation();
    loadWeather(lat: location.lat, lon: location.lat);
  }

  loadWeather({double lat, double lon}) async {
    MapApi mapApi = MapApi.getInstance();
    final data = await mapApi.getWeather(lat: lat, lon:lon);

    setState(() {

      this._weatherData = data;
    });
  }
}
