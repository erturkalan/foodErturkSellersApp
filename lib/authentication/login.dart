import 'package:flutter/material.dart';
import 'package:fooderturk_sellers_app/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Image.asset(
                "images/seller.png",
                height: 300,
              ),
            ),
          ),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                      controller: emailController,
                      iconData: Icons.email,
                      hintText: "Email",
                      isObscure: false),
                  CustomTextField(
                      controller: passwordController,
                      iconData: Icons.lock,
                      hintText: "Password",
                      isObscure: false),
                ],
              )),
          ElevatedButton(
            onPressed: () {
              //TODO: Login!!
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 12)),
            child: const Text(
              "Login",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
