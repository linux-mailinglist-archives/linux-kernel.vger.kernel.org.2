Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399FD3BC6D5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 08:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhGFGsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 02:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbhGFGsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 02:48:24 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50E2C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 23:45:46 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id o4so8406385plg.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 23:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hlaqQPlGCk3tFWhNY3fwaLeoKxK3RScZN31TpYJkPTg=;
        b=l9U4onaVpYHDipfTOTqfsP4ebXu/2T7L3IXVaCTG7iygsq/4RVvpqPX8V3rr0/L3Hh
         lRXg2hMr/7jqiRnuHSSVX8Dh1M1kllWrFfanJRYCFwXeHQI6KyN4WoKWJ99kBO2lZMli
         b3gnjfxXoDXDdYJByDYf0KoLNkjxEJEGgXJROUO/z8WoczAyscO6U7mQxxKjdxDXEvYB
         G++mDt+dLZPwx9ePA3KAQSrly4y/U6G8m8ygQrvGM5HhJJaETfCav1D5NjYrX1Kwsj+B
         MBt3PJXWiMaTB6IkXazeEOfCsMTgBrDTGHjfVzBLx/gSUzJzdLC1CfsucjIcVYCZFGRK
         06vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hlaqQPlGCk3tFWhNY3fwaLeoKxK3RScZN31TpYJkPTg=;
        b=dSsOOelsArXT3oYZw9wO0oUo9UdwoC85FVC2D8a62BG1blHlB5YtTEFeYCWanq9y1e
         3iyhiI1Uf+Xmp0n1pPc/G0AglCKgHXHqd2ovlbjwprJKE3HfiuVuOZ/f6KCKlomWzwTv
         eoOAK3cJzDUEpVWpeanV5+PcILktH43FJDHQZJdgymEaRBektlwFPX2GYRZMHG3T2shH
         DhYjzesQDAWxgOS90ZfWmUpf409d3bwqrFb7XaRUHglriAXgd2spAOMTZ9CLW/my1Tgv
         yRQntUkondTB0Z1hNUcG9dFVxtBw8jFYwr0kaAIr18v7oXcAsz9LcjMP5bZGmc9ZOBv/
         SEiQ==
X-Gm-Message-State: AOAM532pSrErONK6WyXH42t6Z//3wgA2ptod9gaW0FvFIJzMzcA4EdVs
        z10RXrFodzf1N18ZL1dqnnY=
X-Google-Smtp-Source: ABdhPJzqiTBZPGtqDisGrOuksaYnFiappsPktIrp0iGLLF31+h5idd3DPpwHreGODi3O7OhcJ2fewQ==
X-Received: by 2002:a17:90a:9282:: with SMTP id n2mr19147444pjo.204.1625553945953;
        Mon, 05 Jul 2021 23:45:45 -0700 (PDT)
Received: from localhost.localdomain (1-171-1-183.dynamic-ip.hinet.net. [1.171.1.183])
        by smtp.gmail.com with ESMTPSA id r10sm16987611pga.48.2021.07.05.23.45.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Jul 2021 23:45:45 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     lee.jones@linaro.org, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        axel.lin@ingics.com, cy_huang@richtek.com
Subject: [PATCH v2] regulator: rt5033: Use linear ranges to map all voltage selection
Date:   Tue,  6 Jul 2021 14:45:39 +0800
Message-Id: <1625553939-9109-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Instead of linear mapping, Use linear range to map all voltage selection.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
Since v2
- recover the volt number back in rt5033-private.h
- Add the n_voltages from v1 back.

Even though commit 6549c46af855 ("regulator: rt5033: Fix n_voltages settings for BUCK and LDO")
can fix the linear mapping to the correct min/max voltage
But there're still non-step ranges for the reserved value.

To use the linear range can fix it for mapping all voltage selection.
---
 drivers/regulator/rt5033-regulator.c | 21 +++++++++++++++------
 include/linux/mfd/rt5033-private.h   |  4 ++--
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/rt5033-regulator.c b/drivers/regulator/rt5033-regulator.c
index 0e73116..da4cf5a 100644
--- a/drivers/regulator/rt5033-regulator.c
+++ b/drivers/regulator/rt5033-regulator.c
@@ -13,6 +13,16 @@
 #include <linux/mfd/rt5033-private.h>
 #include <linux/regulator/of_regulator.h>
 
+static const struct linear_range rt5033_buck_ranges[] = {
+	REGULATOR_LINEAR_RANGE(1000000, 0, 20, 100000),
+	REGULATOR_LINEAR_RANGE(3000000, 21, 31, 0),
+};
+
+static const struct linear_range rt5033_ldo_ranges[] = {
+	REGULATOR_LINEAR_RANGE(1200000, 0, 18, 100000),
+	REGULATOR_LINEAR_RANGE(3000000, 19, 31, 0),
+};
+
 static const struct regulator_ops rt5033_safe_ldo_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
@@ -24,8 +34,7 @@ static const struct regulator_ops rt5033_buck_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
-	.list_voltage		= regulator_list_voltage_linear,
-	.map_voltage		= regulator_map_voltage_linear,
+	.list_voltage		= regulator_list_voltage_linear_range,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 };
@@ -40,8 +49,8 @@ static const struct regulator_desc rt5033_supported_regulators[] = {
 		.type		= REGULATOR_VOLTAGE,
 		.owner		= THIS_MODULE,
 		.n_voltages	= RT5033_REGULATOR_BUCK_VOLTAGE_STEP_NUM,
-		.min_uV		= RT5033_REGULATOR_BUCK_VOLTAGE_MIN,
-		.uV_step	= RT5033_REGULATOR_BUCK_VOLTAGE_STEP,
+		.linear_ranges	= rt5033_buck_ranges,
+		.n_linear_ranges = ARRAY_SIZE(rt5033_buck_ranges),
 		.enable_reg	= RT5033_REG_CTRL,
 		.enable_mask	= RT5033_CTRL_EN_BUCK_MASK,
 		.vsel_reg	= RT5033_REG_BUCK_CTRL,
@@ -56,8 +65,8 @@ static const struct regulator_desc rt5033_supported_regulators[] = {
 		.type		= REGULATOR_VOLTAGE,
 		.owner		= THIS_MODULE,
 		.n_voltages	= RT5033_REGULATOR_LDO_VOLTAGE_STEP_NUM,
-		.min_uV		= RT5033_REGULATOR_LDO_VOLTAGE_MIN,
-		.uV_step	= RT5033_REGULATOR_LDO_VOLTAGE_STEP,
+		.linear_ranges	= rt5033_ldo_ranges,
+		.n_linear_ranges = ARRAY_SIZE(rt5033_ldo_ranges),
 		.enable_reg	= RT5033_REG_CTRL,
 		.enable_mask	= RT5033_CTRL_EN_LDO_MASK,
 		.vsel_reg	= RT5033_REG_LDO_CTRL,
diff --git a/include/linux/mfd/rt5033-private.h b/include/linux/mfd/rt5033-private.h
index 40a0c2d..2d1895c 100644
--- a/include/linux/mfd/rt5033-private.h
+++ b/include/linux/mfd/rt5033-private.h
@@ -200,13 +200,13 @@ enum rt5033_reg {
 #define RT5033_REGULATOR_BUCK_VOLTAGE_MIN		1000000U
 #define RT5033_REGULATOR_BUCK_VOLTAGE_MAX		3000000U
 #define RT5033_REGULATOR_BUCK_VOLTAGE_STEP		100000U
-#define RT5033_REGULATOR_BUCK_VOLTAGE_STEP_NUM		21
+#define RT5033_REGULATOR_BUCK_VOLTAGE_STEP_NUM		32
 
 /* RT5033 regulator LDO output voltage uV */
 #define RT5033_REGULATOR_LDO_VOLTAGE_MIN		1200000U
 #define RT5033_REGULATOR_LDO_VOLTAGE_MAX		3000000U
 #define RT5033_REGULATOR_LDO_VOLTAGE_STEP		100000U
-#define RT5033_REGULATOR_LDO_VOLTAGE_STEP_NUM		19
+#define RT5033_REGULATOR_LDO_VOLTAGE_STEP_NUM		32
 
 /* RT5033 regulator SAFE LDO output voltage uV */
 #define RT5033_REGULATOR_SAFE_LDO_VOLTAGE		4900000U
-- 
2.7.4

