import 'package:fbase/user_screen.dart';
import 'package:fbase/logging_in/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_icons/icons8.dart';
import 'package:lottie/src/lottie.dart';

String girismail = '';

class KullaniciGiris extends StatefulWidget {
  const KullaniciGiris({super.key});

  @override
  State<KullaniciGiris> createState() => _KullaniciGirisState();
}

class _KullaniciGirisState extends State<KullaniciGiris> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  void GirisYap() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: _email.text.trim(),
      password: _password.text.trim(),
    )
        .then((userCredential) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Kullanici(email: _email.text.trim())));
    }).catchError((error) {
      // Handle login errors here
      String errorMessage = "An error occurred. Please check your email and password.";

      if (error is FirebaseAuthException) {
        if (error.code == 'user-not-found') {
          errorMessage = "No user found with this email.";
        } else if (error.code == 'wrong-password') {
          errorMessage = "Wrong password. Please try again.";
        }
      }

      // Show the error message using a SnackBar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
      ));
    });
    girismail = _email.text.trim();
  }

  void uselessFunc(){
    return;
}

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          splashRadius: 50,
          iconSize: 100,
          icon: Lottie.asset(Icons8.book, height: 70, fit: BoxFit.fitHeight),
          onPressed: null,
        ),
        TFdesign(alanadi: "email", onTap: uselessFunc, degisken: _email),
        TFdesign(alanadi: "password", onTap: uselessFunc, degisken: _password),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
          onPressed: () {
            GirisYap();
          },
          child: Text("Log in"),
        ),
      ],
    );
  }

}