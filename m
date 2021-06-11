Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619893A3974
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 03:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhFKCBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 22:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbhFKCBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 22:01:04 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723A1C061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 18:58:59 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id b14so14181351iow.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 18:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zZJde4o2L2qg8vNw7HtP2CFLX1sOraFXZhqavB6u28E=;
        b=HlbEw/IgXPWlFlo5xmewtDujAgpnKlacrXyXaWF8GPL/1k0dBg8z5PMwMl+NT4bto1
         x6Agoa5Tcwft8dvKREYpTefTCPXRO9p8X4dKZRaocFaenR0PotQHwrcHDrLBHQfXbeXr
         cvb0v86EJCg0u+5jVGidvPMt0Ou3JOl/zSHZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zZJde4o2L2qg8vNw7HtP2CFLX1sOraFXZhqavB6u28E=;
        b=cpi1JNzB2uPNr3QX1W4CS+2KDE5zZ/C6d2tshH/S57VuST/t/0GiVbOKeDiJICz/k/
         KZZ2VQ+XfmiWSFd8vMu0N0Im2j/IuN4TE8E8Wgm+z82jhf1hp7lsvRWc8gyRaCZpoS/u
         ejReEocG7Rf09R+yReavJoln+yLKIAR322jVWD6qJZP/XurYpYZqdVEHQFMSYNbUXvOx
         dIkuMDiicq21x/fOQy1K0D/5iotka/KumYFjep34Qcjp1jNafwYJyt841jaLJ1HkKSSs
         1aMl6fCOMg5tQwxtazDM2lfMKACXH64IqUKhjSg+RQFmRKWXawcr3e14YnQGQiWstevk
         flsQ==
X-Gm-Message-State: AOAM530kW951a1hT57u+oSr8uwPf9OtBc2gk+Vlgx05FH+ZxB3H9zaLY
        YcREutkISzudrLlU42R+Fh50Qw==
X-Google-Smtp-Source: ABdhPJy5dyB25zNPV/G1vZwDtG6mro/vxYNPOH0KijCRQMYYArulRACmbS3ga0zv//1UXMp/D0aa4g==
X-Received: by 2002:a05:6638:1682:: with SMTP id f2mr1376788jat.139.1623376738776;
        Thu, 10 Jun 2021 18:58:58 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n20sm2623663ioo.23.2021.06.10.18.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 18:58:58 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     sakari.ailus@linux.intel.com, laurent.pinchart@ideasonboard.com,
        dan.carpenter@oracle.com, mchehab@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: [PATCH] media: Fix Media Controller API config checks
Date:   Thu, 10 Jun 2021 19:58:49 -0600
Message-Id: <20210611015849.42589-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch static checker warns that "mdev" can be null:

sound/usb/media.c:287 snd_media_device_create()
    warn: 'mdev' can also be NULL

If CONFIG_MEDIA_CONTROLLER is disabled, this file should not be included
in the build.

The below conditions in the sound/usb/Makefile are in place to ensure that
media.c isn't included in the build.

sound/usb/Makefile:
snd-usb-audio-$(CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER) += media.o

select SND_USB_AUDIO_USE_MEDIA_CONTROLLER if MEDIA_CONTROLLER &&
       (MEDIA_SUPPORT=y || MEDIA_SUPPORT=SND_USB_AUDIO)

The following config check in include/media/media-dev-allocator.h is
in place to enable the API only when CONFIG_MEDIA_CONTROLLER and
CONFIG_USB are enabled.

 #if defined(CONFIG_MEDIA_CONTROLLER) && defined(CONFIG_USB)

This check doesn't work as intended when CONFIG_USB=m. When CONFIG_USB=m,
CONFIG_USB_MODULE is defined and CONFIG_USB is not. The above config check
doesn't catch that CONFIG_USB is defined as a module and disables the API.
This results in sound/usb enabling Media Controller specific ALSA driver
code, while Media disables the Media Controller API.

Fix the problem requires two changes:

1. Change the check to use IS_ENABLED to detect when CONFIG_USB is enabled
   as a module or static. Since CONFIG_MEDIA_CONTROLLER is a bool, leave
   the check unchanged to be consistent with drivers/media/Makefile.

2. Change the drivers/media/mc/Makefile to include mc-dev-allocator.o
   in mc-objs when CONFIG_USB is y or m.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lore.kernel.org/alsa-devel/YLeAvT+R22FQ%2FEyw@mwanda/
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/media/mc/Makefile           | 2 +-
 include/media/media-dev-allocator.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/mc/Makefile b/drivers/media/mc/Makefile
index 119037f0e686..140f0a78540e 100644
--- a/drivers/media/mc/Makefile
+++ b/drivers/media/mc/Makefile
@@ -3,7 +3,7 @@
 mc-objs	:= mc-device.o mc-devnode.o mc-entity.o \
 	   mc-request.o
 
-ifeq ($(CONFIG_USB),y)
+ifeq ($(CONFIG_USB),$(filter $(CONFIG_USB),y m))
 	mc-objs += mc-dev-allocator.o
 endif
 
diff --git a/include/media/media-dev-allocator.h b/include/media/media-dev-allocator.h
index b35ea6062596..2ab54d426c64 100644
--- a/include/media/media-dev-allocator.h
+++ b/include/media/media-dev-allocator.h
@@ -19,7 +19,7 @@
 
 struct usb_device;
 
-#if defined(CONFIG_MEDIA_CONTROLLER) && defined(CONFIG_USB)
+#if defined(CONFIG_MEDIA_CONTROLLER) && IS_ENABLED(CONFIG_USB)
 /**
  * media_device_usb_allocate() - Allocate and return struct &media device
  *
-- 
2.30.2

