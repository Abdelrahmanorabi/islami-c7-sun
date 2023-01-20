import 'package:flutter/material.dart';
import 'package:islami_c7_sun/model/RadioResponse.dart';
import 'package:islami_c7_sun/my_theme.dart';
import 'package:islami_c7_sun/providers/settings_provider.dart';
import 'package:provider/provider.dart';


class RadioController extends StatefulWidget {
  Radios radios;
  Function play;
  Function pause;
  RadioController({required this.radios,required this.play,required this.pause});

  @override
  State<RadioController> createState() => _RadioControllerState();
}

class _RadioControllerState extends State<RadioController> {


  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          Text(
            widget.radios.name ?? '',
            textAlign: TextAlign.center
            ,style: Theme.of(context).textTheme.headline5,),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                padding: EdgeInsets.symmetric(horizontal: 25),
                onPressed: (){
                 widget.pause();
                },
                icon: Icon(Icons.pause, size: 40),
                color: settingsProvider.isDarkMode()
                    ? MyTheme.colorYellow
                    : MyTheme.lightPrimary,
              ),

              IconButton(
                padding: EdgeInsets.symmetric(horizontal: 25),
                onPressed: (){
                  widget.play();
                } ,
                icon: Icon(Icons.play_arrow, size: 40),
                color: settingsProvider.isDarkMode()
                    ? MyTheme.colorYellow
                    : MyTheme.lightPrimary,
              ),
            ],
          )
        ],
      ),
    );
  }
}
