Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90630310C56
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 15:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbhBEN7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 08:59:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:56322 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231597AbhBENyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 08:54:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 62858ACBA;
        Fri,  5 Feb 2021 13:53:00 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     f.fainelli@gmail.com, Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     phil@raspberrypi.com, wahrenst@gmx.net,
        linux-kernel@vger.kernel.org
Subject: [RFC/PATCH 04/11] mfd: bcm2835-pm: Add support for BCM2711
Date:   Fri,  5 Feb 2021 14:52:40 +0100
Message-Id: <20210205135249.2924-5-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210205135249.2924-1-nsaenzjulienne@suse.de>
References: <20210205135249.2924-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In BCM2711 the new ARGON ASB took over V3D. The old ASB is still present
with the ISP and H264 bits, and V3D is in the same place in the new ASB
as the old one.

As per the devicetree bindings, BCM2711 will provide both the old and
new ASB registers, so get both of them and pass them into
'bcm2835-power,' which will take care of selecting which one to use
accordingly.

We're being extra careful when dealing with older firmware. We can't
assume all V3D users will use the new "brcm,bcm2711-pm" compatible
string, so use the fact that a 3rd resource is present in firmware as a
hint we're running on BCM2711.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/mfd/bcm2835-pm.c       | 55 ++++++++++++++++++++++++++--------
 include/linux/mfd/bcm2835-pm.h |  1 +
 2 files changed, 43 insertions(+), 13 deletions(-)

diff --git a/drivers/mfd/bcm2835-pm.c b/drivers/mfd/bcm2835-pm.c
index 42fe67f1538e..98c6943d3cd0 100644
--- a/drivers/mfd/bcm2835-pm.c
+++ b/drivers/mfd/bcm2835-pm.c
@@ -6,6 +6,7 @@
  * the WDT and power drivers.
  */
 
+#include <linux/bits.h>
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/mfd/bcm2835-pm.h>
@@ -17,6 +18,9 @@
 #include <linux/types.h>
 #include <linux/watchdog.h>
 
+#define BCM2835		BIT(1)
+#define BCM2711		BIT(2)
+
 static const struct mfd_cell bcm2835_pm_devs[] = {
 	{ .name = "bcm2835-wdt" },
 };
@@ -30,6 +34,7 @@ static int bcm2835_pm_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct device *dev = &pdev->dev;
 	struct bcm2835_pm *pm;
+	bool is_bcm2711;
 	int ret;
 
 	pm = devm_kzalloc(dev, sizeof(*pm), GFP_KERNEL);
@@ -38,6 +43,7 @@ static int bcm2835_pm_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, pm);
 
 	pm->dev = dev;
+	is_bcm2711 = (uintptr_t)device_get_match_data(&pdev->dev) & BCM2711;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pm->base = devm_ioremap_resource(dev, res);
@@ -50,30 +56,53 @@ static int bcm2835_pm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/* We'll use the presence of the AXI ASB regs in the
-	 * bcm2835-pm binding as the key for whether we can reference
-	 * the full PM register range and support power domains.
+	/* To support old firmware, check if a third resource was defined and
+	 * use that as a hint that we're on bcm2711.
 	 */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+	if (res) {
+		pm->arsan_asb = devm_ioremap_resource(dev, res);
+		if (IS_ERR(pm->arsan_asb)) {
+			dev_err(dev, "Failed to map Arsan ASB: %ld\n",
+				PTR_ERR(pm->arsan_asb));
+			return PTR_ERR(pm->arsan_asb);
+		}
+
+		if (!is_bcm2711) {
+			dev_warn(dev, "Using an outdated DT, please update it\n");
+			is_bcm2711 = true;
+		}
+	}
+
+	if (is_bcm2711 && !pm->arsan_asb) {
+		dev_err(dev, "Arsan ASB resource missing\n");
+		return -EINVAL;
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	if (res) {
 		pm->asb = devm_ioremap_resource(dev, res);
-		if (IS_ERR(pm->asb))
+		if (IS_ERR(pm->asb)) {
+			dev_err(dev, "Failed to map ASB: %ld\n", PTR_ERR(pm->asb));
 			return PTR_ERR(pm->asb);
-
-		ret = devm_mfd_add_devices(dev, -1,
-					   bcm2835_power_devs,
-					   ARRAY_SIZE(bcm2835_power_devs),
-					   NULL, 0, NULL);
-		if (ret)
-			return ret;
+		}
 	}
 
+	/* We'll use the presence of the ASB regs in the bcm2835-pm binding as
+	 * the key for whether we can reference the full PM register range and
+	 * support power domains.
+	 */
+	if (pm->asb)
+		return devm_mfd_add_devices(dev, -1, bcm2835_power_devs,
+					    ARRAY_SIZE(bcm2835_power_devs),
+					    NULL, 0, NULL);
 	return 0;
 }
 
 static const struct of_device_id bcm2835_pm_of_match[] = {
-	{ .compatible = "brcm,bcm2835-pm-wdt", },
-	{ .compatible = "brcm,bcm2835-pm", },
+	{ .compatible = "brcm,bcm2835-pm-wdt", .data = (void *)BCM2835},
+	{ .compatible = "brcm,bcm2835-pm", .data = (void *)BCM2835},
+	{ .compatible = "brcm,bcm2711-pm", .data = (void *)BCM2711},
 	{},
 };
 MODULE_DEVICE_TABLE(of, bcm2835_pm_of_match);
diff --git a/include/linux/mfd/bcm2835-pm.h b/include/linux/mfd/bcm2835-pm.h
index ed37dc40e82a..536e3c85347c 100644
--- a/include/linux/mfd/bcm2835-pm.h
+++ b/include/linux/mfd/bcm2835-pm.h
@@ -9,6 +9,7 @@ struct bcm2835_pm {
 	struct device *dev;
 	void __iomem *base;
 	void __iomem *asb;
+	void __iomem *arsan_asb;
 };
 
 #endif /* BCM2835_MFD_PM_H */
-- 
2.30.0

