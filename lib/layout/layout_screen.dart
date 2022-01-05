import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'cubit/cubit.dart';
import 'cubit/state.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  _LayoutScreenState createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, states) {},
      builder: (context, states) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Google Mobile Ad'),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                //************************BannerAD*******************
                Text('BannerAd :',style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.teal
                ),),
                SizedBox(
                  height: 20.0,
                ),
                if (AppCubit.get(context).isBannerAdReady)
                  Container(
                    //height: 50.0,
                    //width: double.infinity,
                    height:AppCubit.get(context).bannerAd.size.height.toDouble(),
                    width: AppCubit.get(context).bannerAd.size.width.toDouble(),
                    child: AdWidget(ad: AppCubit.get(context).bannerAd),
                  ),
                SizedBox(
                  height: 20.0,
                ),

                //************************InterstitialAD*******************

                Text('InterstitialAd :',style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.teal
                ),),
                SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                    onPressed: AppCubit.get(context).isInterstitialAdReady
                        ? AppCubit.get(context).interstitialAd.show
                        : null,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text("interstitial Ad"),
                    )),

                //************************RewardedAd*******************

                SizedBox(
                  height: 20.0,
                ),
                Text('RewardedAd :',style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.teal
                ),),
                if (AppCubit.get(context).isRewardedAdReady)
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Need a hint?'),
                            content: Text('Watch an Ad to get a hint!'),
                            actions: [
                              TextButton(
                                child: Text('cancel'.toUpperCase()),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              TextButton(
                                child: Text('ok'.toUpperCase()),
                                onPressed: () {
                                  Navigator.pop(context);
                                  AppCubit.get(context).rewardedAd?.show(
                                    onUserEarnedReward: (_, reward) {
                                      // QuizManager.instance.useHint();
                                    },
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text("hint"),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
