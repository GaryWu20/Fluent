# Fluent
A socially-oriented language learning mobile app that connects you with fluent speakers to level up your language training.

## Minimum Viable Product (MVP)
- User accounts
  * User authentication & profile creation (e.g. name, bio, languages, interests, etc.)
  * Ability to edit your own profile and view others'
- Matching algorithm
  * Match users based on their languages and preferences
  * Ability to find a new match
- Ability to search for and find a specific user
- Inbox to see current conversations
- In-app text chat
- In-app voice chat

## Stretch Goals
- Chat Features
  * In-app video chat
  * Group chats/forums
  * Chatbot assistant to help generate more conversation/add structure
  * Ability to translate a chat message (using Google Translate)
  * Voice Memos (like iMessage voice memos)
  * Speech to Text Functions (w/ Google Speech To Text)
  * Corrections for feedback
- Learning Features
  * Learning section (eg. basic phrases, alphabet, etc. for major languages)
- Tracking Features
  * Daily interaction streak
- Social Features
  * Ability to block another user
  * Geolocation: filter by people near me
  
## Resources
### General Software
- [Git Bash](https://git-scm.com/downloads) 
  * For command line Git
- Text Editors/IDEs
  * [Android Studio](https://developer.android.com/studio): IDE designed specifically for Android app development, works well with Flutter 
- UI/UX Design Tool options: 
  * [Figma](https://www.figma.com/): free web-based design tool
  * [Adobe XD](https://www.adobe.com/products/xd.html): more powerful design tool, can have 1 project for free

### Tech Stack
**Mobile Application Framework**
- [Flutter](https://flutter.dev/)
  * Uses [Dart](https://dart.dev/): used less by developers than JavaScript, but has great documentation
  * Lots of built-in components

**Database Options**
- [Firebase](https://firebase.google.com/)
  * Works well with Flutter (b/c also released by Google)
  * Real-time database, cross-platform API
  * Whole ecosystem for mobile development, also includes user authentication and text chat
  * Free up to 1 GB of storage (see plans [here](https://firebase.google.com/pricing))

**Chat APIs**
- [Twilio Conversations API](https://www.twilio.com/conversations-api)
  * Scalable, multiparty conversations
  * Free up to 200 users
- [Twilio VOIP (Voice Over Internet Protocol)](https://www.twilio.com/client)
  * $0.0040 per minute for calls to or from mobile devices

### [Getting Started](https://docs.google.com/document/d/17Tu3zG0fuDVQO7FjPYxGqbTPvIRuphNbcDw4orascy8/edit?usp=sharing)
^ A general installation guide. Please feel free to find additional resources that work for you!

#### Learning Resources
Look through all of these resources at the beginning :)
- [How to be successful in ACM Projects](https://docs.google.com/document/d/1mRIWzmfmJO3MCsvR9vr6VI94GnVYtHqZiq4sqMd3fic/edit?usp=sharing)
- [Overview of making API calls](https://snipcart.com/blog/apis-integration-usage-benefits)
- [Professor Cole's How to Program](https://personal.utdallas.edu/~jxc064000/HowToProgram.html)

#### Common GitHub Commands
[GitHub Cheatsheet PDF](https://education.github.com/git-cheat-sheet-education.pdf)

[Video: Learn Git in 15 minutes](https://youtu.be/USjZcfj8yxE)

General Use:
| Command | Description |
| :-----: | :---------: |
| cd "Fluent" | Change directories to our repository |
| git branch | Lists branches |
| git branch "branch name " | Makes a new branch |
| git checkout "branch name" | Switch to branch |
| git checkout -b "branch name" | 2 previous commands combined |
| git add . | Finds and adds all changed files to your next commit |
| git commit -m "msg" | Commit with message |
| git push origin "branch" | Push to branch |
| git pull origin "branch" | Pull updates from a specific branch |
