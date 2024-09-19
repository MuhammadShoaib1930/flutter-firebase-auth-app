import 'package:fire_base_application/forgot_password.dart';
import 'package:fire_base_application/main.dart';
import 'package:fire_base_application/sign_up_page.dart';
import 'package:fire_base_application/ui_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  login(String email, String password) async {
    if (email == "" && password == "") {
      return UiHelper.customAlertBox(context, "Enter Required Password");
    } else {
      UserCredential? userCredential;
      try {
        userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MyHomePage())));
      } on FirebaseAuthException catch (ex) {
        return UiHelper.customAlertBox(context, ex.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UiHelper.customTextField(
              emailController, "Email", Icons.email, false),
          UiHelper.customTextField(
              passwordController, "Password", Icons.password, true),
          const SizedBox(
            height: 30,
          ),
          UiHelper.customButton(() {
            login(emailController.text.toString(),
                passwordController.text.toString());
          }, "Login"),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Already Have an Account??",
                style: TextStyle(fontSize: 16),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (content) => const SignUpPage()));
                  },
                  child: const Text("Sign Up",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)))
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ForgotPassword(),
                    ));
              },
              child: const Text(
                "Forgot Password??",
                style: TextStyle(fontSize: 20),
              )),
        ],
      ),
    );
  }
}
