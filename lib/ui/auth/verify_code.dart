import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import '../../widgets/round_button.dart';

class VerifyCodeScreen extends StatefulWidget {
  
  final String verificationId;
  const VerifyCodeScreen({super.key, required  this.verificationId});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {

  bool loading = false;
  final phoneNumberController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            TextFormField(
              controller: phoneNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: '+1 234 567 899'),
            ),
            SizedBox(
              height: 80,
            ),
            RoundButton(
              title: 'Login',
              loading: loading,
              onTap: () {
                setState(() {
                  loading = true;
                });
                auth.verifyPhoneNumber(
                  phoneNumber: phoneNumberController.text,
                  verificationCompleted: (_) {
                    setState(() {
                      loading = false;
                    });
                  },
                  verificationFailed: (e) {
                     setState(() {
                      loading = false;
                    });
                    Utils().toastMessage(e.toString());
                  },
                  codeSent: (String verificationId, int? token) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VerifyCodeScreen(
                                verificationId: verificationId)));
                  },
                  codeAutoRetrievalTimeout: (e) {
                    Utils().toastMessage(e.toString());
                     setState(() {
                      loading = false;
                    });
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
