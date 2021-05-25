Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEE638FF65
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 12:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhEYKjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 06:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbhEYKjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 06:39:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB0DC06138E
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 03:37:25 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1llUR9-0004jG-QC; Tue, 25 May 2021 12:37:23 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1llUR9-00017K-27; Tue, 25 May 2021 12:37:23 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel@pengutronix.de, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] Drop helper devm_platform_ioremap_resource_wc()
Date:   Tue, 25 May 2021 12:37:11 +0200
Message-Id: <20210525103711.956438-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the macro was introduced in 2019 (commit bb6243b4f73d ("drivers:
platform: provide devm_platform_ioremap_resource_wc()") there is only a
single user which hardly justifies the function for the small task it
provides.

So drop the helper and open-code it in the only user. Adapt the non-wc
case accordingly.

For a all-mod-config build on amd64 this change introduces the following
changes according to bloat-o-meter:

add/remove: 0/1 grow/shrink: 1/0 up/down: 20/-252 (-232)
Function                                     old     new   delta
devm_platform_ioremap_resource_wc            252       -    -252
sram_probe                                   796     816     +20

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 .../driver-api/driver-model/devres.rst        |  1 -
 drivers/base/platform.c                       | 20 -------------------
 drivers/misc/sram.c                           |  6 ++++--
 include/linux/platform_device.h               |  3 ---
 4 files changed, 4 insertions(+), 26 deletions(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index e0814d214048..0fe1fffa295e 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -314,7 +314,6 @@ IOMAP
   devm_ioremap_resource() : checks resource, requests memory region, ioremaps
   devm_ioremap_resource_wc()
   devm_platform_ioremap_resource() : calls devm_ioremap_resource() for platform device
-  devm_platform_ioremap_resource_wc()
   devm_platform_ioremap_resource_byname()
   devm_platform_get_and_ioremap_resource()
   devm_iounmap()
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 9cd34def2237..ae071e8ed665 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -124,26 +124,6 @@ void __iomem *devm_platform_ioremap_resource(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource);
 
-/**
- * devm_platform_ioremap_resource_wc - write-combined variant of
- *                                     devm_platform_ioremap_resource()
- *
- * @pdev: platform device to use both for memory resource lookup as well as
- *        resource management
- * @index: resource index
- *
- * Return: a pointer to the remapped memory or an ERR_PTR() encoded error code
- * on failure.
- */
-void __iomem *devm_platform_ioremap_resource_wc(struct platform_device *pdev,
-						unsigned int index)
-{
-	struct resource *res;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
-	return devm_ioremap_resource_wc(&pdev->dev, res);
-}
-
 /**
  * devm_platform_ioremap_resource_byname - call devm_ioremap_resource for
  *					   a platform device, retrieve the
diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
index 202bf951e909..93638ae2753a 100644
--- a/drivers/misc/sram.c
+++ b/drivers/misc/sram.c
@@ -341,6 +341,7 @@ static int sram_probe(struct platform_device *pdev)
 {
 	struct sram_dev *sram;
 	int ret;
+	struct resource *res;
 	int (*init_func)(void);
 
 	sram = devm_kzalloc(&pdev->dev, sizeof(*sram), GFP_KERNEL);
@@ -349,10 +350,11 @@ static int sram_probe(struct platform_device *pdev)
 
 	sram->dev = &pdev->dev;
 
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (of_property_read_bool(pdev->dev.of_node, "no-memory-wc"))
-		sram->virt_base = devm_platform_ioremap_resource(pdev, 0);
+		sram->virt_base = devm_ioremap_resource(&pdev->dev, res);
 	else
-		sram->virt_base = devm_platform_ioremap_resource_wc(pdev, 0);
+		sram->virt_base = devm_ioremap_resource_wc(&pdev->dev, res);
 	if (IS_ERR(sram->virt_base)) {
 		dev_err(&pdev->dev, "could not map SRAM registers\n");
 		return PTR_ERR(sram->virt_base);
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index cd81e060863c..ed42ea9f60ba 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -66,9 +66,6 @@ extern void __iomem *
 devm_platform_ioremap_resource(struct platform_device *pdev,
 			       unsigned int index);
 extern void __iomem *
-devm_platform_ioremap_resource_wc(struct platform_device *pdev,
-				  unsigned int index);
-extern void __iomem *
 devm_platform_ioremap_resource_byname(struct platform_device *pdev,
 				      const char *name);
 extern int platform_get_irq(struct platform_device *, unsigned int);
-- 
2.30.2

