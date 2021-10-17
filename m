Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068CE430B5E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 20:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242637AbhJQSIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 14:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbhJQSIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 14:08:54 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93596C06161C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 11:06:44 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id e10so1692749uab.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 11:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=WrXAb5FJ4wFr27XW+WDhPcLEUHrqCefg7pSMfDmUKhE=;
        b=M+liEYz3IO8pUxLV++59gEmiU243lMPWQOWLLdUQ9QxROsBwYtHyzTwmZSOxeQsDMo
         vlEtMlPryE4gXP9xTo54Lp4/bcvR+R6ap9QPtGyh2eQWqAgohQ87mqWUKtBjkBqXkQs8
         Ypjsb3gX5GWrecXzpLC1Z+Vjh6Bd+5LfdFlOkj4zVwJcetG9/RvLVDn/noHaqk9q3Z1W
         c6UePRURxHDEc522wUBi0fc9+JGlNHoTtoQYicCY7f1gHPUG+K60Yqyo76OOGSSzz0fC
         HSo96VN+ceedrrEu6ISXA4hNJMv3RE6Npq4lIbEcKGPH4kYVYsOmHqffaIOGOfCjqXsH
         mXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=WrXAb5FJ4wFr27XW+WDhPcLEUHrqCefg7pSMfDmUKhE=;
        b=mPwJoCIXrShv4oDGn01dGFfcGYp+sT0eagEmTTOIB7XuEB8PKa85ZPB4m/0FWPLSVn
         PaS0hadIgAPFWTRDZ8b8TR1JrHn0N2o5YjKqCuDeoxBV5AQBWxS2z5IH/nUo1lu0A7Bl
         wwUeFyg9nK9vQRvqIpktZ8pf6hgQx3pI4D/TLRg2e33rqTgf2FXbVj3zgtyjA6T65tWA
         6aMqTbLbIl17Lj0YKJtZ4BXyMkUtuTTEHa4sDbypWzcZp7MT5uyC0NVHEBuJNkeDCrNb
         j89+Jt702TutbaF7MDXqZH5/3olGz3MAdQbsa+iBlTyEWdOq7THlJSEdJIMhnO1N1T+Z
         TIQw==
X-Gm-Message-State: AOAM533aEW0JUxX3LzayPt/clDUomL6cTt7XVKVCL37yO7p7cf84hAw8
        3HF9VfCn9lHXSITjcuXzJC2gVpQ8W1U=
X-Google-Smtp-Source: ABdhPJxeiy+OWDC/3LX0XajapVa2A/l7ZLgrAHN71/xE78vcnszUNOmEpni2kWt4iqUb0q1f6Sdc6g==
X-Received: by 2002:a05:6102:3ecf:: with SMTP id n15mr24761996vsv.14.1634494003384;
        Sun, 17 Oct 2021 11:06:43 -0700 (PDT)
Received: from fedora ([187.64.134.142])
        by smtp.gmail.com with ESMTPSA id q3sm7932857vko.4.2021.10.17.11.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 11:06:42 -0700 (PDT)
Date:   Sun, 17 Oct 2021 15:06:39 -0300
From:   =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
To:     linux-kernel@vger.kernel.org
Cc:     broonie@kernel.org, lgirdwood@gmail.com
Subject: [PATCH] regulator/tps62360: replacing legacy gpio interface for gpiod
Message-ID: <YWxmL2baF5AdzyHv@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removing all linux/gpio.h and linux/of_gpio.h dependencies and replacing
them with the gpiod interface.

Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
 drivers/regulator/tps62360-regulator.c | 59 ++++++++++++--------------
 include/linux/regulator/tps62360.h     |  6 ---
 2 files changed, 26 insertions(+), 39 deletions(-)

diff --git a/drivers/regulator/tps62360-regulator.c b/drivers/regulator/tps62360-regulator.c
index 315cd5daf480..574958690ace 100644
--- a/drivers/regulator/tps62360-regulator.c
+++ b/drivers/regulator/tps62360-regulator.c
@@ -28,13 +28,12 @@
 #include <linux/err.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/tps62360.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/slab.h>
 #include <linux/regmap.h>
@@ -65,8 +64,8 @@ struct tps62360_chip {
 	struct regulator_desc desc;
 	struct regulator_dev *rdev;
 	struct regmap *regmap;
-	int vsel0_gpio;
-	int vsel1_gpio;
+	struct gpio_desc *vsel0_gpio;
+	struct gpio_desc *vsel1_gpio;
 	u8 voltage_reg_mask;
 	bool en_internal_pulldn;
 	bool en_discharge;
@@ -165,8 +164,8 @@ static int tps62360_dcdc_set_voltage_sel(struct regulator_dev *dev,
 
 	/* Select proper VSET register vio gpios */
 	if (tps->valid_gpios) {
-		gpio_set_value_cansleep(tps->vsel0_gpio, new_vset_id & 0x1);
-		gpio_set_value_cansleep(tps->vsel1_gpio,
+		gpiod_set_value_cansleep(tps->vsel0_gpio, new_vset_id & 0x1);
+		gpiod_set_value_cansleep(tps->vsel1_gpio,
 					(new_vset_id >> 1) & 0x1);
 	}
 	return 0;
@@ -310,9 +309,6 @@ static struct tps62360_regulator_platform_data *
 		return NULL;
 	}
 
-	pdata->vsel0_gpio = of_get_named_gpio(np, "vsel0-gpio", 0);
-	pdata->vsel1_gpio = of_get_named_gpio(np, "vsel1-gpio", 0);
-
 	if (of_find_property(np, "ti,vsel0-state-high", NULL))
 		pdata->vsel0_def_state = 1;
 
@@ -349,6 +345,7 @@ static int tps62360_probe(struct i2c_client *client,
 	int ret;
 	int i;
 	int chip_id;
+	int gpio_flags;
 
 	pdata = dev_get_platdata(&client->dev);
 
@@ -390,8 +387,6 @@ static int tps62360_probe(struct i2c_client *client,
 
 	tps->en_discharge = pdata->en_discharge;
 	tps->en_internal_pulldn = pdata->en_internal_pulldn;
-	tps->vsel0_gpio = pdata->vsel0_gpio;
-	tps->vsel1_gpio = pdata->vsel1_gpio;
 	tps->dev = &client->dev;
 
 	switch (chip_id) {
@@ -426,29 +421,27 @@ static int tps62360_probe(struct i2c_client *client,
 	tps->lru_index[0] = tps->curr_vset_id;
 	tps->valid_gpios = false;
 
-	if (gpio_is_valid(tps->vsel0_gpio) && gpio_is_valid(tps->vsel1_gpio)) {
-		int gpio_flags;
-		gpio_flags = (pdata->vsel0_def_state) ?
-				GPIOF_OUT_INIT_HIGH : GPIOF_OUT_INIT_LOW;
-		ret = devm_gpio_request_one(&client->dev, tps->vsel0_gpio,
-				gpio_flags, "tps62360-vsel0");
-		if (ret) {
-			dev_err(&client->dev,
-				"%s(): Could not obtain vsel0 GPIO %d: %d\n",
-				__func__, tps->vsel0_gpio, ret);
-			return ret;
-		}
+	gpio_flags = (pdata->vsel0_def_state) ?
+			GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
+	tps->vsel0_gpio = devm_gpiod_get_optional(&client->dev, "vsel0", gpio_flags);
+	if (IS_ERR(tps->vsel0_gpio)) {
+		dev_err(&client->dev,
+			"%s(): Could not obtain vsel0 GPIO: %ld\n",
+			__func__, PTR_ERR(tps->vsel0_gpio));
+		return PTR_ERR(tps->vsel0_gpio);
+	}
 
-		gpio_flags = (pdata->vsel1_def_state) ?
-				GPIOF_OUT_INIT_HIGH : GPIOF_OUT_INIT_LOW;
-		ret = devm_gpio_request_one(&client->dev, tps->vsel1_gpio,
-				gpio_flags, "tps62360-vsel1");
-		if (ret) {
-			dev_err(&client->dev,
-				"%s(): Could not obtain vsel1 GPIO %d: %d\n",
-				__func__, tps->vsel1_gpio, ret);
-			return ret;
-		}
+	gpio_flags = (pdata->vsel1_def_state) ?
+			GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
+	tps->vsel1_gpio = devm_gpiod_get_optional(&client->dev, "vsel1", gpio_flags);
+	if (IS_ERR(tps->vsel1_gpio)) {
+		dev_err(&client->dev,
+			"%s(): Could not obtain vsel1 GPIO: %ld\n",
+			__func__, PTR_ERR(tps->vsel1_gpio));
+		return PTR_ERR(tps->vsel1_gpio);
+	}
+
+	if (tps->vsel0_gpio != NULL && tps->vsel1_gpio != NULL) {
 		tps->valid_gpios = true;
 
 		/*
diff --git a/include/linux/regulator/tps62360.h b/include/linux/regulator/tps62360.h
index 94a90c06f1e5..398e74a1d941 100644
--- a/include/linux/regulator/tps62360.h
+++ b/include/linux/regulator/tps62360.h
@@ -19,10 +19,6 @@
  * @en_discharge: Enable discharge the output capacitor via internal
  *                register.
  * @en_internal_pulldn: internal pull down enable or not.
- * @vsel0_gpio: Gpio number for vsel0. It should be -1 if this is tied with
- *              fixed logic.
- * @vsel1_gpio: Gpio number for vsel1. It should be -1 if this is tied with
- *              fixed logic.
  * @vsel0_def_state: Default state of vsel0. 1 if it is high else 0.
  * @vsel1_def_state: Default state of vsel1. 1 if it is high else 0.
  */
@@ -30,8 +26,6 @@ struct tps62360_regulator_platform_data {
 	struct regulator_init_data *reg_init_data;
 	bool en_discharge;
 	bool en_internal_pulldn;
-	int vsel0_gpio;
-	int vsel1_gpio;
 	int vsel0_def_state;
 	int vsel1_def_state;
 };
-- 
2.31.1

