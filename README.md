# Docker Image for Android Projects
---

Simple docker image that contains all the necessary dependencies to build a modern Android project. It uses [`sdkmanager`](https://developer.android.com/studio/command-line/sdkmanager.html) instead of the deprecated [`android`](http://tools.android.com/recent/androidsdktoolsrevision2530feb2017) tool.

# Contains

* Oracle JDK 8
* Android SDK
* Android NDK
* Android Support Libraries
* Google Play Services
* Latest Build and Platform Tools

See [android-packages](./android-packages) for more Android dependencies.

# Usage

Navigate to project folder and run:

```
docker run --interactive --volume=$(pwd):/tmp/project android-builder:1.0 /bin/sh -c "./gradlew {MY_GRADLE_TASK}"
```

Replace `{MY_GRADLE_TASK}` with any gradle task such as `check` or `build`.

# Finally
Gradle is very memory hungry so give your container at least 4GB of RAM.

# License

Copyright (c) 2017 Carlos Paulino <cpaulino@gmail.com>.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.