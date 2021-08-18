Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05DD73F0BF0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 21:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbhHRTlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 15:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbhHRTlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 15:41:04 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D179C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 12:40:29 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id n18so3374031pgm.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 12:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bw4ze6oPqpPpa0WfXBYMenQVUrVlVVgykWlQzXXSpA0=;
        b=ysvZMrZrfJUYWtQ2jV9wTOxbiUYt126yWSc7zulk86Is2xZu53z9jH3wJeiyKPwGo1
         dmN+vHj/3rauFjyKYM21l7VKnAhGlYFxsR4lfBCM8M2V/fvKT9iFjptBwx4hwCbyy1Hz
         Ysm/KjKtW0X3mUlBVNiREIm1qxCnQt1MTPiP0yUzroZtZbibaOLbUKRcaDxoOf2i70FU
         R+Vtw+e81dsURANDGKTEfpKjn7SoFQ2N0+4ekFdtAlN5tra3+cbIjYYxpPqgx2oZXEhe
         sAxbuCx7Ysto31HMhsEQ4HVZ/pbe/m+9AkqB6TuMMxv5PHclhhSYMnA9yXQZkAi3C70J
         0qBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bw4ze6oPqpPpa0WfXBYMenQVUrVlVVgykWlQzXXSpA0=;
        b=T/1Ma0n2/S9WnpNFISK9cp7RAxnRA+fe2rP29o0UtKMh8cJpKbT7ECvcOXpdzve//o
         R3dzNX038nDD+7StN3yXKuVNOchDINvGpcIne6QV81wC4unqHBd4aj2jSBN6VR+LMhfq
         6jDpHtGCLL9QgO7dqJMOJYrN2b5kc0Wh3aChDnnd2wmgLu5+nrMx3M4Sh9k8HWnd+++3
         cBx1m7i2Mf2JysukfJaclYmL3FnFkdW9PevjJ4KfxbsdqNQ8AroetPo+5e8ivBmrtoVP
         axz5mdieo7Fnq8emJKlwZI+iAflczgw/FGMlppirB3uaghE0eJfDFjlrpc7dqD1GZj1m
         QOyw==
X-Gm-Message-State: AOAM5319EVfV7hVaid2F+6p31qKFQBe5Gkjr1WkU+vYx0l3QaclXGBB5
        pJtu/yCYDE56FeX5bNkKQfesBQ==
X-Google-Smtp-Source: ABdhPJwd3TlHGntB0EV/r4BxY378aBCkN8rRcDeI4cGj0kSNcVvZFdPkFZEEZdJSL0Z2HXCJQcogrA==
X-Received: by 2002:a62:52ce:0:b029:3e0:7bc6:3c7c with SMTP id g197-20020a6252ce0000b02903e07bc63c7cmr11075026pfb.20.1629315629122;
        Wed, 18 Aug 2021 12:40:29 -0700 (PDT)
Received: from p14s.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id k12sm2960137pjg.6.2021.08.18.12.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 12:40:28 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] coresight: config: Add configuration and feature generic functions
Date:   Wed, 18 Aug 2021 13:40:14 -0600
Message-Id: <20210818194022.379573-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210818194022.379573-1-mathieu.poirier@linaro.org>
References: <20210818194022.379573-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Leach <mike.leach@linaro.org>

Adds a set of generic support functions that allow devices to set and save
features values on the device, and enable and disable configurations.

Additional functions for other common operations including feature
reset.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Link: https://lore.kernel.org/r/20210723165444.1048-4-mike.leach@linaro.org
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/Makefile          |   2 +-
 .../hwtracing/coresight/coresight-config.c    | 272 ++++++++++++++++++
 .../hwtracing/coresight/coresight-config.h    |   9 +
 .../hwtracing/coresight/coresight-syscfg.c    |   3 +-
 4 files changed, 284 insertions(+), 2 deletions(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-config.c

diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index 3d037f17aade..63ecfc3cf66d 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -4,7 +4,7 @@
 #
 obj-$(CONFIG_CORESIGHT) += coresight.o
 coresight-y := coresight-core.o  coresight-etm-perf.o coresight-platform.o \
-		coresight-sysfs.o coresight-syscfg.o
+		coresight-sysfs.o coresight-syscfg.o coresight-config.o
 obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o
 coresight-tmc-y := coresight-tmc-core.o coresight-tmc-etf.o \
 		      coresight-tmc-etr.o
diff --git a/drivers/hwtracing/coresight/coresight-config.c b/drivers/hwtracing/coresight/coresight-config.c
new file mode 100644
index 000000000000..4723bf7402a2
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-config.c
@@ -0,0 +1,272 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright(C) 2020 Linaro Limited. All rights reserved.
+ * Author: Mike Leach <mike.leach@linaro.org>
+ */
+
+#include <linux/sysfs.h>
+#include "coresight-config.h"
+#include "coresight-priv.h"
+
+/*
+ * This provides a set of generic functions that operate on configurations
+ * and features to manage the handling of parameters, the programming and
+ * saving of registers used by features on devices.
+ */
+
+/*
+ * Write the value held in the register structure into the driver internal memory
+ * location.
+ */
+static void cscfg_set_reg(struct cscfg_regval_csdev *reg_csdev)
+{
+	u32 *p_val32 = (u32 *)reg_csdev->driver_regval;
+	u32 tmp32 = reg_csdev->reg_desc.val32;
+
+	if (reg_csdev->reg_desc.type & CS_CFG_REG_TYPE_VAL_64BIT) {
+		*((u64 *)reg_csdev->driver_regval) = reg_csdev->reg_desc.val64;
+		return;
+	}
+
+	if (reg_csdev->reg_desc.type & CS_CFG_REG_TYPE_VAL_MASK) {
+		tmp32 = *p_val32;
+		tmp32 &= ~reg_csdev->reg_desc.mask32;
+		tmp32 |= reg_csdev->reg_desc.val32 & reg_csdev->reg_desc.mask32;
+	}
+	*p_val32 = tmp32;
+}
+
+/*
+ * Read the driver value into the reg if this is marked as one we want to save.
+ */
+static void cscfg_save_reg(struct cscfg_regval_csdev *reg_csdev)
+{
+	if (!(reg_csdev->reg_desc.type & CS_CFG_REG_TYPE_VAL_SAVE))
+		return;
+	if (reg_csdev->reg_desc.type & CS_CFG_REG_TYPE_VAL_64BIT)
+		reg_csdev->reg_desc.val64 = *(u64 *)(reg_csdev->driver_regval);
+	else
+		reg_csdev->reg_desc.val32 = *(u32 *)(reg_csdev->driver_regval);
+}
+
+/*
+ * Some register values are set from parameters. Initialise these registers
+ * from the current parameter values.
+ */
+static void cscfg_init_reg_param(struct cscfg_feature_csdev *feat_csdev,
+				 struct cscfg_regval_desc *reg_desc,
+				 struct cscfg_regval_csdev *reg_csdev)
+{
+	struct cscfg_parameter_csdev *param_csdev;
+
+	/* for param, load routines have validated the index */
+	param_csdev = &feat_csdev->params_csdev[reg_desc->param_idx];
+	param_csdev->reg_csdev = reg_csdev;
+	param_csdev->val64 = reg_csdev->reg_desc.type & CS_CFG_REG_TYPE_VAL_64BIT;
+
+	if (param_csdev->val64)
+		reg_csdev->reg_desc.val64 = param_csdev->current_value;
+	else
+		reg_csdev->reg_desc.val32 = (u32)param_csdev->current_value;
+}
+
+/* set values into the driver locations referenced in cscfg_reg_csdev */
+static int cscfg_set_on_enable(struct cscfg_feature_csdev *feat_csdev)
+{
+	unsigned long flags;
+	int i;
+
+	spin_lock_irqsave(feat_csdev->drv_spinlock, flags);
+	for (i = 0; i < feat_csdev->nr_regs; i++)
+		cscfg_set_reg(&feat_csdev->regs_csdev[i]);
+	spin_unlock_irqrestore(feat_csdev->drv_spinlock, flags);
+	dev_dbg(&feat_csdev->csdev->dev, "Feature %s: %s",
+		feat_csdev->feat_desc->name, "set on enable");
+	return 0;
+}
+
+/* copy back values from the driver locations referenced in cscfg_reg_csdev */
+static void cscfg_save_on_disable(struct cscfg_feature_csdev *feat_csdev)
+{
+	unsigned long flags;
+	int i;
+
+	spin_lock_irqsave(feat_csdev->drv_spinlock, flags);
+	for (i = 0; i < feat_csdev->nr_regs; i++)
+		cscfg_save_reg(&feat_csdev->regs_csdev[i]);
+	spin_unlock_irqrestore(feat_csdev->drv_spinlock, flags);
+	dev_dbg(&feat_csdev->csdev->dev, "Feature %s: %s",
+		feat_csdev->feat_desc->name, "save on disable");
+}
+
+/* default reset - restore default values */
+void cscfg_reset_feat(struct cscfg_feature_csdev *feat_csdev)
+{
+	struct cscfg_regval_desc *reg_desc;
+	struct cscfg_regval_csdev *reg_csdev;
+	int i;
+
+	/*
+	 * set the default values for all parameters and regs from the
+	 * relevant static descriptors.
+	 */
+	for (i = 0; i < feat_csdev->nr_params; i++)
+		feat_csdev->params_csdev[i].current_value =
+			feat_csdev->feat_desc->params_desc[i].value;
+
+	for (i = 0; i < feat_csdev->nr_regs; i++) {
+		reg_desc = &feat_csdev->feat_desc->regs_desc[i];
+		reg_csdev = &feat_csdev->regs_csdev[i];
+		reg_csdev->reg_desc.type = reg_desc->type;
+
+		/* check if reg set from a parameter otherwise desc default */
+		if (reg_desc->type & CS_CFG_REG_TYPE_VAL_PARAM)
+			cscfg_init_reg_param(feat_csdev, reg_desc, reg_csdev);
+		else
+			/*
+			 * for normal values the union between val64 & val32 + mask32
+			 * allows us to init using the 64 bit value
+			 */
+			reg_csdev->reg_desc.val64 = reg_desc->val64;
+	}
+}
+
+/*
+ * For the selected presets, we set the register associated with the parameter, to
+ * the value of the preset index associated with the parameter.
+ */
+static int cscfg_update_presets(struct cscfg_config_csdev *config_csdev, int preset)
+{
+	int i, j, val_idx = 0, nr_cfg_params;
+	struct cscfg_parameter_csdev *param_csdev;
+	struct cscfg_feature_csdev *feat_csdev;
+	const struct cscfg_config_desc *config_desc = config_csdev->config_desc;
+	const char *name;
+	const u64 *preset_base;
+	u64 val;
+
+	/* preset in range 1 to nr_presets */
+	if (preset < 1 || preset > config_desc->nr_presets)
+		return -EINVAL;
+	/*
+	 * Go through the array of features, assigning preset values to
+	 * feature parameters in the order they appear.
+	 * There should be precisely the same number of preset values as the
+	 * sum of number of parameters over all the features - but we will
+	 * ensure there is no overrun.
+	 */
+	nr_cfg_params = config_desc->nr_total_params;
+	preset_base = &config_desc->presets[(preset - 1) * nr_cfg_params];
+	for (i = 0; i < config_csdev->nr_feat; i++) {
+		feat_csdev = config_csdev->feats_csdev[i];
+		if (!feat_csdev->nr_params)
+			continue;
+
+		for (j = 0; j < feat_csdev->nr_params; j++) {
+			param_csdev = &feat_csdev->params_csdev[j];
+			name = feat_csdev->feat_desc->params_desc[j].name;
+			val = preset_base[val_idx++];
+			if (param_csdev->val64) {
+				dev_dbg(&config_csdev->csdev->dev,
+					"set param %s (%lld)", name, val);
+				param_csdev->reg_csdev->reg_desc.val64 = val;
+			} else {
+				param_csdev->reg_csdev->reg_desc.val32 = (u32)val;
+				dev_dbg(&config_csdev->csdev->dev,
+					"set param %s (%d)", name, (u32)val);
+			}
+		}
+
+		/* exit early if all params filled */
+		if (val_idx >= nr_cfg_params)
+			break;
+	}
+	return 0;
+}
+
+/*
+ * if we are not using a preset, then need to update the feature params
+ * with current values. This sets the register associated with the parameter
+ * with the current value of that parameter.
+ */
+static int cscfg_update_curr_params(struct cscfg_config_csdev *config_csdev)
+{
+	int i, j;
+	struct cscfg_feature_csdev *feat_csdev;
+	struct cscfg_parameter_csdev *param_csdev;
+	const char *name;
+	u64 val;
+
+	for (i = 0; i < config_csdev->nr_feat; i++) {
+		feat_csdev = config_csdev->feats_csdev[i];
+		if (!feat_csdev->nr_params)
+			continue;
+		for (j = 0; j < feat_csdev->nr_params; j++) {
+			param_csdev = &feat_csdev->params_csdev[j];
+			name = feat_csdev->feat_desc->params_desc[j].name;
+			val = param_csdev->current_value;
+			if (param_csdev->val64) {
+				dev_dbg(&config_csdev->csdev->dev,
+					"set param %s (%lld)", name, val);
+				param_csdev->reg_csdev->reg_desc.val64 = val;
+			} else {
+				param_csdev->reg_csdev->reg_desc.val32 = (u32)val;
+				dev_dbg(&config_csdev->csdev->dev,
+					"set param %s (%d)", name, (u32)val);
+			}
+		}
+	}
+	return 0;
+}
+
+/*
+ * Configuration values will be programmed into the driver locations if enabling, or read
+ * from relevant locations on disable.
+ */
+static int cscfg_prog_config(struct cscfg_config_csdev *config_csdev, bool enable)
+{
+	int i, err = 0;
+	struct cscfg_feature_csdev *feat_csdev;
+	struct coresight_device *csdev;
+
+	for (i = 0; i < config_csdev->nr_feat; i++) {
+		feat_csdev = config_csdev->feats_csdev[i];
+		csdev = feat_csdev->csdev;
+		dev_dbg(&csdev->dev, "cfg %s;  %s feature:%s", config_csdev->config_desc->name,
+			enable ? "enable" : "disable", feat_csdev->feat_desc->name);
+
+		if (enable)
+			err = cscfg_set_on_enable(feat_csdev);
+		else
+			cscfg_save_on_disable(feat_csdev);
+
+		if (err)
+			break;
+	}
+	return err;
+}
+
+/*
+ * Enable configuration for the device. Will result in the internal driver data
+ * being updated ready for programming into the device.
+ *
+ * @config_csdev:	config_csdev to set.
+ * @preset:		preset values to use - 0 for default.
+ */
+int cscfg_csdev_enable_config(struct cscfg_config_csdev *config_csdev, int preset)
+{
+	int err = 0;
+
+	if (preset)
+		err = cscfg_update_presets(config_csdev, preset);
+	else
+		err = cscfg_update_curr_params(config_csdev);
+	if (!err)
+		err = cscfg_prog_config(config_csdev, true);
+	return err;
+}
+
+void cscfg_csdev_disable_config(struct cscfg_config_csdev *config_csdev)
+{
+	cscfg_prog_config(config_csdev, false);
+}
diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
index 685fb46ce893..5a39cbbc38a4 100644
--- a/drivers/hwtracing/coresight/coresight-config.h
+++ b/drivers/hwtracing/coresight/coresight-config.h
@@ -237,4 +237,13 @@ struct cscfg_csdev_feat_ops {
 			 struct cscfg_feature_csdev *feat_csdev);
 };
 
+/* coresight config helper functions*/
+
+/* enable / disable config on a device - called with appropriate locks set.*/
+int cscfg_csdev_enable_config(struct cscfg_config_csdev *config_csdev, int preset);
+void cscfg_csdev_disable_config(struct cscfg_config_csdev *config_csdev);
+
+/* reset a feature to default values */
+void cscfg_reset_feat(struct cscfg_feature_csdev *feat_csdev);
+
 #endif /* _CORESIGHT_CORESIGHT_CONFIG_H */
diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
index 2c0d4906e226..5e4bd86f369e 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg.c
+++ b/drivers/hwtracing/coresight/coresight-syscfg.c
@@ -189,7 +189,8 @@ static int cscfg_load_feat_csdev(struct coresight_device *csdev,
 	if (err)
 		return err;
 
-	/* add to internal csdev feature list */
+	/* add to internal csdev feature list & initialise using reset call */
+	cscfg_reset_feat(feat_csdev);
 	spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
 	list_add(&feat_csdev->node, &csdev->feature_csdev_list);
 	spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
-- 
2.25.1

