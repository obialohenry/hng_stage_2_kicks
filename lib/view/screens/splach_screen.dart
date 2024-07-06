import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_stage_2_kicks/config/app_colors.dart';
import 'package:hng_stage_2_kicks/view/components/gap.dart';
import 'package:hng_stage_2_kicks/view_model/kicks_product_view_model.dart';


class SplashScreen extends ConsumerStatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  Widget build(
    BuildContext context,
  ) {
    var kicksProductProvider = ref.watch(kicksProductViewModel);
    return Scaffold(
      backgroundColor: AppColors.kLightGray,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/kicks_logo.png",
                height: 100,
                width: 100,
              ),
              const Gap(10),
              const Text(
                "Kicks",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Gap(10),
              const Text(
                "Welcome to Kicks,an online retail shoe business",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              const Gap(10),
              GestureDetector(
                onTap: () {
                  kicksProductProvider.getKicksProducts(context);
                },
                child: Container(
                  width: 200,
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                    color: AppColors.kSoftGreenShade,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: kicksProductProvider.gettingKicksProducts
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          "View Our Products",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
