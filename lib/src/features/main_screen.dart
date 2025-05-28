import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController zipController = TextEditingController();
  Future<String>? cityFut;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            spacing: 32,
            children: [
              TextFormField(
                controller: zipController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Postleitzahl",
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  // TODO: implementiere Suche
                  setState(() {
                    cityFut = getCityFromZip(zipController.text.trim());
                  });
                },
                child: const Text("Suche"),
              ),
              FutureBuilder<String>(
                future: cityFut,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("Fehler bei der Suche!");
                  } else if (snapshot.hasData) {
                    return Text(
                      "Ergebnis: ${snapshot.data}",
                    );
                  } else {
                    return Text("Keine PLZ gesucht");
                  }
                },
              ),
              // Text(
              //   "Ergebnis: Noch keine PLZ gesucht",
              //   style: Theme.of(context).textTheme.labelLarge,
              // ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: dispose controllers
    zipController.dispose();
    super.dispose();
  }

  Future<String> getCityFromZip(String zip) async {
    // simuliere Dauer der Datenbank-Anfrage
    await Future.delayed(const Duration(seconds: 3));

    switch (zip) {
      case "10115":
        return 'Berlin';
      case "20095":
        return 'Hamburg';
      case "80331":
        return 'München';
      case "50667":
        return 'Köln';
      case "60311":
      case "60313":
        return 'Frankfurt am Main';
      default:
        return 'Unbekannte Stadt';
    }
  }
}
