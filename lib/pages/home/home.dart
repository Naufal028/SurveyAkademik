import 'package:survey_akademik/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Survey Akademik'),
        backgroundColor: Colors.lightBlueAccent,
        /*actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<ProfileScreen>(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
          )
        ],*/
      ),
      drawer: const NavigationDrawer(),
      body: Center(
        child: Column(
        ),
      ),
    );

  
}

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