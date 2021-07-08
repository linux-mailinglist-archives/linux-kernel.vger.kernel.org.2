Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1B73BF877
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 12:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbhGHKf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 06:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbhGHKf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 06:35:27 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2327C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 03:32:45 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 62so5512765pgf.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 03:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U8WO6aPNk2ka22778emxAJE++UlTtMDZdhWjSs2NCKU=;
        b=A+4ouNXvdqaIuBfPMOrDx+35czM4FBGTxDfgODAiWfHy2wNrBvMGkOQ6Akqp7CFIRl
         Pohx9PAZZxphnDBG/IR4extgsYqg5l3Fg9qBASWRfn22mRCPkmkHFaGNeGxmQETTn5V7
         zOsZ6UGit9c8pQ9rGCB4C2l1TGd5pYo+xtAQwfqzww0z4g3RHcNr6RIeMsMFcyC4uwnS
         fMVOTAH86CpU7OLmUvTV+kSpzQqRAvjuN7acmSagg4WaCVScwKz7sTet4qOQXPqSLFUp
         NIBmGJR4A7hdK0ruPwQBnuVhOJ1WtedepW38SkElnXULCcxtTIN1VeIDU39xniyS6y+e
         /HtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U8WO6aPNk2ka22778emxAJE++UlTtMDZdhWjSs2NCKU=;
        b=ZpjHhlcXgUhOrtl3bHAPikLSmxls5SCdj5xC6qbQjaYXO2x1tS73szWwwUYx3NNASk
         vY2gbBuzqO5uQzHcTBstdNE7D3FUSXAgnP6TlL6hCNxjQWW6vuFbpj3p5DVGl6ZZDev0
         K3DozpgO+nFnkGbJN83Y05Lxdpc8yvA52/tOQl8hy+HakAMtg+KrCyCQvKpYl/j4w48B
         UHh7ejOc+FQwyhvag4Ux+t+VTmtPVt+rcKM3oY4jrYLsq+mSc/u7gu8uqpeo5axryO72
         2Axtj2kCCO5l7FGFj0dsLgXTSOhJc/FrVRMycxHBEMiuWJgI4vrbhNznRtQBUJ93RHlu
         Ux7A==
X-Gm-Message-State: AOAM530JcMnzSqgXqDRoR/ogRRhtr2cwQO+hhCcjUqsyGqgO1VUelAay
        +LayldC9ZC9cT6Myvu9UTUo=
X-Google-Smtp-Source: ABdhPJwlSB9o99ETcpHizPIyUhS34ktULxl5UKMKRdAwzRMPRpvnJEq+3cjnTv8jXK9lNljPvSgaiA==
X-Received: by 2002:a05:6a00:2494:b029:326:5453:8c14 with SMTP id c20-20020a056a002494b029032654538c14mr7407706pfv.43.1625740365269;
        Thu, 08 Jul 2021 03:32:45 -0700 (PDT)
Received: from localhost.lan ([2400:4070:175b:7500::7a7])
        by smtp.gmail.com with ESMTPSA id y1sm2686669pgr.70.2021.07.08.03.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 03:32:43 -0700 (PDT)
Received: from x2.lan (localhost [127.0.0.1])
        by localhost.lan (Postfix) with ESMTPSA id 8BCDD9011C2;
        Thu,  8 Jul 2021 10:32:40 +0000 (GMT)
From:   Vincent Pelletier <plr.vincent@gmail.com>
To:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v5] regulator: da9063: Add support for full-current mode.
Date:   Thu,  8 Jul 2021 10:32:37 +0000
Message-Id: <9d5decc6d5b15702d0e1039f8c9bda51d9a4d630.1625740324.git.plr.vincent@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to the ability of merging some power outputs, this chip has
an overdrive mode.
BCORE1, BCORE2 and BPRO have this ability, in which case the legal
current draw is increased from 2 amps to 2.5 amps (at the expense of
a quiescent current increase), and the configurable current limits
are doubled.
If a current higher than maximum half-current mode is requested, enable
overdrive, and scale the current limit down.
Symmetrically, scale the current limit up when querying a overdrive-enabled
regulator.

Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
---
V4 -> V5:
- when disabling overdrive, adjust current limit first
- remove forgotten development comment
V3 -> V4:
- complete logic change: my original approach was backwards: the driver
  should take full control the overdrive bit, and not depend on the state
  it finds the hardware in.
V2 -> V3:
- ACTUALLY skip DA9063_ID_BCORES_MERGED_OD when not full-current, and
  vice-versa.
- head put in brown paper bag
V1 -> V2:
- skip DA9063_ID_BCORES_MERGED_OD when not full-current, and vice-versa
- cc linux-kernel ML
- fix subject prefix
---
 drivers/regulator/da9063-regulator.c | 115 ++++++++++++++++++++++++++-
 1 file changed, 113 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index cf7d5341750e..d595f88a00fc 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -412,6 +412,117 @@ static int da9063_ldo_set_suspend_mode(struct regulator_dev *rdev,
 	return regmap_field_write(regl->suspend_sleep, val);
 }
 
+static unsigned int da9063_get_overdrive_mask(const struct regulator_desc *desc)
+{
+	switch (desc->id) {
+	case DA9063_ID_BCORES_MERGED:
+	case DA9063_ID_BCORE1:
+		return DA9063_BCORE1_OD;
+	case DA9063_ID_BCORE2:
+		return DA9063_BCORE2_OD;
+	case DA9063_ID_BPRO:
+		return DA9063_BPRO_OD;
+	default:
+		return 0;
+	}
+}
+
+static int da9063_buck_set_limit_set_overdrive(struct regulator_dev *rdev,
+					       int min_uA, int max_uA,
+					       unsigned int overdrive_mask)
+{
+	/* When enabling overdrive, do it before changing the current limit to
+	 * ensure sufficient supply throughout the switch.
+	 */
+	struct da9063_regulator *regl = rdev_get_drvdata(rdev);
+	int ret;
+	unsigned int orig_overdrive;
+
+	ret = regmap_read(regl->hw->regmap, DA9063_REG_CONFIG_H,
+			  &orig_overdrive);
+	if (ret < 0)
+		return ret;
+	ret = regmap_set_bits(regl->hw->regmap, DA9063_REG_CONFIG_H,
+			      overdrive_mask);
+	if (ret < 0)
+		return ret;
+	ret = regulator_set_current_limit_regmap(rdev, min_uA / 2, max_uA / 2);
+	if (ret < 0)
+		/* attempt to restore original overdrive state, ignore failure-
+		 * on-failure
+		 */
+		regmap_update_bits(regl->hw->regmap, DA9063_REG_CONFIG_H,
+				   overdrive_mask, orig_overdrive);
+	return ret;
+}
+
+static int da9063_buck_set_limit_clear_overdrive(struct regulator_dev *rdev,
+						 int min_uA, int max_uA,
+						 unsigned int overdrive_mask)
+{
+	/* When disabling overdrive, do it after changing the current limit to
+	 * ensure sufficient supply throughout the switch.
+	 */
+	struct da9063_regulator *regl = rdev_get_drvdata(rdev);
+	int ret, orig_limit;
+
+	ret = regmap_read(rdev->regmap, rdev->desc->csel_reg, &orig_limit);
+	if (ret < 0)
+		return ret;
+	ret = regulator_set_current_limit_regmap(rdev, min_uA, max_uA);
+	if (ret < 0)
+		return ret;
+	ret = regmap_clear_bits(regl->hw->regmap, DA9063_REG_CONFIG_H,
+				overdrive_mask);
+	if (ret < 0)
+		/* attempt to restore original current limit, ignore failure-
+		 * on-failure
+		 */
+		regmap_write(rdev->regmap, rdev->desc->csel_reg, orig_limit);
+	return ret;
+}
+
+static int da9063_buck_set_current_limit(struct regulator_dev *rdev,
+					 int min_uA, int max_uA)
+{
+	unsigned int overdrive_mask, n_currents;
+
+	overdrive_mask = da9063_get_overdrive_mask(rdev->desc);
+	if (overdrive_mask) {
+		n_currents = rdev->desc->n_current_limits;
+		if (n_currents == 0)
+			return -EINVAL;
+		if (max_uA > rdev->desc->curr_table[n_currents - 1])
+			return da9063_buck_set_limit_set_overdrive(rdev, min_uA,
+								   max_uA,
+								   overdrive_mask);
+		return da9063_buck_set_limit_clear_overdrive(rdev, min_uA,
+							     max_uA,
+							     overdrive_mask);
+	}
+	return regulator_set_current_limit_regmap(rdev, min_uA, max_uA);
+}
+
+static int da9063_buck_get_current_limit(struct regulator_dev *rdev)
+{
+	struct da9063_regulator *regl = rdev_get_drvdata(rdev);
+	int val, ret, limit;
+	unsigned int mask;
+
+	limit = regulator_get_current_limit_regmap(rdev);
+	if (limit < 0)
+		return limit;
+	mask = da9063_get_overdrive_mask(rdev->desc);
+	if (mask) {
+		ret = regmap_read(regl->hw->regmap, DA9063_REG_CONFIG_H, &val);
+		if (ret < 0)
+			return ret;
+		if (val & mask)
+			limit *= 2;
+	}
+	return limit;
+}
+
 static const struct regulator_ops da9063_buck_ops = {
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
@@ -419,8 +530,8 @@ static const struct regulator_ops da9063_buck_ops = {
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 	.list_voltage		= regulator_list_voltage_linear,
-	.set_current_limit	= regulator_set_current_limit_regmap,
-	.get_current_limit	= regulator_get_current_limit_regmap,
+	.set_current_limit	= da9063_buck_set_current_limit,
+	.get_current_limit	= da9063_buck_get_current_limit,
 	.set_mode		= da9063_buck_set_mode,
 	.get_mode		= da9063_buck_get_mode,
 	.get_status		= da9063_buck_get_status,
-- 
2.32.0

