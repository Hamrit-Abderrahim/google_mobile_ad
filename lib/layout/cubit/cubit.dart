
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ad_app/layout/cubit/state.dart';
import 'package:google_mobile_ad_app/shared/ad_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  @override
  Future<void> close() {
    bannerAd.dispose();
    interstitialAd.dispose();
    return super.close();
  }

  late BannerAd bannerAd;
  bool isBannerAdReady = false;
  late InterstitialAd interstitialAd;
  bool isInterstitialAdReady = false;
  bool isRewardedAdReady = false;
  RewardedAd? rewardedAd;
void bannerAD(){
  bannerAd = BannerAd(
    // Change Banner Size According to Ur Need
      size: AdSize.banner,
      adUnitId: AdHelper.bannerAdUnitId,
      listener: BannerAdListener(onAdLoaded: (_) {
          isBannerAdReady = true;
          emit(BannerAddState());
      }, onAdFailedToLoad: (ad, LoadAdError error) {
        print("Failed to Load A Banner Ad${error.message}");
        isBannerAdReady = false;
        ad.dispose();
      }),
      request: AdRequest())
    ..load();
}
void interAD(){
  InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
        this.interstitialAd = ad;
        isInterstitialAdReady = true;
        emit(InterAddState());
      }, onAdFailedToLoad: (LoadAdError error) {
        print("failed to Load Interstitial Ad ${error.message}");
      }));
  loadRewardedAd();
}
//**************************
  void loadRewardedAd() {
    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad) {
        this.rewardedAd = ad;
        ad.fullScreenContentCallback =
            FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {

               isRewardedAdReady = false;
               emit(RewAdFalseState());

              loadRewardedAd();
            });

          isRewardedAdReady = true;
        emit(RewAdTrueState());


      }, onAdFailedToLoad: (error) {
        print('Failed to load a rewarded ad: ${error.message}');

          isRewardedAdReady = false;
        emit(RewAdFalseState());

      }),
    );
  }

}