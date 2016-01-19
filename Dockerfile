FROM webratio/ant

# Installs i386 architecture required for running 32 bit Android tools
RUN dpkg --add-architecture i386 && \
      apt-get update -y && \
      apt-get install -y libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 && \
      rm -rf /var/lib/apt/lists/* && \
                                  apt-get autoremove -y && \
                                  apt-get clean

# Installs Android SDK
ENV ANDROID_SDK_FILENAME android-sdk_r24.4.1-linux.tgz
ENV ANDROID_SDK_URL http://dl.google.com/android/${ANDROID_SDK_FILENAME}
ENV ANDROID_API_LEVELS android-22
ENV ANDROID_BUILD_TOOLS_VERSION 23.0.2
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools
RUN mkdir -p /opt
WORKDIR /opt
RUN wget ${ANDROID_SDK_URL}
RUN tar -xzf ${ANDROID_SDK_FILENAME}
RUN rm ${ANDROID_SDK_FILENAME}
RUN ls
RUN echo y | android update sdk --no-ui -a --filter tools,platform-tools,${ANDROID_API_LEVELS},build-tools-${ANDROID_BUILD_TOOLS_VERSION}
RUN apt-get update
RUN apt-get install unzip
RUN unzip /opt/android-sdk-linux/temp/tools_r24.4.1-linux.zip
RUN rm -r /opt/android-sdk-linux/tools
RUN mv tools /opt/android-sdk-linux/
RUN echo y | android update sdk --no-ui --filter 41,42,44,45
