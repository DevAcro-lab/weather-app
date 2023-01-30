import 'package:clima_flutter/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima_flutter/utilities/constants.dart';
import 'package:clima_flutter/services/weather.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  late int temperature;
  late String txtForTemperature;
  late String weatherIcon;
  late String cityName;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        txtForTemperature = 'Unable to get Weather data';
        cityName = '';
        weatherIcon = 'Error';
        return;
      }
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weatherModel.getWeatherIcon(condition);
      cityName = weatherData['name'];
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      txtForTemperature = weatherModel.getMessage(temperature);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      onPressed: () async {
                        var weatherData =
                            await weatherModel.getLocationWeather();
                        updateUI(weatherData);
                      },
                      child: const Icon(
                        Icons.near_me,
                        color: Colors.white,
                        size: 50.0,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        var typedName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CityScreen(),
                          ),
                        );
                        if (typedName != null) {
                          var weatherData =
                              await weatherModel.getCityWeather(typedName);
                          updateUI(weatherData);
                        }
                      },
                      child: const Icon(
                        Icons.location_city,
                        color: Colors.white,
                        size: 50.0,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '$temperature°',
                        style: kTempTextStyle,
                      ),
                      Text(
                        weatherIcon,
                        style: kConditionTextStyle,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Text(
                    "$txtForTemperature in $cityName!",
                    textAlign: TextAlign.right,
                    style: kMessageTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
