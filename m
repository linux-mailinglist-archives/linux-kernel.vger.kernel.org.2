Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF45314FB7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 14:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhBINDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 08:03:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:45082 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230422AbhBINCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 08:02:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7550BAFD2;
        Tue,  9 Feb 2021 13:00:45 +0000 (UTC)
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
Subject: [RFC/PATCH v2 07/16] mfd: bcm2835-pm: Use 'reg-names' to get resources
Date:   Tue,  9 Feb 2021 13:59:03 +0100
Message-Id: <20210209125912.3398-8-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210209125912.3398-1-nsaenzjulienne@suse.de>
References: <20210209125912.3398-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If available in firmware, find resources by their 'reg-names' position
instead of relying on hardcoded offsets. Care is taken to support old
firmware nonetheless.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/mfd/bcm2835-pm.c | 56 ++++++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 19 deletions(-)

diff --git a/drivers/mfd/bcm2835-pm.c b/drivers/mfd/bcm2835-pm.c
index 836343e69f43..182ccdc2a06b 100644
--- a/drivers/mfd/bcm2835-pm.c
+++ b/drivers/mfd/bcm2835-pm.c
@@ -25,9 +25,38 @@ static const struct mfd_cell bcm2835_power_devs[] = {
 	{ .name = "bcm2835-power" },
 };
 
+static int bcm2835_pm_get_pdata(struct platform_device *pdev,
+				struct bcm2835_pm *pm)
+{
+	/* If no 'reg-names' property is found we can assume we're using old
+	 * firmware.
+	 */
+	if (!of_find_property(pm->dev->of_node, "reg-names", NULL)) {
+		dev_warn(pm->dev, "Old devicetree detected, please update your firmware.\n");
+
+		pm->base = devm_platform_ioremap_resource(pdev, 0);
+		if (IS_ERR(pm->base))
+			return PTR_ERR(pm->base);
+
+		pm->rpivid_asb = devm_platform_ioremap_resource(pdev, 1);
+		if (IS_ERR(pm->rpivid_asb))
+			pm->rpivid_asb = NULL;
+	} else {
+		pm->base = devm_platform_ioremap_resource_byname(pdev, "pm");
+		if (IS_ERR(pm->base))
+			return PTR_ERR(pm->base);
+
+		pm->rpivid_asb = devm_platform_ioremap_resource_byname(pdev,
+								       "rpivid_asb");
+		if (IS_ERR(pm->base))
+			pm->rpivid_asb = NULL;
+	}
+
+	return 0;
+}
+
 static int bcm2835_pm_probe(struct platform_device *pdev)
 {
-	struct resource *res;
 	struct device *dev = &pdev->dev;
 	struct bcm2835_pm *pm;
 	int ret;
@@ -39,10 +68,9 @@ static int bcm2835_pm_probe(struct platform_device *pdev)
 
 	pm->dev = dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pm->base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(pm->base))
-		return PTR_ERR(pm->base);
+	ret = bcm2835_pm_get_pdata(pdev, pm);
+	if (ret)
+		return ret;
 
 	ret = devm_mfd_add_devices(dev, -1,
 				   bcm2835_pm_devs, ARRAY_SIZE(bcm2835_pm_devs),
@@ -54,20 +82,10 @@ static int bcm2835_pm_probe(struct platform_device *pdev)
 	 * bcm2835-pm binding as the key for whether we can reference
 	 * the full PM register range and support power domains.
 	 */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (res) {
-		pm->rpivid_asb = devm_ioremap_resource(dev, res);
-		if (IS_ERR(pm->rpivid_asb))
-			return PTR_ERR(pm->rpivid_asb);
-
-		ret = devm_mfd_add_devices(dev, -1,
-					   bcm2835_power_devs,
-					   ARRAY_SIZE(bcm2835_power_devs),
-					   NULL, 0, NULL);
-		if (ret)
-			return ret;
-	}
-
+	if (pm->rpivid_asb)
+		return devm_mfd_add_devices(dev, -1, bcm2835_power_devs,
+					    ARRAY_SIZE(bcm2835_power_devs),
+					    NULL, 0, NULL);
 	return 0;
 }
 
-- 
2.30.0

