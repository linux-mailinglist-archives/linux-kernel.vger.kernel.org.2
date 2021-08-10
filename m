Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1FC23E49AD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 18:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbhHIQVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 12:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbhHIQVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 12:21:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB56C06179C
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 09:20:56 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1mD816-00021d-B8; Mon, 09 Aug 2021 18:20:44 +0200
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1mD814-0008Km-UP; Mon, 09 Aug 2021 18:20:42 +0200
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: [PATCH v5 6/7] watchdog: f71808e_wdt: refactor to platform device/driver pair
Date:   Mon,  9 Aug 2021 18:20:36 +0200
Message-Id: <9e1088839662e5c357286cab0b9de0bb0602e4fd.1628525954.git-series.a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.3654d10d79751f1b01adc9403f9840543df4bcc4.1628525954.git-series.a.fatoum@pengutronix.de>
References: <cover.3654d10d79751f1b01adc9403f9840543df4bcc4.1628525954.git-series.a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver so far wasn't ported to the driver model and registered
the watchdog device out of the init after probing the I/O ports
for a watchdog with correct vendor and device revision.

Keep the device detection part at init time, but move watchdog
registration to a platform driver probe function.

Suggested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 drivers/watchdog/f71808e_wdt.c | 49 ++++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/f71808e_wdt.c b/drivers/watchdog/f71808e_wdt.c
index 67e344627586..a23f68be137f 100644
--- a/drivers/watchdog/f71808e_wdt.c
+++ b/drivers/watchdog/f71808e_wdt.c
@@ -13,6 +13,7 @@
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/watchdog.h>
 
 #define DRVNAME "f71808e_wdt"
@@ -431,10 +432,19 @@ static const struct watchdog_ops fintek_wdt_ops = {
 	.set_timeout = fintek_wdt_set_timeout,
 };
 
-static int __init watchdog_init(int sioaddr)
+static int fintek_wdt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct watchdog_device *wdd;
 	int wdt_conf, err = 0;
+	struct resource *res;
+	int sioaddr;
+
+	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	if (!res)
+		return -ENXIO;
+
+	sioaddr = res->start;
 
 	watchdog.sioaddr = sioaddr;
 	watchdog.ident.options = WDIOF_SETTIMEOUT
@@ -467,6 +477,7 @@ static int __init watchdog_init(int sioaddr)
 
 	superio_exit(sioaddr);
 
+	wdd->parent		= dev;
 	wdd->info               = &watchdog.ident;
 	wdd->ops                = &fintek_wdt_ops;
 	wdd->min_timeout        = 1;
@@ -491,16 +502,16 @@ static int __init watchdog_init(int sioaddr)
 	if (start_withtimeout) {
 		err = fintek_wdt_start(wdd);
 		if (err) {
-			pr_err("cannot start watchdog timer\n");
+			dev_err(dev, "cannot start watchdog timer\n");
 			return err;
 		}
 
 		set_bit(WDOG_HW_RUNNING, &wdd->status);
-		pr_info("watchdog started with initial timeout of %u sec\n",
-			start_withtimeout);
+		dev_info(dev, "watchdog started with initial timeout of %u sec\n",
+			 start_withtimeout);
 	}
 
-	return watchdog_register_device(wdd);
+	return devm_watchdog_register_device(dev, wdd);
 }
 
 static int __init fintek_wdt_find(int sioaddr)
@@ -566,9 +577,19 @@ static int __init fintek_wdt_find(int sioaddr)
 	return err;
 }
 
+static struct platform_driver fintek_wdt_driver = {
+	.probe          = fintek_wdt_probe,
+	.driver         = {
+		.name   = DRVNAME,
+	},
+};
+
+static struct platform_device *fintek_wdt_pdev;
+
 static int __init fintek_wdt_init(void)
 {
 	static const unsigned short addrs[] = { 0x2e, 0x4e };
+	struct resource wdt_res = {};
 	int err = -ENODEV;
 	int i;
 
@@ -585,12 +606,26 @@ static int __init fintek_wdt_init(void)
 	if (i == ARRAY_SIZE(addrs))
 		return err;
 
-	return watchdog_init(addrs[i]);
+	platform_driver_register(&fintek_wdt_driver);
+
+	wdt_res.name = "superio port";
+	wdt_res.flags = IORESOURCE_IO;
+	wdt_res.start = addrs[i];
+	wdt_res.end   = addrs[i] + 1;
+
+	fintek_wdt_pdev = platform_device_register_simple(DRVNAME, -1, &wdt_res, 1);
+	if (IS_ERR(fintek_wdt_pdev)) {
+		platform_driver_unregister(&fintek_wdt_driver);
+		return PTR_ERR(fintek_wdt_pdev);
+	}
+
+	return 0;
 }
 
 static void __exit fintek_wdt_exit(void)
 {
-	watchdog_unregister_device(&watchdog.wdd);
+	platform_device_unregister(fintek_wdt_pdev);
+	platform_driver_unregister(&fintek_wdt_driver);
 }
 
 MODULE_DESCRIPTION("F71808E Watchdog Driver");
-- 
git-series 0.9.1
