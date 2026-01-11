import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:unii_demo/component/color.dart';
import 'package:unii_demo/country.dart';
import 'package:unii_demo/otp.dart';
import 'package:unii_demo/component/Button.dart';

class LoginPage extends StatefulWidget {
  final String code;
  final String dial;
  const LoginPage({required this.code, required this.dial, super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneController = TextEditingController();
  String phoneNumber = "";

  String formatPhone(String phone) {
    phone = phone.trim();
    if (phone.startsWith('0')) {
      phone = phone.substring(1);
    }
    return phone;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: CoLor.background,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            //IMG Backgroud
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset("images/Clippathgroup.png", fit: BoxFit.cover),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: size.height * 0.12,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: AlignmentGeometry.topCenter,
                    end: AlignmentGeometry.bottomCenter,
                    colors: [CoLor.purple, CoLor.darkpurple],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'Anuphan',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: size.height * 0.15,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Text(
                    "Enter your mobile number to Login.",
                    style: TextStyle(
                      color: Color(0xff5C5C5C),
                      fontSize: 16,
                      fontFamily: 'Anuphan',
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.06,
                    ),
                    child: TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: 'Phone number',
                        prefixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(width: size.width * 0.025),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CountryPage(),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Text(widget.code),
                                  SizedBox(width: size.width * 0.01),
                                  Text(widget.dial),
                                  Icon(Icons.arrow_drop_down),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.04,
                              child: VerticalDivider(
                                color: Color.fromARGB(255, 192, 192, 192),
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 192, 192, 192),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  CustomButton(
                    text: "Login",
                    onPressed: () {
                      formatPhone(phoneController.text);
                      if (phoneController.text.length == 9 ||
                          phoneController.text.length == 10) {
                        String formattedPhone = formatPhone(
                          phoneController.text,
                        );

                        setState(() {
                          phoneNumber = formattedPhone;
                        });

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OtpPage(
                              phoneNumber: phoneNumber,
                              dial: widget.dial,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter your Phone Number'),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
