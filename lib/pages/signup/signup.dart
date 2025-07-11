import 'package:survey_akademik/pages/login/login.dart';
import 'package:survey_akademik/services/auth_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ---------------------------------------------------------------------------
// POLISHED SIGN‑UP SCREEN (stand‑alone file)
// ---------------------------------------------------------------------------
class Signup extends StatefulWidget {
  const Signup({super.key});
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
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
  TextStyle get _labelStyle => GoogleFonts.raleway(fontSize: 16, color: Colors.black87);

  Future<void> _handleSignup() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _submitting = true);
    await AuthService().signup(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      context: context,
    );
    if (mounted) setState(() => _submitting = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(toolbarHeight: 50, backgroundColor: Colors.transparent, elevation: 0),
      bottomNavigationBar: _loginPrompt(context),
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
                _headline('Register Account'),
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
                        decoration: _fieldDecoration('you@example.com'),
                        validator: (v) => v != null && v.contains('@') ? null : 'Enter a valid email',
                      ),
                      const SizedBox(height: 20),
                      Text('Password', style: _labelStyle),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePwd,
                        decoration: _fieldDecoration(
                          'Create a strong password',
                          suffix: IconButton(
                            icon: Icon(_obscurePwd ? Icons.visibility_rounded : Icons.visibility_off_rounded),
                            onPressed: () => setState(() => _obscurePwd = !_obscurePwd),
                          ),
                        ),
                        validator: (v) => v != null && v.length >= 6 ? null : 'Minimum 6 characters',
                      ),
                      const SizedBox(height: 30),
                      FilledButton(
                        onPressed: _submitting ? null : _handleSignup,
                        style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(56),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        child: _submitting
                            ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2))
                            : const Text('Sign Up'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---- COMPONENTS ---------------------------------------------------------
  Widget _logo() => Center(child: Image.asset('asset/logo/logoundip.png', height: 90));
  Widget _headline(String text) => Center(
        child: Text(text, style: GoogleFonts.raleway(fontSize: 32, fontWeight: FontWeight.bold)),
      );
  Widget _loginPrompt(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            TextSpan(text: 'Already have an account? ', style: GoogleFonts.raleway(color: const Color(0xFF6A6A6A))),
            TextSpan(
              text: 'Log In',
              style: GoogleFonts.raleway(fontWeight: FontWeight.w600, color: Colors.black87),
              recognizer: TapGestureRecognizer()
                ..onTap = () => Navigator.push(context, MaterialPageRoute(builder: (_) => const Login())),
            ),
          ]),
        ),
      );
}
