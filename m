Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8424F42F6C7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 17:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240603AbhJOPQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 11:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240625AbhJOPQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 11:16:46 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577C5C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 08:14:40 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id i15so18789095uap.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 08:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=KhuZQgDoIwQNw5Yyue9EBe6QQ+ja0GU2+Kux485994I=;
        b=aEMJoqPdpGOxWg0vj0XbV0MtLvd3xVCZXe/+pa7O75QqK7k82f3iv8VAa7L1hLqbVM
         uSMUrkOoiM/PdgwTQYScbe+qJSldcqQM51rV8nOKV5rkw551MaFKh0FWiwNJ1+w5tO75
         shWjzyr5bitCR72J+juGM6B2JtlezIlXcXbYiXT1OMtZrPBQaDJHA5faxnBqgGbJLla4
         doEDUHwDgrxpPA/F0YDeD0BpfH8KhDRNiRq4RcdyzzcWszRAtfwFlFqzb5hp4KXn4sEh
         q6NhvJc+gWpdrajByWP7j/cUEMRHMA/easkQcxW6ip0Qwi4oAqTfFTIury0paAKBh2bz
         b50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=KhuZQgDoIwQNw5Yyue9EBe6QQ+ja0GU2+Kux485994I=;
        b=K65Yvtpj67AUSq7DsW+78YQh4p+u0PVbmtDGmpKyg//HmkjmHUrO6te30h8kM8DdYP
         c1l+SK2NjNsvMtWhdlAAYUSInTzPaF/JfYe+ygd+m2DoaVn9EYguox+zPmGm2B0k0/7F
         setPQGnano19IgK+NBMgEcZhTTHXUAOAEt7JzHGu+IG8auG4oWh/ms2W+8Qs7nez0Inr
         PNv+0LJj8uqZ1IHqKJqph/PuEXwEkz9o90V5Q4mkGGMu36nIiy3cFAebJeP62BDI8upP
         MUsbIp/q8HF/SMBJ2YUsKwM+31W5205Sq71Y2H7FX6LNLQ7MjaXZp2tvOB51fthW+Ttp
         CePA==
X-Gm-Message-State: AOAM531z7AbBfPbDPE3HdUHgW/Em4o9nACiYE+aFIhP3ZweTM/CNBrxB
        iSed6fsvn227+4TT7cTIUSW5Gk5uD2dVQXIV
X-Google-Smtp-Source: ABdhPJx+FURZzHwHnOjdOVZa3CTjspnhEItQswV//KZ+eNEeH6yCGfL+yQ7eOv7Zsnx1/recy9Si8g==
X-Received: by 2002:a67:e28a:: with SMTP id g10mr14423678vsf.5.1634310879108;
        Fri, 15 Oct 2021 08:14:39 -0700 (PDT)
Received: from fedora ([187.64.134.142])
        by smtp.gmail.com with ESMTPSA id x21sm3834379uao.2.2021.10.15.08.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 08:14:38 -0700 (PDT)
Date:   Fri, 15 Oct 2021 12:14:35 -0300
From:   =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
To:     linux-kernel@vger.kernel.org
Cc:     lgirdwood@gmail.com, broonie@kernel.org
Subject: [PATCH] regulator/lp872x: replacing legacy gpio interface for gpiod
Message-ID: <YWma2yTyuwS5XwhY@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removing all linux/gpio.h and linux/of_gpio.h dependencies and replacing
them with the gpiod interface

Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
 drivers/regulator/lp872x.c       | 38 +++++++++++++-------------------
 include/linux/regulator/lp872x.h | 14 ++++++------
 2 files changed, 22 insertions(+), 30 deletions(-)

diff --git a/drivers/regulator/lp872x.c b/drivers/regulator/lp872x.c
index e84be29533f4..1dba5dbcd461 100644
--- a/drivers/regulator/lp872x.c
+++ b/drivers/regulator/lp872x.c
@@ -10,13 +10,12 @@
 #include <linux/i2c.h>
 #include <linux/regmap.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 #include <linux/regulator/lp872x.h>
 #include <linux/regulator/driver.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/regulator/of_regulator.h>
 
 /* Registers : LP8720/8725 shared */
@@ -250,12 +249,12 @@ static int lp872x_regulator_enable_time(struct regulator_dev *rdev)
 }
 
 static void lp872x_set_dvs(struct lp872x *lp, enum lp872x_dvs_sel dvs_sel,
-			int gpio)
+			struct gpio_desc *gpio)
 {
 	enum lp872x_dvs_state state;
 
 	state = dvs_sel == SEL_V1 ? DVS_HIGH : DVS_LOW;
-	gpio_set_value(gpio, state);
+	gpiod_set_value(gpio, state);
 	lp->dvs_pin = state;
 }
 
@@ -321,7 +320,7 @@ static int lp872x_buck_set_voltage_sel(struct regulator_dev *rdev,
 	u8 addr, mask = LP872X_VOUT_M;
 	struct lp872x_dvs *dvs = lp->pdata ? lp->pdata->dvs : NULL;
 
-	if (dvs && gpio_is_valid(dvs->gpio))
+	if (dvs && dvs->gpio)
 		lp872x_set_dvs(lp, dvs->vsel, dvs->gpio);
 
 	addr = lp872x_select_buck_vout_addr(lp, buck);
@@ -675,7 +674,6 @@ static const struct regulator_desc lp8725_regulator_desc[] = {
 
 static int lp872x_init_dvs(struct lp872x *lp)
 {
-	int ret, gpio;
 	struct lp872x_dvs *dvs = lp->pdata ? lp->pdata->dvs : NULL;
 	enum lp872x_dvs_state pinstate;
 	u8 mask[] = { LP8720_EXT_DVS_M, LP8725_DVS1_M | LP8725_DVS2_M };
@@ -684,15 +682,15 @@ static int lp872x_init_dvs(struct lp872x *lp)
 	if (!dvs)
 		goto set_default_dvs_mode;
 
-	gpio = dvs->gpio;
-	if (!gpio_is_valid(gpio))
+	if (!dvs->gpio)
 		goto set_default_dvs_mode;
 
 	pinstate = dvs->init_state;
-	ret = devm_gpio_request_one(lp->dev, gpio, pinstate, "LP872X DVS");
-	if (ret) {
-		dev_err(lp->dev, "gpio request err: %d\n", ret);
-		return ret;
+	dvs->gpio = devm_gpiod_get_optional(lp->dev, "ti,dvs", pinstate);
+
+	if (IS_ERR(dvs->gpio)) {
+		dev_err(lp->dev, "gpio request err: %ld\n", PTR_ERR(dvs->gpio));
+		return PTR_ERR(dvs->gpio);
 	}
 
 	lp->dvs_pin = pinstate;
@@ -706,20 +704,17 @@ static int lp872x_init_dvs(struct lp872x *lp)
 
 static int lp872x_hw_enable(struct lp872x *lp)
 {
-	int ret, gpio;
-
 	if (!lp->pdata)
 		return -EINVAL;
 
-	gpio = lp->pdata->enable_gpio;
-	if (!gpio_is_valid(gpio))
+	if (!lp->pdata->enable_gpio)
 		return 0;
 
 	/* Always set enable GPIO high. */
-	ret = devm_gpio_request_one(lp->dev, gpio, GPIOF_OUT_INIT_HIGH, "LP872X EN");
-	if (ret) {
-		dev_err(lp->dev, "gpio request err: %d\n", ret);
-		return ret;
+	lp->pdata->enable_gpio = devm_gpiod_get_optional(lp->dev, "enable", GPIOD_OUT_HIGH);
+	if (IS_ERR(lp->pdata->enable_gpio)) {
+		dev_err(lp->dev, "gpio request err: %ld\n", PTR_ERR(lp->pdata->enable_gpio));
+		return PTR_ERR(lp->pdata->enable_gpio);
 	}
 
 	/* Each chip has a different enable delay. */
@@ -844,13 +839,10 @@ static struct lp872x_platform_data
 	if (!pdata->dvs)
 		return ERR_PTR(-ENOMEM);
 
-	pdata->dvs->gpio = of_get_named_gpio(np, "ti,dvs-gpio", 0);
 	of_property_read_u8(np, "ti,dvs-vsel", (u8 *)&pdata->dvs->vsel);
 	of_property_read_u8(np, "ti,dvs-state", &dvs_state);
 	pdata->dvs->init_state = dvs_state ? DVS_HIGH : DVS_LOW;
 
-	pdata->enable_gpio = of_get_named_gpio(np, "enable-gpios", 0);
-
 	if (of_get_child_count(np) == 0)
 		goto out;
 
diff --git a/include/linux/regulator/lp872x.h b/include/linux/regulator/lp872x.h
index d780dbb8b423..8e7e0343c6e1 100644
--- a/include/linux/regulator/lp872x.h
+++ b/include/linux/regulator/lp872x.h
@@ -10,7 +10,7 @@
 
 #include <linux/regulator/machine.h>
 #include <linux/platform_device.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 
 #define LP872X_MAX_REGULATORS		9
 
@@ -41,8 +41,8 @@ enum lp872x_regulator_id {
 };
 
 enum lp872x_dvs_state {
-	DVS_LOW  = GPIOF_OUT_INIT_LOW,
-	DVS_HIGH = GPIOF_OUT_INIT_HIGH,
+	DVS_LOW  = GPIOD_OUT_LOW,
+	DVS_HIGH = GPIOD_OUT_HIGH,
 };
 
 enum lp872x_dvs_sel {
@@ -52,12 +52,12 @@ enum lp872x_dvs_sel {
 
 /**
  * lp872x_dvs
- * @gpio       : gpio pin number for dvs control
+ * @gpio       : gpio descriptor for dvs control
  * @vsel       : dvs selector for buck v1 or buck v2 register
  * @init_state : initial dvs pin state
  */
 struct lp872x_dvs {
-	int gpio;
+	struct gpio_desc *gpio;
 	enum lp872x_dvs_sel vsel;
 	enum lp872x_dvs_state init_state;
 };
@@ -78,14 +78,14 @@ struct lp872x_regulator_data {
  * @update_config     : if LP872X_GENERAL_CFG register is updated, set true
  * @regulator_data    : platform regulator id and init data
  * @dvs               : dvs data for buck voltage control
- * @enable_gpio       : gpio pin number for enable control
+ * @enable_gpio       : gpio descriptor for enable control
  */
 struct lp872x_platform_data {
 	u8 general_config;
 	bool update_config;
 	struct lp872x_regulator_data regulator_data[LP872X_MAX_REGULATORS];
 	struct lp872x_dvs *dvs;
-	int enable_gpio;
+	struct gpio_desc *enable_gpio;
 };
 
 #endif
-- 
2.31.1

