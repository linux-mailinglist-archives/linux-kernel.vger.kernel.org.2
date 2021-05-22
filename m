Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF54C38D5DC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 14:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhEVMo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 08:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbhEVMo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 08:44:27 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B0EC061574
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 05:43:01 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id u7so3787036plq.4
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 05:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pixYQfkTFmONXDkh4NYVdpiElfn+YnUC5KBlg4AmP5s=;
        b=rYuISGJlX3D8QBAh7xjO1blyJUVi7nmlps7NSo2xFGEKCHRmZQmqIN5nJLK+3/Bf1B
         pxgClNznsKKQkbdkqK5rKMRoPFtWet1PEEQ5Lsa3K0oqBWYHqIsjAynXhXSwoUcPxyl1
         3RFTVRsrWu3UONF/arltSg1cIsMrIKnW3/Z3mkvLtpIRtOYNXugkz0p/3mpWwdylarXM
         1bL4rwqE7RFES2areprLOd4h/Lu56IFxXHZaQ19b2/0+nicBOQhCkITdD3G+YsGXcNbX
         B6pZXPNoNTtGbuMKPOsG+c4rbUHWVkKdH3yNxcYUNMeTbYJaiwartQYCvaqs5/k9fqCg
         +/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pixYQfkTFmONXDkh4NYVdpiElfn+YnUC5KBlg4AmP5s=;
        b=F+8XLsTseBtEn1b0Q0Ku6CDWgQleCjN2m70guw8picK/+rVLuzbUrum9yK1EgzZpvc
         vx14+JHmrCOJixYDK1ttKbrM3KbeEl050G3y8tvziy5INm4fsLYhF/RKJFuUeDyFncY5
         mkaQ9gjHfOKBvSQ1edqFxPm1byhdcaz1EDnHWuKxCJurhc+LdqMZBBXbcCXYG+6f1yR7
         GAnrNDbSUzWKaXExP3+viAWqAWk+X1EvyGtW8xrlMQCyOK7EfgEk0H6QpWc+mEfpL7QY
         XQ4HxwDFU4/uxyS0Uelv6Kv2SKDYeciox1vPSsIwhnMOKe28rIW/c4l2J8cVI8LYsISS
         xndA==
X-Gm-Message-State: AOAM5320xLunqDMhxBrwxshN8v6FiMY+HuiHxUcuOAsTQau0uA6q5sN7
        iw6qy6yc7toUnbMA5BkN9iKA9g==
X-Google-Smtp-Source: ABdhPJwlXIBSuVnqU12oC3T2pit6qeRrBtpmbjEyXkihLgulGu2EuvMKWD9HbYiLpP8lbcxQ29K9Xg==
X-Received: by 2002:a17:902:8ecc:b029:ef:6471:dc08 with SMTP id x12-20020a1709028eccb02900ef6471dc08mr16820524plo.5.1621687380762;
        Sat, 22 May 2021 05:43:00 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id v11sm7047706pgs.6.2021.05.22.05.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 05:43:00 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: bd70528: Convert to use regulator_set_ramp_delay_regmap
Date:   Sat, 22 May 2021 20:42:50 +0800
Message-Id: <20210522124250.2121076-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regulator_set_ramp_delay_regmap instead of open-coded.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/bd70528-regulator.c | 37 ++++++++++++---------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/regulator/bd70528-regulator.c b/drivers/regulator/bd70528-regulator.c
index 1f5f9482b209..e6fec70fabfa 100644
--- a/drivers/regulator/bd70528-regulator.c
+++ b/drivers/regulator/bd70528-regulator.c
@@ -16,10 +16,6 @@
 #include <linux/regulator/of_regulator.h>
 #include <linux/slab.h>
 
-#define BUCK_RAMPRATE_250MV 0
-#define BUCK_RAMPRATE_125MV 1
-#define BUCK_RAMP_MAX 250
-
 static const struct linear_range bd70528_buck1_volts[] = {
 	REGULATOR_LINEAR_RANGE(1200000, 0x00, 0x1, 600000),
 	REGULATOR_LINEAR_RANGE(2750000, 0x2, 0xf, 50000),
@@ -47,22 +43,9 @@ static const unsigned int led_volts[] = {
 	20000, 30000
 };
 
-static int bd70528_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
-{
-	if (ramp_delay > 0 && ramp_delay <= BUCK_RAMP_MAX) {
-		unsigned int ramp_value = BUCK_RAMPRATE_250MV;
-
-		if (ramp_delay <= 125)
-			ramp_value = BUCK_RAMPRATE_125MV;
-
-		return regmap_update_bits(rdev->regmap, rdev->desc->vsel_reg,
-				  BD70528_MASK_BUCK_RAMP,
-				  ramp_value << BD70528_SIFT_BUCK_RAMP);
-	}
-	dev_err(&rdev->dev, "%s: ramp_delay: %d not supported\n",
-		rdev->desc->name, ramp_delay);
-	return -EINVAL;
-}
+static const unsigned int bd70528_buck_ramp_table[] = {
+	250, 125
+};
 
 static int bd70528_led_set_voltage_sel(struct regulator_dev *rdev,
 				       unsigned int sel)
@@ -90,7 +73,7 @@ static const struct regulator_ops bd70528_buck_ops = {
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.set_voltage_time_sel = regulator_set_voltage_time_sel,
-	.set_ramp_delay = bd70528_set_ramp_delay,
+	.set_ramp_delay = regulator_set_ramp_delay_regmap,
 };
 
 static const struct regulator_ops bd70528_ldo_ops = {
@@ -127,6 +110,10 @@ static const struct regulator_desc bd70528_desc[] = {
 		.enable_mask = BD70528_MASK_RUN_EN,
 		.vsel_reg = BD70528_REG_BUCK1_VOLT,
 		.vsel_mask = BD70528_MASK_BUCK_VOLT,
+		.ramp_reg = BD70528_REG_BUCK1_VOLT,
+		.ramp_mask = BD70528_MASK_BUCK_RAMP,
+		.ramp_delay_table = bd70528_buck_ramp_table,
+		.n_ramp_values = ARRAY_SIZE(bd70528_buck_ramp_table),
 		.owner = THIS_MODULE,
 	},
 	{
@@ -143,6 +130,10 @@ static const struct regulator_desc bd70528_desc[] = {
 		.enable_mask = BD70528_MASK_RUN_EN,
 		.vsel_reg = BD70528_REG_BUCK2_VOLT,
 		.vsel_mask = BD70528_MASK_BUCK_VOLT,
+		.ramp_reg = BD70528_REG_BUCK2_VOLT,
+		.ramp_mask = BD70528_MASK_BUCK_RAMP,
+		.ramp_delay_table = bd70528_buck_ramp_table,
+		.n_ramp_values = ARRAY_SIZE(bd70528_buck_ramp_table),
 		.owner = THIS_MODULE,
 	},
 	{
@@ -159,6 +150,10 @@ static const struct regulator_desc bd70528_desc[] = {
 		.enable_mask = BD70528_MASK_RUN_EN,
 		.vsel_reg = BD70528_REG_BUCK3_VOLT,
 		.vsel_mask = BD70528_MASK_BUCK_VOLT,
+		.ramp_reg = BD70528_REG_BUCK3_VOLT,
+		.ramp_mask = BD70528_MASK_BUCK_RAMP,
+		.ramp_delay_table = bd70528_buck_ramp_table,
+		.n_ramp_values = ARRAY_SIZE(bd70528_buck_ramp_table),
 		.owner = THIS_MODULE,
 	},
 	{
-- 
2.25.1

