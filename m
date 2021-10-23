Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D43438219
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 08:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhJWHBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 03:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhJWHBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 03:01:39 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9501AC061764;
        Fri, 22 Oct 2021 23:59:20 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m42so4995183wms.2;
        Fri, 22 Oct 2021 23:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=odO9BU6w2dsyXVnjQWKBXDwWqOdNcc7IgTwaejfrngQ=;
        b=lzhP6TcppNmupz3tHcRJkoanJgpf2+mQTa9YjsV40VKLf0mC4xt8MEmEwivcs3Yrhm
         5mlqeNslY971QEgvmFmJyxFQwgaRNCHG6gMV4yejdH/VxwG9Gg/BwwTHitbn3xsxiX3q
         Ax1bUGHQxcHmTeNAw+1X6o43b7ttATzrrlCOBoAHNqyim0blFr/C2QbfybZXfLMY8TbB
         0LSlF3Vd1VpjRSVJfdL87goZNdJZ6yo+vrXDve4en/WIkkbqA74+Oh7xPGX26HMHDxpI
         9pVQkQRRyekqdTMKyvG0tjpKEg4MJ2pObVoahvXn1tPS3Gs4Mz7FlQMtXUnFBesNtZ7q
         ahKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=odO9BU6w2dsyXVnjQWKBXDwWqOdNcc7IgTwaejfrngQ=;
        b=csorbrPY/dZDQ/Zbm9/Y2nX3gBDZMWWSdupJaqJCEz4W+po8qxXOIvl7/hjAsDlVSM
         3zVV2ko7dsOosFNjQN7yj7TLXTx+XtFzhBuBb6t2Bxzfh06AjlJkeEVxPjkAW8XUr6yx
         BXSCfct+SehILuXTDicEHktc9R09BKWlAkKQ7iIWBpDLe48d/Wc/8Gf8TsZ0eok0KB0y
         iOuUrN3XfOLNiDLZjngd8xXvWJywApy76zz+cwOJ+1vVtPQer0o5YXD20VFY+9ao0rlR
         Rt8MXdE+BCftk8k1GYvnX8yzDExwW4g25+ei2z1LCBG16vi0Lri3R+Ffz71s+jImBJ21
         5B9w==
X-Gm-Message-State: AOAM530bXVeEPnvpppWpzECUl/Ui+/xo55P3I2qnTKU6rw7Vm8o0Tf6E
        kdiwLKnVPk5HBTTm9Bji8wWneXP+R3s=
X-Google-Smtp-Source: ABdhPJyNKDPBP+Blum3WToWhdGNARKYfKpMdz/CZSKU4ZC5KPbtlOH3/R3h/LfInB+pq573n7nDT9Q==
X-Received: by 2002:a05:600c:4f42:: with SMTP id m2mr34039106wmq.82.1634972358393;
        Fri, 22 Oct 2021 23:59:18 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p200300c78f4e0684ec383d1d224ce07d.dip0.t-ipconnect.de. [2003:c7:8f4e:684:ec38:3d1d:224c:e07d])
        by smtp.gmail.com with ESMTPSA id 126sm4167584wmz.28.2021.10.22.23.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 23:59:18 -0700 (PDT)
Date:   Sat, 23 Oct 2021 08:59:16 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org
Subject: [PATCH v3] Docs: usb: update struct usb_driver, __init and __exit
Message-ID: <20211023065916.GA6268@matrix-ESPRIMO-P710>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update struct usb_driver from usb-skeleton.c.
remove :c:func: for usb_register and usb_deregister

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V2 -> V3: update struct usb_driver with tabs as in the original
          taken out all changes for _init and __exit
          except replacing :c:func:
V1 -> V2: changed :c:func:`usb_register` to usb_register()
          changed the :c:func:`usb_deregister` to usb_deregister()
          used literal blocks for makro module_usb_driver and added one more
          stage of multi-stage macros.

 Documentation/driver-api/usb/writing_usb_driver.rst | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/driver-api/usb/writing_usb_driver.rst b/Documentation/driver-api/usb/writing_usb_driver.rst
index 2176297e5765..d0f7c1b79815 100644
--- a/Documentation/driver-api/usb/writing_usb_driver.rst
+++ b/Documentation/driver-api/usb/writing_usb_driver.rst
@@ -57,9 +57,12 @@ structure. The skeleton driver declares a :c:type:`usb_driver` as::
 	    .name        = "skeleton",
 	    .probe       = skel_probe,
 	    .disconnect  = skel_disconnect,
-	    .fops        = &skel_fops,
-	    .minor       = USB_SKEL_MINOR_BASE,
+	    .suspend     = skel_suspend,
+	    .resume      = skel_resume,
+	    .pre_reset   = skel_pre_reset,
+	    .post_reset  = skel_post_reset,
 	    .id_table    = skel_table,
+	    .supports_autosuspend = 1,
     };
 
 
@@ -81,7 +84,7 @@ this user-space interaction. The skeleton driver needs this kind of
 interface, so it provides a minor starting number and a pointer to its
 :c:type:`file_operations` functions.
 
-The USB driver is then registered with a call to :c:func:`usb_register`,
+The USB driver is then registered with a call to usb_register(),
 usually in the driver's init function, as shown here::
 
     static int __init usb_skel_init(void)
@@ -102,7 +105,7 @@ usually in the driver's init function, as shown here::
 
 
 When the driver is unloaded from the system, it needs to deregister
-itself with the USB subsystem. This is done with the :c:func:`usb_deregister`
+itself with the USB subsystem. This is done with the usb_deregister()
 function::
 
     static void __exit usb_skel_exit(void)
-- 
2.25.1

