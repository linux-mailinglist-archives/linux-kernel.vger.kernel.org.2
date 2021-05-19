Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 206E13887AE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 08:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhESGlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 02:41:21 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:60150 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229548AbhESGlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 02:41:20 -0400
X-UUID: d42a4fd712444cff96cc9c868820c3f6-20210519
X-UUID: d42a4fd712444cff96cc9c868820c3f6-20210519
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1008533697; Wed, 19 May 2021 14:39:55 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 19 May 2021 14:39:53 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 19 May 2021 14:39:52 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <treding@nvidia.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Lee Jones <lee.jones@linaro.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 1/3] usb: common: usb-conn-gpio: fix NULL pointer dereference of charger
Date:   Wed, 19 May 2021 14:39:44 +0800
Message-ID: <1621406386-18838-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: DF0E149C1591C14F9E946A4E74FD92CB5C856779CBF27C32AF978A275F8FE3AC2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When power on system with OTG cable, IDDIG's interrupt arises before
the charger registration, it will cause a NULL pointer dereference,
fix the issue by registering the power supply before requesting
IDDIG/VBUS irq.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: no changes
---
 drivers/usb/common/usb-conn-gpio.c | 44 ++++++++++++++++++------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/common/usb-conn-gpio.c b/drivers/usb/common/usb-conn-gpio.c
index 6c4e3a19f42c..c9545a4eff66 100644
--- a/drivers/usb/common/usb-conn-gpio.c
+++ b/drivers/usb/common/usb-conn-gpio.c
@@ -149,14 +149,32 @@ static int usb_charger_get_property(struct power_supply *psy,
 	return 0;
 }
 
-static int usb_conn_probe(struct platform_device *pdev)
+static int usb_conn_psy_register(struct usb_conn_info *info)
 {
-	struct device *dev = &pdev->dev;
-	struct power_supply_desc *desc;
-	struct usb_conn_info *info;
+	struct device *dev = info->dev;
+	struct power_supply_desc *desc = &info->desc;
 	struct power_supply_config cfg = {
 		.of_node = dev->of_node,
 	};
+
+	desc->name = "usb-charger";
+	desc->properties = usb_charger_properties;
+	desc->num_properties = ARRAY_SIZE(usb_charger_properties);
+	desc->get_property = usb_charger_get_property;
+	desc->type = POWER_SUPPLY_TYPE_USB;
+	cfg.drv_data = info;
+
+	info->charger = devm_power_supply_register(dev, desc, &cfg);
+	if (IS_ERR(info->charger))
+		dev_err(dev, "Unable to register charger\n");
+
+	return PTR_ERR_OR_ZERO(info->charger);
+}
+
+static int usb_conn_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct usb_conn_info *info;
 	bool need_vbus = true;
 	int ret = 0;
 
@@ -218,6 +236,10 @@ static int usb_conn_probe(struct platform_device *pdev)
 		return PTR_ERR(info->role_sw);
 	}
 
+	ret = usb_conn_psy_register(info);
+	if (ret)
+		goto put_role_sw;
+
 	if (info->id_gpiod) {
 		info->id_irq = gpiod_to_irq(info->id_gpiod);
 		if (info->id_irq < 0) {
@@ -252,20 +274,6 @@ static int usb_conn_probe(struct platform_device *pdev)
 		}
 	}
 
-	desc = &info->desc;
-	desc->name = "usb-charger";
-	desc->properties = usb_charger_properties;
-	desc->num_properties = ARRAY_SIZE(usb_charger_properties);
-	desc->get_property = usb_charger_get_property;
-	desc->type = POWER_SUPPLY_TYPE_USB;
-	cfg.drv_data = info;
-
-	info->charger = devm_power_supply_register(dev, desc, &cfg);
-	if (IS_ERR(info->charger)) {
-		dev_err(dev, "Unable to register charger\n");
-		return PTR_ERR(info->charger);
-	}
-
 	platform_set_drvdata(pdev, info);
 
 	/* Perform initial detection */
-- 
2.18.0

