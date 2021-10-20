Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89FF543546C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 22:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhJTURG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 16:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhJTURF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 16:17:05 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1A9C061749;
        Wed, 20 Oct 2021 13:14:50 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id s198-20020a1ca9cf000000b0030d6986ea9fso12150816wme.1;
        Wed, 20 Oct 2021 13:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=TKTpnnnUpx+vD8sFIjPYUVjAFgwjxzS94IwIoEcy9XE=;
        b=ZpJsnpmr/x3a0OTfxnf4RZ8VTobw3AJrfaj3EFN950XhYPiXwr/C6XHo89zBdhiCZY
         FEERPulmFuvNJ0jTJdF1TD4LfOOrCmMi+7A2WYxeDwNuSDZpt2oCf4EP07fPkCo/7X4w
         ACu9OpYBsZSTEAe/PVByb9f8NYONGbU0T3b6aq/RATPlWZ2XHDJUrAjndLHnRSWABixp
         pCG/tDK0PwacGwKRMilYjAhLZzwnt796obyM4ZoTTKnhGbcBmH4X0/87rBrbSjPGTipC
         dH4BC9b8sM8QRsZnoPOZ2nIdnNQnxk5Bo3hVUHZ1EKjDM++LL2AxdITpLaPfzoMJvzQp
         9UDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=TKTpnnnUpx+vD8sFIjPYUVjAFgwjxzS94IwIoEcy9XE=;
        b=Wfnvq7vV+z9s2eg1SXoM0nh6CttkR24HcE9CbATxHpNzSiRQKObzicNU4vYOn3m3Zi
         pNboesnsR22voSRShRGCYQf+UUD609BAzB2Bukq+mxxiaDgi+PFHrOdKAXg6VAXg5CHU
         ankkuXTaaauTsiwU+qDMPzK0xhbvo2hReJICxbiqNHXOecWuyxB96q0uH7E7P+F+mGPk
         EWlqVepLq3JLIQwc2IlL92XGwJxXwbYYLrqCBXiu09ho7DKEPQtZymGmfJFNbXeOKTGl
         9DuZahbuoxJdFaBtacQn24hvr0yaykVyXY5mCbgx4HQ7xiaY60jqpamOHOYQTFC9608F
         g9ZA==
X-Gm-Message-State: AOAM532bc9Ur051FRA9VvfBewV7ZQG+Rz49w4vuTc5WNKxf1eDSY384x
        33YKlZcX4kQM3OFmpxw51LPNNsAlAIk=
X-Google-Smtp-Source: ABdhPJy6tDIo254eUcAHKcO53ATzE0ea0MsNiclyGriseMbXQ6j6HJzda8gMIF57tM6sY5EtWs/Ckw==
X-Received: by 2002:a05:600c:4ec8:: with SMTP id g8mr15911251wmq.153.1634760889182;
        Wed, 20 Oct 2021 13:14:49 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p200300c78f4e0613a7e83c8384f9a2e9.dip0.t-ipconnect.de. [2003:c7:8f4e:613:a7e8:3c83:84f9:a2e9])
        by smtp.gmail.com with ESMTPSA id f18sm2810499wrg.3.2021.10.20.13.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 13:14:48 -0700 (PDT)
Date:   Wed, 20 Oct 2021 22:14:46 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org
Subject: [PATCH v2] Docs: usb: update struct usb_driver, __init and __exit
Message-ID: <20211020201446.GA8482@matrix-ESPRIMO-P710>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update struct usb_driver from usb-skeleton.c.
update __init and __exit functions that are moved from
usb-skeleton.c to common used multi-stage macros.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1 -> V2: changed :c:func:`usb_register` to usb_register()
          changed the :c:func:`usb_deregister` to usb_deregister()
          used literal blocks for makro module_usb_driver and added one more
          stage of multi-stage macros.

 .../driver-api/usb/writing_usb_driver.rst     | 70 ++++++++++---------
 1 file changed, 36 insertions(+), 34 deletions(-)

diff --git a/Documentation/driver-api/usb/writing_usb_driver.rst b/Documentation/driver-api/usb/writing_usb_driver.rst
index 2176297e5765..12e0481cceae 100644
--- a/Documentation/driver-api/usb/writing_usb_driver.rst
+++ b/Documentation/driver-api/usb/writing_usb_driver.rst
@@ -54,12 +54,15 @@ information is passed to the USB subsystem in the :c:type:`usb_driver`
 structure. The skeleton driver declares a :c:type:`usb_driver` as::
 
     static struct usb_driver skel_driver = {
-	    .name        = "skeleton",
-	    .probe       = skel_probe,
-	    .disconnect  = skel_disconnect,
-	    .fops        = &skel_fops,
-	    .minor       = USB_SKEL_MINOR_BASE,
-	    .id_table    = skel_table,
+           .name        = "skeleton",
+           .probe       = skel_probe,
+           .disconnect  = skel_disconnect,
+           .suspend     = skel_suspend,
+           .resume      = skel_resume,
+           .pre_reset   = skel_pre_reset,
+           .post_reset  = skel_post_reset,
+           .id_table    = skel_table,
+           .supports_autosuspend = 1,
     };
 
 
@@ -81,36 +84,35 @@ this user-space interaction. The skeleton driver needs this kind of
 interface, so it provides a minor starting number and a pointer to its
 :c:type:`file_operations` functions.
 
-The USB driver is then registered with a call to :c:func:`usb_register`,
-usually in the driver's init function, as shown here::
-
-    static int __init usb_skel_init(void)
-    {
-	    int result;
-
-	    /* register this driver with the USB subsystem */
-	    result = usb_register(&skel_driver);
-	    if (result < 0) {
-		    err("usb_register failed for the "__FILE__ "driver."
-			"Error number %d", result);
-		    return -1;
-	    }
-
-	    return 0;
-    }
-    module_init(usb_skel_init);
-
+The USB driver is then registered with a call to usb_register()
+which is usually in the driver's init function. Since this functionality
+is usable with many USB drivers, it is hidden behind multi-stage macros.
+While the first macros are USB specific the later macros are used in different
+subsystems. This removes a lot of boilerplate code.
 
 When the driver is unloaded from the system, it needs to deregister
-itself with the USB subsystem. This is done with the :c:func:`usb_deregister`
-function::
-
-    static void __exit usb_skel_exit(void)
-    {
-	    /* deregister this driver with the USB subsystem */
-	    usb_deregister(&skel_driver);
-    }
-    module_exit(usb_skel_exit);
+itself with the USB subsystem. This is done with usb_deregister()
+which is also hidden behind multi-stage macros.
+
+The init and exit functions are included in the macro module_usb_driver.
+Find the first three stages of macros below::
+
+    module_usb_driver(skel_driver);
+                         |
+                         V
+    module_driver(__usb_driver, usb_register, usb_deregister)
+                         |               \               \
+                         V                ----------      ----------
+    static int __init __driver##_init(void) \      |               |
+    { \                 v---------------------------               |
+            return __register(&(__driver) , ##__VA_ARGS__); \      |
+    } \                                                            |
+    module_init(__driver##_init); \                                |
+    static void __exit __driver##_exit(void) \                     |
+    { \            v------------------------------------------------
+            __unregister(&(__driver) , ##__VA_ARGS__); \
+    } \
+    module_exit(__driver##_exit);
 
 
 To enable the linux-hotplug system to load the driver automatically when
-- 
2.25.1

