import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, dynamic> data = {};

  @override
  Widget build(BuildContext context) {
    // Safely retrieve arguments from ModalRoute
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    // Update data if arguments are provided
    if (args != null) {
      data = data.isNotEmpty ? data : args;
      print(data);
    }

    // Retrieve values with default fallbacks
    final location = data['location'] ?? 'Unknown Location';
    final time = data['time'] ?? 'Unknown Time';
    final isDayTime = data['isDayTime'] ?? true; // Default to `true` if `null`

    // Set background based on `isDayTime` (ensure it's not null)
    String bgImage = isDayTime ? 'day.png' : 'night.png';
    Color bgColor = isDayTime ? Colors.blue : Colors.indigo[700]!;

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: Column(
              children: [
                // Edit Location Button
                TextButton.icon(
                  onPressed: () async{
                    dynamic result = await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = {
                        'time' : result['time'],
                        'location' : result['location'],
                        'isDayTime' : result['isDayTime'],
                        'flag' : result['flag'],

                      };
                    });
                  },
                  icon: const Icon(
                    Icons.edit_location,
                    color: Colors.grey,
                  ),
                  label: const Text(
                    'Edit Location',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Display Location
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      location,
                      style: const TextStyle(
                        fontSize: 28,
                        letterSpacing: 2,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Display Time
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 66,
                    color: Colors.white,
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
