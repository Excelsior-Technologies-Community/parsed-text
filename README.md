# Flutter Parsed Text

A lightweight and customizable Flutter widget for parsing and styling text patterns such as:

- @mentions
- #hashtags
- URLs
- Emails
- Phone numbers

Supports clickable interactions with automatic URL launching, email opening, and phone dialing.

---

# ✨ Features

- 🔗 URL detection & browser launch
- 📧 Email detection & mail app launch
- 📞 Phone detection & dialer launch
- 👤 Mention parsing
- #️⃣ Hashtag parsing
- 🎨 Fully customizable styles
- 👆 Tap callbacks support
- ⚡ Lightweight & easy to use
- 📱 Responsive rich text rendering

---

### demo 


https://github.com/user-attachments/assets/96d274da-de04-4ea3-894e-ebb23ef75867





# 📦 Installation

Add dependency in your `pubspec.yaml`:

```yaml
dependencies:
  flutter_parsed_text: 
  path: ../
```

Required dependency:

```yaml
dependencies:
  url_launcher: ^6.3.0
```

Then run:

```bash
flutter pub get
```

---

# 🚀 Import

```dart
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
```

---

# 🛠 Basic Usage

```dart
ParsedText(
  text: "Hello @jay welcome to #flutter",
)
```

---

# 📱 Full Example

```dart
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
      appBar: AppBar(
        title: const Text("Parsed Text Demo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ParsedText(
          text: '''
Hello @jay

Welcome to #flutter

Website:
https://flutter.dev

Email:
test@gmail.com

Phone:
9876543210
''',

          onMentionTap: (value) {
            debugPrint("Mention tapped: $value");
          },

          onHashtagTap: (value) {
            debugPrint("Hashtag tapped: $value");
          },

          onUrlTap: (value) {
            debugPrint("URL tapped: $value");
          },

          onEmailTap: (value) {
            debugPrint("Email tapped: $value");
          },

          onPhoneTap: (value) {
            debugPrint("Phone tapped: $value");
          },

          mentionStyle: const TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),

          hashtagStyle: const TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),

          urlStyle: const TextStyle(
            color: Colors.green,
            decoration: TextDecoration.underline,
          ),

          emailStyle: const TextStyle(
            color: Colors.orange,
          ),

          phoneStyle: const TextStyle(
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
```

---

# ⚙️ Parameters

| Parameter | Type | Description |
|---|---|---|
| `text` | `String` | Text to parse |
| `style` | `TextStyle?` | Default text style |
| `mentionStyle` | `TextStyle?` | Mention text style |
| `hashtagStyle` | `TextStyle?` | Hashtag text style |
| `urlStyle` | `TextStyle?` | URL text style |
| `emailStyle` | `TextStyle?` | Email text style |
| `phoneStyle` | `TextStyle?` | Phone text style |
| `onMentionTap` | `Function(String)?` | Mention tap callback |
| `onHashtagTap` | `Function(String)?` | Hashtag tap callback |
| `onUrlTap` | `Function(String)?` | URL tap callback |
| `onEmailTap` | `Function(String)?` | Email tap callback |
| `onPhoneTap` | `Function(String)?` | Phone tap callback |
| `parseMentions` | `bool` | Enable mention parsing |
| `parseHashtags` | `bool` | Enable hashtag parsing |
| `parseUrls` | `bool` | Enable URL parsing |
| `parseEmails` | `bool` | Enable email parsing |
| `parsePhones` | `bool` | Enable phone parsing |

---

# 🔥 Automatic Actions

The package automatically:

| Type | Action |
|---|---|
| URL | Opens browser |
| Email | Opens mail app |
| Phone | Opens dialer |

---

# 🎨 Custom Styling

```dart
ParsedText(
  text: "Hello @jay",

  mentionStyle: const TextStyle(
    color: Colors.blue,
    fontWeight: FontWeight.bold,
  ),
)
```

---

# 🚫 Disable Specific Parsing

```dart
ParsedText(
  text: "Hello @jay #flutter",

  parseMentions: false,
)
```

---

# 🧠 How It Works

The widget:

1. Uses RegExp patterns to detect text types
2. Splits text into styled spans
3. Creates clickable `TextSpan`s
4. Renders everything using `RichText`
5. Launches URLs, emails, and phones automatically

---

# 📌 Supported Patterns

| Pattern | Example |
|---|---|
| Mention | `@jay` |
| Hashtag | `#flutter` |
| URL | `https://flutter.dev` |
| Email | `test@gmail.com` |
| Phone | `9876543210` |

---

# 📄 License

MIT License

Copyright (c) 2026 Excelsior technologies

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
