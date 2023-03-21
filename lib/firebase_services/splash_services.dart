import 'package:firebase/ui/posts/post_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase/ui/auth/login_screen.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if (user != null) {
      Timer(
        const Duration(seconds: 3),
        () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostScreen(),
          ),
        ),
      );
    } else {
      Timer(
        const Duration(seconds: 3),
        () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        ),
      );
    }
  }
}
