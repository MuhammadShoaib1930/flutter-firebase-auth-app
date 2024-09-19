import 'package:fire_base_application/login_page.dart';
import 'package:fire_base_application/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CheckUser extends StatefulWidget {
  const CheckUser({super.key});

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  @override
  Widget build(BuildContext context) {
    return checkUser();
  }

  checkUser() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return const MyHomePage();
    } else {
      return const LoginPage();
    }
  }
}
