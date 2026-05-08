import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ParsedText extends StatelessWidget {
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  final String text;

  final TextStyle? style;
  final TextStyle? mentionStyle;
  final TextStyle? hashtagStyle;
  final TextStyle? urlStyle;
  final TextStyle? emailStyle;
  final TextStyle? phoneStyle;

  final Function(String)? onMentionTap;
  final Function(String)? onHashtagTap;
  final Function(String)? onUrlTap;
  final Function(String)? onEmailTap;
  final Function(String)? onPhoneTap;

  final bool parseMentions;
  final bool parseHashtags;
  final bool parseUrls;
  final bool parseEmails;
  final bool parsePhones;

  const ParsedText({
    super.key,
    required this.text,
    this.style,
    this.mentionStyle,
    this.hashtagStyle,
    this.urlStyle,
    this.emailStyle,
    this.phoneStyle,
    this.onMentionTap,
    this.onHashtagTap,
    this.onUrlTap,
    this.onEmailTap,
    this.onPhoneTap,
    this.parseMentions = true,
    this.parseHashtags = true,
    this.parseUrls = true,
    this.parseEmails = true,
    this.parsePhones = true,
  });

  @override
  Widget build(BuildContext context) {
    final List<PatternData> patterns = [];

    if (parseMentions) {
      patterns.add(
        PatternData(
          regex: RegExp(r'@\w+'),
          style:
              mentionStyle ??
              const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          onTap: onMentionTap,
        ),
      );
    }

    if (parseHashtags) {
      patterns.add(
        PatternData(
          regex: RegExp(r'#\w+'),
          style:
              hashtagStyle ??
              const TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
          onTap: onHashtagTap,
        ),
      );
    }

    if (parseUrls) {
      patterns.add(
        PatternData(
          regex: RegExp(r'(https?:\/\/[^\s]+)'),
          style:
              urlStyle ??
              const TextStyle(
                color: Colors.green,
                decoration: TextDecoration.underline,
              ),
          onTap: onUrlTap,
        ),
      );
    }

    if (parseEmails) {
      patterns.add(
        PatternData(
          regex: RegExp(r'[\w-\.]+@([\w-]+\.)+[\w-]{2,4}'),
          style: emailStyle ?? const TextStyle(color: Colors.orange),
          onTap: onEmailTap,
        ),
      );
    }

    if (parsePhones) {
      patterns.add(
        PatternData(
          regex: RegExp(r'(\+?\d{1,3})?[-.\s]?\d{10}'),
          style: phoneStyle ?? const TextStyle(color: Colors.red),
          onTap: onPhoneTap,
        ),
      );
    }

    final List<MatchData> allMatches = [];

    for (final pattern in patterns) {
      final matches = pattern.regex.allMatches(text);

      for (final match in matches) {
        allMatches.add(
          MatchData(
            start: match.start,
            end: match.end,
            text: text.substring(match.start, match.end),
            style: pattern.style,
            onTap: pattern.onTap,
          ),
        );
      }
    }

    allMatches.sort((a, b) => a.start.compareTo(b.start));

    List<TextSpan> spans = [];

    int currentIndex = 0;

    for (final match in allMatches) {
      if (match.start < currentIndex) continue;

      if (match.start > currentIndex) {
        spans.add(
          TextSpan(
            text: text.substring(currentIndex, match.start),
            style: style ?? const TextStyle(color: Colors.black),
          ),
        );
      }

      spans.add(
        TextSpan(
          text: match.text,
          style: match.style,
         recognizer: TapGestureRecognizer()
  ..onTap = () async {

    /// URL
    if (match.text.startsWith('http')) {
      final uri = Uri.parse(match.text);

      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }

    /// Email
    else if (match.text.contains('@')) {
      final uri = Uri(
        scheme: 'mailto',
        path: match.text,
      );

      await launchUrl(uri);
    }

    /// Phone
    else if (RegExp(r'(\+?\d{1,3})?[-.\s]?\d{10}')
        .hasMatch(match.text)) {
      final uri = Uri(
        scheme: 'tel',
        path: match.text,
      );

      await launchUrl(uri);
    }

    match.onTap?.call(match.text);
  },
        ),
      );

      currentIndex = match.end;
    }

    if (currentIndex < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(currentIndex),
          style: style ?? const TextStyle(color: Colors.black),
        ),
      );
    }

    return RichText(text: TextSpan(children: spans));
  }
}

class PatternData {
  final RegExp regex;
  final TextStyle style;
  final Function(String)? onTap;

  PatternData({required this.regex, required this.style, required this.onTap});
}

class MatchData {
  final int start;
  final int end;
  final String text;
  final TextStyle style;
  final Function(String)? onTap;

  MatchData({
    required this.start,
    required this.end,
    required this.text,
    required this.style,
    required this.onTap,
  });
}
