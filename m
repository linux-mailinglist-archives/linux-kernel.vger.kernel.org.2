Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2C63BBD68
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 15:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbhGENWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 09:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhGENW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 09:22:29 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E77C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 06:19:51 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 67-20020a17090a0fc9b02901725ed49016so8901920pjz.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 06:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ojEoRzGurn3QAaEGGdfMVfemjm1jmrkP9t6VFr7qb00=;
        b=U4wv3J93DkSk1dt6DYTPkffUJ4qM4e4bNR4iYDcZKx3/JbQpgQj9SdjrXF/ff+DBzZ
         GgBUSIzyzGlxeIVI16nF7bZ1W6AEAA2aSQ14tF1RRQa9UX/BsIt3uBHCNwE7wfISI13U
         tqp70v0XAXu0htxGv+pEtsFm6sKiSk92XUtLOgDpUKLVRlLHtH6F2gv2I8+3n3xg4fwv
         QZyhuu9w+7M0EK+PsSy0Mu0I++pBtVIY9zjMsMGm2042tnzIFiuy8htMebUfqDZVqbm8
         kRkm2W/R7GJyy3oWHmGFtdnz+x9r1K5O2wUPpsoeEQpx6N77QbZ1vIybZYQUDXXnIwkr
         O29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ojEoRzGurn3QAaEGGdfMVfemjm1jmrkP9t6VFr7qb00=;
        b=WiYAuZBFLxAuw44BRgwT/gXcamxafMhdtYYMkEortRwGiUo0aRKV41o2hrQAQrM1WX
         X4QDwOge0IlTuXrjat9bp58EgOd+rAWkVktgR/+HPU8yxsRdBvNKeBnIR9E7N6J7MtqF
         n1LYJC2lpoa8EklR+ZrM8hVL5Z3BAP7kzUSK6ze+FCfp2N1o0Rlq61wsOtwykNVw3PhL
         bHfIUJ6AWOBj1FzqaYrPoopniGm0VDgJRqBCNSwrHGKZHPLMFdxCb3Wxg8UO2TGT+gEu
         VVGKoe9eH9lrQWmjVFPp977nH/kwBbqsm7I1xyKIyv+6Ntkmwo5tJ3M9JefDOJqwQ6SY
         0ZmA==
X-Gm-Message-State: AOAM533wPZHDJrAUoeVUdgmSAZN0rAqPJq81ADDKCjmjSmW/32i01ii6
        yi+22nUyfUpOG6XhCsZmxpo=
X-Google-Smtp-Source: ABdhPJyz1Mub+WVqATPtxGFRIMgrMWYf9YsA5TGZvOxFcDon5bLMemSd+bHGqC0CklRFcPkBSV5ylg==
X-Received: by 2002:a17:902:9895:b029:128:cdfb:f389 with SMTP id s21-20020a1709029895b0290128cdfbf389mr12227555plp.45.1625491190951;
        Mon, 05 Jul 2021 06:19:50 -0700 (PDT)
Received: from localhost.lan ([2400:4070:175b:7500::7a7])
        by smtp.gmail.com with ESMTPSA id p3sm21868605pjt.0.2021.07.05.06.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 06:19:50 -0700 (PDT)
Received: from x2.lan (localhost [127.0.0.1])
        by localhost.lan (Postfix) with ESMTPSA id 8F9B6900901;
        Mon,  5 Jul 2021 13:19:48 +0000 (GMT)
From:   Vincent Pelletier <plr.vincent@gmail.com>
To:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v4] regulator: da9063: Add support for full-current mode.
Date:   Mon,  5 Jul 2021 13:19:44 +0000
Message-Id: <58a4ef0f70b227a5da820ea51c7b3b60fa453b1e.1625490856.git.plr.vincent@gmail.com>
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
Symetrically, scale the current limit up when querying a overdrive-enabled
regulator.

Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
---
V3 -> V4:
- complete logic change: my original approach was backwards: the driver
  should take full control the overdrive bit, and not depend on the state
  it find the hardware in.
V2 -> V3:
- ACTUALLY skip DA9063_ID_BCORES_MERGED_OD when not full-current, and
  vice-versa.
- head put in brown paper bag
V1 -> V2:
- skip DA9063_ID_BCORES_MERGED_OD when not full-current, and vice-versa
- cc linux-kernel ML
- fix subject prefix


 drivers/regulator/da9063-regulator.c | 75 +++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index cf7d5341750e..4be7cfd06cd4 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -412,6 +412,77 @@ static int da9063_ldo_set_suspend_mode(struct regulator_dev *rdev,
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
+static int da9063_buck_set_current_limit(struct regulator_dev *rdev,
+					 int min_uA, int max_uA)
+{
+	struct da9063_regulator *regl = rdev_get_drvdata(rdev);
+	unsigned int mask, n_currents;
+	int ret, overdrive;
+	bool overdrive_changed = false;
+
+	mask = da9063_get_overdrive_mask(rdev->desc);
+	if (mask) {
+		n_currents = rdev->desc->n_current_limits;
+		if (n_currents == 0)
+			return -EINVAL;
+		if (max_uA > rdev->desc->curr_table[n_currents - 1]) {
+			overdrive = mask;
+			min_uA /= 2; // XXX: rounding ?
+			max_uA /= 2;
+		} else {
+			overdrive = 0;
+		}
+		ret = regmap_update_bits_check(regl->hw->regmap,
+					       DA9063_REG_CONFIG_H, mask,
+					       overdrive, &overdrive_changed);
+		if (ret < 0)
+			return ret;
+	}
+	ret = regulator_set_current_limit_regmap(rdev, min_uA, max_uA);
+	if (ret < 0 && overdrive_changed)
+		/* attempt to restore original overdrive state, ignore failure-
+		 * on-failure
+		 */
+		regmap_update_bits(regl->hw->regmap, DA9063_REG_CONFIG_H,
+				   mask, ~overdrive);
+	return ret;
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
@@ -419,8 +490,8 @@ static const struct regulator_ops da9063_buck_ops = {
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

