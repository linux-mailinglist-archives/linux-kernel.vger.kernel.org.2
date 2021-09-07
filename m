Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A10974022E7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 07:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbhIGErC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 00:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhIGErB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 00:47:01 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD73C061575;
        Mon,  6 Sep 2021 21:45:31 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id t2-20020a4ae9a2000000b0028c7144f106so2551161ood.6;
        Mon, 06 Sep 2021 21:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N30J/t8m7J507GtQ1rrwHXHLv2qCiuN4IuHTSwb73DA=;
        b=Y+YV/sFQEprZA7w1zW8eabH/Kq3gYQI3zG2RuTsj2q4Wy3z5fS50lB28gr3JpN+MWn
         qRhEdqBrD2BknwkM22SHbcz/Ym+HD/GdJjqnh2t9DOspLZbqNM+uNEg+KKL9wGLa6QNg
         y8nfLFKpC1jS7a9o6ennBLH34aaFJ7Rr4yDMHXly87ErH3HqMO3/P9ddRwT18AheFj6C
         5Q6a6lnWOucYFf0Fuor9e6qK1qllwpwOxJA/3iqmEDD3tfWXCQc4J6eaUJ4UGYEC4YRg
         bugV6oPnBIW7PunjcOlfAAWCbyl5DWrO6nBpxVFb/4TaPbt6TsCaqvB+vD6L8xXP3+/o
         jCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=N30J/t8m7J507GtQ1rrwHXHLv2qCiuN4IuHTSwb73DA=;
        b=o104zg0W0q/vN5Xs1q64QZt6YiLeMhp8MWk9s0a/cnY0o7r4s4GrnFlVWZN4vRJfck
         pSzKy3HLhmAsr16x6enxn8zTpz1cVBJhOXVWHZMEAc7m+cp3/6u6Af+VPeIg35IzNfi6
         gl0tlDo+CPLhfsZ0JM6g8GUSvE1jWeM57J2OnE2bRj5eGWXcqpFyupkZQHKOGSff9uQm
         FIZZ87mgELGc1VFMcjQEKaU6k2BBpx4lueAqO7T4NFpnHPZeOzx04RxZVErDxdifP1kF
         952kH7g8IythjiKsKhJmZN08HhTHnD+hQbpq0/skymezp/EcVbW+O5JFMW7eEHhsmJQw
         uv5w==
X-Gm-Message-State: AOAM530vS2ebdaDUXHLnYgFVpYy0SVqezDDs9Q7nuA+WhrsD4/1vAiy1
        AVncfcKNVNPS/3ctD2pXDLoLvo0VnIw=
X-Google-Smtp-Source: ABdhPJwug+qXa3al0THmOlTXOggIObyypmbu8TJNIQBgRhKo0KPZr6xZKt9bESHrxGNDKq8O1TVKBA==
X-Received: by 2002:a4a:6f4a:: with SMTP id i10mr16638744oof.64.1630989930322;
        Mon, 06 Sep 2021 21:45:30 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x13sm2258036otk.42.2021.09.06.21.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 21:45:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] usb: ehci: Simplify platform driver registration
Date:   Mon,  6 Sep 2021 21:45:27 -0700
Message-Id: <20210907044527.2137211-1-linux@roeck-us.net>
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
 drivers/usb/host/ehci-hcd.c | 75 +++++++++++--------------------------
 1 file changed, 21 insertions(+), 54 deletions(-)

diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 6bdc6d6bf74d..8a32a9531ad2 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1278,29 +1278,42 @@ MODULE_LICENSE ("GPL");
 
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
+#ifdef CONFIG_PPC_PS3
+	&ps3_ehci_driver,
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
@@ -1324,47 +1337,12 @@ static int __init ehci_hcd_init(void)
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
-
-#ifdef OF_PLATFORM_DRIVER
-	retval = platform_driver_register(&OF_PLATFORM_DRIVER);
-	if (retval < 0)
-		goto clean3;
-#endif
-
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
-#endif
-#ifdef PLATFORM_DRIVER
-	platform_driver_unregister(&PLATFORM_DRIVER);
 clean0:
-#endif
 #ifdef CONFIG_DYNAMIC_DEBUG
 	debugfs_remove(ehci_debug_root);
 	ehci_debug_root = NULL;
@@ -1376,18 +1354,7 @@ module_init(ehci_hcd_init);
 
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
-#endif
+	platform_unregister_drivers(platform_drivers, ARRAY_SIZE(platform_drivers));
 #ifdef CONFIG_DYNAMIC_DEBUG
 	debugfs_remove(ehci_debug_root);
 #endif
-- 
2.33.0

