Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7F538D96E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 09:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhEWHY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 03:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbhEWHY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 03:24:57 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E44C061574
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 00:23:31 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id c12so6655897pfl.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 00:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PkG8jNHTi3JD0XNYKIhVDuwA7YpjcQW9imdEIIiDPZQ=;
        b=yHHcRZvoDtdX4c9xsIOfoLmt6NISTY4jTc30lGwYMeI6VTe+KLjXh6zaYPBH/9tmMu
         XGicohbExl/SSAnbCQf2Rm9fu4kPOneXw6re0jdjb/dzhW3dztMQgYwCw4DDBs4aAcPI
         xJJT9Bi2lo5wMq6RCNdKMMTbmlwVIwnqTHRrR5a6cq02o2iYTyeaGMNP2aIH4uBdc/m4
         rnk5IDbp79aHlSXXjNvKMkMcIySZQ8R4+1BNoqgqpQ9C1CAu7DQGSWkbMIcJZJrI2ZXX
         zOVaJlWsqD7QloNruSOZuIvuq+a3D80+eP4Gkzu953Z04AMp1Ln/SVi8ATeomPw79g0L
         K1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PkG8jNHTi3JD0XNYKIhVDuwA7YpjcQW9imdEIIiDPZQ=;
        b=H53nltTZRMA9/oRLjAQi6QOU72YU6yHCdiNRzxJvkepk2ol2yuXThIUOF2E04h0LsX
         c1hhPqRa5VrHCrSz3vJLDcxx00H5Sp7zM5g9PZgsQN18cSU1Bc0b98suQgdaUoOEqXa8
         JBfYJ3LNBCRB82v+/rcHoG3CPkV97Jsefz2viZLU7bbBce3u8EuGI3qY5yv9djN2OvHm
         ORJqCN29jyT1XcL43AQkycWAYArZgmCCo3xSQgitv7F5ZSo+a5YHhkMjau/NeCu2N4E0
         C2odBu7+jeBhLK2udSU6gz/t+TylKYVo7xZPotW2Edsn3Uic/UgC9D7buoPjbCT24w+6
         zeiA==
X-Gm-Message-State: AOAM533i1vmMogpw0r/Uj2TOIG4ZAvFJq8gHQZmOcrvcv4TSUwE3juMv
        u1QDDhYI5TpLchTEZhP/jhxGpQ==
X-Google-Smtp-Source: ABdhPJzuvMy5gZai1RZN2UKI/jCgm5GHF1zsKHhageAHjNWNmi814Jumeiilp1fdxjN5oJsz5lkaKA==
X-Received: by 2002:a63:1e4f:: with SMTP id p15mr7585742pgm.40.1621754611459;
        Sun, 23 May 2021 00:23:31 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id u1sm8719861pgh.80.2021.05.23.00.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 00:23:31 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Javier Martinez Canillas <javier@dowhile0.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: max77802: Convert to use regulator_set_ramp_delay_regmap
Date:   Sun, 23 May 2021 15:23:20 +0800
Message-Id: <20210523072320.2174443-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210523072320.2174443-1-axel.lin@ingics.com>
References: <20210523072320.2174443-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regulator_set_ramp_delay_regmap instead of open-coded.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/max77802-regulator.c | 69 +++++---------------------
 1 file changed, 12 insertions(+), 57 deletions(-)

diff --git a/drivers/regulator/max77802-regulator.c b/drivers/regulator/max77802-regulator.c
index 903c6fc10efb..21e0eb0f43f9 100644
--- a/drivers/regulator/max77802-regulator.c
+++ b/drivers/regulator/max77802-regulator.c
@@ -43,15 +43,14 @@
 #define MAX77802_OFF_PWRREQ		0x1
 #define MAX77802_LP_PWRREQ		0x2
 
-/* MAX77802 has two register formats: 2-bit and 4-bit */
-static const unsigned int ramp_table_77802_2bit[] = {
+static const unsigned int max77802_buck234_ramp_table[] = {
 	12500,
 	25000,
 	50000,
 	100000,
 };
 
-static unsigned int ramp_table_77802_4bit[] = {
+static const unsigned int max77802_buck16_ramp_table[] = {
 	1000,	2000,	3030,	4000,
 	5000,	5880,	7140,	8330,
 	9090,	10000,	11110,	12500,
@@ -221,58 +220,6 @@ static int max77802_enable(struct regulator_dev *rdev)
 				  max77802->opmode[id] << shift);
 }
 
-static int max77802_find_ramp_value(struct regulator_dev *rdev,
-				    const unsigned int limits[], int size,
-				    unsigned int ramp_delay)
-{
-	int i;
-
-	for (i = 0; i < size; i++) {
-		if (ramp_delay <= limits[i])
-			return i;
-	}
-
-	/* Use maximum value for no ramp control */
-	dev_warn(&rdev->dev, "%s: ramp_delay: %d not supported, setting 100000\n",
-		 rdev->desc->name, ramp_delay);
-	return size - 1;
-}
-
-/* Used for BUCKs 2-4 */
-static int max77802_set_ramp_delay_2bit(struct regulator_dev *rdev,
-					int ramp_delay)
-{
-	int id = rdev_get_id(rdev);
-	unsigned int ramp_value;
-
-	if (id > MAX77802_BUCK4) {
-		dev_warn(&rdev->dev,
-			 "%s: regulator: ramp delay not supported\n",
-			 rdev->desc->name);
-		return -EINVAL;
-	}
-	ramp_value = max77802_find_ramp_value(rdev, ramp_table_77802_2bit,
-				ARRAY_SIZE(ramp_table_77802_2bit), ramp_delay);
-
-	return regmap_update_bits(rdev->regmap, rdev->desc->enable_reg,
-				  MAX77802_RAMP_RATE_MASK_2BIT,
-				  ramp_value << MAX77802_RAMP_RATE_SHIFT_2BIT);
-}
-
-/* For BUCK1, 6 */
-static int max77802_set_ramp_delay_4bit(struct regulator_dev *rdev,
-					    int ramp_delay)
-{
-	unsigned int ramp_value;
-
-	ramp_value = max77802_find_ramp_value(rdev, ramp_table_77802_4bit,
-				ARRAY_SIZE(ramp_table_77802_4bit), ramp_delay);
-
-	return regmap_update_bits(rdev->regmap, rdev->desc->enable_reg,
-				  MAX77802_RAMP_RATE_MASK_4BIT,
-				  ramp_value << MAX77802_RAMP_RATE_SHIFT_4BIT);
-}
-
 /*
  * LDOs 2, 4-19, 22-35
  */
@@ -316,7 +263,7 @@ static const struct regulator_ops max77802_buck_16_dvs_ops = {
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
-	.set_ramp_delay		= max77802_set_ramp_delay_4bit,
+	.set_ramp_delay		= regulator_set_ramp_delay_regmap,
 	.set_suspend_disable	= max77802_set_suspend_disable,
 };
 
@@ -330,7 +277,7 @@ static const struct regulator_ops max77802_buck_234_ops = {
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
-	.set_ramp_delay		= max77802_set_ramp_delay_2bit,
+	.set_ramp_delay		= regulator_set_ramp_delay_regmap,
 	.set_suspend_disable	= max77802_set_suspend_disable,
 	.set_suspend_mode	= max77802_set_suspend_mode,
 };
@@ -408,6 +355,10 @@ static const struct regulator_ops max77802_buck_dvs_ops = {
 	.vsel_mask	= MAX77802_DVS_VSEL_MASK,			\
 	.enable_reg	= MAX77802_REG_BUCK ## num ## CTRL,		\
 	.enable_mask	= MAX77802_OPMODE_MASK,				\
+	.ramp_reg	= MAX77802_REG_BUCK ## num ## CTRL,		\
+	.ramp_mask	= MAX77802_RAMP_RATE_MASK_4BIT,			\
+	.ramp_delay_table = max77802_buck16_ramp_table,			\
+	.n_ramp_values	= ARRAY_SIZE(max77802_buck16_ramp_table),	\
 	.of_map_mode	= max77802_map_mode,				\
 }
 
@@ -430,6 +381,10 @@ static const struct regulator_ops max77802_buck_dvs_ops = {
 	.enable_reg	= MAX77802_REG_BUCK ## num ## CTRL1,		\
 	.enable_mask	= MAX77802_OPMODE_MASK <<			\
 				MAX77802_OPMODE_BUCK234_SHIFT,		\
+	.ramp_reg	= MAX77802_REG_BUCK ## num ## CTRL1,		\
+	.ramp_mask	= MAX77802_RAMP_RATE_MASK_2BIT,			\
+	.ramp_delay_table = max77802_buck234_ramp_table,		\
+	.n_ramp_values	= ARRAY_SIZE(max77802_buck234_ramp_table),	\
 	.of_map_mode	= max77802_map_mode,				\
 }
 
-- 
2.25.1

