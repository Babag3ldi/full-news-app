// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:full_news/feature/home/home_view.dart';
import 'package:full_news/feature/splash/splash_provider.dart';
import 'package:full_news/product/constants/color_constants.dart';
import 'package:full_news/product/constants/string_constans.dart';
import 'package:full_news/product/enums/image_constants.dart';
import 'package:full_news/product/widget/text/wavy_text.dart';
import 'package:kartal/kartal.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  final splashProvider =
      StateNotifierProvider<SplashProvider, SplashState>((ref) {
    return SplashProvider();
  });

  @override
  void initState() {
    ''.version;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(splashProvider, (previous, next) {
      if (next.isRequiredForceUpdate ?? false) {
        showAboutDialog(context: context);
      }
      if (next.isRedirectHome != null) {
        if (next.isRedirectHome!) {
          context.navigateToPage(const HomeView());
        } else {}
      }
    });
    return Scaffold(
      backgroundColor: ColorConstants.purpleDark,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconConstants.appIcon.toImage,
            Text(
              StringConstants.appName,
              style: context.textTheme.headlineSmall?.copyWith(
                  color: ColorConstants.white, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: context.onlyTopPaddingHigh,
              child: const WavyBoldText(title: StringConstants.appName),
            )
          ],
        ),
      ),
    );
  }
}
