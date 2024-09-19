import 'package:fire_base_application/main.dart';
import 'package:fire_base_application/ui_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // logic build
  signUp(String email, String password)async{
    if (email == "" && password == "") {
      UiHelper.customAlertBox(context, 'Enter Required Fields');
    } else {
      UserCredential? userCredential;
      try {
        userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then(
              (value) => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MyHomePage())),
            );
      } on FirebaseAuthException catch (ex) {
        return UiHelper.customAlertBox(context, ex.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SignUp Page"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          UiHelper.customTextField(
              emailController, "Email", Icons.email, false),
          UiHelper.customTextField(
              passwordController, "Password", Icons.password, true),
          const SizedBox(
            height: 30,
          ),
          UiHelper.customButton(() {
            signUp(emailController.text.toString(), passwordController.text.toString());
          }, "Sign Up")
        ],
      ),
    );
  }
}
// 44 minuts