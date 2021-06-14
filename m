Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7F53A6F17
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 21:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbhFNTfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 15:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbhFNTe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 15:34:59 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E432C061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 12:32:44 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id e1so7141721plh.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 12:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=/OPxWaLtvVu/z2v/4XfNWK9orPebrYZ20oJOegdJeGo=;
        b=AQmzMqMQWD8J/LlROBnDEwQcTpJJIW7ZtrUMLI2Jjc0U2C6qfUT0qULgPeb3CfktIi
         WNCkEQ38R7rQItUU9rbXFJry6p1M5Oq/d6sn1Hzp72tGFCqJqB99bHi8Zr0f2V0K/7GO
         Dc8+WyKg9TXDm+ndq5FRtjzZafAg6a5dK/x6rWJ72msXGQiUhcPpCZyzdjI25s02ADXM
         VvnDxc6jhgzfl5d7DuiH7jF9PrInTRP1lUbToOAqSuvo83aeVek7dXssKSL0PKS/9NHz
         aL7ooxSpaeNMGTq/rg1ghbAJh2z+maca7pY7oU2WvYh0iDFwJOt5D9xeA7COzAclg+P+
         gfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=/OPxWaLtvVu/z2v/4XfNWK9orPebrYZ20oJOegdJeGo=;
        b=lnlN+CDezHkJ6x5imIVme6WUeQfMVQNLwuH3bSLLKpftu0Sj7dspau4b83DkUl15w2
         J8PS+KeniepPlBqWz75/1Q8zaBlCrTDpSFwiuJ1XgIPsC4ZDB80/f2I0SmayUxkYXqIC
         RGVLMViu0RDkDuEobkFko7Sj0rTfrYpcwD5le7Yyoto4yIu/1BO4XHGT8sFTBq+DiDrW
         bAsoj3YREqV/y4zH+ESE0vARH0BnuPT1EelMxV2liYEO53HUOSW6IuVTdhzMqsXaDM/Q
         hFDJH7ESUqqhvn9o3yl0a39Gv6DcfO5Ujb9zZrWIg0DQtFAn2b4WbHDxQxi9uDZjgJVY
         sydg==
X-Gm-Message-State: AOAM5310sDiXWaY04ZxapW210lKpkOg7Hz+mboBtwy1xSxXVxJdHyVO9
        S8/3NOOzEWQYumIY1DLO57U=
X-Google-Smtp-Source: ABdhPJz08bEuyuWwwwWae+Il5Y8vEh64X4IreInp90IwXE8spwySeGxwFrQWPGzPFvToKno28FoWmw==
X-Received: by 2002:a17:902:c789:b029:110:4933:71ce with SMTP id w9-20020a170902c789b0290110493371cemr404007pla.56.1623699163964;
        Mon, 14 Jun 2021 12:32:43 -0700 (PDT)
Received: from ojas ([122.177.234.250])
        by smtp.gmail.com with ESMTPSA id k21sm13444961pgb.56.2021.06.14.12.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 12:32:43 -0700 (PDT)
Date:   Tue, 15 Jun 2021 01:02:32 +0530
From:   Ojaswin Mujoo <ojaswin98@gmail.com>
To:     nsaenz@kernel.org
Cc:     gregkh@linuxfoundation.org, dan.carpenter@oracle.com,
        phil@raspberrypi.com, bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] Request to review progress decoupling vchiq platform code
Message-ID: <cover.1623698773.git.ojaswin98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I'm working on addressing item 10 of the following TODO list:

    drivers/staging/vc04-services/interface/TODO

For reference, the task is:

    10) Reorganize file structure: Move char driver to it's own file and join
    both platform files

    The cdev is defined alongside with the platform code in vchiq_arm.c. It
    would be nice to completely decouple it from the actual core code. For
    instance to be able to use bcm2835-audio without having /dev/vchiq created.
    One could argue it's better for security reasons or general cleanliness. It
    could even be interesting to create two different kernel modules, something
    the likes of vchiq-core.ko and vchiq-dev.ko. This would also ease the
    upstreaming process.


This patch is the first step towards decoupling the platform and the cdev code.
It moves all the cdev related code from vchiq_arm.c to vchiq_dev.c. However, for
now, I have aimed to keep the functionality untouched, hence the platform code
still calls the cdev initialisation function, and isn't truly decoupled yet.

The summary of the changes is as follows:


 *  Definition of functions and variables shared by cdev and platform
    code are moved to vchiq_arm.h while declaration stays in vchiq_arm.c

 *  Declaration and definition of functions and variables only used by
    cdev code are moved to vchiq_dev.c file.

 *  Defined vchiq_deregister_chrdev() and vchiq_register_chrdev(..) in
    vchiq_dev.c which handle cdev creation and deletion. They are called by the
    platfrom code during probe().


I mainly wanted to put this patch out to see if I have the right idea of the
task at hand and to ensure I'm heading into the right direction. I would love to
hear your thoughts and suggestions on this. Once I have some feedback on this, I
can accordingly work towards a newer version to completely decouple the code. 

Lastly, I had some questions related to the the task: 

1. So regarding the following line in the TODO:

    "For instance to be able to use bcm2835-audio without having /dev/vchiq
    created." 

  I was wondering about the possible ways to achieve this. Specifically, I was
  thinking of the following 2 ways:

  1.1  Making a KConfig entry for Cdev creation, like CONFIG_VCHIQ_CDEV, and
       then do something like:

         vchiq_probe(..) 
         {
           /* platform init code */

           #if defined(CONFIG_VCHIQ_CDEV)

           /* Call cdev register function */

           #endif 
         }

  1.2  The second approach is creating an entirely separate module for the cdev,
       as suggested in the TODO. 

  So I'm just wondering what the right approach should be?

2. Second, I currently tested by installing my patches to a pi3 B+ and running
   `cat /dev/vchiq` to compare the output with the original kernel.  Also, to
   see if the platform code works without the cdev code, I commented out the
   call to vchiq_register_cdev() and made sure the platform device (and
   children) was registered but the char device was not present. However, I'm
   not sure if these tests are comprehensive enough. What would be the right way
   to test my changes?

3. Lastly, I think the git diff is acting up a bit because of the code
   rearrangement.  I tried to check online if this is normal or if I messed it
   up somehow, but couldn't find much. Can someone please confirm this? 

Thank you in advance for looking into this and for helping me out upto this
point!

Regards,
Ojaswin

Ojaswin Mujoo (1):
  staging: vchiq: Move vchiq char driver to its own file

 drivers/staging/vc04_services/Makefile        |    1 +
 .../interface/vchiq_arm/vchiq_arm.c           | 1885 ++---------------
 .../interface/vchiq_arm/vchiq_arm.h           |   73 +
 .../interface/vchiq_arm/vchiq_dev.c           | 1488 +++++++++++++
 4 files changed, 1770 insertions(+), 1677 deletions(-)
 create mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c

-- 
2.25.1

