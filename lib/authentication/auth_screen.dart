import 'package:flutter/material.dart';
import 'package:fooderturk_sellers_app/authentication/login.dart';
import 'package:fooderturk_sellers_app/authentication/register.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.red, Colors.redAccent],
                        begin: FractionalOffset(0.0, 0.0),
                        end: FractionalOffset(1.0, 0.0),
                        stops: [0.0, 0.7],
                        tileMode: TileMode.mirror)),
              ),
              automaticallyImplyLeading: false,
              title: const Text(
                "iFood",
                style: TextStyle(
                    color: Colors.white, fontFamily: "Lobster", fontSize: 60),
              ),
              centerTitle: true,
              bottom: const TabBar(
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                    text: "Login",
                  ),
                  Tab(
                    icon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    text: "Register",
                  )
                ],
                indicatorColor: Colors.white38,
                indicatorWeight: 6,
                labelColor: Colors.yellow,
                unselectedLabelColor: Colors.white,
              ),
            ),
            body: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                colors: [Colors.red, Colors.redAccent],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              )),
              child: const TabBarView(
                children: [LoginScreen(), RegisterScreen()],
              ),
            )),
      ),
    );
  }
}
