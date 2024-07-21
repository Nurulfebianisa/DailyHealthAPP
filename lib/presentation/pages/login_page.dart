import 'package:course_tusk_app/common/app_color.dart';
import 'package:course_tusk_app/common/app_info.dart';
import 'package:course_tusk_app/common/app_route.dart';
import 'package:course_tusk_app/data/source/user_source.dart';
import 'package:course_tusk_app/presentation/widgets/app_button.dart';
import 'package:d_session/d_session.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController edtEmail = TextEditingController();
  final TextEditingController edtPassword = TextEditingController();
  bool _isPasswordVisible = false;

  void login(String email, String password, BuildContext context) {
    print('Attempting to login with email: $email');
    UserSource.login(email, password).then((result) {
      if (result == null) {
        print('Login failed');
        AppInfo.failed(context, 'Login Failed');
      } else {
        print('Login successful');
        AppInfo.success(context, 'Login Success');
        DSession.setUser(result.toJson());
        Navigator.pushNamed(context, AppRoute.home);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/By febi.png',
                  height: 120,
                  width: 120,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Daily Healthy Food Management App',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Email',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: TextField(
                    controller: edtEmail,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: 'Enter your email',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Password',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: TextField(
                    controller: edtPassword,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      hintText: 'Enter your password',
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(12),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                AppButton.primary('LOGIN', () {
                  login(edtEmail.text, edtPassword.text, context);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
