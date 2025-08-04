import 'package:survey_akademik/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 1; // Home is the middle item

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // Navigate to Survey Page
        break;
      case 1:
        // Already on Home
        break;
      case 2:
        // Navigate to Peraturan Akademik Page
        break;
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      extendBody: true,
      backgroundColor: Colors.lightBlueAccent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: AppBar(
              elevation: 5,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              title: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // TODO: Navigate to profile page
                    },
                    child: const CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.lightBlueAccent,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    FirebaseAuth.instance.currentUser?.displayName ??
                    FirebaseAuth.instance.currentUser?.email ??
                    'Guest',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout, color: Colors.red),
                  tooltip: 'Sign Out',
                  onPressed: () async {
                    await AuthService().signout(context: context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: Container(
          height: 300,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              'Empty Body',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            elevation: 5,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: Colors.lightBlueAccent,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.assignment),
                label: 'Survey',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.info_outline),
                label: 'Peraturan',
              ),
            ],
          ),
        ),
      ),
    );
}

/*
class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        buildHeader(context),
        Expanded(child: SingleChildScrollView(
          child: buildMenuItems(context),
        ),
        ),
        const SizedBox(height: 30,),
                _logout(context)
      ],
    )
  );

  Widget _logout(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.logout, color: Colors.redAccent),
      title: const Text(
        "Sign Out",
        style: TextStyle(
          color: Colors.redAccent,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: () async {
        await AuthService().signout(context: context);
      },
    );
  }

  Widget buildHeader(BuildContext context) => Container(
    padding: EdgeInsets.only(
      top: MediaQuery.of(context).padding.top,
    ),
  );

  Widget buildMenuItems(BuildContext context) => Wrap(
    runSpacing: 16,
    children: [
      ListTile(
        leading: const Icon(Icons.home_outlined),
        title: const Text("Home"),
        onTap: () =>
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const Home(),
            )),
      ),
      ListTile(
        leading: const Icon(Icons.assignment),
        title: const Text("Survey"),
        onTap: () {},
      ),
      ListTile(
        leading: const Icon(Icons.info),
        title: const Text("Peraturan Akademik"),
        onTap: () {},
      ),
    ],
  );
}
*/