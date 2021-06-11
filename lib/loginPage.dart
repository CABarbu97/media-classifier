import 'package:flutter/material.dart';
import 'package:media_classifier/authentication_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class LoginPage extends StatefulWidget {
  const LoginPage() : super();

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              height: 220,
              decoration: BoxDecoration(
                //color: Colors.orange.shade100,
                image: DecorationImage(
                  image: AssetImage('assets/logo.png'),
                ),
              ),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
              ),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  await context.read<AuthenticationService>().signIn(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim());
                },
                child: Text("Sign in"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red.shade600,
                  onPrimary: Colors.white,
                )),
            ElevatedButton(
              onPressed: () async {
                await context.read<AuthenticationService>().signUp(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim());
              },
              child: Text("Register"),
              style: ElevatedButton.styleFrom(
                primary: Colors.red.shade600,
                onPrimary: Colors.white,
              ),
            ),
            GoogleSignInButton(
              onPressed: () async {
                await context.read<AuthenticationService>().signInWithGoogle();
              }, // default: false
            )
          ],
        ),
      ),
    );
  }
}
