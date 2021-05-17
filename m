Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA37C383B59
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 19:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243369AbhEQRfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 13:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243031AbhEQRez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 13:34:55 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8C1C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 10:33:37 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id lj11-20020a17090b344bb029015bc3073608so50845pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 10:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0qfc/4x5NUlqMKF6YV5bXi/lMGhfFwLsCdX8LnCxHAU=;
        b=iX+ssj3xwZLEAW+CObvf35JxI7MqutPNzS4sjwIoFtE0WYnrSJxDeyxw6EqzhvNI7C
         NqJVlMPTrLUrXfWLyQBNPcUgtUVFGrGJ3hUky4g4oiF0lIsrrMtgnMM5E/wc1oyO+Wbb
         ayKPujkKNdg5132uZTb+LlMw6BZQBV0lqDQgCVHEbWqyeNQqfRh+OkL/hcAXcMa9JxRz
         UmVGc+w2SIDkA/52zV7cyiExYvg631+OTBzCOKV3dWZEfOudNMkYfCR65s201MY5XEYz
         esfdgM9EhSYmot1PCaFWuv2JVGQyBAY+K7ODnNuzc7adocHaZii6GM7wk32GlMRubfUd
         9Z+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0qfc/4x5NUlqMKF6YV5bXi/lMGhfFwLsCdX8LnCxHAU=;
        b=ZnlHbJf84mK5ABt0QdAEfYtspyL9/tEfznaeu/lVK3FF/Sqq/Fp6AqrVkeSfOWLYmh
         /IUkhsjZZhAmChWRkGbFlpJHSiKzJXKTYCWNGZJiUFLv3llMw9zDwUViL1gn/RY4xFJY
         nYd992wfwLZCljtURjFtf1LWU0Kp2FyFHcAUKtUun0ti9Zlo1dyL2Td+s5wd4AUbbto3
         +XuSIdiseIq0NW1h7jilmGn49GHnyIKjQwoFEkb3mglMrxOGTHgXzKjpJCD4aWj35pfL
         FODL2w7+rblThQcBB2qnwykQ0xIia+zoBNIyPwjagnYZhj1fDRW/iEqCG9yxhXEsRwYI
         Ugwg==
X-Gm-Message-State: AOAM530bXAK85PfxXjizMa6QdR3uqZ/yJwvaIlcmczQlwIiLRh8SDt+Q
        Lkt6RZcZLherqUTT2JIbP54=
X-Google-Smtp-Source: ABdhPJwm5NzIiZyyDDJzX7EMmWURFlbn6tp+cx0QVoBLPJSCbM4AiMEuRdEU2G3mWdQJE9LnV7S+SQ==
X-Received: by 2002:a17:90b:1e43:: with SMTP id pi3mr563730pjb.51.1621272817037;
        Mon, 17 May 2021 10:33:37 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:47e:c24d:6c72:a52:2c8:7df1])
        by smtp.gmail.com with ESMTPSA id c12sm10358296pfr.154.2021.05.17.10.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 10:33:36 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: [PATCH v8 05/10] mfd: mt6360: Rename mt6360_pmu_data by mt6360_ddata
Date:   Tue, 18 May 2021 01:33:09 +0800
Message-Id: <20210517173314.140912-6-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517173314.140912-1-gene.chen.richtek@gmail.com>
References: <20210517173314.140912-1-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Rename mt6360_pmu_data by mt6360_ddata because of including
not only PMU part, but also entire MT6360 IC.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/mt6360-core.c  | 44 +++++++++++++++++++-------------------
 include/linux/mfd/mt6360.h |  2 +-
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index 3553c7045829..6428160ef19d 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -211,9 +211,9 @@ static const struct regmap_irq mt6360_pmu_irqs[] =  {
 
 static int mt6360_pmu_handle_post_irq(void *irq_drv_data)
 {
-	struct mt6360_pmu_data *mpd = irq_drv_data;
+	struct mt6360_ddata *ddata = irq_drv_data;
 
-	return regmap_update_bits(mpd->regmap,
+	return regmap_update_bits(ddata->regmap,
 		MT6360_PMU_IRQ_SET, MT6360_IRQ_RETRIG, MT6360_IRQ_RETRIG);
 }
 
@@ -310,61 +310,61 @@ static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] = {
 
 static int mt6360_pmu_probe(struct i2c_client *client)
 {
-	struct mt6360_pmu_data *mpd;
+	struct mt6360_ddata *ddata;
 	unsigned int reg_data;
 	int i, ret;
 
-	mpd = devm_kzalloc(&client->dev, sizeof(*mpd), GFP_KERNEL);
-	if (!mpd)
+	ddata = devm_kzalloc(&client->dev, sizeof(*ddata), GFP_KERNEL);
+	if (!ddata)
 		return -ENOMEM;
 
-	mpd->dev = &client->dev;
-	i2c_set_clientdata(client, mpd);
+	ddata->dev = &client->dev;
+	i2c_set_clientdata(client, ddata);
 
-	mpd->regmap = devm_regmap_init_i2c(client, &mt6360_pmu_regmap_config);
-	if (IS_ERR(mpd->regmap)) {
+	ddata->regmap = devm_regmap_init_i2c(client, &mt6360_pmu_regmap_config);
+	if (IS_ERR(ddata->regmap)) {
 		dev_err(&client->dev, "Failed to register regmap\n");
-		return PTR_ERR(mpd->regmap);
+		return PTR_ERR(ddata->regmap);
 	}
 
-	ret = regmap_read(mpd->regmap, MT6360_PMU_DEV_INFO, &reg_data);
+	ret = regmap_read(ddata->regmap, MT6360_PMU_DEV_INFO, &reg_data);
 	if (ret) {
 		dev_err(&client->dev, "Device not found\n");
 		return ret;
 	}
 
-	mpd->chip_rev = reg_data & CHIP_REV_MASK;
-	if (mpd->chip_rev != CHIP_VEN_MT6360) {
+	ddata->chip_rev = reg_data & CHIP_REV_MASK;
+	if (ddata->chip_rev != CHIP_VEN_MT6360) {
 		dev_err(&client->dev, "Device not supported\n");
 		return -ENODEV;
 	}
 
-	mt6360_pmu_irq_chip.irq_drv_data = mpd;
-	ret = devm_regmap_add_irq_chip(&client->dev, mpd->regmap, client->irq,
+	mt6360_pmu_irq_chip.irq_drv_data = ddata;
+	ret = devm_regmap_add_irq_chip(&client->dev, ddata->regmap, client->irq,
 				       IRQF_TRIGGER_FALLING, 0,
-				       &mt6360_pmu_irq_chip, &mpd->irq_data);
+				       &mt6360_pmu_irq_chip, &ddata->irq_data);
 	if (ret) {
 		dev_err(&client->dev, "Failed to add Regmap IRQ Chip\n");
 		return ret;
 	}
 
-	mpd->i2c[0] = client;
+	ddata->i2c[0] = client;
 	for (i = 1; i < MT6360_SLAVE_MAX; i++) {
-		mpd->i2c[i] = devm_i2c_new_dummy_device(&client->dev,
+		ddata->i2c[i] = devm_i2c_new_dummy_device(&client->dev,
 							client->adapter,
 							mt6360_slave_addr[i]);
-		if (IS_ERR(mpd->i2c[i])) {
+		if (IS_ERR(ddata->i2c[i])) {
 			dev_err(&client->dev,
 				"Failed to get new dummy I2C device for address 0x%x",
 				mt6360_slave_addr[i]);
-			return PTR_ERR(mpd->i2c[i]);
+			return PTR_ERR(ddata->i2c[i]);
 		}
-		i2c_set_clientdata(mpd->i2c[i], mpd);
+		i2c_set_clientdata(ddata->i2c[i], ddata);
 	}
 
 	ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_AUTO,
 				   mt6360_devs, ARRAY_SIZE(mt6360_devs), NULL,
-				   0, regmap_irq_get_domain(mpd->irq_data));
+				   0, regmap_irq_get_domain(ddata->irq_data));
 	if (ret) {
 		dev_err(&client->dev,
 			"Failed to register subordinate devices\n");
diff --git a/include/linux/mfd/mt6360.h b/include/linux/mfd/mt6360.h
index 72edf1352229..81bca7c2ad4d 100644
--- a/include/linux/mfd/mt6360.h
+++ b/include/linux/mfd/mt6360.h
@@ -21,7 +21,7 @@ enum {
 #define MT6360_LDO_SLAVEID	0x64
 #define MT6360_TCPC_SLAVEID	0x4E
 
-struct mt6360_pmu_data {
+struct mt6360_ddata {
 	struct i2c_client *i2c[MT6360_SLAVE_MAX];
 	struct device *dev;
 	struct regmap *regmap;
-- 
2.25.1

