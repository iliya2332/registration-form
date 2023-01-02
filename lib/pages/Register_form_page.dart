// ignore_for_file: file_names, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_final_fields, no_leading_underscores_for_local_identifiers, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_flutter_application/model/user.dart';
import 'package:new_flutter_application/pages/user_info_page.dart';

class RegisterFormPage extends StatefulWidget {
  @override
  _RegisterFormPageState createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  bool _hidePass = true;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _lifeStoryController = TextEditingController();
  final _passController = TextEditingController();
  final _confPassController = TextEditingController();

  List<String> _countries = ['Ukraine', 'Poland', 'France', 'Germany'];
  String? _selectedCoutnry;

  final _nameFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _passFocus = FocusNode();
  final _confPassFocus = FocusNode();

  User newUser = User();

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _lifeStoryController.dispose();
    _passController.dispose();
    _confPassController.dispose();
    _nameFocus.dispose();
    _phoneFocus.dispose();
    _passFocus.dispose();
    _confPassFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Register Form'),
        centerTitle: true,
      ),
      body: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              TextFormField(
                focusNode: _nameFocus,
                autofocus: true,
                onFieldSubmitted: (_) {
                  _fieldFocusChange(context, _nameFocus, _phoneFocus);
                },
                validator: (value) {
                  final _nameExp = RegExp(r'^[A-Za-z]+$');
                  if (value == null || value.isEmpty) {
                    return 'Name is require.';
                  } else if (!_nameExp.hasMatch(value)) {
                    return 'Please enter alphabetical characters.';
                  } else {
                    return null;
                  }
                },
                controller: _nameController,
                decoration: InputDecoration(
                    labelText: 'Full Name ',
                    hintText: 'What do people call you?',
                    prefixIcon: Icon(Icons.person),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _nameController.clear();
                      },
                      child: Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide:
                            BorderSide(color: Colors.black, width: 2.0)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onSaved: (value) => newUser.name = value,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                focusNode: _phoneFocus,
                onFieldSubmitted: (_) {
                  _fieldFocusChange(context, _nameFocus, _passFocus);
                },
                controller: _phoneController,
                decoration: InputDecoration(
                    labelText: 'Phone Number',
                    hintText: 'Where can we reach you?',
                    helperText: 'Phone format (XXX)XXX-XX-XX',
                    prefixIcon: Icon(Icons.call),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _phoneController.clear();
                      },
                      child: Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide:
                            BorderSide(color: Colors.black, width: 2.0)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter(RegExp(r'^[()\d -]{1,15}$'),
                      allow: true)
                ],
                validator: (value) => _validatePhoneNumber(value!)
                    ? null
                    : 'Phone number must be entered as (###)',
                onSaved: (value) => newUser.phone = value,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email Addres',
                  hintText: 'Enter a email addres',
                  prefixIcon: Icon(Icons.mail),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _emailController.clear();
                    },
                    child: Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: Colors.black, width: 2.0)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: Colors.blue, width: 2.0)),
                ),
                keyboardType: TextInputType.emailAddress,
                onSaved: (value) => newUser.email = value,
              ),
              SizedBox(
                height: 10,
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.map),
                  labelText: 'Country',
                ),
                items: _countries.map((country) {
                  return DropdownMenuItem(
                    value: country,
                    child: Text(country),
                  );
                }).toList(),
                onChanged: (country) {
                  print(country);
                  setState(() {
                    _selectedCoutnry = country;
                    newUser.country = country;
                  });
                },
                value: _selectedCoutnry,
                validator: (val) {
                  if (val == null) {
                    return 'Please select a country';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _lifeStoryController,
                decoration: InputDecoration(
                    labelText: 'Life Story',
                    hintText: 'Tell us about your self',
                    helperText: 'Keep it short, this is just a demo',
                    border: OutlineInputBorder()),
                maxLines: 3,
                onSaved: (value) => newUser.story = value,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                focusNode: _passFocus,
                autofocus: true,
                onFieldSubmitted: (_) {
                  _fieldFocusChange(context, _nameFocus, _confPassFocus);
                },
                controller: _passController,
                obscureText: _hidePass,
                maxLength: 8,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter a password',
                  suffixIcon: IconButton(
                    icon: Icon(
                        _hidePass ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _hidePass = !_hidePass;
                      });
                    },
                  ),
                  prefixIcon: Icon(Icons.security),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: Colors.black, width: 2.0)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: Colors.blue, width: 2.0)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password can not be empty';
                  } else if (_passController.text.length != 8) {
                    return '8 character require for password';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                focusNode: _confPassFocus,
                controller: _confPassController,
                obscureText: _hidePass,
                maxLength: 8,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  hintText: 'Enter a password',
                  suffixIcon: IconButton(
                    icon: Icon(
                        _hidePass ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _hidePass = !_hidePass;
                      });
                    },
                  ),
                  prefixIcon: Icon(Icons.security),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: Colors.black, width: 2.0)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: Colors.blue, width: 2.0)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password can not be empty';
                  } else if (_confPassController.text.length != 8) {
                    return '8 character required for password';
                  } else if (_confPassController.text != _passController.text) {
                    return 'Password do not match';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: _submitForm,
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green)),
                child: Text(
                  'Submit Form',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          )),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _showDialog(name: _nameController.text);
      print('Name : ${_nameController.text}');
      print('Phone: ${_phoneController.text}');
      print('Email: ${_emailController.text}');
      print('Country: $_selectedCoutnry');
      print('Life Story: ${_lifeStoryController.text}');
    } else {
      _showMessage(message: 'Form is not valid! Please review and correct');
    }
  }

  bool _validatePhoneNumber(String input) {
    final _phoneExp = RegExp(r'^\(\d\d\d\)\d\d\d-\d\d\d\d$');
    return _phoneExp.hasMatch(input);
  }

  void _showMessage({required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(
        message,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 18.0,
        ),
      ),
    ));
  }

  void _showDialog({required String name}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Registration successful',
              style: TextStyle(
                color: Colors.green,
              ),
            ),
            content: Text('$name is now a verified register form',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0)),
            actions: [
              FloatingActionButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserInfoPage(
                          userInfo: newUser,
                        ),
                      ));
                },
                child: Text(
                  'Ok',
                  style: TextStyle(color: Colors.black, fontSize: 18.0),
                ),
              )
            ],
          );
        });
  }
}
