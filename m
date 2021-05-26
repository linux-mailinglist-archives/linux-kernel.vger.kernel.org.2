Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380E239180D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 14:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbhEZMzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 08:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234310AbhEZMxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 08:53:12 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8A0C061343
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 05:50:38 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id t21so570143plo.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 05:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RZAUyCB17UTlwinH/Z1IvFK6BSvyENUyST8rB/rw5L0=;
        b=tzRUvZYKpleCpqth7CIG6+TXFQFNYz77WLWpWT4KXJX3cyR1onHnD4pEBnWA/XdICp
         BJTyJ/Z8uJxkoHnSsgdqhqtwp0lu063CHYT24a4WCmnRFXKKtBKCgRW9Dvu57rLCZGVs
         73EPWNWFJGW1joSuVxvFtp6Eo0+Z1DA9VfpyPGS8yRKbQ8wOAZk8z7cWvHtOQk0W0TGA
         p6KGKoRe0gunPmeFMM9Rwp60KWuyqjeosF8NJka9dflOx7+qvYEsAopwTE2XJ9ivF5/i
         4WX073Z3hn5nAA6IauFc2RMXlYVfIK+nOU6nwYF2/zOqGWrc0CtLmJuiTyWWv3SnFKju
         3Wqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RZAUyCB17UTlwinH/Z1IvFK6BSvyENUyST8rB/rw5L0=;
        b=FgV98xRbajDTSTGaEdbKH3opnc0O2Z8lKl5RUBSTqqdT4u1LZdMD/Nfu38M72s5e/y
         vvGWK0//O/1BBfuKK5AXMa51lclECbo9sSHMjV+u2sIYIIJiLee/0eNKed1VG6TMWuIN
         x/gJjiYVb/jndRDBQbVAXZvmrBaQw72rEU0zr0MPusDgar+bcNI+75sYx/KV5VQNVofH
         yI6VrlMisp2Rohc1QVm0somIOjuHui8aaHYyecMg6I8wLlh5lVgkapBo8wcMNZLqdELV
         FmEu9UzyCf/2indHb2PQnKKSiuZPHTLNNwub6ONRy1sfTzZhRMSbCNIcFORp82276Nlx
         Gjeg==
X-Gm-Message-State: AOAM532o4Hhv2vKiJUngpBcBliWKf27rcOYj9dSDHBKeN7vuISIzfbhE
        Rn4MVl2Tsr8GMZ3EySt6MRbCFQ==
X-Google-Smtp-Source: ABdhPJwQz0n4RY28+tFLH4DdieO1woh3XJMQwTC34AVaFv08NVdinafneNOx7lwHWGjwU4dkofLUBg==
X-Received: by 2002:a17:90b:10d:: with SMTP id p13mr3638845pjz.131.1622033437243;
        Wed, 26 May 2021 05:50:37 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id m1sm16579659pfb.14.2021.05.26.05.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 05:50:36 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     "Andrei . Stefanescu @ microchip . com" 
        <Andrei.Stefanescu@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: mcp16502: Convert to use regulator_set_ramp_delay_regmap
Date:   Wed, 26 May 2021 20:50:26 +0800
Message-Id: <20210526125026.82549-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210526125026.82549-1-axel.lin@ingics.com>
References: <20210526125026.82549-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regulator_set_ramp_delay_regmap instead of open-coded.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/mcp16502.c | 74 +++++++++++++-----------------------
 1 file changed, 26 insertions(+), 48 deletions(-)

diff --git a/drivers/regulator/mcp16502.c b/drivers/regulator/mcp16502.c
index ac1b129e33d9..042668385678 100644
--- a/drivers/regulator/mcp16502.c
+++ b/drivers/regulator/mcp16502.c
@@ -90,10 +90,14 @@ enum mcp16502_reg {
 };
 
 /* Ramp delay (uV/us) for buck1, ldo1, ldo2. */
-static const int mcp16502_ramp_b1l12[] = { 6250, 3125, 2083, 1563 };
+static const unsigned int mcp16502_ramp_b1l12[] = {
+	6250, 3125, 2083, 1563
+};
 
 /* Ramp delay (uV/us) for buck2, buck3, buck4. */
-static const int mcp16502_ramp_b234[] = { 3125, 1563, 1042, 781 };
+static const unsigned int mcp16502_ramp_b234[] = {
+	3125, 1563, 1042, 781
+};
 
 static unsigned int mcp16502_of_map_mode(unsigned int mode)
 {
@@ -103,7 +107,7 @@ static unsigned int mcp16502_of_map_mode(unsigned int mode)
 	return REGULATOR_MODE_INVALID;
 }
 
-#define MCP16502_REGULATOR(_name, _id, _ranges, _ops)			\
+#define MCP16502_REGULATOR(_name, _id, _ranges, _ops, _ramp_table)	\
 	[_id] = {							\
 		.name			= _name,			\
 		.regulators_node	= of_match_ptr("regulators"),	\
@@ -121,6 +125,10 @@ static unsigned int mcp16502_of_map_mode(unsigned int mode)
 		.vsel_mask		= MCP16502_VSEL,		\
 		.enable_reg		= (((_id) + 1) << 4),		\
 		.enable_mask		= MCP16502_EN,			\
+		.ramp_reg		= MCP16502_REG_BASE(_id, CFG),	\
+		.ramp_mask		= MCP16502_DVSR,		\
+		.ramp_delay_table	= _ramp_table,			\
+		.n_ramp_values		= ARRAY_SIZE(_ramp_table),	\
 	}
 
 enum {
@@ -314,42 +322,6 @@ static int mcp16502_set_voltage_time_sel(struct regulator_dev *rdev,
 	return ret;
 }
 
-static int mcp16502_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
-{
-	const int *ramp;
-	int id = rdev_get_id(rdev);
-	unsigned int i, size;
-
-	switch (id) {
-	case BUCK1:
-	case LDO1:
-	case LDO2:
-		ramp = mcp16502_ramp_b1l12;
-		size = ARRAY_SIZE(mcp16502_ramp_b1l12);
-		break;
-
-	case BUCK2:
-	case BUCK3:
-	case BUCK4:
-		ramp = mcp16502_ramp_b234;
-		size = ARRAY_SIZE(mcp16502_ramp_b234);
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
-	for (i = 0; i < size; i++) {
-		if (ramp[i] == ramp_delay)
-			break;
-	}
-	if (i == size)
-		return -EINVAL;
-
-	return regmap_update_bits(rdev->regmap, MCP16502_REG_BASE(id, CFG),
-				  MCP16502_DVSR, (i << 2));
-}
-
 #ifdef CONFIG_SUSPEND
 /*
  * mcp16502_suspend_get_target_reg() - get the reg of the target suspend PMIC
@@ -445,7 +417,7 @@ static const struct regulator_ops mcp16502_buck_ops = {
 	.is_enabled			= regulator_is_enabled_regmap,
 	.get_status			= mcp16502_get_status,
 	.set_voltage_time_sel		= mcp16502_set_voltage_time_sel,
-	.set_ramp_delay			= mcp16502_set_ramp_delay,
+	.set_ramp_delay			= regulator_set_ramp_delay_regmap,
 
 	.set_mode			= mcp16502_set_mode,
 	.get_mode			= mcp16502_get_mode,
@@ -471,7 +443,7 @@ static const struct regulator_ops mcp16502_ldo_ops = {
 	.is_enabled			= regulator_is_enabled_regmap,
 	.get_status			= mcp16502_get_status,
 	.set_voltage_time_sel		= mcp16502_set_voltage_time_sel,
-	.set_ramp_delay			= mcp16502_set_ramp_delay,
+	.set_ramp_delay			= regulator_set_ramp_delay_regmap,
 
 #ifdef CONFIG_SUSPEND
 	.set_suspend_voltage		= mcp16502_set_suspend_voltage,
@@ -495,13 +467,19 @@ static const struct linear_range b234_ranges[] = {
 };
 
 static const struct regulator_desc mcp16502_desc[] = {
-	/* MCP16502_REGULATOR(_name, _id, ranges, regulator_ops) */
-	MCP16502_REGULATOR("VDD_IO", BUCK1, b1l12_ranges, mcp16502_buck_ops),
-	MCP16502_REGULATOR("VDD_DDR", BUCK2, b234_ranges, mcp16502_buck_ops),
-	MCP16502_REGULATOR("VDD_CORE", BUCK3, b234_ranges, mcp16502_buck_ops),
-	MCP16502_REGULATOR("VDD_OTHER", BUCK4, b234_ranges, mcp16502_buck_ops),
-	MCP16502_REGULATOR("LDO1", LDO1, b1l12_ranges, mcp16502_ldo_ops),
-	MCP16502_REGULATOR("LDO2", LDO2, b1l12_ranges, mcp16502_ldo_ops)
+	/* MCP16502_REGULATOR(_name, _id, ranges, regulator_ops, ramp_table) */
+	MCP16502_REGULATOR("VDD_IO", BUCK1, b1l12_ranges, mcp16502_buck_ops,
+			   mcp16502_ramp_b1l12),
+	MCP16502_REGULATOR("VDD_DDR", BUCK2, b234_ranges, mcp16502_buck_ops,
+			   mcp16502_ramp_b234),
+	MCP16502_REGULATOR("VDD_CORE", BUCK3, b234_ranges, mcp16502_buck_ops,
+			   mcp16502_ramp_b234),
+	MCP16502_REGULATOR("VDD_OTHER", BUCK4, b234_ranges, mcp16502_buck_ops,
+			   mcp16502_ramp_b234),
+	MCP16502_REGULATOR("LDO1", LDO1, b1l12_ranges, mcp16502_ldo_ops,
+			   mcp16502_ramp_b1l12),
+	MCP16502_REGULATOR("LDO2", LDO2, b1l12_ranges, mcp16502_ldo_ops,
+			   mcp16502_ramp_b1l12)
 };
 
 static const struct regmap_range mcp16502_ranges[] = {
-- 
2.25.1

