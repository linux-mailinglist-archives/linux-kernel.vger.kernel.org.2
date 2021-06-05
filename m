Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBBB539C4D6
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 03:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbhFEBhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 21:37:47 -0400
Received: from mail-pj1-f45.google.com ([209.85.216.45]:52184 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbhFEBho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 21:37:44 -0400
Received: by mail-pj1-f45.google.com with SMTP id k5so6493927pjj.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 18:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A3XSuDu4v1KEuY5o0SochRu1cjFBvY2Wo/dlIAkzijI=;
        b=VIB2byNFAqkbOQiCdMaKGpEH4a0ft11NABouhC9HVb3m/UtN29NNLiUpk8/jPasiUd
         mMbInLsocdTtMoqKIA5Wa9qdookKA+q8S4aHVLdlzfIUd60p8TFJXeMnAKm0srsC4y4o
         KgxtaAtOFk9TKeyiPRHY0s6bv4+SAMj9BdOwTqSHiznxFvWOOK6r86u+MqSN9jf39Q1N
         cbr5TE5EV+gxyQNOQxlmI4PAuWABcM5rXwIwpcgdoY8kHLeB/+hLqRr6kWJW2qh+dGk8
         9nUp3vtanjkpwByrV6t4SULdZewv8DeU8pI40pPJ81aDIZAoDkS/UY3qtkYaDE5VbU4k
         K2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A3XSuDu4v1KEuY5o0SochRu1cjFBvY2Wo/dlIAkzijI=;
        b=PBeHK7iYmC4MFgInj/jgYlrGu0GHZMt+lmf9Y6vxu/TE+kduBUoHpPWP7HlIzqJFC+
         5815JLUsDdSYMab0MK0ypTMNZVqUVSVdw7J5+071n8f+HiplnqE2aS0ykVi1YPUoHnpT
         CqhFzH4F4kZpRg3kGrB+akh4eW5npZ8rWH97YX6A7zQuef5T8+eX6r1tPo/QSVKGYdL4
         mfKiIFJdPit7FbzuQhZP5p3ZH9XlS0c4WiPN8jrfaGvVBqVJU+ak+2VzQxOnYViHxuO/
         cE0FB/NZnfchI/aXlM73m+r38JPBOOgd59+r1stcqzjTikPn23M0zgHKcrxS7sQPmJKr
         6WvQ==
X-Gm-Message-State: AOAM533w9c+nMeGOJk68bGt1FDK/Hgyz8m9+NZfEqW2xlxF/Iyc7Peck
        x9QdBhpep0tJTUeQfB4zlUaEXw==
X-Google-Smtp-Source: ABdhPJxQ/qVDLZ4OpTiCofa+NctxxAKDR2enjz3XOiyXy4LJ6p2eoxNjIQvPWQ/AWbCfOqQRFQDrJw==
X-Received: by 2002:a17:903:185:b029:fe:cd9a:a6b1 with SMTP id z5-20020a1709030185b02900fecd9aa6b1mr6957057plg.49.1622856883872;
        Fri, 04 Jun 2021 18:34:43 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id a4sm5419883pjw.46.2021.06.04.18.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 18:34:43 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: max77686: Convert to use regulator_set_ramp_delay_regmap
Date:   Sat,  5 Jun 2021 09:34:24 +0800
Message-Id: <20210605013424.1298773-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regulator_set_ramp_delay_regmap instead of open-coded.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/max77686-regulator.c | 42 ++++++--------------------
 1 file changed, 9 insertions(+), 33 deletions(-)

diff --git a/drivers/regulator/max77686-regulator.c b/drivers/regulator/max77686-regulator.c
index 9089ec608fcc..55a07d3f3ee2 100644
--- a/drivers/regulator/max77686-regulator.c
+++ b/drivers/regulator/max77686-regulator.c
@@ -67,13 +67,6 @@
 #define MAX77686_REGULATORS	MAX77686_REG_MAX
 #define MAX77686_LDOS		26
 
-enum max77686_ramp_rate {
-	RAMP_RATE_13P75MV,
-	RAMP_RATE_27P5MV,
-	RAMP_RATE_55MV,
-	RAMP_RATE_NO_CTRL,	/* 100mV/us */
-};
-
 struct max77686_data {
 	struct device *dev;
 	DECLARE_BITMAP(gpio_enabled, MAX77686_REGULATORS);
@@ -220,31 +213,6 @@ static int max77686_enable(struct regulator_dev *rdev)
 				  max77686->opmode[id] << shift);
 }
 
-static int max77686_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
-{
-	unsigned int ramp_value = RAMP_RATE_NO_CTRL;
-
-	switch (ramp_delay) {
-	case 1 ... 13750:
-		ramp_value = RAMP_RATE_13P75MV;
-		break;
-	case 13751 ... 27500:
-		ramp_value = RAMP_RATE_27P5MV;
-		break;
-	case 27501 ... 55000:
-		ramp_value = RAMP_RATE_55MV;
-		break;
-	case 55001 ... 100000:
-		break;
-	default:
-		pr_warn("%s: ramp_delay: %d not supported, setting 100000\n",
-			rdev->desc->name, ramp_delay);
-	}
-
-	return regmap_update_bits(rdev->regmap, rdev->desc->enable_reg,
-				  MAX77686_RAMP_RATE_MASK, ramp_value << 6);
-}
-
 static int max77686_of_parse_cb(struct device_node *np,
 		const struct regulator_desc *desc,
 		struct regulator_config *config)
@@ -284,6 +252,10 @@ static int max77686_of_parse_cb(struct device_node *np,
 	return 0;
 }
 
+static const unsigned int max77686_buck_dvs_ramp_table[] = {
+	13750, 27500, 55000, 100000
+};
+
 static const struct regulator_ops max77686_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
@@ -330,7 +302,7 @@ static const struct regulator_ops max77686_buck_dvs_ops = {
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
-	.set_ramp_delay		= max77686_set_ramp_delay,
+	.set_ramp_delay		= regulator_set_ramp_delay_regmap,
 	.set_suspend_disable	= max77686_set_suspend_disable,
 };
 
@@ -462,6 +434,10 @@ static const struct regulator_ops max77686_buck_dvs_ops = {
 	.enable_reg	= MAX77686_REG_BUCK2CTRL1 + (num - 2) * 10,	\
 	.enable_mask	= MAX77686_OPMODE_MASK				\
 			<< MAX77686_OPMODE_BUCK234_SHIFT,		\
+	.ramp_reg	= MAX77686_REG_BUCK2CTRL1 + (num - 2) * 10,	\
+	.ramp_mask	= MAX77686_RAMP_RATE_MASK,			\
+	.ramp_delay_table = max77686_buck_dvs_ramp_table,		\
+	.n_ramp_values	= ARRAY_SIZE(max77686_buck_dvs_ramp_table),	\
 }
 
 static const struct regulator_desc regulators[] = {
-- 
2.25.1

