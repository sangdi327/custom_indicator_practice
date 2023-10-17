import 'package:custom_indicator_practice3/components/indicator_widget.dart';
import 'package:custom_indicator_practice3/model/indicator_option.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            children: [
              Image.asset(
                'image/marmot1.jpg',
                fit: BoxFit.cover,
              ),
              Image.asset(
                'image/marmot2.jpg',
                fit: BoxFit.cover,
              ),
              Image.asset(
                'image/mountain.jpg',
                fit: BoxFit.cover,
              ),
              Image.asset(
                'image/shell.jpg',
                fit: BoxFit.cover,
              ),
            ],
            onPageChanged: (value) {},
          ),
          IndicatorWidget(
            indicatorOption: IndicatorOption(
              size: const Size(20, 20),
              gap: 20,
              counts: 4,
            ),
            pageController: pageController,
          ),
        ],
      ),
    );
  }
}
