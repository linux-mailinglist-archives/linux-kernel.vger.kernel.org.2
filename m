Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3B8314FB0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 14:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbhBINCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 08:02:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:44960 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230415AbhBINCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 08:02:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8CFE0ADCD;
        Tue,  9 Feb 2021 13:00:44 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     f.fainelli@gmail.com, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-rpi-kernel@lists.infradead.org, phil@raspberrypi.com,
        wahrenst@gmx.net, linux-arm-kernel@lists.infradead.org,
        mripard@kernel.org, eric@anholt.net
Subject: [RFC/PATCH v2 06/16] mfd: bcm2835-pm: Rename asb to rpivid_asb
Date:   Tue,  9 Feb 2021 13:59:02 +0100
Message-Id: <20210209125912.3398-7-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210209125912.3398-1-nsaenzjulienne@suse.de>
References: <20210209125912.3398-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In anticipation to supporting BCM2711 on which new ASB took over V3D,
use a more explicit name on the currently supported one.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/mfd/bcm2835-pm.c        |  8 ++++----
 drivers/soc/bcm/bcm2835-power.c | 10 +++++-----
 include/linux/mfd/bcm2835-pm.h  |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/bcm2835-pm.c b/drivers/mfd/bcm2835-pm.c
index 42fe67f1538e..836343e69f43 100644
--- a/drivers/mfd/bcm2835-pm.c
+++ b/drivers/mfd/bcm2835-pm.c
@@ -50,15 +50,15 @@ static int bcm2835_pm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/* We'll use the presence of the AXI ASB regs in the
+	/* We'll use the presence of the RPiVid ASB regs in the
 	 * bcm2835-pm binding as the key for whether we can reference
 	 * the full PM register range and support power domains.
 	 */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	if (res) {
-		pm->asb = devm_ioremap_resource(dev, res);
-		if (IS_ERR(pm->asb))
-			return PTR_ERR(pm->asb);
+		pm->rpivid_asb = devm_ioremap_resource(dev, res);
+		if (IS_ERR(pm->rpivid_asb))
+			return PTR_ERR(pm->rpivid_asb);
 
 		ret = devm_mfd_add_devices(dev, -1,
 					   bcm2835_power_devs,
diff --git a/drivers/soc/bcm/bcm2835-power.c b/drivers/soc/bcm/bcm2835-power.c
index 1e0041ec8132..59b8abfc5617 100644
--- a/drivers/soc/bcm/bcm2835-power.c
+++ b/drivers/soc/bcm/bcm2835-power.c
@@ -126,8 +126,8 @@
 
 #define ASB_AXI_BRDG_ID			0x20
 
-#define ASB_READ(reg) readl(power->asb + (reg))
-#define ASB_WRITE(reg, val) writel(PM_PASSWORD | (val), power->asb + (reg))
+#define ASB_READ(reg) readl(power->rpivid_asb + (reg))
+#define ASB_WRITE(reg, val) writel(PM_PASSWORD | (val), power->rpivid_asb + (reg))
 
 struct bcm2835_power_domain {
 	struct generic_pm_domain base;
@@ -140,8 +140,8 @@ struct bcm2835_power {
 	struct device		*dev;
 	/* PM registers. */
 	void __iomem		*base;
-	/* AXI Async bridge registers. */
-	void __iomem		*asb;
+	/* RPiVid bridge registers. */
+	void __iomem		*rpivid_asb;
 
 	struct genpd_onecell_data pd_xlate;
 	struct bcm2835_power_domain domains[BCM2835_POWER_DOMAIN_COUNT];
@@ -625,7 +625,7 @@ static int bcm2835_power_probe(struct platform_device *pdev)
 
 	power->dev = dev;
 	power->base = pm->base;
-	power->asb = pm->asb;
+	power->rpivid_asb = pm->rpivid_asb;
 
 	id = ASB_READ(ASB_AXI_BRDG_ID);
 	if (id != 0x62726467 /* "BRDG" */) {
diff --git a/include/linux/mfd/bcm2835-pm.h b/include/linux/mfd/bcm2835-pm.h
index ed37dc40e82a..ed4bd548db09 100644
--- a/include/linux/mfd/bcm2835-pm.h
+++ b/include/linux/mfd/bcm2835-pm.h
@@ -8,7 +8,7 @@
 struct bcm2835_pm {
 	struct device *dev;
 	void __iomem *base;
-	void __iomem *asb;
+	void __iomem *rpivid_asb;
 };
 
 #endif /* BCM2835_MFD_PM_H */
-- 
2.30.0

