// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:unii_demo/component/color.dart';
import 'package:unii_demo/summery.dart';
import 'package:unii_demo/component/button.dart';

class OtpPage extends StatefulWidget {
  final String phoneNumber;
  final String dial;
  const OtpPage({
    required this.phoneNumber,
    required this.dial,
    super.key,
  });

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController OTPController = TextEditingController();
  String OTP = '';

  @override
  void dispose() {
    OTPController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Default Pin Theme
    const PinTheme defultOTPTheme = PinTheme(
      height: 56,
      width: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      textStyle: TextStyle(
        color: Color(0xff333333),
        fontSize: 16,
        fontFamily: 'Anuphan',
      ),
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: CoLor.background,
        body: Stack(
          children: [
            // AppBar
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
                child: Stack(
                  // alignment: Alignment.bottomCenter,
                  children: [
                    Positioned(
                      top: size.height * 0.07,
                      left: size.width * 0.38,
                      child: Text(
                        "OTP Code",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'Anuphan',
                        ),
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.055,
                      left: size.width * 0.03,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_rounded,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Logo and Text
            Positioned(
              top: size.height * 0.19,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Image.asset("images/Uniilogo.png"),
                  SizedBox(height: size.height * 0.04),
                  Text(
                    "Enter 6 digit code",
                    style: TextStyle(
                      fontFamily: 'Anuphan',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff333333),
                    ),
                  ),
                  Text(
                    "send to your number",
                    style: TextStyle(
                      fontFamily: 'Anuphan',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff333333),
                    ),
                  ),
                ],
              ),
            ),

            // OTP
            Positioned(
              top: size.height * 0.42,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                    child: Pinput(
                      length: 6,
                      controller: OTPController,
                      defaultPinTheme: defultOTPTheme,
                      focusedPinTheme: defultOTPTheme.copyWith(
                        decoration: defultOTPTheme.decoration!.copyWith(
                          border: Border.all(color: CoLor.purple, width: 2),
                        ),
                      ),
                      showCursor: true,
                      onCompleted: (pin) => setState(() {
                        OTP = OTPController.text;
                      }),
                    ),
                  ),
                ],
              ),
            ),

            // Button
            Positioned(
              bottom: size.height * 0.04,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  CustomButton(
                    text: "Confirm",
                    onPressed: () {
                      if (OTP.length == 6) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SummeryPage(
                              phoneNumber: widget.phoneNumber,
                              OTPnumber: OTP,
                              dial: widget.dial,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter the OTP code'),
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
