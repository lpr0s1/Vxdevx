import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "VxKit",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0D0D0D),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF111111),
          elevation: 2,
        ),
      ),
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int index = 0;

  final pages = const [
    HomePage(),
    ToolsPage(),
    MoviesPage(),
    VersionPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 350),
        child: pages[index],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) => setState(() => index = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home, color: Colors.blue),
            label: 'Accueil',
          ),
          NavigationDestination(
            icon: Icon(Icons.terminal_outlined),
            selectedIcon: Icon(Icons.terminal, color: Colors.red),
            label: 'Outils',
          ),
          NavigationDestination(
            icon: Icon(Icons.movie_outlined),
            selectedIcon: Icon(Icons.movie, color: Colors.blue),
            label: 'Movies',
          ),
          NavigationDestination(
            icon: Icon(Icons.info_outline),
            selectedIcon: Icon(Icons.info, color: Colors.green),
            label: 'Version',
          ),
        ],
      ),
    );
  }
}

//
// PAGE ACCUEIL
//
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("VxKit - Accueil")),
      body: const Center(
        child: Text(
          "Bienvenue dans VxKit\nVotre kit de commandes Pentest",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}

//
// PAGE OUTILS
//
class ToolsPage extends StatelessWidget {
  const ToolsPage({super.key});

  Future<void> openTelegram() async {
    final url = Uri.parse("https://t.me/vxshare5");
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final tools = [
      ("Nmap", "nmap -sV -A <cible>", Colors.blue),
      ("Hydra", "hydra -l admin -P wordlist.txt <cible> ssh", Colors.red),
      ("Metasploit", "msfconsole", Colors.green),
      ("Nikto", "nikto -h <cible>", Colors.red),
      ("Gobuster", "gobuster dir -u <cible> -w wordlist.txt", Colors.blue),
      ("SQLmap", "sqlmap -u <url> --batch", Colors.green),
      ("John The Ripper", "john --wordlist=rockyou.txt hash.txt", Colors.red),
      ("Aircrack-ng", "aircrack-ng capture.cap", Colors.blue),
      ("Tcpdump", "tcpdump -i eth0", Colors.green),
      ("Netcat", "nc -lvnp 4444", Colors.red),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Commandes Pentest")),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: openTelegram,
        backgroundColor: Colors.blue,
        icon: const Icon(Icons.telegram),
        label: const Text("Telegram"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: tools.length,
        itemBuilder: (context, i) {
          final (name, cmd, color) = tools[i];
          return PentestCard(title: name, command: cmd, color: color);
        },
      ),
    );
  }
}

class PentestCard extends StatelessWidget {
  final String title;
  final String command;
  final Color color;

  const PentestCard({
    super.key,
    required this.title,
    required this.command,
    required this.color,
  });

  void copyCommand(BuildContext context) {
    Clipboard.setData(ClipboardData(text: command));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Commande copiée : $command"),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1A1A1A),
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(Icons.code, color: color),
        title: Text(title, style: TextStyle(color: color, fontSize: 18)),
        subtitle: Text(command),
        trailing: IconButton(
          icon: const Icon(Icons.copy, color: Colors.white),
          onPressed: () => copyCommand(context),
        ),
      ),
    );
  }
}

//
// PAGE MOVIES (WEBVIEW)
//
class MoviesPage extends StatelessWidget {
  const MoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Movies")),
      body: const WebView(
        initialUrl: "https://hvxsrc.online/v/m",
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}

//
// PAGE VERSION
//
class VersionPage extends StatelessWidget {
  const VersionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Version")),
      body: const Center(
        child: Text(
          "VxKit\nVersion : 0.0.1\nDéveloppeur : Hx",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
