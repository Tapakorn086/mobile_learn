import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _form = GlobalKey<FormState>();
  late bool loggedId;
  late String email;
  late String password;
  late String name;
  late String confirmpassword;

  @override
  void initState() {
    super.initState();
    loggedId = false;
    email = '';
    password = '';
    name = '';
    confirmpassword = '';
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? _validateAge(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your age';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value != _passwordController.text) {
      return 'Passwords not match';
    } else if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    } else if (!value.contains('@')) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    } else if (value.length < 8) {
      return 'Please enter a password with at least 8 characters';
    }
    return null;
  }

  void _validate() {
    final form = _form.currentState;
    if (form!.validate()) {
      setState(() {
        loggedId = true;
        email = _emailController.text;
        password = _passwordController.text;
        name = _nameController.text;
        confirmpassword = _confirmPasswordController.text;
      });
    }
  }

  int _calculateAge(DateTime birthDate) {
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Page'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(99, 68, 137, 255), Colors.lightBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Container(
              height: 750,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              key: const Key("formRegister"),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: _form,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      TextFormField(
                        controller: _nameController,
                        validator: _validateName,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          prefixIcon: Icon(Icons.people),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 40),
                      TextFormField(
                        controller: _ageController,
                        validator: _validateAge, // เพิ่มการตรวจสอบอายุที่นี่
                        decoration: const InputDecoration(
                          labelText: 'Age',
                          prefixIcon: Icon(Icons.calendar_today),
                          border: OutlineInputBorder(),
                        ),
                        readOnly: true,
                        onTap: () async {
                          final DateTime today = DateTime.now();
                          final DateTime eighteenYearsAgo =
                              DateTime(today.year - 18, today.month, today.day);

                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: eighteenYearsAgo,
                            firstDate: DateTime(1950),
                            lastDate: eighteenYearsAgo,
                          );
                          if (picked != null) {
                            setState(() {
                              int age = _calculateAge(picked);
                              _ageController.text = age.toString();
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 40),
                      TextFormField(
                        controller: _emailController,
                        validator: _validateEmail,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 40),
                      TextFormField(
                        controller: _passwordController,
                        validator: _validatePassword,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 40),
                      TextFormField(
                        controller: _confirmPasswordController,
                        validator: _validateConfirmPassword,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Confirm Password',
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: _validate,
                            child: const Text('Register'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
