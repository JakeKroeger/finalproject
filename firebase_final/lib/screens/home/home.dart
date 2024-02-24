import 'package:firebase_final/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('Brew Crew'),
        backgroundColor: Colors.brown[400],
        elevation: 3,
        actions: [
          ElevatedButton.icon(
            label: const Text('Logout'),
            onPressed: () async {
              await _auth.signOut();
            },
            icon: const Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
