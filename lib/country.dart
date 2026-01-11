import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unii_demo/component/color.dart';
import 'package:unii_demo/login.dart';

class CountryPage extends StatefulWidget {
  const CountryPage({super.key});

  @override
  State<CountryPage> createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  List<dynamic> countries = [];
  List<dynamic> filteredCountries = [];
  TextEditingController searchController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCountries();
    searchController.addListener(_filterCountries);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> loadCountries() async {
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/country_code.json',
      );
      setState(() {
        countries = jsonDecode(jsonString);
        filteredCountries = countries;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _filterCountries() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredCountries = countries
          .where(
            (country) =>
                country['country'].toLowerCase().contains(query) ||
                country['code'].toLowerCase().contains(query) ||
                country['dial'].toLowerCase().contains(query),
          )
          .toList();
    });
  }

  Map<String, List<dynamic>> _groupCountries() {
    final Map<String, List<dynamic>> grouped = {};

    for (var country in filteredCountries) {
      final letter = country['country'][0].toUpperCase();
      grouped.putIfAbsent(letter, () => []);
      grouped[letter]!.add(country);
    }

    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: CoLor.background,
        body: Stack(
          children: [
            // Country
            Positioned(
              top: size.height * 0.22,
              left: 0,
              right: 0,
              bottom: 0,
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Color(0xff9A2990),
                      ),
                    )
                  : filteredCountries.isEmpty
                  ? Center(
                      child: Text(
                        'No countries found',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Anuphan',
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: size.width * 0.04),
                          child: Text(
                            "ขึ้นอยู่กับตำแหน่งที่ตั้งของคุณ",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Anuphan',
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.045,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListTile(
                              leading: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: CoLor.purple,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  "TH",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              title: const Text(
                                'Thai',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Anuphan',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              subtitle: const Text(
                                '+66',
                                style: TextStyle(
                                  color: Color(0xff5C5C5C),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Anuphan',
                                ),
                              ),
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        LoginPage(code: "TH", dial: "+66"),
                                  ),
                                  (Route<dynamic> route) => false,
                                );
                              },
                            ),
                          ),
                        ),
                        ..._groupCountries().entries.map((entry) {
                          final letter = entry.key;
                          final countries = entry.value;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                child: Text(
                                  letter,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ).copyWith(bottom: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  children: countries.map((country) {
                                    return Column(
                                      children: [
                                        ListTile(
                                          leading: Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: CoLor.purple,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: Text(
                                              country['code'],
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          title: Text(
                                            country['country'],
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Anuphan',
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                          subtitle: Text(
                                            country['dial'],
                                            style: TextStyle(
                                              color: Color(0xff5C5C5C),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Anuphan',
                                            ),
                                          ),
                                          onTap: () {
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LoginPage(
                                                  code: country["code"],
                                                  dial: country["dial"],
                                                ),
                                              ),
                                              (Route<dynamic> route) => false,
                                            );
                                          },
                                        ),
                                        if (country != countries.last)
                                          Divider(height: 1),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
            ),

            // AppBar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: size.height * 0.2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: AlignmentGeometry.topCenter,
                    end: AlignmentGeometry.bottomCenter,
                    colors: [CoLor.purple, CoLor.darkpurple],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: size.height * 0.07,
                      left: size.width * 0.23,
                      child: Text(
                        "Select Country or Region",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'Anuphan',
                        ),
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.055,
                      left: size.width * 0.03,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_rounded,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.12,
                      left: size.width * 0.05,
                      right: size.width * 0.05,
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: size.width * 0.05),
                            child: Icon(Icons.search),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
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
