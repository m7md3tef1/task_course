import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart'
    as v;
import 'package:projectgrad/animated_list.dart';
import 'package:projectgrad/customtextfile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projectgrad/signupScreen.dart';

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

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  var s = true;
  String? email, password, name, rePassword;
  var SignInKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return v.KeyboardVisibilityBuilder(
        builder: (context, visible) => Padding(
              padding: EdgeInsets.only(bottom: visible ? .31.sh : 0),
              child: Scaffold(
                body: SingleChildScrollView(
                  child: InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                      },
                      child: Column(children: [
                        ClipPath(
                          clipper: WaveShape(),
                          child: SizedBox(
                            width: 1.sw,
                            height: 150.h,
                            child: Container(
                                color: Colors.deepPurple,
                                child: Center(
                                    child: Text(
                                  'Login',
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
                              label: 'Enter Email',
                              name: 'Email',
                              keyboard: TextInputType.emailAddress,
                              hint: 'Enter Email',
                              onsaved: (value) {
                                email = value;
                              },
                              validator: (value) {
                                return value.toString().isEmpty
                                    ? 'Please Enter Password'
                                    : null;
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
                                rePassword = value;
                              },
                              validator: (value) {
                                return value.toString().isEmpty
                                    ? 'Please Enter Password'
                                    : null;
                              },
                              icondata: Icons.lock,
                              secure: s == true ? true : false,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 120,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: TextButton(
                                      onPressed: () {
                                        // Navigator.pushNamed(context, 'ForgetPass');
                                      },
                                      child: const Text(
                                        'Forgot your Password?',
                                        style: TextStyle(
                                            color: Colors.deepPurple,
                                            fontSize: 15),
                                      )),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return const AnimatedListScreen();
                                        }));
                                      },
                                      child: const Text(
                                        'Sign up',
                                        style: TextStyle(
                                            color: Colors.black26,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )),
                                )
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                if (SignInKey.currentState!.validate()) {
                                  SignInKey.currentState!.save();
                                  try {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return const AnimatedListScreen();
                                    }));
                                  } catch (error) {
                                    print(error);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(error.toString())));
                                  }
                                } else {
                                  const SnackBar(
                                      content: Text('Complete Require Data'));
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    12, 5.0, 12.0, 5.0),
                                child: Container(
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                      color: Colors.deepPurple,
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  child: const Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Login ',
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
                            InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return const RegisterScreen();
                                }));
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    12, 5.0, 12.0, 5.0),
                                child: Container(
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.deepPurple),
                                      borderRadius:
                                          BorderRadius.circular(12.r)),
                                  child: const Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Register',
                                        style: TextStyle(
                                            color: Colors.deepPurple,
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
                                    // Navigator.pushNamed(
                                    //     context, 'SignoutScreen');
                                  },
                                  child: const Text(
                                    'Don\'t have an account',
                                    style: TextStyle(
                                        color: Colors.black26, fontSize: 20),
                                  )),
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return const AnimatedListScreen();
                                }));
                              },
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'Skip   ',
                                  style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ]),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(30.0, 1, 10.0, 6),
                          child: Row(
                            children: [
                              SizedBox(
                                  width: .35.sw,
                                  child: const Divider(
                                    color: Colors.black26,
                                    thickness: 2,
                                  )),
                              const Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '    OR    ',
                                    style: TextStyle(
                                        color: Colors.deepPurple,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )),
                              SizedBox(
                                  width: .35.sw,
                                  child: const Divider(
                                    color: Colors.black26,
                                    thickness: 2,
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .02,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  22.h, 5.0.h, 22.0.h, 5.0.h),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(13)),
                                child: const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Icon(
                                        FontAwesomeIcons.google,
                                        color: Colors.red,
                                      ),
                                    ),
                                    Text(
                                      ' SIGN IN WITH Google',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 23,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  22.h, 5.0.h, 22.0.h, 5.0.h),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(13)),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(12.h),
                                      child: const Icon(
                                        FontAwesomeIcons.facebook,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const Text(
                                      ' SIGN IN WITH Facebook',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 23,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ])),
                ),
              ),
            ));
  }
}
