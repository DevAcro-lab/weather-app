import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';

class Location {
  late double longitude;
  late double latitude;

  Future<void> getCurrentLocation() async {
    try {
      LocationPermission permission;
      permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      longitude = position.longitude;
      latitude = position.latitude;
    } catch (e) {
      print(e);
    }
  }
}
