import 'package:survey_akademik/pages/signup/signup.dart';
import 'package:survey_akademik/services/auth_service.dart';
import 'package:survey_akademik/pages/login/forgotpassword.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A polished login screen implementing Material 3 design,
/// graceful form validation, and a branded Google sign‑in button.
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePwd = true;
  bool _submitting = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// ---- UI HELPERS ----
  InputDecoration _fieldDecoration(String hint, {Widget? suffix}) => InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 14, color: Color(0xFF6A6A6A)),
        filled: true,
        fillColor: const Color(0xFFF7F7F9),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        suffixIcon: suffix,
      );

  TextStyle get _labelStyle => GoogleFonts.inter(fontSize: 16, color: Colors.black87);

  Future<void> _handleSignin() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _submitting = true);
    await AuthService().signin(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      context: context,
    );
    if (mounted) setState(() => _submitting = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: _signupPrompt(context),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
                _logo(),
                const SizedBox(height: 24),
                _headline(),
                const SizedBox(height: 40),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Email Address', style: _labelStyle),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        decoration: _fieldDecoration('you@example.com'),
                        validator: (v) => v == null || !v.contains('@') ? 'Enter a valid email' : null,
                      ),
                      const SizedBox(height: 20),
                      Text('Password', style: _labelStyle),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePwd,
                        decoration: _fieldDecoration(
                          '••••••••',
                          suffix: IconButton(
                            icon: Icon(_obscurePwd ? Icons.visibility_rounded : Icons.visibility_off_rounded),
                            onPressed: () => setState(() => _obscurePwd = !_obscurePwd),
                          ),
                        ),
                        validator: (v) => (v == null || v.length < 6) ? 'Enter a valid password' : null,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => ForgotPasswordPage()),
                            );
                          },
                          child: Text(
                            'Forgot Password?',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(height: 30),
                      FilledButton(
                        onPressed: _submitting ? null : _handleSignin,
                        style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(56),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        child: _submitting
                            ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2))
                            : const Text('Sign In'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _googleButton(theme),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// ---- COMPONENTS ----
  Widget _logo() => Center(
        child: Image.asset('asset/logo/logoundip.png', height: 90, fit: BoxFit.contain),
      );

  Widget _headline() => Center(
        child: Text('Welcome',
            style: GoogleFonts.raleway(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black87)),
      );

  Widget _googleButton(ThemeData theme) => OutlinedButton.icon(
        icon: Image.asset('asset/logo/googlelogo_login.png', height: 22),
        label: const Text('Sign In with Google'),
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(56),
          side: BorderSide(color: theme.colorScheme.primary),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        onPressed: () async => AuthService().googlesignin(context: context),
      );

  Widget _signupPrompt(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: 'New user? ',
                style: GoogleFonts.raleway(fontSize: 15, color: const Color(0xFF6A6A6A)),
              ),
              TextSpan(
                text: 'Create Account',
                style: GoogleFonts.raleway(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w600),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => Signup()),
                      ),
              ),
            ],
          ),
        ),
      );
}
