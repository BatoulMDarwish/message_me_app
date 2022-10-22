import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:message_me/screens/chat_screen.dart';
import 'package:message_me/screens/login_screen.dart';
import 'package:message_me/screens/register_screen.dart';
import 'package:message_me/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
void main()async {
WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  final _auth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Message Me',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: _auth.currentUser !=null?
          ChatScreen.screenRout:
         welcomScreen.screenRout,
      routes: {
        welcomScreen.screenRout: (context) => const welcomScreen(),
        RegisterScreen.screenRout: (context) => const RegisterScreen(),
        SignInScreen.screenRout: (context) => const SignInScreen(),
        ChatScreen.screenRout: (context) => const ChatScreen(),
      },
    );
  }
}
