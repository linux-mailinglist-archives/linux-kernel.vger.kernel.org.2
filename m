Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C85F3A7C2E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 12:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbhFOKmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 06:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbhFOKmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 06:42:09 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB821C061767
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 03:40:04 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g22so5998017pgk.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 03:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qUWmmDRe4di+FskXCbx274OOftLRJ2dixibbdkpnnt4=;
        b=l2neu2J4CVSRE/iHpyMo1I530+4csrr+RhVrkHxFeWv5VGtxDjU7kYYnaRlGF0UXJZ
         ydUGVsd5w3lNCsIqHCby1R83vtlVPmwVCys2BRs4NsaUcA36CwSyMGDr69FhZHmjV1LQ
         4OWqPO/5ZxuHw30JHDMUD82icjJBvCwliRlyXCui7JhxQrs1sQR/59S0N277L/PKolUC
         7JqxEhDjBkAbpfADT2VF3GKkdTZ4iS8Hi6yZLrUeBf/4Tm2QePtiZLP+aNTGHJldUkbJ
         pR7NbTiq8VLwKEUV+UezDyR5tnyGFioHYO/qlJny+Sh/VuSSL1Zs2xI0kKLtnIZ8uGVT
         JG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qUWmmDRe4di+FskXCbx274OOftLRJ2dixibbdkpnnt4=;
        b=k4ifFhyh/n69kEHYtx/NjDNNlcS2aHfNVmMzGV3xp7OgcBuVokK2aviHt9iItC1KwI
         YJlz0ZOnXbqeq3IDz6RNIfxXg1L6rcNGoNpqDA5ppIwiORmfmmZT6Xnaga9qLmWoHY6A
         ICpyfITeTzNd/CP8MV6KlOxon1+RI7g10lh96NDxaJh9x5wqduC+lgoTpH7ouPX0OQ7B
         JHJOggRAyTitSXCweCnB7Aeopo1S7W0J5uohy9RBEeOal+fgQC4+z4fFlRJZE5vrr8KK
         vNg0Ll2LvWi+Tb5OnLRSNtWEn3vS5B3WXu294A9kiykLHXoVtGeLhVZuUqYgCV/+zjNr
         lIpw==
X-Gm-Message-State: AOAM533rcptARjwa8zvBu3w8gOQZrzzEgDQHxTD+uvUCL261MYibgwjc
        AcTIngv09vzjDAS+9nrCL7jJ0BiqxbG427UF
X-Google-Smtp-Source: ABdhPJxC1+2gH99lIM146pvlvp0pBFWbtMYTEJ2sV/IHLRtxt7s6EUvT3PFKUFODVXgvd8bJk64UMQ==
X-Received: by 2002:a05:6a00:1344:b029:2f6:5ce3:218e with SMTP id k4-20020a056a001344b02902f65ce3218emr3698246pfu.80.1623753604275;
        Tue, 15 Jun 2021 03:40:04 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id q145sm8361273pfc.60.2021.06.15.03.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 03:40:03 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     ChiYuan Huang <cy_huang@richtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: rt6160: Remove vsel_active_low from struct rt6160_priv
Date:   Tue, 15 Jun 2021 18:39:47 +0800
Message-Id: <20210615103947.3387994-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a local variable instead is enough, this simplifies the code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/rt6160-regulator.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/rt6160-regulator.c b/drivers/regulator/rt6160-regulator.c
index b6b53868050f..ccd023da4318 100644
--- a/drivers/regulator/rt6160-regulator.c
+++ b/drivers/regulator/rt6160-regulator.c
@@ -42,7 +42,6 @@ struct rt6160_priv {
 	struct regulator_desc desc;
 	struct gpio_desc *enable_gpio;
 	struct regmap *regmap;
-	bool vsel_active_low;
 	bool enable_state;
 };
 
@@ -128,19 +127,15 @@ static unsigned int rt6160_get_mode(struct regulator_dev *rdev)
 
 static int rt6160_set_suspend_voltage(struct regulator_dev *rdev, int uV)
 {
-	struct rt6160_priv *priv = rdev_get_drvdata(rdev);
 	struct regmap *regmap = rdev_get_regmap(rdev);
-	unsigned int reg = RT6160_REG_VSELH;
 	int vsel;
 
 	vsel = regulator_map_voltage_linear(rdev, uV, uV);
 	if (vsel < 0)
 		return vsel;
 
-	if (priv->vsel_active_low)
-		reg = RT6160_REG_VSELL;
-
-	return regmap_update_bits(regmap, reg, RT6160_VSEL_MASK, vsel);
+	return regmap_update_bits(regmap, rdev->desc->vsel_reg,
+				  RT6160_VSEL_MASK, vsel);
 }
 
 static int rt6160_get_error_flags(struct regulator_dev *rdev, unsigned int *flags)
@@ -228,6 +223,7 @@ static int rt6160_probe(struct i2c_client *i2c)
 	struct rt6160_priv *priv;
 	struct regulator_config regulator_cfg = {};
 	struct regulator_dev *rdev;
+	bool vsel_active_low;
 	unsigned int devid;
 	int ret;
 
@@ -235,7 +231,8 @@ static int rt6160_probe(struct i2c_client *i2c)
 	if (!priv)
 		return -ENOMEM;
 
-	priv->vsel_active_low = device_property_present(&i2c->dev, "richtek,vsel-active-low");
+	vsel_active_low =
+		device_property_present(&i2c->dev, "richtek,vsel-active-low");
 
 	priv->enable_gpio = devm_gpiod_get_optional(&i2c->dev, "enable", GPIOD_OUT_HIGH);
 	if (IS_ERR(priv->enable_gpio)) {
@@ -267,7 +264,10 @@ static int rt6160_probe(struct i2c_client *i2c)
 	priv->desc.owner = THIS_MODULE;
 	priv->desc.min_uV = RT6160_VOUT_MINUV;
 	priv->desc.uV_step = RT6160_VOUT_STPUV;
-	priv->desc.vsel_reg = RT6160_REG_VSELH;
+	if (vsel_active_low)
+		priv->desc.vsel_reg = RT6160_REG_VSELL;
+	else
+		priv->desc.vsel_reg = RT6160_REG_VSELH;
 	priv->desc.vsel_mask = RT6160_VSEL_MASK;
 	priv->desc.n_voltages = RT6160_N_VOUTS;
 	priv->desc.ramp_reg = RT6160_REG_CNTL;
@@ -276,8 +276,6 @@ static int rt6160_probe(struct i2c_client *i2c)
 	priv->desc.n_ramp_values = ARRAY_SIZE(rt6160_ramp_tables);
 	priv->desc.of_map_mode = rt6160_of_map_mode;
 	priv->desc.ops = &rt6160_regulator_ops;
-	if (priv->vsel_active_low)
-		priv->desc.vsel_reg = RT6160_REG_VSELL;
 
 	regulator_cfg.dev = &i2c->dev;
 	regulator_cfg.of_node = i2c->dev.of_node;
-- 
2.25.1

