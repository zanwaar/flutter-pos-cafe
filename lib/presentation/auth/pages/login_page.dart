import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pos_app/data/datasources/auth_local_datasource.dart';
import 'package:flutter_pos_app/presentation/auth/bloc/login/login_bloc.dart';
import 'package:email_validator/email_validator.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/buttons.dart';
// import '../../../core/components/custom_text_field.dart';
import '../../../core/components/custom_input_field.dart';
import '../../../core/components/spaces.dart';
import '../../home/pages/dashboard_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();
  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 190, 152, 94),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color.fromARGB(255, 250, 250, 250)],
            // Atur titik awal (begin) dan akhir (end) dari gradien sesuai kebutuhan Anda
            // Anda juga dapat menambahkan properti lain seperti stops untuk lebih menyesuaikan gradien
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(18.0),
          children: [
            const SpaceHeight(40.0),
            SizedBox(
              width: 250,
              height: 250,
              // padding: const EdgeInsets.symmetric(horizontal: 130.0),
              child: FittedBox(
                fit: BoxFit
                    .contain, // Sesuaikan dengan kebutuhan Anda (misal: contain, cover, fill)
                child: Image.asset(
                  Assets.images.logo.path,
                ),
              ),
            ),
            const SpaceHeight(14.0),
            const Center(
              child: Text(
                "CoffeeisHappiness",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 8, 8, 18),
                ),
              ),
            ),
            const SpaceHeight(2.0),
            const Center(
              child: Text(
                "temukan kebahagianmu dengan sederhana",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87
                ),
              ),
            ),
            const SpaceHeight(40.0),
            SingleChildScrollView(
              child: Form(
                key: _loginFormKey,
                child: Column(
                  children: [
                    CustomInputField(
                        controller: usernameController,
                        labelText: 'Email',
                        hintText: 'Masuk email id',
                        validator: (textValue) {
                          if (textValue == null || textValue.isEmpty) {
                            return 'Email is required!';
                          }
                          if (!EmailValidator.validate(textValue)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomInputField(
                      controller: passwordController,
                      labelText: 'Password',
                      hintText: 'Masuk password',
                      obscureText: true,
                      suffixIcon: true,
                      validator: (textValue) {
                        if (textValue == null || textValue.isEmpty) {
                          return 'Password is required!';
                        }
                        return null;
                      },
                    ),
                    const SpaceHeight(45.0),
                    BlocListener<LoginBloc, LoginState>(
                      listener: (context, state) {
                        state.maybeWhen(
                          orElse: () {},
                          success: (authResponseModel) {
                            AuthLocalDatasource()
                                .saveAuthData(authResponseModel);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DashboardPage(),
                              ),
                            );
                          },
                          error: (message) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(message),
                                backgroundColor: Colors.red,
                              ),
                            );
                          },
                        );
                      },
                      // padding: EdgeInsets.all(8),

                      child: BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          return state.maybeWhen(orElse: () {
                            return Button.outlined(
                              onPressed: () {
                                if (_loginFormKey.currentState!.validate()) {
                                  // Validasi input sebelum login
                                  String email = usernameController.text;
                                  String password = passwordController.text;
                                  context.read<LoginBloc>().add(
                                        LoginEvent.login(
                                          email: email,
                                          password: password,
                                        ),
                                      );
                                }
                              },
                              label: 'Masuk',
                            );
                          }, loading: () {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
