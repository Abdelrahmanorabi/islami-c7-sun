import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:islami_c7_sun/home/radio/radoi_controller.dart';
import 'package:islami_c7_sun/model/RadioResponse.dart';

class RadioTab extends StatefulWidget {
  @override
  State<RadioTab> createState() => _RadioTabState();
}

class _RadioTabState extends State<RadioTab> {
  late Future<RadioResponse> radioResponse;
  late AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
    radioResponse = fetchRadio();
    audioPlayer = AudioPlayer();
  }

  play(String url) async {
    await audioPlayer.play(UrlSource(url));
  }
  pause() async {
    await audioPlayer.pause();
  }
  Future<RadioResponse> fetchRadio() async {
    Uri uri = Uri.parse('https://api.mp3quran.net/radios/radio_arabic.json');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      // String responseBody = response.body;
      Map<String, dynamic> json = jsonDecode(utf8.decode(response.bodyBytes));
      return RadioResponse.fromJson(json);
    } else {
      throw Exception('Failed to connect radio response');
    }
  }
  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<RadioResponse>(
      future: radioResponse,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: IconButton(onPressed: (){
              radioResponse=fetchRadio();
            },icon: Icon(Icons.refresh),),
          );
        }
        else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        else {
          return Column(
            children: [
              Expanded(
                  flex: 2, child: Image.asset('assets/images/radio_light.png')),
              Expanded(
                  flex: 1,
                  child: ListView.builder(
                      physics: const PageScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data?.radios?.length,
                      itemBuilder: (buildContext, index) {
                        return RadioController(
                          radios: snapshot.data!.radios![index],
                          play: () {
                            play(snapshot.data!.radios![index].radioUrl ?? '');
                          },
                          pause: () {
                            pause();
                          },
                        );
                      }))
            ],
          );
        }
      },
    );
  }
}
