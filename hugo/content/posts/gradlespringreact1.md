---
title: "Gradle, Spring, and React, Part 1"
date: 2021-02-23T21:55:25Z
draft: false
---


In the past few days I decided to spend some time playing with the [spring](https://spring.io) framework. 

My favorite build environment for JAVA is gradle, so the first step was to figure out how to have Webpack and NPN seamlessly work together. 

I also like for my code to support being compiled from both Windows and Linux. The major issue was how to configure the gradle build file. In fact, by following the instruction found online, WebPack and NPN would fail on Windows for multiple reasons (one of them was path related). 

I fixed the NPN problem by using the [pluging](https://github.com/srs/gradle-node-plugin) provided by moonwork by means of which it is possible to execute NPN install and other commands from gradle. 

To fix the WebPack issue, I created a webpack task that would behave differently based on the operative system. In the end you can see my build.gradle as an example. 

Some useful commands: 

    // Run the spring applications after compiling the JS code
    gradle bootRun
    
    // Creates a jar for the application that can be run doing java -jar build/libs/<jar-name>.jar
    gradle jar

    // Configure and install NPN dependencies 
    gradle npnSetup/npnInstall 

    // Compile React code, this will be executed automatically when the bootRun task is called.
    gradle webpack

build.gradle:

    plugins {
        id 'org.springframework.boot' version '2.4.1'
        id 'io.spring.dependency-management' version '1.0.10.RELEASE'
        id 'java'
        // trying
        id "com.moowork.node" version "1.3.1"
    }

    group = 'us.ihmc'
    version = '0.0.1-SNAPSHOT'
    sourceCompatibility = '1.8'

    apply plugin: "com.moowork.node"
    node {
        version = '12.16.2'
        npmVersion = '6.14.4'
        download = true
    }

    repositories {
        mavenCentral()
    }

    dependencies {
        // data backend
        implementation 'org.springframework.boot:spring-boot-starter-data-jpa'
        runtimeOnly 'com.h2database:h2'
        compileOnly 'org.projectlombok:lombok'
        annotationProcessor 'org.projectlombok:lombok'
        implementation 'org.springframework.boot:spring-boot-starter-hateoas'
        implementation 'org.springframework.boot:spring-boot-starter-thymeleaf'
        implementation 'org.springframework.boot:spring-boot-starter-web'
        testImplementation 'org.springframework.boot:spring-boot-starter-test'
        testImplementation 'io.projectreactor:reactor-test'
    }

    test {
        useJUnitPlatform()
    }

    task webpack(type: Exec) {
        if (System.getProperty('os.name').toLowerCase(Locale.ROOT).contains('windows')) {
                commandLine 'cmd', '/c', 'npm run webpack'
        } else {
            commandLine 'npn run webpack'
        }
    }
    
    processResources.dependsOn 'webpack'
    clean.delete << file('node_modules')
    clean.delete << file('src/main/resources/static/dist')


