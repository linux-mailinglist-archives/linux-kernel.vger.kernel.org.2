Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2489C430C69
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 23:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344691AbhJQVwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 17:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235532AbhJQVwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 17:52:02 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DB7C06161C;
        Sun, 17 Oct 2021 14:49:51 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n40-20020a05600c3ba800b0030da2439b21so8524320wms.0;
        Sun, 17 Oct 2021 14:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=Rp36An9Whu1Q5tp2hHHWfj8eeqEEPzX3I1EdK1KS93Q=;
        b=KdRiRJeSS5BCaItuDsrEu4ldLY05y+fpsv0f2NOQDUqkNf6pyn9f1hjL8k6Y1aRQ6V
         eJrEj/T5oEqRe+UTnF4H5tQgxds1r8+FJd73f8CqnTB3Sk2quVYZ9WmR1gib6cWS+4HE
         VU35MsCtaqbMEq9C6DWJlp7b42nTaYmTtq8QsCMC1l0yGIlzH5+yfVapqRhUNLx2dunt
         d9DrmP9dkLG7A9ykJttUKM6nkPuG1cC+POWygmt/VRE1V/NNfqPhwSY5C0sQqrSVNHo8
         yrkpqmwMl4ya3ceFnB4BTpC+UUiFrttbA7fcwkiBrBUInmFcZoBmuKIA+8V5rNwTMo96
         t/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=Rp36An9Whu1Q5tp2hHHWfj8eeqEEPzX3I1EdK1KS93Q=;
        b=ZHM5L8z63ecviwK9Cw1pCRFve0+UzcCCWEoRkHPU3N5WFBMqIGIxxizSnE0X4u58Ab
         NzJVfMj7kmow0jEdwiqfoxUZeIz5Fp3eI7b/uscE0G0RHkMM+2T2v6DyTouEduKlDGNf
         6ZHHYzakJqisf9+RvV/wJ+92vTssi7tiW2IgiHlTVX80aWHhrEBzASvFfMGKe9zEsbhL
         orZxMTMNz8S/VAnAcpiDjXAu0LWS4865hn/Ggxs2Vw7YyprPBUao7+dGJXlml/vMCRPn
         qKxOq68xChutG5AiK63IgXcPDshCrde1DM3OeTk5HKTPyZWd3fjmULgVmM0otZlzXZnt
         mg2A==
X-Gm-Message-State: AOAM531cxrZVjzBqMcq0CnSMgZUFMY/38DtnMuEHTDEcSnByPY3xObrC
        nNSW+YeC2lH0lUc07jNvyP9Twymas0I=
X-Google-Smtp-Source: ABdhPJwDOCGD4ssD71NTxVoMy3pNyDLxXhfk75GEvgvWaIpbXuU5cMeEyQL/DY9bnydIi8KgbnM+XA==
X-Received: by 2002:a05:600c:1c8c:: with SMTP id k12mr26755884wms.74.1634507390401;
        Sun, 17 Oct 2021 14:49:50 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p200300c78f4e06087995111441372b59.dip0.t-ipconnect.de. [2003:c7:8f4e:608:7995:1114:4137:2b59])
        by smtp.gmail.com with ESMTPSA id n1sm16208809wmi.30.2021.10.17.14.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 14:49:50 -0700 (PDT)
Date:   Sun, 17 Oct 2021 23:49:48 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Docs: usb: update struct usb_driver, __init and __exit
Message-ID: <20211017214948.GA9901@matrix-ESPRIMO-P710>
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
 .../driver-api/usb/writing_usb_driver.rst     | 51 +++++++------------
 1 file changed, 19 insertions(+), 32 deletions(-)

diff --git a/Documentation/driver-api/usb/writing_usb_driver.rst b/Documentation/driver-api/usb/writing_usb_driver.rst
index 2176297e5765..1064adf79ccb 100644
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
 
 
@@ -81,36 +84,20 @@ this user-space interaction. The skeleton driver needs this kind of
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
+The USB driver is then registered with a call to :c:func:`usb_register`
+which is usually in the driver's init function. Since this functionality
+is usable with many USB drivers, it is hidden behind multi-stage macros.
+While the first macros are USB specific the later macros are used in different
+subsystems. This removes a lot of boilerplate code.
 
 When the driver is unloaded from the system, it needs to deregister
 itself with the USB subsystem. This is done with the :c:func:`usb_deregister`
-function::
+which is also hidden behind multi-stage macros.
 
-    static void __exit usb_skel_exit(void)
-    {
-	    /* deregister this driver with the USB subsystem */
-	    usb_deregister(&skel_driver);
-    }
-    module_exit(usb_skel_exit);
+The init and exit functions are included in the macro :
+module_usb_driver(skel_driver);
+which is in the first stage replaced by:
+module_driver(__usb_driver, usb_register, usb_deregister)
 
 
 To enable the linux-hotplug system to load the driver automatically when
-- 
2.25.1

