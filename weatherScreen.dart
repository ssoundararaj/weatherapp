import 'package:flutter/material.dart';
import 'package:my_weather_app/web_service_api.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherApiService _apiService = WeatherApiService();
  TextEditingController _searchController = TextEditingController();
  Map<String, dynamic>? _weatherData;

  void _fetchWeatherData(String city) async {
    try {
      final data = await _apiService.fetchWeatherData(city);
      setState(() {
        _weatherData = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        backgroundColor: Colors.lightGreen,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            ListTile(
              title: Text('No.1'),
            ),
            Divider(
              height: 0.2,
            ),
            ListTile(
              title: Text('No.1'),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                  labelText: 'Enter city', suffix: Icon(Icons.search)),
            ),
            ElevatedButton(
              onPressed: () {
                _fetchWeatherData(_searchController.text);
              },
              child: Text('Get Weather'),
            ),
            if (_weatherData != null)
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      '${_weatherData!['location']['name']}, ${_weatherData!['location']['country']}',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Image.network(
                    'https:${_weatherData!['current']['condition']['icon']}',
                    height: 200.0,
                    width: 200.0,
                  ),
                  Text(
                    '${_weatherData!['current']['temp_c']}°C',
                    style: const TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    _weatherData!['current']['condition']['text'],
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                    // width: 15.0,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Divider(
                          height: 0.2,
                        ),
                        ListTile(
                            leading: const Icon(
                              Icons.wb_sunny,
                              color: Colors.yellow,
                            ),
                            title: const Text("Temperature"),
                            subtitle: Text(
                                '${_weatherData!['current']['temp_c']}°C')),
                        Divider(
                          height: 0.2,
                        ),
                        ListTile(
                            leading: const Icon(
                              Icons.cloud,
                              color: Colors.blue,
                            ),
                            title: const Text("Weather"),
                            subtitle: Text(
                              _weatherData!['current']['condition']['text'],
                            )),
                        Divider(
                          height: 0.2,
                        ),
                        ListTile(
                            leading: const Icon(
                              Icons.opacity,
                              color: Colors.blueGrey,
                            ),
                            title: const Text("Humidity"),
                            subtitle: Text(
                                '${_weatherData!['current']['humidity']}%')),
                        Divider(
                          height: 0.2,
                        ),
                        ListTile(
                            leading: const Icon(
                              Icons.air,
                              color: Color.fromARGB(255, 69, 29, 182),
                            ),
                            title: const Text("Wind Speed"),
                            subtitle: Text(
                                '${_weatherData!['current']['wind_kph']} km/h')),
                        Divider(
                          height: 0.2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Colors.black12,
          ),
        ],
      ),
    );
  }
}
