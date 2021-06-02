Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB51A399489
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 22:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhFBUbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 16:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbhFBUbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 16:31:02 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5162BC06174A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 13:29:19 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id l1so3255409pgm.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 13:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MD+isL8cNVT/yF1S1l/22CEEX+JBBjfdFhs5HrJbFZ0=;
        b=MFN/v6HAtmbiBcr/rW9sBIkkjZbiudr1DhMvzrLq1O3AAnYMn02NQr+HwsvapcGEZX
         CPjt9kjtmYpyWkdPiKYURP5yTbv+wmC1WETW/uTaTgKT5cQEkRthljpjgQeylXoCA2qZ
         n963YCHB30oxbOj9um4IKM24KUgQ+iStfwknk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MD+isL8cNVT/yF1S1l/22CEEX+JBBjfdFhs5HrJbFZ0=;
        b=jj7mUuRTNjnw7LFROHwRwVWF9ur4MUbihjZDhxFVX7rCEXt8tVF0JcZtLFnPtXqaNR
         UZSk31ojvAmYQdJ/XToW+egoo8XfZe1ckoIpYdhJLJ2JMbLkgEMQsKwZNH4430BW9+B5
         vyxqWZEZw8uIlNO8aqoYwwHu0Zp9hqtbQhwPk233hEVACekb+2j3gIoLu+blVQUyUhNG
         i4GaWLJbmAL92PZ9ln8bAQAH2xip55SR1VAljU8ezA9Ti2K3ufFMWnnkLvHn5AiqrsyV
         +yoUPCKnL6Iza3YgcO8JLxJyjhmpQwk5+bZVBWaFsQhymAG2QltJam4qVyQEgCXhaBxH
         0o9Q==
X-Gm-Message-State: AOAM531911OlFdS/YzZ7Cp1ZaI2OoiVo5MCMVxWdGl9+UdeeTneTGUAy
        QZkMbHDLX0k5adB/RzHJ+nLzy7yo7mxYcQ==
X-Google-Smtp-Source: ABdhPJyg1lwfSzxzEISHF+uwm+A+ZRndlFWtVzrGgCDaE4ivIe5hOhAxzRoZmPk9Fxyx/dV5kW2jsg==
X-Received: by 2002:a65:41c8:: with SMTP id b8mr35391636pgq.196.1622665758956;
        Wed, 02 Jun 2021 13:29:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c17sm596607pgm.3.2021.06.02.13.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 13:29:18 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Maxim Krasnyansky <maxk@qti.qualcomm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH] docs: networking: Replace strncpy() with strscpy()
Date:   Wed,  2 Jun 2021 13:29:14 -0700
Message-Id: <20210602202914.4079123-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=08a021de6652594e6002a3fa2779560fbfe4687c; i=OtS/j+af/fe4GVQBQBUoq9mDVJJ7GbT1sWYBCoEQ36k=; m=gAU3qSQ85FC8trlGFWM3KtcCVKh49fUAyHP3MClMFZg=; p=x25iameOGPjYX/6T3Mx1eg/f0np3ZbIi5+Bk5dRwABo=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmC36hkACgkQiXL039xtwCaRMw/7BAD suzqyeGDnSLe/rc/lhfELAz/dIUzadYBlY6Po3Mjhl2SFXMB3ehLUAL/+Pu48v3H0P5TMM1/TuAXs jEg8JUmwkKSKslqWXRGuSDlhd0f/s0d2Zx8eprgIRQArAtCrMwGBgxpcQtCBSGBZUSqSFhtf/AUid FOgAN+2tyXObxmwoFmpp1osEZYqyQUGQY9mhUiTPiaj5F0Ba1Fsm2ajqPaUC0iPeiP7b7YiBbdPbB sgJy53vMebfmFevoJwAulBV+FHI8z5XhGHflTiGB4MDHQkMplQuyXVoCdt2V+NFYPPr3TasjCalLU 3WelN3uzN140SAKe393Xh/uVF/Ktv1nqLKfT83+t2hC4k8bz8jbY1HcqVDh4CuOaXpfrIoLfR2e0G D1C4QKu7gNcfWxA6RFignhiNcjqRRgKK/0eWYFywFvVJEhY0gKUY1NeWWzAFVMlB3WCDnNI3au7Y+ +78VLNn+Ay0hd0UUK6r7io1kIgXvMBZIV0bZfQ833RLsQNYFAc8KznhD/5mkqb3tqEkFY0Da99JVC QEKz9kbcUB6mt5Rn8roJsUoZSqEmilJcZEKk1CkGYuSeZoQXnFni/zVqWBuXE81BgrEo8yjLxW6TQ ppwwDAxmY4lHuBJ90zGnafPLdRWg78AtSfPZwzDW8+TYO1Cmf24NCXnd2fGNDF+A=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace example code's use of strncpy() with strscpy() functions. Using
strncpy() is considered deprecated:
https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/input/joydev/joystick-api.rst | 2 +-
 Documentation/networking/packet_mmap.rst    | 2 +-
 Documentation/networking/tuntap.rst         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/input/joydev/joystick-api.rst b/Documentation/input/joydev/joystick-api.rst
index af5934c10c1c..5db6dc6fe1c5 100644
--- a/Documentation/input/joydev/joystick-api.rst
+++ b/Documentation/input/joydev/joystick-api.rst
@@ -263,7 +263,7 @@ possible overrun should the name be too long::
 
 	char name[128];
 	if (ioctl(fd, JSIOCGNAME(sizeof(name)), name) < 0)
-		strncpy(name, "Unknown", sizeof(name));
+		strscpy(name, "Unknown", sizeof(name));
 	printf("Name: %s\n", name);
 
 
diff --git a/Documentation/networking/packet_mmap.rst b/Documentation/networking/packet_mmap.rst
index 500ef60b1b82..c5da1a5d93de 100644
--- a/Documentation/networking/packet_mmap.rst
+++ b/Documentation/networking/packet_mmap.rst
@@ -153,7 +153,7 @@ As capture, each frame contains two parts::
     struct ifreq s_ifr;
     ...
 
-    strncpy (s_ifr.ifr_name, "eth0", sizeof(s_ifr.ifr_name));
+    strscpy_pad (s_ifr.ifr_name, "eth0", sizeof(s_ifr.ifr_name));
 
     /* get interface index of eth0 */
     ioctl(this->socket, SIOCGIFINDEX, &s_ifr);
diff --git a/Documentation/networking/tuntap.rst b/Documentation/networking/tuntap.rst
index a59d1dd6fdcc..4d7087f727be 100644
--- a/Documentation/networking/tuntap.rst
+++ b/Documentation/networking/tuntap.rst
@@ -107,7 +107,7 @@ Note that the character pointer becomes overwritten with the real device name
        */
       ifr.ifr_flags = IFF_TUN;
       if( *dev )
-	 strncpy(ifr.ifr_name, dev, IFNAMSIZ);
+	 strscpy_pad(ifr.ifr_name, dev, IFNAMSIZ);
 
       if( (err = ioctl(fd, TUNSETIFF, (void *) &ifr)) < 0 ){
 	 close(fd);
-- 
2.25.1

