import 'package:flutter/material.dart';
import 'package:patient/main.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: Color.fromARGB(171, 27, 176, 106),
                child: Icon(Icons.people, size: 50, color: Colors.white),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const MainPage()),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 216, 168, 7),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      'Back',style: TextStyle(color: Colors.white,fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Project Team',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const Divider(
                thickness: 1,
                height: 20,
                color: Colors.red,
              ),
              _buildTeamMember('Hemin Hassan'),
              _buildTeamMember('Huda Abdulla'),
              _buildTeamMember('Hogr Twana'),
              _buildTeamMember('Miran Abdulla'),
              const SizedBox(height: 10),
              const Divider(thickness: 1, height: 5),
              const SizedBox(height: 10),
              const Text(
                'Supervised by',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const Text(
                'Dr. Ako abubakir jaefar',
                style: TextStyle(
                    fontSize: 25, color: Color.fromARGB(255, 18, 17, 17)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTeamMember(String name) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: const Color.fromARGB(193, 163, 169, 177),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.person,
              color: Color.fromARGB(171, 27, 176, 106),
              size: 40,
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.all(10),
              width: 300,
              color: Color.fromARGB(171, 27, 176, 106),
              child: Center(
                child: Text(
                  name,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
