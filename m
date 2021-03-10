Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADB7334234
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 16:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbhCJPzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 10:55:20 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50284 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbhCJPzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 10:55:09 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12AFt0Xp071249;
        Wed, 10 Mar 2021 09:55:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615391700;
        bh=DWDQ/I1EftwxzOF/aY9rBU7dyDN4w0Pjm02jY9b0Yg0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=OXw1OQ73UTv5dwQEcrpg9YLgzAnvsDVp5n9VSboWVt+Oq6HoJ4q4yd0lptXNhl9SD
         0eEEOqRFjW4HHWuGlnbgRY0ZCXR5FITtkG7WplX+omlgRM3x8JT7YVCkqSQPIWY+82
         q9kmff3YzMFXScl5qA4iEo8IA1WCTDW6VPY2ycpI=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12AFt0EC029184
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Mar 2021 09:55:00 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 10
 Mar 2021 09:55:00 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 10 Mar 2021 09:55:00 -0600
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12AFsq5i082613;
        Wed, 10 Mar 2021 09:54:57 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-phy@lists.infradead.org>, Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH 1/4] phy: ti: j721e-wiz: Do not configure wiz if its already configured
Date:   Wed, 10 Mar 2021 21:24:42 +0530
Message-ID: <20210310155445.534-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210310155445.534-1-kishon@ti.com>
References: <20210310155445.534-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Faiz Abbas <faiz_abbas@ti.com>

Serdes lanes might be shared between multiple cores in some usecases
and its not possible to lock PLLs for both the lanes independently
by the two cores. This requires a bootloader to configure both the
lanes at early boot time.

To handle this case, skip all configuration if any of the lanes has
already been enabled.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/ti/phy-j721e-wiz.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index 659597645201..95905e5c4f3d 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -1132,13 +1132,14 @@ static int wiz_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->of_node;
 	struct platform_device *serdes_pdev;
+	bool already_configured = false;
 	struct device_node *child_node;
 	struct regmap *regmap;
 	struct resource res;
 	void __iomem *base;
 	struct wiz *wiz;
+	int ret, val, i;
 	u32 num_lanes;
-	int ret;
 
 	wiz = devm_kzalloc(dev, sizeof(*wiz), GFP_KERNEL);
 	if (!wiz)
@@ -1266,10 +1267,20 @@ static int wiz_probe(struct platform_device *pdev)
 		goto err_get_sync;
 	}
 
-	ret = wiz_init(wiz);
-	if (ret) {
-		dev_err(dev, "WIZ initialization failed\n");
-		goto err_wiz_init;
+	for (i = 0; i < wiz->num_lanes; i++) {
+		regmap_field_read(wiz->p_enable[i], &val);
+		if (val & (P_ENABLE | P_ENABLE_FORCE)) {
+			already_configured = true;
+			break;
+		}
+	}
+
+	if (!already_configured) {
+		ret = wiz_init(wiz);
+		if (ret) {
+			dev_err(dev, "WIZ initialization failed\n");
+			goto err_wiz_init;
+		}
 	}
 
 	serdes_pdev = of_platform_device_create(child_node, NULL, dev);
-- 
2.17.1

