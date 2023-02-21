import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatefulWidget {
  String? name;
  String? hint;
  String? label;
  var icondata;
  var suffix;
  var keyboard;

  bool? secure;
  void Function(String?)? onsaved;
  String Function(String?)? validator;
  CustomTextFormField({super.key,
    this.name,
    this.hint,
    this.label,
    this.icondata,
    this.secure,
    this.onsaved,
    this.validator,
    this.keyboard,
    this.suffix,
  });
  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
        child: TextFormField(
            style: const TextStyle(color: Colors.deepPurple),
            obscureText: widget.secure!,
            onSaved: widget.onsaved,
            validator: widget.validator,
            keyboardType: widget.keyboard,

            autofocus: false,
            decoration: InputDecoration(
              prefixIcon: Icon(
                widget.icondata,
                color: Colors.black38,
              ),
              labelText: widget.label,
              labelStyle: const TextStyle(color: Colors.deepPurple),
              suffixIcon: widget.suffix,
              hintText: widget.hint,
              hintStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                //     color: color,
              ),
              border: const OutlineInputBorder(),
              focusColor: Colors.deepPurple,
            )));
  }
}
