Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A83A3FECFB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 13:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343551AbhIBL3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 07:29:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:37240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233850AbhIBL3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 07:29:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2AFA46102A;
        Thu,  2 Sep 2021 11:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630582125;
        bh=j236r0HQoOndjcOxkrKIPTvbRfBkwsPT7Hv04mqi28s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bOj+qUmm6NcTYq1tir6enWNrIqpaQ6bPJCeymQPv6fvoaVIrt3ckE9U2xnmwvNU3V
         X0jibuNZbDRD0rqf0RIjtpX+f0l8XrZSMvMp5bUhoV5bx3qM61sfrzPNQiGAoGUUbJ
         YxPWJIkrhzh3i03FWaAtBT5Za8303JieR/MUWVp0GPDIhyw0zY0gBav6nwPqufgXpW
         P8RJz4ip03TkS5w9omf6h31IMv2qytMvj4aLqyuwF17JF9R6Oj3hJ5zUrw9Qs3tRV2
         j69A36ItNlNh6XgvAEquyQVn5iCZctm/IGzg2KCD+lBDBo43lpiqAOZULKj3yoLxmB
         ek98FVb5imylw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mLktf-0004ZS-7z; Thu, 02 Sep 2021 13:28:43 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "John Stultz" <john.stultz@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] misc: hisi_hikey_usb: change the DT schema
Date:   Thu,  2 Sep 2021 13:28:35 +0200
Message-Id: <d990e75f28c443c0c5a5fc857b87acc4be3f9464.1630581434.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1630581434.git.mchehab+huawei@kernel.org>
References: <cover.1630581434.git.mchehab+huawei@kernel.org>
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
 drivers/misc/hisi_hikey_usb.c | 81 +++++++++++++++--------------------
 1 file changed, 35 insertions(+), 46 deletions(-)

diff --git a/drivers/misc/hisi_hikey_usb.c b/drivers/misc/hisi_hikey_usb.c
index 989d7d129469..8be7d28cdd71 100644
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
 
@@ -147,36 +143,11 @@ static int hub_usb_role_switch_set(struct usb_role_switch *sw, enum usb_role rol
 	return 0;
 }
 
-static int hisi_hikey_usb_parse_kirin970(struct platform_device *pdev,
-					 struct hisi_hikey_usb *hisi_hikey_usb)
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
 static int hisi_hikey_usb_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct hisi_hikey_usb *hisi_hikey_usb;
 	struct usb_role_switch_desc hub_role_switch = {NULL};
-	int ret;
 
 	hisi_hikey_usb = devm_kzalloc(dev, sizeof(*hisi_hikey_usb), GFP_KERNEL);
 	if (!hisi_hikey_usb)
@@ -184,35 +155,50 @@ static int hisi_hikey_usb_probe(struct platform_device *pdev)
 
 	hisi_hikey_usb->dev = &pdev->dev;
 
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
 	mutex_init(&hisi_hikey_usb->lock);
@@ -225,6 +211,9 @@ static int hisi_hikey_usb_probe(struct platform_device *pdev)
 							       &hub_role_switch);
 
 	if (IS_ERR(hisi_hikey_usb->hub_role_sw)) {
+		dev_err(dev,
+			"failed to register hub role with error %ld\n",
+			PTR_ERR(hisi_hikey_usb->hub_role_sw));
 		usb_role_switch_put(hisi_hikey_usb->dev_role_sw);
 		return PTR_ERR(hisi_hikey_usb->hub_role_sw);
 	}
@@ -248,8 +237,8 @@ static int  hisi_hikey_usb_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id id_table_hisi_hikey_usb[] = {
-	{ .compatible = "hisilicon,gpio_hubv1" },
-	{ .compatible = "hisilicon,kirin970_hikey_usbhub" },
+	{ .compatible = "hisilicon,hikey960-usbhub" },
+	{ .compatible = "hisilicon,hikey970-usbhub" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, id_table_hisi_hikey_usb);
-- 
2.31.1

