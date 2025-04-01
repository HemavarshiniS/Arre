import 'dart:async';

import 'package:arrre/Home%20Page/Homepage.dart';
import 'package:flutter/material.dart';

class Splashpage extends StatefulWidget {
  const Splashpage({super.key});

  @override
  State<Splashpage> createState() => _SplashpageState();
}

class _SplashpageState extends State<Splashpage> {

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(_createRoute());
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color(0xff074a65),

      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Spacer(),

            Image.asset(
                "assets/images/splash.png",
              width: 200,
              height: 70,
            ),

            SizedBox(
              height: 50,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text(
                  "Arré",
                  style: TextStyle(
                      fontSize: 26,
                      fontFamily: "OpenSans",
                      fontWeight: FontWeight.w200,
                      letterSpacing: -1,
                      color: Colors.white,
                  ),
                ),

                SizedBox(
                  width: 5,
                ),

                Text(
                  "Journal",
                  style: TextStyle(
                      fontSize: 26,
                      fontFamily: "OpenSans",
                      fontStyle: FontStyle.italic,
                      letterSpacing: -1,
                      color: Colors.white
                  ),
                )

              ],
            ),

            Spacer(),

            Text(
              "Audio journalling made easy!",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: "MonaSans",
                fontSize: 16,
                color: Color(0xffabc8d4),
              ),

            ),

          ],
        ),

      ),

    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context,animation, secondaryAnimation) => Homepage(),
  );
}