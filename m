Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44CB13B8CBD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 05:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbhGAD4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 23:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbhGAD4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 23:56:44 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B73AC061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 20:54:13 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id f11so2925807plg.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 20:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9Fipkw0HU9MxxxKttH7QXZJ4bpXGnCmniFyP0d8kMzo=;
        b=OHfB4n3QdKgrO9CyZEDUR85Ddc2qGQmGMemA/w+ee9KJd+8QnilwZ9Ch7Lrh/fdcN/
         W+Is7x7tQWrniIQ4X0XwBqaU47R/htztEC0QhSew4EGAbm9gXu4+pe9wEdNQcKx+K/yf
         ybnJp8KLNJx8BFdHEBKUIXOXhHJ14KZ1VNLdVjkrtePPfhKYCxWqQ6o3lOA82r691AD6
         mDVzNcM6+d2OnutRyPzv0QOlb2ryXsKvi9in/2P5/3llKzRmmZ9f0UI4IJGI/dUlwqJR
         ClwxnxoS6FaspijX8/t6v/Eu69+MkMPVErIErztNOs7jTX7xZNt9Cf3mZvsMeVsTErcI
         QOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9Fipkw0HU9MxxxKttH7QXZJ4bpXGnCmniFyP0d8kMzo=;
        b=a/ACAUccyRvuC5C/RlRf90Gr9tojRLxqQAQZiQavdVELfH/bWbVHLPzjbxRhU9KFHy
         SBi2DUtG+uju46xJoZcWN9VzBlnsmGB6leePsGTPmkcQCqB65lzLx7WM2028Azc/Si3Z
         Aic02J/NPo+TBoiGUxp9wh0oLPkH6ScKBRhHzG2F2xUc+ys3TeMc4SUhpdKiI87fyJ3Y
         0IsmJ3lt0/MRx2qQsDwLgwR133r026SsNQ8mRCp3AgNoJcp4YG3chfWQx7lm8yQ5swE2
         oe8JL8OZUSIizWsdYYOyEqDES9zHK0R5+XOBXknMABlSZYJiEdq0VVe2mq4kFMMivqkh
         Wpyw==
X-Gm-Message-State: AOAM530uTmMzqPYTeKqUidbGN3US+IaPD5gF2KflTHNrdIR0uoHSN/ek
        kR56ZFVbIsjwVaGkAK6Y6YA=
X-Google-Smtp-Source: ABdhPJyR6/oynuyfuDZ6SO9Ncj1rkpXKJ1KLn24P8kQWNWHd1IMh1Z689zBR2a+24pI/vIksTG2c5A==
X-Received: by 2002:a17:90a:4295:: with SMTP id p21mr18778728pjg.149.1625111652744;
        Wed, 30 Jun 2021 20:54:12 -0700 (PDT)
Received: from localhost.localdomain (1-171-4-204.dynamic-ip.hinet.net. [1.171.4.204])
        by smtp.gmail.com with ESMTPSA id g2sm3590295pjd.55.2021.06.30.20.54.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jun 2021 20:54:11 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, axel.lin@ingics.com,
        linux-kernel@vger.kernel.org, ChiYuan Huang <cy_huang@richtek.com>
Subject: [PATCH] regulator: rt5033: Use linear ranges to map all voltage selection
Date:   Thu,  1 Jul 2021 11:54:06 +0800
Message-Id: <1625111646-3955-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Instead of linear mapping, Use linear range to map all voltage selection.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
Even though commit 6549c46af855 ("regulator: rt5033: Fix n_voltages settings for BUCK and LDO")
can fix the linear mapping to the correct min/max voltage
But there're still non-step ranges for the reserved value.

To use the linear range can fix it for mapping all voltage selection.
---
 drivers/regulator/rt5033-regulator.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/rt5033-regulator.c b/drivers/regulator/rt5033-regulator.c
index 0e73116..2ff607c 100644
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
@@ -39,9 +48,8 @@ static const struct regulator_desc rt5033_supported_regulators[] = {
 		.ops		= &rt5033_buck_ops,
 		.type		= REGULATOR_VOLTAGE,
 		.owner		= THIS_MODULE,
-		.n_voltages	= RT5033_REGULATOR_BUCK_VOLTAGE_STEP_NUM,
-		.min_uV		= RT5033_REGULATOR_BUCK_VOLTAGE_MIN,
-		.uV_step	= RT5033_REGULATOR_BUCK_VOLTAGE_STEP,
+		.linear_ranges	= rt5033_buck_ranges,
+		.n_linear_ranges = ARRAY_SIZE(rt5033_buck_ranges),
 		.enable_reg	= RT5033_REG_CTRL,
 		.enable_mask	= RT5033_CTRL_EN_BUCK_MASK,
 		.vsel_reg	= RT5033_REG_BUCK_CTRL,
@@ -55,9 +63,8 @@ static const struct regulator_desc rt5033_supported_regulators[] = {
 		.ops		= &rt5033_buck_ops,
 		.type		= REGULATOR_VOLTAGE,
 		.owner		= THIS_MODULE,
-		.n_voltages	= RT5033_REGULATOR_LDO_VOLTAGE_STEP_NUM,
-		.min_uV		= RT5033_REGULATOR_LDO_VOLTAGE_MIN,
-		.uV_step	= RT5033_REGULATOR_LDO_VOLTAGE_STEP,
+		.linear_ranges	= rt5033_ldo_ranges,
+		.n_linear_ranges = ARRAY_SIZE(rt5033_ldo_ranges),
 		.enable_reg	= RT5033_REG_CTRL,
 		.enable_mask	= RT5033_CTRL_EN_LDO_MASK,
 		.vsel_reg	= RT5033_REG_LDO_CTRL,
-- 
2.7.4

