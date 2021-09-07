Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D6E4028CD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 14:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344182AbhIGMbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 08:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343631AbhIGMbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 08:31:12 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C629CC061575;
        Tue,  7 Sep 2021 05:30:05 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id p2so12574307oif.1;
        Tue, 07 Sep 2021 05:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FRVGFt9LkOhVd0/r2OGAbLYw270d4m7rZQ9DzIgc5G4=;
        b=iC9Y113leFqquv36CJBze+lMyDRepJC24eqQbOtRcYpJLa/I4fCDKZBYhXXSfY45uR
         rYDwM2M1jqQwdChRZ3JGMXgSnmM1A/AXBYTNtz20vS8OIM+7TlyobI+VkTGiYKE3NeJW
         R/YrriLQot2jMzity0g65Ts6l078G5wNnfwmzEoC4KDk7K907D5Pch6E12RYlSFhUuhd
         7FPswYgCJBrw/zKYxAamX5ODl2PY26b71NOmpwuAkYn4Tra6AbE5BEuAWL4XNYK8enqU
         hAkC7CblfuItC2mM9VJlnPZVT95mlNOzRHFxhziI0HTQjfRivGM4fDfLnfLqYrcPJCVc
         MRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=FRVGFt9LkOhVd0/r2OGAbLYw270d4m7rZQ9DzIgc5G4=;
        b=dCqD/I8Wn6Hg6zCW7F3O9z9MWouUPD5fnzzl32luGuQX82sG9zJNDRE9fNvXwP+x7V
         Rn3PMZikZ2ftiJLOhnv83sqbEFPUcJN9iIsm3nCc9gvLQm6StVVNqZag3fjOGX3g5P9N
         71HQ35bBqAVy8CMcDtJ3BIKPWdU7pw4CmyTt/qo2BKAjTq+3q46JbnE73OBJFSW9QZE2
         p4ALvnMPJY+pLwl3N+ReFOh5bDuMAJSeNdxgteFH73Qc8kjNhbhrbG4NPAbKcCkWWUkK
         sk1OjwOj1BSbqwVuPsjyy+DQdjrffU4kZhGWPxciyuNDDDH5X5KRsJ2Bf95aMMQAc4Bi
         krdg==
X-Gm-Message-State: AOAM530nz9g89ort6kWW2qqvAfgToQ9fpeP/yih+XUwxIkSg6gqPNxoP
        mAPs3OpwT6qBi99wbABWU7U727kvnkQ=
X-Google-Smtp-Source: ABdhPJws9SViCqutxsbWcOUAqouQPz/pTDTDw5SYgusytdMNjXEngWoAvhjwUxxX1IZPOiTFS6yy4g==
X-Received: by 2002:a05:6808:7c2:: with SMTP id f2mr2787184oij.20.1631017805097;
        Tue, 07 Sep 2021 05:30:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n73sm2070299oig.9.2021.09.07.05.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 05:30:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2] usb: ehci: Simplify platform driver registration
Date:   Tue,  7 Sep 2021 05:30:02 -0700
Message-Id: <20210907123002.3951446-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use platform_register_drivers() and platform_unregister_drivers() to
register and unregister ehci platform drivers. This simplifies the code
and prevents the following build errors seen with sparc:allmodconfig.

drivers/usb/host/ehci-hcd.c:1301: error:
	"PLATFORM_DRIVER" redefined
drivers/usb/host/ehci-sh.c:173:31: error:
	'ehci_hcd_sh_driver' defined but not used

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Explicitly include platform_device.h.
    The ps3 driver is not a platform driver, so we still have
    to handle it separately.
    
 drivers/usb/host/ehci-hcd.c | 75 +++++++++++++------------------------
 1 file changed, 27 insertions(+), 48 deletions(-)

diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 6bdc6d6bf74d..1776c05d0a48 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -26,6 +26,7 @@
 #include <linux/moduleparam.h>
 #include <linux/dma-mapping.h>
 #include <linux/debugfs.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 
 #include <asm/byteorder.h>
@@ -1278,29 +1279,39 @@ MODULE_LICENSE ("GPL");
 
 #ifdef CONFIG_USB_EHCI_SH
 #include "ehci-sh.c"
-#define PLATFORM_DRIVER		ehci_hcd_sh_driver
 #endif
 
 #ifdef CONFIG_PPC_PS3
 #include "ehci-ps3.c"
-#define	PS3_SYSTEM_BUS_DRIVER	ps3_ehci_driver
 #endif
 
 #ifdef CONFIG_USB_EHCI_HCD_PPC_OF
 #include "ehci-ppc-of.c"
-#define OF_PLATFORM_DRIVER	ehci_hcd_ppc_of_driver
 #endif
 
 #ifdef CONFIG_XPS_USB_HCD_XILINX
 #include "ehci-xilinx-of.c"
-#define XILINX_OF_PLATFORM_DRIVER	ehci_hcd_xilinx_of_driver
 #endif
 
 #ifdef CONFIG_SPARC_LEON
 #include "ehci-grlib.c"
-#define PLATFORM_DRIVER		ehci_grlib_driver
 #endif
 
+static struct platform_driver * const platform_drivers[] = {
+#ifdef CONFIG_USB_EHCI_SH
+	&ehci_hcd_sh_driver,
+#endif
+#ifdef CONFIG_USB_EHCI_HCD_PPC_OF
+	&ehci_hcd_ppc_of_driver,
+#endif
+#ifdef CONFIG_XPS_USB_HCD_XILINX
+	&ehci_hcd_xilinx_of_driver,
+#endif
+#ifdef CONFIG_SPARC_LEON
+	&ehci_grlib_driver,
+#endif
+};
+
 static int __init ehci_hcd_init(void)
 {
 	int retval = 0;
@@ -1324,47 +1335,23 @@ static int __init ehci_hcd_init(void)
 	ehci_debug_root = debugfs_create_dir("ehci", usb_debug_root);
 #endif
 
-#ifdef PLATFORM_DRIVER
-	retval = platform_driver_register(&PLATFORM_DRIVER);
+	retval = platform_register_drivers(platform_drivers, ARRAY_SIZE(platform_drivers));
 	if (retval < 0)
 		goto clean0;
-#endif
-
-#ifdef PS3_SYSTEM_BUS_DRIVER
-	retval = ps3_ehci_driver_register(&PS3_SYSTEM_BUS_DRIVER);
-	if (retval < 0)
-		goto clean2;
-#endif
 
-#ifdef OF_PLATFORM_DRIVER
-	retval = platform_driver_register(&OF_PLATFORM_DRIVER);
+#ifdef CONFIG_PPC_PS3
+	retval = ps3_ehci_driver_register(&ps3_ehci_driver);
 	if (retval < 0)
-		goto clean3;
+		goto clean1;
 #endif
 
-#ifdef XILINX_OF_PLATFORM_DRIVER
-	retval = platform_driver_register(&XILINX_OF_PLATFORM_DRIVER);
-	if (retval < 0)
-		goto clean4;
-#endif
-	return retval;
+	return 0;
 
-#ifdef XILINX_OF_PLATFORM_DRIVER
-	/* platform_driver_unregister(&XILINX_OF_PLATFORM_DRIVER); */
-clean4:
-#endif
-#ifdef OF_PLATFORM_DRIVER
-	platform_driver_unregister(&OF_PLATFORM_DRIVER);
-clean3:
-#endif
-#ifdef PS3_SYSTEM_BUS_DRIVER
-	ps3_ehci_driver_unregister(&PS3_SYSTEM_BUS_DRIVER);
-clean2:
+#ifdef CONFIG_PPC_PS3
+clean1:
 #endif
-#ifdef PLATFORM_DRIVER
-	platform_driver_unregister(&PLATFORM_DRIVER);
+	platform_unregister_drivers(platform_drivers, ARRAY_SIZE(platform_drivers));
 clean0:
-#endif
 #ifdef CONFIG_DYNAMIC_DEBUG
 	debugfs_remove(ehci_debug_root);
 	ehci_debug_root = NULL;
@@ -1376,18 +1363,10 @@ module_init(ehci_hcd_init);
 
 static void __exit ehci_hcd_cleanup(void)
 {
-#ifdef XILINX_OF_PLATFORM_DRIVER
-	platform_driver_unregister(&XILINX_OF_PLATFORM_DRIVER);
-#endif
-#ifdef OF_PLATFORM_DRIVER
-	platform_driver_unregister(&OF_PLATFORM_DRIVER);
-#endif
-#ifdef PLATFORM_DRIVER
-	platform_driver_unregister(&PLATFORM_DRIVER);
-#endif
-#ifdef PS3_SYSTEM_BUS_DRIVER
-	ps3_ehci_driver_unregister(&PS3_SYSTEM_BUS_DRIVER);
+#ifdef CONFIG_PPC_PS3
+	ps3_ehci_driver_unregister(&ps3_ehci_driver);
 #endif
+	platform_unregister_drivers(platform_drivers, ARRAY_SIZE(platform_drivers));
 #ifdef CONFIG_DYNAMIC_DEBUG
 	debugfs_remove(ehci_debug_root);
 #endif
-- 
2.33.0

