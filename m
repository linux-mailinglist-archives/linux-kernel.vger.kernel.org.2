Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35D331D8DF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 12:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbhBQLxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 06:53:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:33972 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232228AbhBQLtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 06:49:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 42035B805;
        Wed, 17 Feb 2021 11:48:27 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     linux-rpi-kernel@lists.infradead.org, phil@raspberrypi.com,
        wahrenst@gmx.net, mripard@kernel.org, eric@anholt.net,
        robh@kernel.org
Subject: [PATCH v3 06/15] mfd: bcm2835-pm: Use 'reg-names' to get resources
Date:   Wed, 17 Feb 2021 12:48:01 +0100
Message-Id: <20210217114811.22069-7-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210217114811.22069-1-nsaenzjulienne@suse.de>
References: <20210217114811.22069-1-nsaenzjulienne@suse.de>
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

Changes since v2:
 - correct names

 drivers/mfd/bcm2835-pm.c | 55 ++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/drivers/mfd/bcm2835-pm.c b/drivers/mfd/bcm2835-pm.c
index 42fe67f1538e..36fede92775c 100644
--- a/drivers/mfd/bcm2835-pm.c
+++ b/drivers/mfd/bcm2835-pm.c
@@ -25,9 +25,37 @@ static const struct mfd_cell bcm2835_power_devs[] = {
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
+		pm->asb = devm_platform_ioremap_resource(pdev, 1);
+		if (IS_ERR(pm->asb))
+			pm->asb = NULL;
+	} else {
+		pm->base = devm_platform_ioremap_resource_byname(pdev, "pm");
+		if (IS_ERR(pm->base))
+			return PTR_ERR(pm->base);
+
+		pm->asb = devm_platform_ioremap_resource_byname(pdev, "asb");
+		if (IS_ERR(pm->base))
+			pm->asb = NULL;
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
@@ -39,10 +67,9 @@ static int bcm2835_pm_probe(struct platform_device *pdev)
 
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
@@ -54,20 +81,10 @@ static int bcm2835_pm_probe(struct platform_device *pdev)
 	 * bcm2835-pm binding as the key for whether we can reference
 	 * the full PM register range and support power domains.
 	 */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (res) {
-		pm->asb = devm_ioremap_resource(dev, res);
-		if (IS_ERR(pm->asb))
-			return PTR_ERR(pm->asb);
-
-		ret = devm_mfd_add_devices(dev, -1,
-					   bcm2835_power_devs,
-					   ARRAY_SIZE(bcm2835_power_devs),
-					   NULL, 0, NULL);
-		if (ret)
-			return ret;
-	}
-
+	if (pm->asb)
+		return devm_mfd_add_devices(dev, -1, bcm2835_power_devs,
+					    ARRAY_SIZE(bcm2835_power_devs),
+					    NULL, 0, NULL);
 	return 0;
 }
 
-- 
2.30.0

