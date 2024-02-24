import 'package:firebase_final/services/auth.dart';
import 'package:firebase_final/shared/constants.dart';
import 'package:firebase_final/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: const Text('Sign Up to Brew Crew'),
              actions: [
                ElevatedButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Sign In'),
                  onPressed: () {
                    widget.toggleView();
                  },
                )
              ],
            ),
            body: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      //Email TextField----------------
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        //TextFormField Decoration
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),

                        //ValidatorOfTextField
                        validator: (value) =>
                            value!.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),

                      //Password TextField---------------
                      const SizedBox(height: 20.0),
                      TextFormField(
                        //TextFormFieldDecoration
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Password'),

                        //ValidatorOfTextField
                        validator: (value) => value!.length < 6
                            ? 'Enter a password 6+ chars long'
                            : null,
                        obscureText: true,
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                      ),

                      //SignIn Button----------------
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await _auth
                                .registerWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error = 'Please supply a valid email';
                              });
                              print(error);
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink[400],
                        ),
                        child: const Text(
                          'Register',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),

                      //Error message Display-----------------
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      )
                    ],
                  )),
            ),
          );
  }
}
