import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart'
as v;
import 'package:projectgrad/animated_list.dart';
import 'package:projectgrad/customtextfile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projectgrad/signinScreen.dart';

class WaveShape extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();
    final lowPoint = size.height - 19;
    final highPoint = size.height - 49;

    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width / 4, highPoint, size.width / 2, lowPoint);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, lowPoint);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var s = true;
  var se = true;
  String? email, password, name, rePassword;
  var SignInKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return v.KeyboardVisibilityBuilder(
        builder: (context,visible)=>Padding(
          padding: EdgeInsets.only(bottom: visible ? .31.sh : 0),
          child: Scaffold(
            body: SingleChildScrollView(
              child: InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Column(

                    children: [
                      ClipPath(
                        clipper: WaveShape(),
                        child: SizedBox(
                          width: 1.sw,
                          height: 150.h,
                          child: Container(
                              color: Colors.deepPurple,
                              child: Center(
                                  child: Text(
                                    'Register',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 28.sp,
                                        fontWeight: FontWeight.bold),
                                  ))),
                        ),
                      ),
                      // Align(
                      //   alignment: Alignment.center,
                      //   child: SizedBox(
                      //     child: DefaultTextStyle(
                      //       style: const TextStyle(color: Colors.blue, fontSize: 30),
                      //       child: AnimatedTextKit(
                      //         totalRepeatCount: 4,
                      //         //  pause: Duration(milliseconds: 1000),
                      //         animatedTexts: [
                      //           TyperAnimatedText(
                      //             'Log in with your Email',
                      //           )
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                      Form(
                        key: SignInKey,
                        child: Column(children: [
                          CustomTextFormField(
                            label: 'Full Name',
                            name: 'Full Name',
                            hint: 'Enter Name',
                            keyboard: TextInputType.name,
                            onsaved: (value) {
                              name = value;
                            },
                            validator: (value) {
                              return value.toString().isEmpty? 'Please Enter Name':null;
                            },
                            icondata: Icons.person,
                            secure: false,
                          ),
                          CustomTextFormField(
                            label: 'Enter Email',
                            name: 'Email',
                            keyboard: TextInputType.emailAddress,
                            hint: 'Enter Email',
                            onsaved: (value) {
                              email = value;
                            },
                            validator: (value) {
                              return value.toString().isEmpty? 'Please Enter Email':null;
                            },
                            icondata: Icons.email,
                            secure: false,
                          ),
                          CustomTextFormField(
                            label: 'Enter Password',
                            name: 'Password',
                            keyboard: TextInputType.visiblePassword,
                            hint: 'Enter Password',
                            suffix: InkWell(
                                onTap: () {
                                  setState(() {
                                    s = !s;
                                  });
                                },
                                child: s
                                    ? const Icon(
                                  Icons.visibility_off,
                                  //  color: Colors.black54,
                                )
                                    : const Icon(
                                  Icons.visibility,
                                  // color: Colors.black54,
                                )),
                            onsaved: (value) {
                              password = value;
                            },
                            validator: (value) {
                              return value.toString().isEmpty? 'Please Enter Password':null;
                            },
                            icondata: Icons.lock,
                            secure: se == true ? true : false,
                          ),
                          CustomTextFormField(
                            keyboard: TextInputType.visiblePassword,
                            label: 'Re-Enter Password',
                            name: 'Password',
                            hint: 'Enter Password',
                            suffix: InkWell(
                                onTap: () {
                                  setState(() {
                                    se = !se;
                                  });
                                },
                                child: se
                                    ? const Icon(
                                  Icons.visibility_off,
                                  //        color: Colors.black54,
                                )
                                    : const Icon(
                                  Icons.visibility,
                                  //      color: Colors.black54,
                                )),
                            onsaved: (value) {
                              rePassword = value;
                            },
                            validator: (value) {
                              return value.toString().isEmpty
                                  ? 'please Enter  Password'
                                  : 'pass Didn\'t Same Confirm pass';
                            },
                            icondata: Icons.lock,
                            secure: se == true ? true : false,
                          ),
                          CustomTextFormField(
                            label: 'Enter Phone',
                            keyboard: TextInputType.phone,
                            name: 'Phone',
                            hint: 'Enter Phone',
                            onsaved: (value) {
                              email = value;
                            },
                            validator: (value) {
                              return value.toString().isEmpty? 'Please Enter Name':null;
                            },
                            icondata: Icons.phone,
                            secure: false,
                          ),
                          InkWell(
                            onTap: () {
                              if (SignInKey.currentState!.validate()) {
                                SignInKey.currentState!.save();
                                try {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (context) {
                                    return const AnimatedListScreen();
                                  }));
                                } catch (error) {
                                  print(error);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(error.toString())));
                                }
                              } else {
                                const SnackBar(
                                    content: Text('Complete Require Data'));
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(12, 5.0, 12.0, 5.0),
                              child: Container(
                                height: 50.h,
                                decoration: BoxDecoration(
                                    color: Colors.deepPurple,
                                    borderRadius: BorderRadius.circular(10.r)),
                                child: const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Register ',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (context) {
                                    return const SigninScreen();
                                  }));
                                },
                                child: const Text(
                                  'Do you have an account',
                                  style:
                                  TextStyle(color: Colors.black26, fontSize: 20),
                                )),
                          ),
                        ]),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .03,
                      ),
                    ]),
              ),
            ),
          ),
        )

    );
  }
}
