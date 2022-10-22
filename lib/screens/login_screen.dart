import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:message_me/screens/chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../widgets/mybutton.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInScreen extends StatefulWidget {
  static const String screenRout = 'signin_screen';
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 250.0,
                  child: Image.asset('assets/images/cats.png'),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value;
                  },
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                    hintText: 'Enter your Email',
                    // ignore: prefer_const_constructors
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    // ignore: prefer_const_constructors
                    border: OutlineInputBorder(
                        // ignore: prefer_const_constructors
                        borderRadius: BorderRadius.all(
                      const Radius.circular(10),
                    )),
                    // ignore: prefer_const_constructors
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.orange, width: 1),
                      // ignore: prefer_const_constructors
                      borderRadius: BorderRadius.all(
                        const Radius.circular(10),
                      ),
                    ),
                    // ignore: prefer_const_constructors
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2),
                      // ignore: prefer_const_constructors
                      borderRadius: BorderRadius.all(
                        const Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                  keyboardType: TextInputType.phone,
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
                  },
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                    hintText: 'Enter your Password',
                    // ignore: prefer_const_constructors
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    // ignore: prefer_const_constructors
                    border: OutlineInputBorder(
                        // ignore: prefer_const_constructors
                        borderRadius: BorderRadius.all(
                      const Radius.circular(10),
                    )),
                    // ignore: prefer_const_constructors
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.orange, width: 1),
                      // ignore: prefer_const_constructors
                      borderRadius: BorderRadius.all(
                        const Radius.circular(10),
                      ),
                    ),
                    // ignore: prefer_const_constructors
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2),
                      // ignore: prefer_const_constructors
                      borderRadius: BorderRadius.all(
                        const Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 25.0,
                ),
                MyButton(
                    color: const Color.fromARGB(255, 245, 86, 23),
                    text: 'sign in',
                    function: () async {
                      try {

                        final user = await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        // ignore: unnecessary_null_comparison
                        if (user != null) {
                          // ignore: use_build_context_synchronously
                          Navigator.pushNamed(context, ChatScreen.screenRout);
                        }
                      } catch (e) {
                        print(e);
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
