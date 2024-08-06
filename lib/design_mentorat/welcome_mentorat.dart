// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticeo/design_course/home_design_course.dart';
import 'design_mentorat_app_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  CategoryType categoryType = CategoryType.module;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DesignMentoratAppTheme.nearlyWhite,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            getAppBarUI(),
            SizedBox(
              height: 40.h,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    getPopularCourseUI(),
                  ],
                ),
              ),
            ),
            getStartButtonUI(),
          ],
        ),
      ),
    );
  }

  Widget getPopularCourseUI() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildAnimatedInfoCard(
            "Modules",
            "Certaines fonctionnalités de notre application, vous devez créer un compte en fournissant des informations exactes et complètes. Vous êtes responsable de la véracité de ces informations.",
            const Color.fromARGB(97, 33, 149, 243),
            'assets/design_course/bcg1.jpg',
          ),
          _buildAnimatedInfoCard(
            "Séances",
            "Certaines fonctionnalités de notre application, vous devez créer un compte en fournissant des informations exactes et complètes. Vous êtes responsable de la véracité de ces informations.",
            const Color.fromARGB(117, 155, 39, 176),
            'assets/design_course/bcg2.png',
          ),
          _buildAnimatedInfoCard(
            "Temps",
            "Certaines fonctionnalités de notre application, vous devez créer un compte en fournissant des informations exactes et complètes. Vous êtes responsable de la véracité de ces informations.",
            const Color.fromARGB(119, 192, 107, 28),
            'assets/design_course/pp.jpg',
          ),
          _buildAnimatedInfoCard(
            "Mentorat",
            "Certaines fonctionnalités de notre application, vous devez créer un compte en fournissant des informations exactes et complètes. Vous êtes responsable de la véracité de ces informations.",
            const Color.fromARGB(119, 96, 125, 139),
            'assets/design_course/bcg3.jpg',
          ),
        ],
      ),
    );
  }

  Widget getStartButtonUI() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 47, 48, 48),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DesignCourseHomeScreen(),
              ),
            );
          },
          child: const Text(
            "Commencer",
            style: TextStyle(
              fontSize: 22.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget getAppBarUI() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 50.0),
          SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              // child: const Text(
              //   'Section cour',
              //   textAlign: TextAlign.left,
              //   style: TextStyle(
              //     fontWeight: FontWeight.w400,
              //     fontSize: 16,
              //     letterSpacing: 0.2,
              //     color: DesignCourseAppTheme.grey,
              //   ),
              // ),
            ),
          ),
          SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: const Text(
                'Bienvenue dans la section cour de TIC-eo',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  letterSpacing: 0.27,
                  color: DesignMentoratAppTheme.darkerText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedInfoCard(String title, String description, Color color,
      String backgroundImagePath) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Stack(
            children: [
              Positioned.fill(
                child: Opacity(
                  opacity: 0.3,
                  child: Image.asset(
                    backgroundImagePath, // Utiliser le chemin d'image spécifique
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Carte avec contenu
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 6.0,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum CategoryType {
  module,
  seance,
  temps,
}
