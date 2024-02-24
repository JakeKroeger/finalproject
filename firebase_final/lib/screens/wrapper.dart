import 'package:firebase_final/models/user.dart';
import 'package:firebase_final/screens/authenticate/authenticate.dart';
//import 'package:firebase_final/screens/authenticate/sign_in.dart';
import 'package:firebase_final/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    print(user);
    // return either the Home or Authenticate widget
    return user == null ? Authenticate() : Home();
  }
}
