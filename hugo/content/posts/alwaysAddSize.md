---
title: "Assigning a capacity to data structures is important"
date: 2021-02-10T20:19:02Z
draft: false
---

For years I underestimated the importance of fixing the capacity of my data structures. Today while I was tracking a nasty bug in one of my software I finally realized that has to stop. After some thinking these are the conclusions I arrived:
By assigning a size…
1)	It is possible to understand more easily what “pipe” has filled in situations where the memory allocation keeps slowly escalating (either because it is not released or because new data is generated more frequently than consumed) and consequently not being overwhelmed during the fixing process;
2)	It is possible to keep track of performances by being warned about structures that are frequently filled;
3)	It is possibly to keep under control the memory footprint of the software.

