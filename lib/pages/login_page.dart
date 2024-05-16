import 'package:flutter/material.dart';
import 'package:recip_book_sample/services/auth_service.dart';
import 'package:status_alert/status_alert.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _loginFromKey = GlobalKey();
  String? username, password;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login",
          textAlign: TextAlign.left,
        ),
      ),
      body: SafeArea(child: _buildUI()),
    );
  }

  Widget _buildUI() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [_title(), _loginForm()],
      ),
    );
  }

  Widget _title() {
    return const Text(
      "Recip Book",
      style: TextStyle(fontSize: 35, fontWeight: FontWeight.w300),
    );
  }

  Widget _loginForm() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.90,
      height: MediaQuery.sizeOf(context).height * 0.30,
      child: Form(
        key: _loginFromKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              initialValue: "kminchelle",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter a username";
                }
              },
              onSaved: (value) {
                setState(() {
                  username = value;
                });
              },
              decoration: InputDecoration(hintText: "Username"),
            ),
            TextFormField(
              initialValue: "0lelplR",
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter a vaild password";
                }
              },
              onSaved: (value) {
                setState(() {
                  password = value;
                });
              },
              decoration: InputDecoration(hintText: "Password"),
            ),
            _loginButton()
          ],
        ),
      ),
    );
  }

  Widget _loginButton() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.60,
      child: ElevatedButton(
          onPressed: () async {
            if (_loginFromKey.currentState?.validate() ?? false) {
              _loginFromKey.currentState?.save();
              bool result = await AuthService().login(username!, password!);
              if (result) {
                Navigator.pushReplacementNamed(context, "/home");
              } else {
                StatusAlert.show(context,
                    duration: Duration(seconds: 2),
                    title: "Login Failed",
                    subtitle: "Please try again",
                    configuration: const IconConfiguration(icon: Icons.error),
                    maxWidth: 260);
              }
            }
          },
          child: const Text("Login")),
    );
  }
}
