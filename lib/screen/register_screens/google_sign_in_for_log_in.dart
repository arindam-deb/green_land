import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInForLogIn extends StatefulWidget {
  GoogleSignInForLogIn({super.key});

  @override
  State<GoogleSignInForLogIn> createState() => _GoogleSignInForLogInState();
}

class _GoogleSignInForLogInState extends State<GoogleSignInForLogIn> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleSignInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential =
        await _auth.signInWithCredential(credential);

    // Return the user credential.
    return userCredential;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                try {
                  final UserCredential userCredential = await signInWithGoogle();
                  // Handle successful sign-in.
                } catch (e) {
                  // Handle sign-in error.
                }
              },
              child: Text('Sign in with Google'),
            )
          ],
        ),
      ),
    );
  }
}
