Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7427339174A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 14:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbhEZMZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 08:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbhEZMZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 08:25:54 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9037C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 05:24:22 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 27so811543pgy.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 05:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w6JvTWcJZBiNlO2U6Ww7l1gVebqbAfDRWlLBunBhvFk=;
        b=wx7Xf2z46xyr7Mt734BDqVOBzZ8Uq0suK8l+8xO+k8jNKMbDdUthihfL5sfq1q1DNS
         tZW18WvB9TN78wUWOiv0ZnFtPfz0pLYEp5XaK1eKwXbiKAQo4vWIcibB7yrK48vwcxFE
         IfFzlugQ3y10SipxTB6MO0a1HUiLqRNV/Yjg/WLmZ6ecTX+4YaXXH2rEf5+fy1fQLRuW
         U0hxfN95xJ/JzHXdYAY0wbVSsVzZS+AjhONCbR3DswJRY0AZ1U6X8VwZQkdej1eeB2Or
         eZEv4/xPJhB++SEqCc8wcVorWQJV8uJ4NFur/A+Um8fdcIWRBosEP2AYhC0NarZ8YAhE
         17hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w6JvTWcJZBiNlO2U6Ww7l1gVebqbAfDRWlLBunBhvFk=;
        b=n49ix7VlG4CyY8k+8LHG2gdvgGv6adz1fwb4K2Mjeavn/q9qHuB//aiLrqCmz5YOvr
         M6xJbVXqS0L6vvShbWQameO66JS8aPyftLWX6q6kqnV6RkhSaRQ9ref32T88qYF3RIQN
         YPZpgPfhzhs5OSSAzFx+UXMEAhd94U8xAtEDj6m7l7U1wPm7v9+lGO1F08Oab+G1cZ4R
         Fx7tyIagrQWN9S5X1iiH6pyR5mv/3gL1N5ErU49g7D07Cwa3DaF9Yfh2LqCcau3xzjfJ
         Tzuxjcc6de9AVQvThaUzlKQBTHFL4jjUBCXi4pHd9IzxqdJvxjxfo+zt3n70oUhLPbWj
         mSNQ==
X-Gm-Message-State: AOAM53378KxnMIccHbqVID+YNl/y6kMumQAIdhEHqYZ1Pa59+hMLO3B0
        X6/gzs+JfNeBEkjCmyqezoMJcw==
X-Google-Smtp-Source: ABdhPJxOD8TueBZvcBdyDrNjGeg271wLH3/gAMlsNoNr2sxEOUig+8iN8KfL1YcsM6R5MXJhmPp5+w==
X-Received: by 2002:aa7:91d4:0:b029:2c5:7d17:c20c with SMTP id z20-20020aa791d40000b02902c57d17c20cmr35493755pfa.4.1622031862351;
        Wed, 26 May 2021 05:24:22 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id 205sm15825043pfc.201.2021.05.26.05.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 05:24:21 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Robin Gong <yibin.gong@nxp.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: pca9450: Convert to use regulator_set_ramp_delay_regmap
Date:   Wed, 26 May 2021 20:24:08 +0800
Message-Id: <20210526122408.78156-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regulator_set_ramp_delay_regmap instead of open-coded.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/pca9450-regulator.c | 51 +++++++++++++--------------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index 2f7ee212cb8c..64e5f5f0cc84 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -65,32 +65,9 @@ static const struct regmap_config pca9450_regmap_config = {
  * 10: 25mV/4usec
  * 11: 25mV/8usec
  */
-static int pca9450_dvs_set_ramp_delay(struct regulator_dev *rdev,
-				      int ramp_delay)
-{
-	int id = rdev_get_id(rdev);
-	unsigned int ramp_value;
-
-	switch (ramp_delay) {
-	case 1 ... 3125:
-		ramp_value = BUCK1_RAMP_3P125MV;
-		break;
-	case 3126 ... 6250:
-		ramp_value = BUCK1_RAMP_6P25MV;
-		break;
-	case 6251 ... 12500:
-		ramp_value = BUCK1_RAMP_12P5MV;
-		break;
-	case 12501 ... 25000:
-		ramp_value = BUCK1_RAMP_25MV;
-		break;
-	default:
-		ramp_value = BUCK1_RAMP_25MV;
-	}
-
-	return regmap_update_bits(rdev->regmap, PCA9450_REG_BUCK1CTRL + id * 3,
-				  BUCK1_RAMP_MASK, ramp_value << 6);
-}
+static const unsigned int pca9450_dvs_buck_ramp_table[] = {
+	25000, 12500, 6250, 3125
+};
 
 static const struct regulator_ops pca9450_dvs_buck_regulator_ops = {
 	.enable = regulator_enable_regmap,
@@ -100,7 +77,7 @@ static const struct regulator_ops pca9450_dvs_buck_regulator_ops = {
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.set_voltage_time_sel = regulator_set_voltage_time_sel,
-	.set_ramp_delay = pca9450_dvs_set_ramp_delay,
+	.set_ramp_delay	= regulator_set_ramp_delay_regmap,
 };
 
 static const struct regulator_ops pca9450_buck_regulator_ops = {
@@ -251,6 +228,10 @@ static const struct pca9450_regulator_desc pca9450a_regulators[] = {
 			.vsel_mask = BUCK1OUT_DVS0_MASK,
 			.enable_reg = PCA9450_REG_BUCK1CTRL,
 			.enable_mask = BUCK1_ENMODE_MASK,
+			.ramp_reg = PCA9450_REG_BUCK1CTRL,
+			.ramp_mask = BUCK1_RAMP_MASK,
+			.ramp_delay_table = pca9450_dvs_buck_ramp_table,
+			.n_ramp_values = ARRAY_SIZE(pca9450_dvs_buck_ramp_table),
 			.owner = THIS_MODULE,
 			.of_parse_cb = pca9450_set_dvs_levels,
 		},
@@ -276,6 +257,10 @@ static const struct pca9450_regulator_desc pca9450a_regulators[] = {
 			.vsel_mask = BUCK2OUT_DVS0_MASK,
 			.enable_reg = PCA9450_REG_BUCK2CTRL,
 			.enable_mask = BUCK1_ENMODE_MASK,
+			.ramp_reg = PCA9450_REG_BUCK2CTRL,
+			.ramp_mask = BUCK2_RAMP_MASK,
+			.ramp_delay_table = pca9450_dvs_buck_ramp_table,
+			.n_ramp_values = ARRAY_SIZE(pca9450_dvs_buck_ramp_table),
 			.owner = THIS_MODULE,
 			.of_parse_cb = pca9450_set_dvs_levels,
 		},
@@ -301,6 +286,10 @@ static const struct pca9450_regulator_desc pca9450a_regulators[] = {
 			.vsel_mask = BUCK3OUT_DVS0_MASK,
 			.enable_reg = PCA9450_REG_BUCK3CTRL,
 			.enable_mask = BUCK3_ENMODE_MASK,
+			.ramp_reg = PCA9450_REG_BUCK3CTRL,
+			.ramp_mask = BUCK3_RAMP_MASK,
+			.ramp_delay_table = pca9450_dvs_buck_ramp_table,
+			.n_ramp_values = ARRAY_SIZE(pca9450_dvs_buck_ramp_table),
 			.owner = THIS_MODULE,
 			.of_parse_cb = pca9450_set_dvs_levels,
 		},
@@ -477,6 +466,10 @@ static const struct pca9450_regulator_desc pca9450bc_regulators[] = {
 			.vsel_mask = BUCK1OUT_DVS0_MASK,
 			.enable_reg = PCA9450_REG_BUCK1CTRL,
 			.enable_mask = BUCK1_ENMODE_MASK,
+			.ramp_reg = PCA9450_REG_BUCK1CTRL,
+			.ramp_mask = BUCK1_RAMP_MASK,
+			.ramp_delay_table = pca9450_dvs_buck_ramp_table,
+			.n_ramp_values = ARRAY_SIZE(pca9450_dvs_buck_ramp_table),
 			.owner = THIS_MODULE,
 			.of_parse_cb = pca9450_set_dvs_levels,
 		},
@@ -502,6 +495,10 @@ static const struct pca9450_regulator_desc pca9450bc_regulators[] = {
 			.vsel_mask = BUCK2OUT_DVS0_MASK,
 			.enable_reg = PCA9450_REG_BUCK2CTRL,
 			.enable_mask = BUCK1_ENMODE_MASK,
+			.ramp_reg = PCA9450_REG_BUCK2CTRL,
+			.ramp_mask = BUCK2_RAMP_MASK,
+			.ramp_delay_table = pca9450_dvs_buck_ramp_table,
+			.n_ramp_values = ARRAY_SIZE(pca9450_dvs_buck_ramp_table),
 			.owner = THIS_MODULE,
 			.of_parse_cb = pca9450_set_dvs_levels,
 		},
-- 
2.25.1

