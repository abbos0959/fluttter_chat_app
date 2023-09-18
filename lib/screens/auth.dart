import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final formkey = GlobalKey<FormState>();
  var _islogin = false;
  var _enteredEmail = "";

  var _enteredPassword = "";
  void _submit() {
    final isvalid = formkey.currentState!.validate();

    if (isvalid) {
      formkey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(
                  left: 20, top: 30, right: 20, bottom: 20),
              width: 200,
              child: Image.asset("assets/image/chat.png"),
            ),
            Card(
              margin: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Form(
                      key: formkey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains("@")) {
                                return "Iltimos qovoqbosh to'g'ri email adress kirit";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                labelText: "Email kiriting"),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            onSaved: (newValue) {
                              _enteredEmail = newValue!;
                            },
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null ||
                                  value.trim().length < 6 ||
                                  value.trim().length > 20) {
                                return "Iltimos qovoqbosh to'g'ri parol kirit";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                labelText: "Parol kiriting"),
                            obscureText: true,
                            autocorrect: false,
                            onSaved: (newValue) {
                              _enteredPassword = newValue!;
                            },
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer),
                            onPressed: _submit,
                            child:
                                Text(_islogin ? "Kirish" : "Ro'yhatdan o'tish"),
                          ),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  _islogin = !_islogin;
                                });
                              },
                              child: Text(_islogin
                                  ? 'Hisob yaratish'
                                  : ' Menda hisob mavjud '))
                        ],
                      )),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
