Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8084A3C6B25
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 09:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbhGMHX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 03:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbhGMHX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 03:23:27 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6EAC0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 00:20:36 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id me13-20020a17090b17cdb0290173bac8b9c9so852986pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 00:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XFtHaGTM5quQs1dFFfKRJGhhjjRc4HQ8bjLY5vI0iM0=;
        b=Qt/Ck422xAf5eJi/9c7zk0uNwU4lgNaOZjNRtrYtxl6nKe184uqAmA2QhoDUXttNFi
         S7QnKq0xG+actHtBGZrqka6Vz8mpERmTHbQRQm5ozzWahqXkA1QUoMeimOcae0dxS13e
         oVrLv2IwiLqGm/d54sJo+TIWsMeZcB/ylxhpuQwSSJE1Qg07th3eNFsXvh6U+53+si3e
         DVqGUVlg0d4VOzxXqnVp9XCZXx3tQ2VMIdB7tUjNOkEUbgdS6PPbBHknMPJzLnVITfhL
         uIvkbod4p47Kj7JESCtrvT6+VXG8InhJbZhlFGF4sCexER3OqyPosIo34g3CBMV+KqY4
         6KxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XFtHaGTM5quQs1dFFfKRJGhhjjRc4HQ8bjLY5vI0iM0=;
        b=KKTXbtDcyYSqbc0dZsFxE1zwKg40fnn6432pIUXmLRzwyY5/q5sT6wu07LcMrgRynu
         CS8z0JG15Slggvq2CVJOp9/heZZhFS7+WB6Bt8vnu7Bz8C/VQGnuEhqxK+dNAFVs96Wo
         BEi0tepikiV7oE1mylu8JakZVl3Yh20jfhQ4INqCcplbK58MdYeUdwZcy8+4SnzU/Sel
         6deDgWnuSize6+alP1pqjgMTPXjbfRaj5CQQgKd0r8gN7Xn9I1vBerWaPQt+eab976Qn
         xyELh8r6ko30vVI4VE6r/Gw4r8KQ562N5e0fO9ua7psb6Fs9bxT7A+IRrMxcvHaC0SOi
         HYnQ==
X-Gm-Message-State: AOAM5305Q90ftZPUZkwZyVIzifwQIIjPhQtLt0sbbE4RS2zioW8BTDfv
        I7otS9f3VPNvNkAYl7/tjsQ=
X-Google-Smtp-Source: ABdhPJwI4VOuCCqVCmdbiJUQUP/oYu1cj5eeydlIQIZ6/LIlSQvplSmUN7zS28Det0QWq6P+2KioSw==
X-Received: by 2002:a17:90b:378c:: with SMTP id mz12mr3118016pjb.122.1626160836499;
        Tue, 13 Jul 2021 00:20:36 -0700 (PDT)
Received: from localhost.lan ([2400:4070:175b:7500::7a7])
        by smtp.gmail.com with ESMTPSA id e23sm3598416pfd.26.2021.07.13.00.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 00:20:35 -0700 (PDT)
Received: from x2.lan (localhost [127.0.0.1])
        by localhost.lan (Postfix) with ESMTPSA id BE7E7900A69;
        Tue, 13 Jul 2021 07:20:33 +0000 (GMT)
From:   Vincent Pelletier <plr.vincent@gmail.com>
To:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v6] regulator: da9063: Add support for full-current mode.
Date:   Tue, 13 Jul 2021 07:20:31 +0000
Message-Id: <824518e6391b783a12eba9ff0527f06607a34bfb.1626160826.git.plr.vincent@gmail.com>
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
V5 -> V6:
- improve coding style: fix multi-line comments style, add newlines
- da9063_buck_set_limit_set_overdrive: skip setting & rolling back
  overdrive bit if it is already set, improve roll-back comment
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
 drivers/regulator/da9063-regulator.c | 132 ++++++++++++++++++++++++++-
 1 file changed, 130 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index cf7d5341750e..82f52a2a031a 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -412,6 +412,134 @@ static int da9063_ldo_set_suspend_mode(struct regulator_dev *rdev,
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
+	/*
+	 * When enabling overdrive, do it before changing the current limit to
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
+	orig_overdrive &= overdrive_mask;
+
+	if (orig_overdrive == 0) {
+		ret = regmap_set_bits(regl->hw->regmap, DA9063_REG_CONFIG_H,
+				overdrive_mask);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = regulator_set_current_limit_regmap(rdev, min_uA / 2, max_uA / 2);
+	if (ret < 0 && orig_overdrive == 0)
+		/*
+		 * regulator_set_current_limit_regmap may have rejected the
+		 * change because of unusable min_uA and/or max_uA inputs.
+		 * Attempt to restore original overdrive state, ignore failure-
+		 * on-failure.
+		 */
+		regmap_clear_bits(regl->hw->regmap, DA9063_REG_CONFIG_H,
+				  overdrive_mask);
+
+	return ret;
+}
+
+static int da9063_buck_set_limit_clear_overdrive(struct regulator_dev *rdev,
+						 int min_uA, int max_uA,
+						 unsigned int overdrive_mask)
+{
+	/*
+	 * When disabling overdrive, do it after changing the current limit to
+	 * ensure sufficient supply throughout the switch.
+	 */
+	struct da9063_regulator *regl = rdev_get_drvdata(rdev);
+	int ret, orig_limit;
+
+	ret = regmap_read(rdev->regmap, rdev->desc->csel_reg, &orig_limit);
+	if (ret < 0)
+		return ret;
+
+	ret = regulator_set_current_limit_regmap(rdev, min_uA, max_uA);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_clear_bits(regl->hw->regmap, DA9063_REG_CONFIG_H,
+				overdrive_mask);
+	if (ret < 0)
+		/*
+		 * Attempt to restore original current limit, ignore failure-
+		 * on-failure.
+		 */
+		regmap_write(rdev->regmap, rdev->desc->csel_reg, orig_limit);
+
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
+
+		if (max_uA > rdev->desc->curr_table[n_currents - 1])
+			return da9063_buck_set_limit_set_overdrive(rdev, min_uA,
+								   max_uA,
+								   overdrive_mask);
+
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
@@ -419,8 +547,8 @@ static const struct regulator_ops da9063_buck_ops = {
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

