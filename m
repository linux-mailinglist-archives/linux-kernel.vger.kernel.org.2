Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFF53A867B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 18:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhFOQaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 12:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbhFOQae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 12:30:34 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9054FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 09:28:29 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id m13-20020a17090b068db02901656cc93a75so2156231pjz.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 09:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MwDwYIjq2eOn/vyCML97eG6YQ4E0JiM3dlWQ7dbtA8Y=;
        b=aDg+a+HX2jwNRTQrWX6aoj3B6RwIRsE0X6OG+TgxE3kNJOGMOx6g9LG5kmHOpXAwSD
         UtWpwykANM3F0chqWqD+F2bOObSbUrgX8H0ePQ6+JSZ5gF0PeK8MT1d/YCnCb8rv9m4G
         NevW0wlYTRvUAjQxaLDy8w+8AM+mafV5Sdkf4ohjyvodHl6J210MdlvOToR8AuJnElFK
         1KszQFrgWMDbEaSoF8D9vzrw5xac+BMVvUAXBe4kkOKi/c2BShQ7hNrDOppof4JpQDWM
         yx9A2Smo+OnAaJ4ZXd8UG7HDRmKcglpbNRMl+cHVF+r1BtdFIcoaE74Nne3FZvD2QBpj
         6z7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MwDwYIjq2eOn/vyCML97eG6YQ4E0JiM3dlWQ7dbtA8Y=;
        b=riD2GkeWP21uwzBo7NhV+saJ4CLESX6M06w+xrv1o7HVrW62AviW20fhsZrmPPyghN
         7IE4D67Vj/Ri2u7ZB0Y6xuIvthP1+/3JOzeuWH4kS5hFluR3E9461LHDvkFXvK3Lm7fy
         vJmhB59WImLvGLjyDJ3QCO8sh3BBTQxaD7vDk7Pxk4YQI+4TXYZMuRSYOn9gsQDd0AEN
         hCcOwasSMnhAGxWsNKKBvReRHYu64fWpg9WlxxyHgpd3V4pB91lClHq5taCqJ7V5ow3h
         oKQGjr2YiOFv8is7TCNxq/nhggif1U7sXPS8WXEkttoyl89vrVrYmcfueNcWNAaY3WsR
         nqFA==
X-Gm-Message-State: AOAM531ON33iV5f1/eidxnonqI/0ETfi/aRmk5yyHlKu53Lc4fFE5t23
        uDEOfuQtSy9iARZJTyl8kGg=
X-Google-Smtp-Source: ABdhPJyDipyuDthyHx5/dYNFdCJb28eebzXG+0xSN4cWx2yD9MFYl/akMF09GuXAzfvnSGKRsDaihw==
X-Received: by 2002:a17:90a:e2c6:: with SMTP id fr6mr5783043pjb.198.1623774508859;
        Tue, 15 Jun 2021 09:28:28 -0700 (PDT)
Received: from localhost.localdomain (1-171-2-171.dynamic-ip.hinet.net. [1.171.2.171])
        by smtp.gmail.com with ESMTPSA id 65sm16344898pfu.159.2021.06.15.09.28.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jun 2021 09:28:28 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        u0084500@gmail.com, ChiYuan Huang <cy_huang@richtek.com>
Subject: [PATCH] regulator: rt6160: Revert chagne and fix vsel high/low suspend voltage logic
Date:   Wed, 16 Jun 2021 00:28:21 +0800
Message-Id: <1623774501-23647-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Revert change and fix vsel logic in suspend voltage logic.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 drivers/regulator/rt6160-regulator.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/rt6160-regulator.c b/drivers/regulator/rt6160-regulator.c
index ccd023d..1cdb1f4 100644
--- a/drivers/regulator/rt6160-regulator.c
+++ b/drivers/regulator/rt6160-regulator.c
@@ -42,6 +42,7 @@ struct rt6160_priv {
 	struct regulator_desc desc;
 	struct gpio_desc *enable_gpio;
 	struct regmap *regmap;
+	bool vsel_active_low;
 	bool enable_state;
 };
 
@@ -127,15 +128,19 @@ static unsigned int rt6160_get_mode(struct regulator_dev *rdev)
 
 static int rt6160_set_suspend_voltage(struct regulator_dev *rdev, int uV)
 {
+	struct rt6160_priv *priv = rdev_get_drvdata(rdev);
 	struct regmap *regmap = rdev_get_regmap(rdev);
+	unsigned int reg = RT6160_REG_VSELH;
 	int vsel;
 
 	vsel = regulator_map_voltage_linear(rdev, uV, uV);
 	if (vsel < 0)
 		return vsel;
 
-	return regmap_update_bits(regmap, rdev->desc->vsel_reg,
-				  RT6160_VSEL_MASK, vsel);
+	if (!priv->vsel_active_low)
+		reg = RT6160_REG_VSELL;
+
+	return regmap_update_bits(regmap, reg, RT6160_VSEL_MASK, vsel);
 }
 
 static int rt6160_get_error_flags(struct regulator_dev *rdev, unsigned int *flags)
@@ -223,7 +228,6 @@ static int rt6160_probe(struct i2c_client *i2c)
 	struct rt6160_priv *priv;
 	struct regulator_config regulator_cfg = {};
 	struct regulator_dev *rdev;
-	bool vsel_active_low;
 	unsigned int devid;
 	int ret;
 
@@ -231,8 +235,7 @@ static int rt6160_probe(struct i2c_client *i2c)
 	if (!priv)
 		return -ENOMEM;
 
-	vsel_active_low =
-		device_property_present(&i2c->dev, "richtek,vsel-active-low");
+	priv->vsel_active_low = device_property_present(&i2c->dev, "richtek,vsel-active-low");
 
 	priv->enable_gpio = devm_gpiod_get_optional(&i2c->dev, "enable", GPIOD_OUT_HIGH);
 	if (IS_ERR(priv->enable_gpio)) {
@@ -264,10 +267,7 @@ static int rt6160_probe(struct i2c_client *i2c)
 	priv->desc.owner = THIS_MODULE;
 	priv->desc.min_uV = RT6160_VOUT_MINUV;
 	priv->desc.uV_step = RT6160_VOUT_STPUV;
-	if (vsel_active_low)
-		priv->desc.vsel_reg = RT6160_REG_VSELL;
-	else
-		priv->desc.vsel_reg = RT6160_REG_VSELH;
+	priv->desc.vsel_reg = RT6160_REG_VSELH;
 	priv->desc.vsel_mask = RT6160_VSEL_MASK;
 	priv->desc.n_voltages = RT6160_N_VOUTS;
 	priv->desc.ramp_reg = RT6160_REG_CNTL;
@@ -276,6 +276,8 @@ static int rt6160_probe(struct i2c_client *i2c)
 	priv->desc.n_ramp_values = ARRAY_SIZE(rt6160_ramp_tables);
 	priv->desc.of_map_mode = rt6160_of_map_mode;
 	priv->desc.ops = &rt6160_regulator_ops;
+	if (priv->vsel_active_low)
+		priv->desc.vsel_reg = RT6160_REG_VSELL;
 
 	regulator_cfg.dev = &i2c->dev;
 	regulator_cfg.of_node = i2c->dev.of_node;
-- 
2.7.4

