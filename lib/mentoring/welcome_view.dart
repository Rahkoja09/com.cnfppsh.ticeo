// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ticeo/components/Theme/ThemeProvider.dart';
import 'package:ticeo/components/database_gest/database_helper.dart';
import 'package:ticeo/design_course/home_design_course.dart';
import 'package:ticeo/mentoring/mentoring_home.dart';

class HomePageMentor extends StatefulWidget {
  const HomePageMentor({super.key});

  @override
  _HomePageMentorState createState() => _HomePageMentorState();
}

class _HomePageMentorState extends State<HomePageMentor>
    with SingleTickerProviderStateMixin {
  CategoryType categoryType = CategoryType.module;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  bool _isLargeTextMode = false;

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
      _loadPreferences();
    });
  }

  Future<void> _loadPreferences() async {
    final mode = await DatabaseHelper().getPreference();
    setState(() {
      _isLargeTextMode = mode == 'largePolice';
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context).currentTheme;
    return Container(
      color: theme.scaffoldBackgroundColor,
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
      padding: EdgeInsets.symmetric(horizontal: 18.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildAnimatedInfoCard(
            "Mentoring",
            "Le programme de mentorat vous met en relation avec des experts qualifiés dans certains domaines. Grâce à cette fonctionnalité, vous pouvez recevoir des conseils personnalisés, des orientations professionnelles, et un accompagnement sur vos projets. Les mentors sont sélectionnés selon leurs compétences et leur expérience pour vous offrir un soutien optimal. Cette fonction est réservée aux utilisateurs ayant un compte actif et ayant complété leur profil.",
            const Color.fromARGB(97, 33, 149, 243),
            'assets/design_course/bcg1.jpg',
          ),
          _buildAnimatedInfoCard(
            "Compte Mentor",
            "Pour devenir mentor, vous devez créer un compte spécifique en fournissant des informations détaillées sur votre expérience professionnelle et vos compétences. Un processus de validation est en place pour vérifier l'exactitude de ces informations avant que vous puissiez commencer à encadrer des apprenants. Votre rôle en tant que mentor est essentiel pour guider et aider les utilisateurs à atteindre leurs objectifs.",
            const Color.fromARGB(117, 155, 39, 176),
            'assets/design_course/bcg2.png',
          ),
          _buildAnimatedInfoCard(
            "Prix",
            "Le mentorat dans notre application est proposé gratuitement, mais les prix est un choix personnel du mentor en fonction des services ou autres raisons spécifiques. les tarif est public et affichés pour tout les utilisateurs. Si vous voulez créer un compte mentor, ous vous encourageons à bien lire les conditions.",
            const Color.fromARGB(119, 192, 107, 28),
            'assets/design_course/pp.jpg',
          ),
          _buildAnimatedInfoCard(
            "Contact et Notification",
            "Restez informé en temps réel grâce aux notifications pour les nouveaux demande mentoring des utilisateurs.Si vous voulez créer un compte mentor, sachez que vos contact et d'autre informations seront public, a lire dans nos termes et conditions. Pour toute question, vous pouvez contacter notre support technique grace aux contact dans la section aide et assistance.",
            const Color.fromARGB(119, 96, 125, 139),
            'assets/design_course/bcg3.jpg',
          ),
        ],
      ),
    );
  }

  Widget getStartButtonUI() {
    double buttonFontSize = _isLargeTextMode ? 30.sp : 26.sp;

    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 19, 75, 120),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MentoringHomePage(),
              ),
            );
          },
          child: Text(
            "Commencer",
            style: TextStyle(
              fontSize: buttonFontSize,
              fontFamily: 'Jersey',
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }

  Widget getAppBarUI() {
    double titleFontSize = _isLargeTextMode ? 32.sp : 32.sp;
    double subtitleFontSize = _isLargeTextMode ? 18.sp : 16.sp;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 50.0.w),
          SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Text(
                'Bienvenue dans la section Mentoring de Tecno-Tic',
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: titleFontSize,
                      fontFamily: 'Jersey',
                      letterSpacing: 0.27,
                      color: Theme.of(context).textTheme.bodyText1?.color,
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
    double cardTitleFontSize = _isLargeTextMode ? 34.sp : 26.sp;
    double cardDescriptionFontSize = _isLargeTextMode ? 28.sp : 16.sp;

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
                    backgroundImagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
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
                      style: TextStyle(
                        fontSize: cardTitleFontSize,
                        fontFamily: 'Jersey',
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.0.h),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: cardDescriptionFontSize,
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
