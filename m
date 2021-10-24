Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFC8438B7B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 20:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbhJXSof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 14:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhJXSoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 14:44:34 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91036C061745
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 11:42:13 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id p23so4992045uaa.6
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 11:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=2zKExMX3MB1TxKtRKrdaVloxMHrKPcGLWTrSGkdV5z4=;
        b=niSvMwWvvs2enhC0ExbLTXLq6XgNUihAaxTbNtxiJ3M+Sw30/3NKfJz/1vwba+g43W
         9d2lOoTgAzy7SIFEwVs9/MvX3shcdepdsZrWrBdcmkp0dPI+uxVLa+F0lUzqizF6OtkG
         DlhB3bhOEF7QmBjJc6Fv2hCTR7CksYXGcbp1yy4MXBd91vLq+kojW+LvJ+8HHiD3m2lt
         9581AEEZ0r79vIVkcL5cNbntmX7lyWO6vcSN/0fMsIkh9+wuu3jwedGfVbrzYDnqN1ZY
         RYw5z0xVl/yUwWw76BFkcGwI6MDCxHAJMxZt/tbUOhmGQVj8pv9ViVuUyleVmmsp8Jjn
         W5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=2zKExMX3MB1TxKtRKrdaVloxMHrKPcGLWTrSGkdV5z4=;
        b=ESDIearMNyJA48wpT+McqqVcNHOEyHKVlKtd0efwwR9/TTkGOZtSIYsXBXGqDLbXAO
         bDQ6WexDXeqfsRtlpvxcfl2JvXo3tBqtf6SLIBG3mR4uDUzplqH22XcYeKLf2wz7qIhv
         kcs+fnr25PjTI1hjsTnDjVVKIX+SWOl39R/oSkltI5scKo/A+5LRoCc9DyTRbppkSFTF
         HTFjnzjUNQtyLzijnHSbSiR3zDxG6hwf+FLFRvhl4qgGf/iE7Lu260nsZ5VTqpHU/KMk
         7kQfECWQRobPbRnYfkVR4WkrjQ1FJm+oMnK530Rv4wIh3J5jsraGblTR0WlvWWdrQWRR
         j8iQ==
X-Gm-Message-State: AOAM532OpHYXCV3bVxcJaP7e7Ljrz9BhShWHHbNOBB5YEqCuEyDDX078
        9aFO0gRgxbKz4FVgz9gD+Trymw==
X-Google-Smtp-Source: ABdhPJwxoKS8t69phmvBWkAPmJH+/yvrTxEgimXVcO09ZX2WO/qV1KanLTZK44hqMEscS6TuH2cCdA==
X-Received: by 2002:a67:e1d2:: with SMTP id p18mr11692032vsl.30.1635100932702;
        Sun, 24 Oct 2021 11:42:12 -0700 (PDT)
Received: from fedora ([187.64.134.142])
        by smtp.gmail.com with ESMTPSA id o18sm8578301vkb.21.2021.10.24.11.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 11:42:12 -0700 (PDT)
Date:   Sun, 24 Oct 2021 15:42:07 -0300
From:   =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
To:     lars@metafoo.de, nuno.sa@analog.com, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: adau1701: Replace legacy gpio interface for gpiod
Message-ID: <YXWo/9o7ye9a11aR@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Considering the current transition of the GPIO subsystem, remove all
dependencies of the legacy GPIO interface (linux/gpio.h and linux
/of_gpio.h) and replace it with the descriptor-based GPIO approach.

Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
 sound/soc/codecs/adau1701.c | 94 ++++++++++++-------------------------
 1 file changed, 31 insertions(+), 63 deletions(-)

diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
index 5ce74697564a..1ef071533b06 100644
--- a/sound/soc/codecs/adau1701.c
+++ b/sound/soc/codecs/adau1701.c
@@ -13,8 +13,8 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/of_device.h>
+#include <linux/gpio/consumer.h>
 #include <linux/regulator/consumer.h>
 #include <linux/regmap.h>
 #include <sound/core.h>
@@ -106,8 +106,8 @@ static const char * const supply_names[] = {
 };
 
 struct adau1701 {
-	int gpio_nreset;
-	int gpio_pll_mode[2];
+	struct gpio_desc  *gpio_nreset;
+	struct gpio_descs *gpio_pll_mode;
 	unsigned int dai_fmt;
 	unsigned int pll_clkdiv;
 	unsigned int sysclk;
@@ -303,39 +303,41 @@ static int adau1701_reset(struct snd_soc_component *component, unsigned int clkd
 	struct adau1701 *adau1701 = snd_soc_component_get_drvdata(component);
 	int ret;
 
+	DECLARE_BITMAP(values, 2);
 	sigmadsp_reset(adau1701->sigmadsp);
 
-	if (clkdiv != ADAU1707_CLKDIV_UNSET &&
-	    gpio_is_valid(adau1701->gpio_pll_mode[0]) &&
-	    gpio_is_valid(adau1701->gpio_pll_mode[1])) {
+	if (clkdiv != ADAU1707_CLKDIV_UNSET && adau1701->gpio_pll_mode) {
 		switch (clkdiv) {
 		case 64:
-			gpio_set_value_cansleep(adau1701->gpio_pll_mode[0], 0);
-			gpio_set_value_cansleep(adau1701->gpio_pll_mode[1], 0);
+			__assign_bit(0, values, 0);
+			__assign_bit(1, values, 0);
 			break;
 		case 256:
-			gpio_set_value_cansleep(adau1701->gpio_pll_mode[0], 0);
-			gpio_set_value_cansleep(adau1701->gpio_pll_mode[1], 1);
+			__assign_bit(0, values, 0);
+			__assign_bit(1, values, 1);
 			break;
 		case 384:
-			gpio_set_value_cansleep(adau1701->gpio_pll_mode[0], 1);
-			gpio_set_value_cansleep(adau1701->gpio_pll_mode[1], 0);
+			__assign_bit(0, values, 1);
+			__assign_bit(1, values, 0);
 			break;
-		case 0:	/* fallback */
+		case 0: /* fallback */
 		case 512:
-			gpio_set_value_cansleep(adau1701->gpio_pll_mode[0], 1);
-			gpio_set_value_cansleep(adau1701->gpio_pll_mode[1], 1);
+			__assign_bit(0, values, 1);
+			__assign_bit(1, values, 1);
 			break;
 		}
+		gpiod_set_array_value_cansleep(adau1701->gpio_pll_mode->ndescs,
+				adau1701->gpio_pll_mode->desc, adau1701->gpio_pll_mode->info,
+				values);
 	}
 
 	adau1701->pll_clkdiv = clkdiv;
 
-	if (gpio_is_valid(adau1701->gpio_nreset)) {
-		gpio_set_value_cansleep(adau1701->gpio_nreset, 0);
+	if (adau1701->gpio_nreset) {
+		gpiod_set_value_cansleep(adau1701->gpio_nreset, 0);
 		/* minimum reset time is 20ns */
 		udelay(1);
-		gpio_set_value_cansleep(adau1701->gpio_nreset, 1);
+		gpiod_set_value_cansleep(adau1701->gpio_nreset, 1);
 		/* power-up time may be as long as 85ms */
 		mdelay(85);
 	}
@@ -719,8 +721,8 @@ static void adau1701_remove(struct snd_soc_component *component)
 {
 	struct adau1701 *adau1701 = snd_soc_component_get_drvdata(component);
 
-	if (gpio_is_valid(adau1701->gpio_nreset))
-		gpio_set_value_cansleep(adau1701->gpio_nreset, 0);
+	if (adau1701->gpio_nreset)
+		gpiod_set_value_cansleep(adau1701->gpio_nreset, 0);
 
 	regulator_bulk_disable(ARRAY_SIZE(adau1701->supplies), adau1701->supplies);
 }
@@ -788,8 +790,6 @@ static int adau1701_i2c_probe(struct i2c_client *client,
 {
 	struct adau1701 *adau1701;
 	struct device *dev = &client->dev;
-	int gpio_nreset = -EINVAL;
-	int gpio_pll_mode[2] = { -EINVAL, -EINVAL };
 	int ret, i;
 
 	adau1701 = devm_kzalloc(dev, sizeof(*adau1701), GFP_KERNEL);
@@ -823,26 +823,6 @@ static int adau1701_i2c_probe(struct i2c_client *client,
 
 
 	if (dev->of_node) {
-		gpio_nreset = of_get_named_gpio(dev->of_node, "reset-gpio", 0);
-		if (gpio_nreset < 0 && gpio_nreset != -ENOENT) {
-			ret = gpio_nreset;
-			goto exit_regulators_disable;
-		}
-
-		gpio_pll_mode[0] = of_get_named_gpio(dev->of_node,
-						   "adi,pll-mode-gpios", 0);
-		if (gpio_pll_mode[0] < 0 && gpio_pll_mode[0] != -ENOENT) {
-			ret = gpio_pll_mode[0];
-			goto exit_regulators_disable;
-		}
-
-		gpio_pll_mode[1] = of_get_named_gpio(dev->of_node,
-						   "adi,pll-mode-gpios", 1);
-		if (gpio_pll_mode[1] < 0 && gpio_pll_mode[1] != -ENOENT) {
-			ret = gpio_pll_mode[1];
-			goto exit_regulators_disable;
-		}
-
 		of_property_read_u32(dev->of_node, "adi,pll-clkdiv",
 				     &adau1701->pll_clkdiv);
 
@@ -851,32 +831,20 @@ static int adau1701_i2c_probe(struct i2c_client *client,
 					  ARRAY_SIZE(adau1701->pin_config));
 	}
 
-	if (gpio_is_valid(gpio_nreset)) {
-		ret = devm_gpio_request_one(dev, gpio_nreset, GPIOF_OUT_INIT_LOW,
-					    "ADAU1701 Reset");
-		if (ret < 0)
-			goto exit_regulators_disable;
+	adau1701->gpio_nreset = devm_gpiod_get_optional(dev, "reset", GPIOD_IN);
+
+	if (IS_ERR(adau1701->gpio_nreset)) {
+		ret = PTR_ERR(adau1701->gpio_nreset);
+		goto exit_regulators_disable;
 	}
 
-	if (gpio_is_valid(gpio_pll_mode[0]) &&
-	    gpio_is_valid(gpio_pll_mode[1])) {
-		ret = devm_gpio_request_one(dev, gpio_pll_mode[0],
-					    GPIOF_OUT_INIT_LOW,
-					    "ADAU1701 PLL mode 0");
-		if (ret < 0)
-			goto exit_regulators_disable;
+	adau1701->gpio_pll_mode = devm_gpiod_get_array_optional(dev, "adi,pll-mode", GPIOD_OUT_LOW);
 
-		ret = devm_gpio_request_one(dev, gpio_pll_mode[1],
-					    GPIOF_OUT_INIT_LOW,
-					    "ADAU1701 PLL mode 1");
-		if (ret < 0)
-			goto exit_regulators_disable;
+	if (IS_ERR(adau1701->gpio_pll_mode)) {
+		ret = PTR_ERR(adau1701->gpio_pll_mode);
+		goto exit_regulators_disable;
 	}
 
-	adau1701->gpio_nreset = gpio_nreset;
-	adau1701->gpio_pll_mode[0] = gpio_pll_mode[0];
-	adau1701->gpio_pll_mode[1] = gpio_pll_mode[1];
-
 	i2c_set_clientdata(client, adau1701);
 
 	adau1701->sigmadsp = devm_sigmadsp_init_i2c(client,
-- 
2.31.1

