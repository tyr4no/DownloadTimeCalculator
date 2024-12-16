// Omar Tayba
// 52210230

import 'package:flutter/material.dart';

 void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController speedController = TextEditingController();
  final TextEditingController fileSizeController = TextEditingController();

  String selectedSpeedUnit = "Mbps";
  String selectedFileSizeUnit = "MB";
  String result = "";
  String format = "Full Breakdown";

  void calculateDownloadTime() {



      double speed = double.tryParse(speedController.text) ?? 0.0;
      double fileSize = double.tryParse(fileSizeController.text) ?? 0.0;



      if (selectedSpeedUnit == "Kbps") {
        speed /= 1000; // convert Kbps to Mbps
      } else if (selectedSpeedUnit == "Gbps") {
        speed *= 1000; // convert Gbps to Mbps
      }


      if (selectedFileSizeUnit == "KB") {
        fileSize /= 1024; // convert KB to MB
      } else if (selectedFileSizeUnit == "GB") {
        fileSize *= 1024; // convert GB to MB
      }


      double downloadTimeInSeconds = (fileSize * 8) / speed;





      if (format == "Minutes Only") {
        result = "Time Required: ${(downloadTimeInSeconds / 60).toStringAsFixed(2)} minutes";
      } else if (format == "Seconds Only") {
        result = "Time Required: ${downloadTimeInSeconds.toStringAsFixed(2)} seconds";
      } else {
        int hours = downloadTimeInSeconds ~/ 3600;
        int minutes = (downloadTimeInSeconds % 3600) ~/ 60;
        int seconds = (downloadTimeInSeconds % 60).toInt();
        result = "Time Required: ${hours}h ${minutes}m ${seconds}s";
      }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Download Time Calculator"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Center(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Text(
                "Enter Details:",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
               SizedBox(height: 20),

              // Speed Input
              SizedBox(
                width: 230,
                child: TextField(
                  controller: speedController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter speed",
                  ),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                ),
              ),
             SizedBox(height: 10),

              // Speed Unit Dropdown
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Speed Unit: "),
                  DropdownButton<String>(
                    value: selectedSpeedUnit,
                    items: ["Kbps", "Mbps", "Gbps"]
                        .map((unit) => DropdownMenuItem(
                      value: unit,
                      child: Text(unit),
                    )).toList(),

                    onChanged: (value) {
                      setState(() {
                        selectedSpeedUnit = value!;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),


              SizedBox(
                width: 230,
                child: TextField(
                  controller: fileSizeController,
                  decoration:  InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter file size",
                  ),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 10),


              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text("File Size Unit: "),
                  DropdownButton<String>(
                    value: selectedFileSizeUnit,
                    items: ["KB", "MB", "GB"]
                        .map((unit) => DropdownMenuItem(
                      value: unit,
                      child: Text(unit),
                    )).toList(),

                    onChanged: (value) {
                      setState(() {
                        selectedFileSizeUnit = value!;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),


              Column(
                children: [
                  Text("Result Format:"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: "Full Breakdown",
                            groupValue: format,
                            onChanged: (value) {
                              setState(() {
                                format = value.toString();
                              });
                            },
                          ),
                        Text("Full Breakdown"),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: "Minutes Only",
                            groupValue: format,
                            onChanged: (value) {
                              setState(() {
                                format = value.toString();
                              });
                            },
                          ),
                          Text("Minutes Only"),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: "Seconds Only",
                            groupValue: format,
                            onChanged: (value) {
                              setState(() {
                                format = value.toString();
                              });
                            },
                          ),
                          Text("Seconds Only"),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),


              ElevatedButton(
                onPressed: (){setState(() {
                  calculateDownloadTime();
                });

                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child:  Text("Calculate Time"),
              ),

              SizedBox(height: 20),


              Text(
                result,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),

      ),
    );
  }
}
