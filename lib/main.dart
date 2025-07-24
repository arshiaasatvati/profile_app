// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.dark;
  Locale locale = Locale('en'); // Default locale set to Persian
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('fa'), // Persian
      ],
      locale: locale, // Set the default locale
      debugShowCheckedModeBanner: false,
      theme: themeMode == ThemeMode.dark
          ? MyAppThemeConfig.dark().getTheme(locale.languageCode)
          : MyAppThemeConfig.light().getTheme(locale.languageCode),
      home: MyHomePage(
        toggleTheme: () {
          setState(() {
            themeMode =
                themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
          });
        },
        selectedLanguageChanged: (LanguageType newSelectedLanguageByUser) {
          setState(() {
            locale = newSelectedLanguageByUser == LanguageType.english
                ? locale = Locale('en')
                : locale = Locale('fa');
          });
        },
      ),
    );
  }
}

class MyAppThemeConfig {
  static const faPrimaryFontFamily = 'Vazir';
  final Color primaryColor = Colors.pink.shade400;
  final Color surfaceColor;
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final Color backgroundColor;
  final Color appBarColor;
  final Brightness brightness;

  MyAppThemeConfig.dark()
      : brightness = Brightness.dark,
        surfaceColor = Color(0x0dffffff),
        primaryTextColor = Colors.white,
        secondaryTextColor = Colors.white70,
        backgroundColor = Color.fromARGB(255, 30, 30, 30),
        appBarColor = Colors.black;

  MyAppThemeConfig.light()
      : brightness = Brightness.light,
        surfaceColor = Color(0x1d000000),
        primaryTextColor = Colors.black,
        secondaryTextColor = Colors.black54,
        backgroundColor = Colors.white,
        appBarColor = Colors.white;

  ThemeData getTheme(String locale) {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      dividerColor: surfaceColor,
      appBarTheme: AppBarTheme(
        backgroundColor: appBarColor,
        foregroundColor: primaryTextColor,
        iconTheme: IconThemeData(color: primaryTextColor),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: surfaceColor,
      ),
      textTheme: locale == 'fa' ? faTextTheme : enTextTheme,
      scaffoldBackgroundColor: backgroundColor,
      useMaterial3: true,
    );
  }

  TextTheme get enTextTheme => GoogleFonts.latoTextTheme(
        TextTheme(
          bodyMedium: TextStyle(fontSize: 15, color: primaryTextColor),
          bodySmall: TextStyle(fontSize: 12, color: primaryTextColor),
          labelLarge:
              TextStyle(fontWeight: FontWeight.bold, color: primaryTextColor),
          titleLarge:
              TextStyle(fontWeight: FontWeight.bold, color: primaryTextColor),
          labelSmall: TextStyle(
            fontWeight: FontWeight.bold,
            color: primaryTextColor,
          ),
          headlineLarge:
              TextStyle(fontWeight: FontWeight.bold, color: primaryTextColor),
          titleSmall: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryTextColor),
        ),
      );

  TextTheme get faTextTheme => TextTheme(
        bodyMedium: TextStyle(
            fontSize: 15,
            height: 1.5,
            color: primaryTextColor,
            fontFamily: faPrimaryFontFamily),
        bodySmall: TextStyle(
            fontSize: 13,
            height: 1.5,
            color: primaryTextColor,
            fontFamily: faPrimaryFontFamily),
        labelLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: primaryTextColor,
            fontFamily: faPrimaryFontFamily),
        titleLarge: TextStyle(
            height: 1.5,
            fontWeight: FontWeight.bold,
            color: primaryTextColor,
            fontFamily: faPrimaryFontFamily),
        labelSmall: TextStyle(
          height: 1.5,
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: primaryTextColor,
        ),
        headlineLarge: TextStyle(
            fontSize: 15,
            height: 1.5,
            fontWeight: FontWeight.bold,
            color: primaryTextColor,
            fontFamily: faPrimaryFontFamily),
        titleSmall: TextStyle(
            height: 1.5,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primaryTextColor,
            fontFamily: faPrimaryFontFamily),
      );
}

class MyHomePage extends StatefulWidget {
  final Function toggleTheme;
  final Function(LanguageType languageType) selectedLanguageChanged;
  const MyHomePage(
      {super.key,
      required this.toggleTheme,
      required this.selectedLanguageChanged});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum SkillType {
  photoshop,
  xd,
  illustrator,
  afterEffect,
  lightRoom,
}

enum LanguageType {
  english,
  persian,
}

class _MyHomePageState extends State<MyHomePage> {
  SkillType _skillType = SkillType.photoshop;
  LanguageType _languageType = LanguageType.english;

  void _updateSkillType(SkillType skill) {
    setState(() {
      _skillType = skill;
    });
  }

  void _updateLanguageType(LanguageType language) {
    widget.selectedLanguageChanged(language);
    setState(() {
      _languageType = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.profileTitle),
        actions: [
          Icon(CupertinoIcons.chat_bubble),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 16, 0),
            child: InkWell(
              child: Icon(CupertinoIcons.ellipsis_vertical),
              onTap: () {
                widget.toggleTheme();
              },
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(32),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/profile_image.png',
                      width: 60,
                    ),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localizations.name,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      SizedBox(height: 2),
                      Text(localizations.jobTitle),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.location_fill,
                            size: 16,
                            color: Theme.of(context).textTheme.bodySmall!.color,
                          ),
                          SizedBox(width: 3),
                          Text(
                            localizations.location,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      )
                    ],
                  ),
                  Spacer(),
                  Icon(
                    CupertinoIcons.heart,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 16),
              child: Text(
                localizations.description,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.fromLTRB(32, 12, 32, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(localizations.selectedLanguage),
                  CupertinoSlidingSegmentedControl<LanguageType>(
                    thumbColor: Theme.of(context).primaryColor,
                    groupValue: _languageType,
                    children: {
                      LanguageType.english: Text(
                        localizations.enLang,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      LanguageType.persian: Text(
                        localizations.faLang,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    },
                    onValueChanged: (value) {
                      if (value != null) {
                        _updateLanguageType(value);
                      }
                    },
                  )
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 12, 32, 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    localizations.skills,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  Icon(
                    CupertinoIcons.chevron_down,
                    size: 12,
                    color: Theme.of(context).textTheme.bodySmall!.color,
                  ),
                ],
              ),
            ),
            Center(
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                direction: Axis.horizontal,
                children: [
                  Skill(
                    imagePath: 'assets/images/app_icon_01.png',
                    shadowColor: Colors.blue,
                    text: 'Photoshop',
                    isActive: _skillType == SkillType.photoshop,
                    onTap: () {
                      _updateSkillType(SkillType.photoshop);
                    },
                    skillType: SkillType.photoshop,
                  ),
                  Skill(
                    imagePath: 'assets/images/app_icon_05.png',
                    shadowColor: Colors.pink,
                    text: 'Adobe xd',
                    isActive: _skillType == SkillType.xd,
                    onTap: () {
                      _updateSkillType(SkillType.xd);
                    },
                    skillType: SkillType.xd,
                  ),
                  Skill(
                    imagePath: 'assets/images/app_icon_04.png',
                    shadowColor: Colors.orange,
                    text: 'Illustrator',
                    isActive: _skillType == SkillType.illustrator,
                    onTap: () {
                      _updateSkillType(SkillType.illustrator);
                    },
                    skillType: SkillType.illustrator,
                  ),
                  Skill(
                    imagePath: 'assets/images/app_icon_03.png',
                    shadowColor: Colors.blue.shade800,
                    text: 'AfterEffect',
                    isActive: _skillType == SkillType.afterEffect,
                    onTap: () {
                      _updateSkillType(SkillType.afterEffect);
                    },
                    skillType: SkillType.afterEffect,
                  ),
                  Skill(
                    imagePath: 'assets/images/app_icon_02.png',
                    shadowColor: Colors.blue,
                    text: 'Lightroom',
                    isActive: _skillType == SkillType.lightRoom,
                    onTap: () {
                      _updateSkillType(SkillType.lightRoom);
                    },
                    skillType: SkillType.lightRoom,
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 12, 32, 16),
              child: Text(
                localizations.personalInfromation,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w900),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 8),
              child: TextField(
                decoration: InputDecoration(
                  labelText: localizations.email,
                  prefixIcon: Icon(
                    CupertinoIcons.at,
                    color: Theme.of(context).textTheme.bodySmall!.color,
                  ),
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 8),
              child: TextField(
                decoration: InputDecoration(
                  labelText: localizations.password,
                  prefixIcon: Icon(
                    CupertinoIcons.lock,
                    color: Theme.of(context).textTheme.bodySmall!.color,
                  ),
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(32, 12, 32, 12),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(localizations.save),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Skill extends StatelessWidget {
  final SkillType skillType;
  final String imagePath;
  final Color shadowColor;
  final String text;
  final bool isActive;
  final Function() onTap;
  const Skill({
    super.key,
    required this.imagePath,
    required this.shadowColor,
    required this.text,
    required this.isActive,
    required this.onTap,
    required this.skillType,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 110,
        height: 110,
        decoration: isActive
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).dividerColor,
              )
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                // ignore: duplicate_ignore
                // ignore: deprecated_member_use
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          color: shadowColor.withOpacity(.5),
                          blurRadius: 16,
                        )
                      ]
                    : null,
              ),
              child: Image.asset(
                imagePath,
                width: 40,
                height: 40,
              ),
            ),
            SizedBox(height: 6),
            Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
