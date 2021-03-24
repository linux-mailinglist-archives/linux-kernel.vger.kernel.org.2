Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B454D347277
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 08:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236004AbhCXHX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 03:23:26 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:34427 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235887AbhCXHWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 03:22:51 -0400
Received: by mail-lf1-f54.google.com with SMTP id i26so14569862lfl.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 00:22:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LOc/sdEqa2fuqslZ0g9dbAfn8FDlngDdWJOGKcVARN8=;
        b=OBu7kNm2gH2gOGxvcOOvge598snzVYgXinCg6STTGNYY1J/I4DQeU3QrVc72OaUnZK
         ayZ9pAupfgAXb+cTUe0krDCsc1GDvLyDH6tuWgMOUaviubEj1cwMAlm+Q80RwxTTV/nR
         2zPfPqghmbN1oqi7+k81sfWJR2dv9Hm9N3KofpXpGVn1L3Yb7ebrBD3stWO/aoS3HiQs
         dHa0MP/+SBMumjhPVqbYPKoo/ZPpgSZQiCVITNTQ2JSOT+813Aw/617NFtLIiUxZgd38
         xWO6VAHR7f4F4rTMjr4l1v735m6b3Ok8Y2VmkMTDoCt07sPpYu3/SKzT+DS9g8IGrSrO
         29wA==
X-Gm-Message-State: AOAM533YGHZL+NeqpyFt2F6ob46W4jL89yt5eQHVXEyzLsrZ7o3CyvpX
        uS4/j43yFLkVzgZRuGVlsaU=
X-Google-Smtp-Source: ABdhPJy5IjgV0SWQ1XeJTf5JyitGK9y/X7JSFt+0gWJXtYL9nty9Lou5arWv1X2b32s6sAppiQ8HCw==
X-Received: by 2002:a05:6512:3d04:: with SMTP id d4mr1215087lfv.102.1616570569985;
        Wed, 24 Mar 2021 00:22:49 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::2])
        by smtp.gmail.com with ESMTPSA id q14sm145728lfr.12.2021.03.24.00.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 00:22:49 -0700 (PDT)
Date:   Wed, 24 Mar 2021 09:22:43 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        linux-kernel@vger.kernel.org, linux-power@fi.rohmeurope.com
Subject: [PATCH v4 02/16] mfd: bd718x7: simplify by cleaning unnecessary
 device data
Message-ID: <3d0a2ec369e242d99c6fc6b190c5602a44ac566e.1616566395.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1616566395.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1616566395.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most ROHM PMIC sub-devices only use the regmap pointer from
parent device. They can obtain this by dev_get_regamap so in
most cases the MFD device does not need to allocate and populate
the driver data. Simplify drivers by removing this.

The BD70528 still needs the access to watchdog mutex so keep
rohm_regmap_dev in use on BD70528 RTC and WDG drivers for now.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
No changes since v3

 drivers/mfd/rohm-bd718x7.c       | 43 ++++++++++++--------------------
 include/linux/mfd/rohm-bd718x7.h | 13 ----------
 2 files changed, 16 insertions(+), 40 deletions(-)

diff --git a/drivers/mfd/rohm-bd718x7.c b/drivers/mfd/rohm-bd718x7.c
index c32c1b6c98fa..bfd81f78beae 100644
--- a/drivers/mfd/rohm-bd718x7.c
+++ b/drivers/mfd/rohm-bd718x7.c
@@ -91,9 +91,9 @@ static const struct regmap_config bd718xx_regmap_config = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-static int bd718xx_init_press_duration(struct bd718xx *bd718xx)
+static int bd718xx_init_press_duration(struct regmap *regmap,
+				       struct device *dev)
 {
-	struct device* dev = bd718xx->chip.dev;
 	u32 short_press_ms, long_press_ms;
 	u32 short_press_value, long_press_value;
 	int ret;
@@ -102,8 +102,7 @@ static int bd718xx_init_press_duration(struct bd718xx *bd718xx)
 				   &short_press_ms);
 	if (!ret) {
 		short_press_value = min(15u, (short_press_ms + 250) / 500);
-		ret = regmap_update_bits(bd718xx->chip.regmap,
-					 BD718XX_REG_PWRONCONFIG0,
+		ret = regmap_update_bits(regmap, BD718XX_REG_PWRONCONFIG0,
 					 BD718XX_PWRBTN_PRESS_DURATION_MASK,
 					 short_press_value);
 		if (ret) {
@@ -116,8 +115,7 @@ static int bd718xx_init_press_duration(struct bd718xx *bd718xx)
 				   &long_press_ms);
 	if (!ret) {
 		long_press_value = min(15u, (long_press_ms + 500) / 1000);
-		ret = regmap_update_bits(bd718xx->chip.regmap,
-					 BD718XX_REG_PWRONCONFIG1,
+		ret = regmap_update_bits(regmap, BD718XX_REG_PWRONCONFIG1,
 					 BD718XX_PWRBTN_PRESS_DURATION_MASK,
 					 long_press_value);
 		if (ret) {
@@ -132,7 +130,8 @@ static int bd718xx_init_press_duration(struct bd718xx *bd718xx)
 static int bd718xx_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
-	struct bd718xx *bd718xx;
+	struct regmap *regmap;
+	struct regmap_irq_chip_data *irq_data;
 	int ret;
 	unsigned int chip_type;
 	struct mfd_cell *mfd;
@@ -142,13 +141,6 @@ static int bd718xx_i2c_probe(struct i2c_client *i2c,
 		dev_err(&i2c->dev, "No IRQ configured\n");
 		return -EINVAL;
 	}
-
-	bd718xx = devm_kzalloc(&i2c->dev, sizeof(struct bd718xx), GFP_KERNEL);
-
-	if (!bd718xx)
-		return -ENOMEM;
-
-	bd718xx->chip_irq = i2c->irq;
 	chip_type = (unsigned int)(uintptr_t)
 		    of_device_get_match_data(&i2c->dev);
 	switch (chip_type) {
@@ -164,29 +156,26 @@ static int bd718xx_i2c_probe(struct i2c_client *i2c,
 		dev_err(&i2c->dev, "Unknown device type");
 		return -EINVAL;
 	}
-	bd718xx->chip.dev = &i2c->dev;
-	dev_set_drvdata(&i2c->dev, bd718xx);
 
-	bd718xx->chip.regmap = devm_regmap_init_i2c(i2c,
-						    &bd718xx_regmap_config);
-	if (IS_ERR(bd718xx->chip.regmap)) {
+	regmap = devm_regmap_init_i2c(i2c, &bd718xx_regmap_config);
+	if (IS_ERR(regmap)) {
 		dev_err(&i2c->dev, "regmap initialization failed\n");
-		return PTR_ERR(bd718xx->chip.regmap);
+		return PTR_ERR(regmap);
 	}
 
-	ret = devm_regmap_add_irq_chip(&i2c->dev, bd718xx->chip.regmap,
-				       bd718xx->chip_irq, IRQF_ONESHOT, 0,
-				       &bd718xx_irq_chip, &bd718xx->irq_data);
+	ret = devm_regmap_add_irq_chip(&i2c->dev, regmap, i2c->irq,
+				       IRQF_ONESHOT, 0, &bd718xx_irq_chip,
+				       &irq_data);
 	if (ret) {
 		dev_err(&i2c->dev, "Failed to add irq_chip\n");
 		return ret;
 	}
 
-	ret = bd718xx_init_press_duration(bd718xx);
+	ret = bd718xx_init_press_duration(regmap, &i2c->dev);
 	if (ret)
 		return ret;
 
-	ret = regmap_irq_get_virq(bd718xx->irq_data, BD718XX_INT_PWRBTN_S);
+	ret = regmap_irq_get_virq(irq_data, BD718XX_INT_PWRBTN_S);
 
 	if (ret < 0) {
 		dev_err(&i2c->dev, "Failed to get the IRQ\n");
@@ -195,9 +184,9 @@ static int bd718xx_i2c_probe(struct i2c_client *i2c,
 
 	button.irq = ret;
 
-	ret = devm_mfd_add_devices(bd718xx->chip.dev, PLATFORM_DEVID_AUTO,
+	ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO,
 				   mfd, cells, NULL, 0,
-				   regmap_irq_get_domain(bd718xx->irq_data));
+				   regmap_irq_get_domain(irq_data));
 	if (ret)
 		dev_err(&i2c->dev, "Failed to create subdevices\n");
 
diff --git a/include/linux/mfd/rohm-bd718x7.h b/include/linux/mfd/rohm-bd718x7.h
index bee2474a8f9f..df2918198d37 100644
--- a/include/linux/mfd/rohm-bd718x7.h
+++ b/include/linux/mfd/rohm-bd718x7.h
@@ -310,17 +310,4 @@ enum {
 	BD718XX_PWRBTN_LONG_PRESS_15S
 };
 
-struct bd718xx {
-	/*
-	 * Please keep this as the first member here as some
-	 * drivers (clk) supporting more than one chip may only know this
-	 * generic struct 'struct rohm_regmap_dev' and assume it is
-	 * the first chunk of parent device's private data.
-	 */
-	struct rohm_regmap_dev chip;
-
-	int chip_irq;
-	struct regmap_irq_chip_data *irq_data;
-};
-
 #endif /* __LINUX_MFD_BD718XX_H__ */
-- 
2.25.4


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
