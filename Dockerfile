FROM ubuntu:16.04

LABEL version="1.0.4" \
  maintainer="Carlos Paulino" \
  maintainer.email="cpaulino@gmail.com" \
  description="Android Build Docker image" \
  repository="https://github.com/carlospaulino/android-builder"

# setup deps & java
RUN apt-get update \
  && apt-get install lib32ncurses5 lib32z1 software-properties-common wget git unzip --yes \
  && echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections \
  && add-apt-repository ppa:webupd8team/java \
  && apt-get update \
  && apt-get install oracle-java8-set-default --yes \
  && apt-get clean

# setup android sdk and android sdk licences
RUN wget -O /opt/android-tools.zip https://dl.google.com/android/repository/tools_r25.2.3-linux.zip \
  && unzip /opt/android-tools.zip -d /opt \
  && mkdir -p /opt/android-sdk/licenses \
  && mv /opt/tools /opt/android-sdk/tools \
  && rm /opt/android-tools.zip \
  && echo "8933bad161af4178b1185d1a37fbf41ea5269c55" > /opt/android-sdk/licenses/android-sdk-license \
  && echo "84831b9409646a918e30573bab4c9c91346d8abd" > /opt/android-sdk/licenses/android-sdk-preview-license \
  && echo "d975f751698a77b662f1254ddbeed3901e976f5a" > /opt/android-sdk/licenses/intel-android-extra-license \
  && mkdir ~/.android; echo "count=0" >> ~/.android/repositories.cfg

ENV JAVA_HOME=/usr/lib/jvm/java-8-oracle \
  ANDROID_HOME=/opt/android-sdk \
  JAVA_OPTS="-Xms2048m -Xmx5120m"

COPY android-packages /tmp/android-packages

# download android packages
RUN /opt/android-sdk/tools/bin/sdkmanager --package_file=/tmp/android-packages \
  && rm /tmp/android-packages

# wrap up
RUN mkdir /tmp/project \
  && echo "sdk.dir=$ANDROID_HOME" > /tmp/project/local.properties

WORKDIR /tmp/project
