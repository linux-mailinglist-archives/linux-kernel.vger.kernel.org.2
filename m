Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8CC63887B2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 08:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbhESGl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 02:41:26 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:4979 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231354AbhESGlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 02:41:24 -0400
X-UUID: 05b2b5c7794149e08e460b4625d20830-20210519
X-UUID: 05b2b5c7794149e08e460b4625d20830-20210519
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1879630647; Wed, 19 May 2021 14:39:59 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 19 May 2021 14:39:55 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 19 May 2021 14:39:54 +0800
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
Subject: [PATCH v2 3/3] Revert "usb: common: usb-conn-gpio: Make VBUS supply optional"
Date:   Wed, 19 May 2021 14:39:46 +0800
Message-ID: <1621406386-18838-3-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1621406386-18838-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1621406386-18838-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 164287284D5D51868550B33931481A8944D3E274C0BECC5DD68242334BA10D312000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vbus is already an optional supply, if the vbus-supply is not
provided in DTS, will use a dummy regulator,
the warning log is as below:
"supply vbus not found, using dummy regulator"

This reverts commit 4ddf1ac79e5f082451cd549283d2eb7559ab6ca9.

Cc: Thierry Reding <treding@nvidia.com>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: remove unused variable "need_vbus"
---
 drivers/usb/common/usb-conn-gpio.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/drivers/usb/common/usb-conn-gpio.c b/drivers/usb/common/usb-conn-gpio.c
index dfbbc4f51ed6..65d89140cd19 100644
--- a/drivers/usb/common/usb-conn-gpio.c
+++ b/drivers/usb/common/usb-conn-gpio.c
@@ -91,14 +91,14 @@ static void usb_conn_detect_cable(struct work_struct *work)
 		return;
 	}
 
-	if (info->last_role == USB_ROLE_HOST && info->vbus)
+	if (info->last_role == USB_ROLE_HOST)
 		regulator_disable(info->vbus);
 
 	ret = usb_role_switch_set_role(info->role_sw, role);
 	if (ret)
 		dev_err(info->dev, "failed to set role: %d\n", ret);
 
-	if (role == USB_ROLE_HOST && info->vbus) {
+	if (role == USB_ROLE_HOST) {
 		ret = regulator_enable(info->vbus);
 		if (ret)
 			dev_err(info->dev, "enable vbus regulator failed\n");
@@ -106,9 +106,8 @@ static void usb_conn_detect_cable(struct work_struct *work)
 
 	info->last_role = role;
 
-	if (info->vbus)
-		dev_dbg(info->dev, "vbus regulator is %s\n",
-			regulator_is_enabled(info->vbus) ? "enabled" : "disabled");
+	dev_dbg(info->dev, "vbus regulator is %s\n",
+		regulator_is_enabled(info->vbus) ? "enabled" : "disabled");
 
 	power_supply_changed(info->charger);
 }
@@ -175,7 +174,6 @@ static int usb_conn_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct usb_conn_info *info;
-	bool need_vbus = true;
 	int ret = 0;
 
 	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
@@ -205,23 +203,7 @@ static int usb_conn_probe(struct platform_device *pdev)
 
 	INIT_DELAYED_WORK(&info->dw_det, usb_conn_detect_cable);
 
-	/*
-	 * If the USB connector is a child of a USB port and that port already provides the VBUS
-	 * supply, there's no need for the USB connector to provide it again.
-	 */
-	if (dev->parent && dev->parent->of_node) {
-		if (of_find_property(dev->parent->of_node, "vbus-supply", NULL))
-			need_vbus = false;
-	}
-
-	if (!need_vbus) {
-		info->vbus = devm_regulator_get_optional(dev, "vbus");
-		if (PTR_ERR(info->vbus) == -ENODEV)
-			info->vbus = NULL;
-	} else {
-		info->vbus = devm_regulator_get(dev, "vbus");
-	}
-
+	info->vbus = devm_regulator_get(dev, "vbus");
 	if (IS_ERR(info->vbus)) {
 		ret = PTR_ERR(info->vbus);
 		return dev_err_probe(dev, ret, "failed to get vbus :%d\n", ret);
@@ -288,7 +270,7 @@ static int usb_conn_remove(struct platform_device *pdev)
 
 	cancel_delayed_work_sync(&info->dw_det);
 
-	if (info->last_role == USB_ROLE_HOST && info->vbus)
+	if (info->last_role == USB_ROLE_HOST)
 		regulator_disable(info->vbus);
 
 	usb_role_switch_put(info->role_sw);
-- 
2.18.0

