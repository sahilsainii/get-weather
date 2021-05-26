import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';

import '../services/weather.dart';
import '../services/weather.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({
    this.locationWeather,
  });
  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temperature;
  String emoji;
  String weatherMessage;
  int tempFeel;
  int minTemp;
  int maxTemp;
  int condition;
  String cityName;

  var speed;
  @override
  void initState() {
    super.initState();

    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        emoji = 'Error';
        weatherMessage = 'Unable to get Weather,check your internet connection';
        cityName = 'paradise island';
        minTemp = 0;
        maxTemp = 0;
        tempFeel = 0;

        return;
      }
      double tempfeel = weatherData['main']['feels_like'];
      tempFeel = tempfeel.toInt();
      double miniTemp = weatherData['main']['temp_min'];
      minTemp = miniTemp.toInt();
      double maxiTemp = weatherData['main']['temp_max'];
      maxTemp = maxiTemp.toInt();
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      weatherMessage = weather.getMessage(temperature);

      condition = weatherData['weather'][0]['id'];
      emoji = weather.getWeatherIcon(condition);

      cityName = weatherData['name'];
      print(cityName);
      // speed = weatherData['current']['weather'][0]['description'];
      // print(speed);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: (AssetImage('images/b.jpeg')),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData =
                          await WeatherModel().getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  Spacer(),
                  FlatButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      if (typedName != null) {
                        var weatherData =
                            await weather.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(left: 45.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: TextStyle(
                        fontSize: 58.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      emoji,
                      style: TextStyle(
                        fontSize: 58.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: Column(
                        children: [
                          Text(
                            'min temp :$minTemp',
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          Text(
                            'max temp: $maxTemp',
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          Text(
                            'Feels like $tempFeel',
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  cityName,
                  textAlign: TextAlign.center,
                  style: kMessageTextStyle,
                ),
              ),
              Spacer(flex: 2),
              Padding(
                padding: EdgeInsets.only(left: 35.0),
                child: Text(
                  weatherMessage,
                  textAlign: TextAlign.left,
                  style: kMessageTextStyle,
                ),
              ),
              Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}

// var temperature = decodedData['main']['temp'];
//
// var condition = decodedData['weather'][0]['id'];
//
// var cityName = decodedData['name'];
