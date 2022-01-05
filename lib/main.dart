import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ad_app/shared/bloc_observer.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:bloc/bloc.dart';

import 'layout/cubit/cubit.dart';
import 'layout/layout_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  BlocOverrides.runZoned(
        () {runApp(MyApp());},
    blocObserver: MyBlocObserver(),
  );

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context)=>AppCubit()..bannerAD()..interAD(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LayoutScreen(),
      ),
    );
  }
}
