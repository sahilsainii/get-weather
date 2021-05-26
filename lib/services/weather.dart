import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const String apiKey = '2f57145bfda1f1a934fef050d4660e48';
const String openWeatherMapUrl =
    'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future getCityWeather(String cityName) async {
    var url = '$openWeatherMapUrl?q=$cityName&APPID=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location locator = Location();
    await locator.getCurrentLocation();
    //print('this is latitude${locator.latitude}');
    //print('this is longitude${locator.longitude}');
    // latitude = locator.latitude;
    // longitude = locator.longitude;
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapUrl?lat=${locator.latitude}&lon=${locator.longitude}&APPID=$apiKey&units=metric');
    // NetworkHelper networkHelper = NetworkHelper(
    //     'https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&exclude=hourly&appid=$apiKey');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
