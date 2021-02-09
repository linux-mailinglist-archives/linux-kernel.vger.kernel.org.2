Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBA7314FBB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 14:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhBINEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 08:04:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:45080 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230418AbhBINCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 08:02:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 75425AFC1;
        Tue,  9 Feb 2021 13:00:46 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     f.fainelli@gmail.com, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     linux-rpi-kernel@lists.infradead.org, phil@raspberrypi.com,
        wahrenst@gmx.net, linux-arm-kernel@lists.infradead.org,
        mripard@kernel.org, eric@anholt.net
Subject: [RFC/PATCH v2 08/16] mfd: bcm2835-pm: Add support for BCM2711
Date:   Tue,  9 Feb 2021 13:59:04 +0100
Message-Id: <20210209125912.3398-9-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210209125912.3398-1-nsaenzjulienne@suse.de>
References: <20210209125912.3398-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In BCM2711 the new Argon ASB took over V3D. The old ASB is still present
with the ISP and H264 bits, and V3D is in the same place in the new ASB
as the old one.

As per the devicetree bindings, BCM2711 will provide both the old and
new ASB resources, so get both of them and pass them into
'bcm2835-power,' which will take care of selecting which one to use
accordingly.

Since the Argon ASB's resources were being provided prior to formalizing
the bindings[1], also support the old firmwares that didn't use
'reg-names.'

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

[1] See: 7dbe8c62ceeb ("ARM: dts: Add minimal Raspberry Pi 4 support")

---

Changes since v1:
 - Use reg-names
 - Correct ASB names

 drivers/mfd/bcm2835-pm.c       | 25 +++++++++++++++++++++++--
 include/linux/mfd/bcm2835-pm.h |  1 +
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/bcm2835-pm.c b/drivers/mfd/bcm2835-pm.c
index 182ccdc2a06b..26666ad11f12 100644
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
@@ -28,6 +32,8 @@ static const struct mfd_cell bcm2835_power_devs[] = {
 static int bcm2835_pm_get_pdata(struct platform_device *pdev,
 				struct bcm2835_pm *pm)
 {
+	bool is_bcm2711 = (uintptr_t)device_get_match_data(pm->dev) & BCM2711;
+
 	/* If no 'reg-names' property is found we can assume we're using old
 	 * firmware.
 	 */
@@ -41,6 +47,10 @@ static int bcm2835_pm_get_pdata(struct platform_device *pdev,
 		pm->rpivid_asb = devm_platform_ioremap_resource(pdev, 1);
 		if (IS_ERR(pm->rpivid_asb))
 			pm->rpivid_asb = NULL;
+
+		pm->argon_asb = devm_platform_ioremap_resource(pdev, 2);
+		if (IS_ERR(pm->argon_asb))
+			pm->argon_asb = NULL;
 	} else {
 		pm->base = devm_platform_ioremap_resource_byname(pdev, "pm");
 		if (IS_ERR(pm->base))
@@ -50,6 +60,16 @@ static int bcm2835_pm_get_pdata(struct platform_device *pdev,
 								       "rpivid_asb");
 		if (IS_ERR(pm->base))
 			pm->rpivid_asb = NULL;
+
+		pm->argon_asb = devm_platform_ioremap_resource_byname(pdev,
+								      "argon_asb");
+		if (IS_ERR(pm->base))
+			pm->argon_asb = NULL;
+
+		if (pm->argon_asb && !is_bcm2711) {
+			dev_err(pm->dev, "Argon ASB support only present in BCM2711\n");
+			return -EINVAL;
+		}
 	}
 
 	return 0;
@@ -90,8 +110,9 @@ static int bcm2835_pm_probe(struct platform_device *pdev)
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
index ed4bd548db09..89fb2b5cdc1a 100644
--- a/include/linux/mfd/bcm2835-pm.h
+++ b/include/linux/mfd/bcm2835-pm.h
@@ -9,6 +9,7 @@ struct bcm2835_pm {
 	struct device *dev;
 	void __iomem *base;
 	void __iomem *rpivid_asb;
+	void __iomem *argon_asb;
 };
 
 #endif /* BCM2835_MFD_PM_H */
-- 
2.30.0

