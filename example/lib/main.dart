import 'package:flutter/material.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const DemoPage(),
    );
  }
}

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Parsed Text Demo")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ParsedText(
            text: '''
      Hello @jay
      
      Welcome to #flutter
      
      Visit:
      https://flutter.dev
      
      Email:
      test@gmail.com
      
      Phone:
      9876543210
      ''',
        
          
            onMentionTap: (mention) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Mention tapped: $mention")),
              );
            },
            onHashtagTap: (hashtag) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Hashtag tapped: $hashtag")),
              );
            },
            onUrlTap: (url) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("URL tapped: $url")),
              );
            },
            onEmailTap: (email) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Email tapped: $email")),
              );
            },
            onPhoneTap: (phone) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Phone tapped: $phone")),
              );
            },
          ),
        ),
      ),
    );
  }
}
