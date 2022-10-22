import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:message_me/screens/login_screen.dart';
import 'package:message_me/screens/register_screen.dart';
import '../widgets/mybutton.dart';

class welcomScreen extends StatefulWidget {
  static const String screenRout = 'welcome_screen';

  const welcomScreen({Key? key}) : super(key: key);

  @override
  State<welcomScreen> createState() => _welcomScreenState();
}

class _welcomScreenState extends State<welcomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  height: 150.0,
                  child: Image.asset('assets/images/image.png'),
                ),
                const Text(
                  'MessageMe',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w900,
                    color: Color(0xff00004d),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30.0,
            ),
            MyButton(
              color: Colors.yellow[900]!,
              text: 'Sign in',
              function: () {
                Navigator.pushNamed(context, SignInScreen.screenRout);
              },
            ),
            MyButton(
              color: const Color.fromARGB(255, 5, 41, 83),
              text: 'Register',
              function: () {
                Navigator.pushNamed(context, RegisterScreen.screenRout);
              },
            ),
          ],
        ),
      ),
    );
  }
}
