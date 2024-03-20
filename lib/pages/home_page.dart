import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_button/sign_in_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? user;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((event) {
      setState(() {
        user = event;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google SignIn'),
      ),
      body: user!=null ? UserInfo(): GoogleSignInButton(),
    );
  }

  Widget GoogleSignInButton(){
    return Center(
      child: SizedBox(
        height: 50,
        child: SignInButton(Buttons.google, text: 'SignIn via Google', onPressed: handleGoogleSignIn,),
      ),
    );
  }

  Widget UserInfo(){
    return SizedBox();
  }

  void handleGoogleSignIn(){
    try{
      GoogleAuthProvider _googlAuthProvider = GoogleAuthProvider();
      _auth.signInWithProvider(_googlAuthProvider);
    }catch(error){
      print(error);
    }
  }
}

class MyCustomForm extends StatelessWidget {
  const MyCustomForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'email',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Password',
            ),
          ),
        ),
        
      ],
    );
  }
}