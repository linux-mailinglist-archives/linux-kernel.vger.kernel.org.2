Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B383FFD1A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 11:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348807AbhICJ3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 05:29:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:32800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348788AbhICJ3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 05:29:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF1AD61074;
        Fri,  3 Sep 2021 09:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630661319;
        bh=P208amnO64R/hyFnMkT0yZzZ8wPv9tiY354hPQb3Vz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=okRjLnqwIWWRYnLkxUWNcPQ0v4u8WxTWyDedPWMssOjERpESWvyr3umStJISAja1I
         hhQQ6ZFwpk5zjuSj9zM/nXq+waGM6ybd9XaCL52CxFrwDB08vMyyz5hhAesrHjz7Dx
         dP2QxFvKDh0AiHpHXM3ee0YEDQOxrqVO0JDg1leX6aIFDy8KGeLzEUpMcGaHuTI6vU
         nB0kDz39SLgTo4ne8laVMpLRjAEMnnR50IE9CKOSV40qlqARihWcBmP6adHWu78E+A
         KRLJ51kx43mDUcum0/JoGz8OtnzHqTDBebKSCdpaWuB5tHJDX8s3rHMaryEGqbkQfB
         Pa6R4aG8P4O6w==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mM5Uy-000zwV-Vx; Fri, 03 Sep 2021 11:28:37 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>, John Stultz <john.stultz@linaro.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/4] misc: hisi_hikey_usb: change the DT schema
Date:   Fri,  3 Sep 2021 11:28:33 +0200
Message-Id: <746237a6bdbb84d4271a77994c82bccf524680c7.1630659949.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1630659949.git.mchehab+huawei@kernel.org>
References: <cover.1630659949.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As there's no upstream DT bindings for this driver, let's
update its DT schema, while it is not too late.

While here, add error messages, in order to help discovering
problems during probing time.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/misc/hisi_hikey_usb.c | 119 ++++++++++++++++++----------------
 1 file changed, 63 insertions(+), 56 deletions(-)

diff --git a/drivers/misc/hisi_hikey_usb.c b/drivers/misc/hisi_hikey_usb.c
index 989d7d129469..2165ec35a343 100644
--- a/drivers/misc/hisi_hikey_usb.c
+++ b/drivers/misc/hisi_hikey_usb.c
@@ -34,7 +34,6 @@ struct hisi_hikey_usb {
 	struct device *dev;
 	struct gpio_desc *otg_switch;
 	struct gpio_desc *typec_vbus;
-	struct gpio_desc *hub_vbus;
 	struct gpio_desc *reset;
 
 	struct regulator *regulator;
@@ -54,9 +53,6 @@ static void hub_power_ctrl(struct hisi_hikey_usb *hisi_hikey_usb, int value)
 {
 	int ret, status;
 
-	if (hisi_hikey_usb->hub_vbus)
-		gpiod_set_value_cansleep(hisi_hikey_usb->hub_vbus, value);
-
 	if (!hisi_hikey_usb->regulator)
 		return;
 
@@ -147,75 +143,50 @@ static int hub_usb_role_switch_set(struct usb_role_switch *sw, enum usb_role rol
 	return 0;
 }
 
-static int hisi_hikey_usb_parse_kirin970(struct platform_device *pdev,
+static int hisi_hikey_usb_of_role_switch(struct platform_device *pdev,
 					 struct hisi_hikey_usb *hisi_hikey_usb)
-{
-	struct regulator *regulator;
-
-	regulator = devm_regulator_get(&pdev->dev, "hub-vdd");
-	if (IS_ERR(regulator)) {
-		if (PTR_ERR(regulator) == -EPROBE_DEFER) {
-			dev_info(&pdev->dev,
-				 "waiting for hub-vdd-supply to be probed\n");
-			return PTR_ERR(regulator);
-		}
-		dev_err(&pdev->dev,
-			"get hub-vdd-supply failed with error %ld\n",
-			PTR_ERR(regulator));
-		return PTR_ERR(regulator);
-	}
-	hisi_hikey_usb->regulator = regulator;
-
-	hisi_hikey_usb->reset = devm_gpiod_get(&pdev->dev, "hub_reset_en_gpio",
-					       GPIOD_OUT_HIGH);
-	return PTR_ERR_OR_ZERO(hisi_hikey_usb->reset);
-}
-
-static int hisi_hikey_usb_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct hisi_hikey_usb *hisi_hikey_usb;
 	struct usb_role_switch_desc hub_role_switch = {NULL};
-	int ret;
 
-	hisi_hikey_usb = devm_kzalloc(dev, sizeof(*hisi_hikey_usb), GFP_KERNEL);
-	if (!hisi_hikey_usb)
-		return -ENOMEM;
-
-	hisi_hikey_usb->dev = &pdev->dev;
+	if (!device_property_read_bool(dev, "usb-role-switch"))
+		return 0;
 
 	hisi_hikey_usb->otg_switch = devm_gpiod_get(dev, "otg-switch",
 						    GPIOD_OUT_HIGH);
-	if (IS_ERR(hisi_hikey_usb->otg_switch))
+	if (IS_ERR(hisi_hikey_usb->otg_switch)) {
+		dev_err(dev, "get otg-switch failed with error %ld\n",
+			PTR_ERR(hisi_hikey_usb->otg_switch));
 		return PTR_ERR(hisi_hikey_usb->otg_switch);
+	}
 
 	hisi_hikey_usb->typec_vbus = devm_gpiod_get(dev, "typec-vbus",
 						    GPIOD_OUT_LOW);
-	if (IS_ERR(hisi_hikey_usb->typec_vbus))
+	if (IS_ERR(hisi_hikey_usb->typec_vbus)) {
+		dev_err(dev, "get typec-vbus failed with error %ld\n",
+			PTR_ERR(hisi_hikey_usb->typec_vbus));
 		return PTR_ERR(hisi_hikey_usb->typec_vbus);
+	}
 
-	/* Parse Kirin 970-specific OF data */
-	if (of_device_is_compatible(pdev->dev.of_node,
-				    "hisilicon,kirin970_hikey_usbhub")) {
-		ret = hisi_hikey_usb_parse_kirin970(pdev, hisi_hikey_usb);
-		if (ret)
-			return ret;
-	} else {
-		/* hub-vdd33-en is optional */
-		hisi_hikey_usb->hub_vbus = devm_gpiod_get_optional(dev, "hub-vdd33-en",
-								   GPIOD_OUT_HIGH);
-		if (IS_ERR(hisi_hikey_usb->hub_vbus))
-			return PTR_ERR(hisi_hikey_usb->hub_vbus);
+	hisi_hikey_usb->reset = devm_gpiod_get_optional(dev,
+							"hub-reset-en",
+							GPIOD_OUT_HIGH);
+	if (IS_ERR(hisi_hikey_usb->reset)) {
+		dev_err(dev, "get hub-reset-en failed with error %ld\n",
+			PTR_ERR(hisi_hikey_usb->reset));
+		return PTR_ERR(hisi_hikey_usb->reset);
 	}
 
 	hisi_hikey_usb->dev_role_sw = usb_role_switch_get(dev);
 	if (!hisi_hikey_usb->dev_role_sw)
 		return -EPROBE_DEFER;
-	if (IS_ERR(hisi_hikey_usb->dev_role_sw))
+	if (IS_ERR(hisi_hikey_usb->dev_role_sw)) {
+		dev_err(dev, "get device role switch failed with error %ld\n",
+			PTR_ERR(hisi_hikey_usb->dev_role_sw));
 		return PTR_ERR(hisi_hikey_usb->dev_role_sw);
+	}
 
 	INIT_WORK(&hisi_hikey_usb->work, relay_set_role_switch);
-	mutex_init(&hisi_hikey_usb->lock);
 
 	hub_role_switch.fwnode = dev_fwnode(dev);
 	hub_role_switch.set = hub_usb_role_switch_set;
@@ -225,10 +196,44 @@ static int hisi_hikey_usb_probe(struct platform_device *pdev)
 							       &hub_role_switch);
 
 	if (IS_ERR(hisi_hikey_usb->hub_role_sw)) {
+		dev_err(dev,
+			"failed to register hub role with error %ld\n",
+			PTR_ERR(hisi_hikey_usb->hub_role_sw));
 		usb_role_switch_put(hisi_hikey_usb->dev_role_sw);
 		return PTR_ERR(hisi_hikey_usb->hub_role_sw);
 	}
 
+	return 0;
+}
+
+static int hisi_hikey_usb_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct hisi_hikey_usb *hisi_hikey_usb;
+	int ret;
+
+	hisi_hikey_usb = devm_kzalloc(dev, sizeof(*hisi_hikey_usb), GFP_KERNEL);
+	if (!hisi_hikey_usb)
+		return -ENOMEM;
+
+	hisi_hikey_usb->dev = &pdev->dev;
+	mutex_init(&hisi_hikey_usb->lock);
+
+	hisi_hikey_usb->regulator = devm_regulator_get(dev, "hub-vdd");
+	if (IS_ERR(hisi_hikey_usb->regulator)) {
+		if (PTR_ERR(hisi_hikey_usb->regulator) == -EPROBE_DEFER) {
+			dev_info(dev, "waiting for hub-vdd-supply\n");
+			return PTR_ERR(hisi_hikey_usb->regulator);
+		}
+		dev_err(dev, "get hub-vdd-supply failed with error %ld\n",
+			PTR_ERR(hisi_hikey_usb->regulator));
+		return PTR_ERR(hisi_hikey_usb->regulator);
+	}
+
+	ret = hisi_hikey_usb_of_role_switch(pdev, hisi_hikey_usb);
+	if (ret)
+		return ret;
+
 	platform_set_drvdata(pdev, hisi_hikey_usb);
 
 	return 0;
@@ -238,18 +243,20 @@ static int  hisi_hikey_usb_remove(struct platform_device *pdev)
 {
 	struct hisi_hikey_usb *hisi_hikey_usb = platform_get_drvdata(pdev);
 
-	if (hisi_hikey_usb->hub_role_sw)
+	if (hisi_hikey_usb->hub_role_sw) {
 		usb_role_switch_unregister(hisi_hikey_usb->hub_role_sw);
 
-	if (hisi_hikey_usb->dev_role_sw)
-		usb_role_switch_put(hisi_hikey_usb->dev_role_sw);
+		if (hisi_hikey_usb->dev_role_sw)
+			usb_role_switch_put(hisi_hikey_usb->dev_role_sw);
+	} else {
+		hub_power_ctrl(hisi_hikey_usb, HUB_VBUS_POWER_OFF);
+	}
 
 	return 0;
 }
 
 static const struct of_device_id id_table_hisi_hikey_usb[] = {
-	{ .compatible = "hisilicon,gpio_hubv1" },
-	{ .compatible = "hisilicon,kirin970_hikey_usbhub" },
+	{ .compatible = "hisilicon,usbhub" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, id_table_hisi_hikey_usb);
-- 
2.31.1

