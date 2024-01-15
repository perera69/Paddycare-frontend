import 'package:flutter/material.dart';
import 'package:login_signup_flow_app/screens/forgot_password_screen.dart';
import 'package:login_signup_flow_app/screens/guestscreen.dart';
import 'package:login_signup_flow_app/screens/register_screen.dart';
import 'package:login_signup_flow_app/api_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nicController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> _handleLogin() async {
    final data = {
      "nic": nicController.text,
      "password": passwordController.text,
    };

    try {
      final response = await ApiServicelogin.loginUser(data);
      print("Response: $response");

      if (response['message'] == 'Login successful') {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Login Successful'),
              content: Text('You have successfully logged in.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    // Navigate to the next screen on dialog confirmation
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ImageUpload()),
                    );
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed. Please try again.'),
          ),
        );
      }
    } catch (e) {
      // Show error message in case of any exceptions
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 0, 0, 0),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: const Text(
                  "Welcome back! Glad to see you, Again!",
                  style: TextStyle(
                    color: Color.fromARGB(255, 15, 78, 2),
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            //NIC
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F8F9),
                  border: Border.all(
                    color: const Color(0xFFE8ECF4),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: TextFormField(
                    controller: nicController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter your NIC no',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 32, 70, 1),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            //password
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F8F9),
                  border: Border.all(
                    color: const Color(0xFFE8ECF4),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter your password',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 32, 70, 1),
                      ),
                      suffixIcon: Icon(
                        Icons.remove_red_eye,
                        color: Color(0xFF8391A1),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            //forgot password
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ForgotPasswordScreen()));
                  },
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: Color.fromARGB(255, 7, 80, 0),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            //login button
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 5,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      color: Color.fromARGB(255, 20, 119, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onPressed: () {
                        _handleLogin();
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don’t have an account? ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterScreen()));
                  },
                  child: const Text(
                    "Register",
                    style: TextStyle(
                      color: Color.fromARGB(255, 66, 143, 2),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
