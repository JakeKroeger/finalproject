import 'package:firebase_final/services/auth.dart';
import 'package:firebase_final/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:firebase_final/shared/constants.dart';

class SignIn extends StatefulWidget {
  //Variables initiation
  final Function toggleView;

  //Class initiation
  SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //Textfield State
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            //----------------APP_BAR------------------
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: const Text('Sign in to Brew Crew'),
              actions: [
                ElevatedButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Register'),
                  onPressed: () {
                    widget.toggleView();
                  },
                )
              ],
            ),

            //-----------------------BODY_BEGIN----------------------
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
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
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
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Password'),
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
                        //ElevatedButtonLogic
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await _auth
                                .signInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                error =
                                    'Could not sign in with those Credentials';
                                loading = false;
                              });
                              print(error);
                            }
                          }
                        },

                        //ElevatedButton Styling
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink[400],
                        ),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),

                      //Error message Display
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
