Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299A7359C3F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 12:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbhDIKiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 06:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbhDIKhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 06:37:48 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF392C061764
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 03:37:34 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id f6so5134035wrv.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 03:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dBcmk8hgXkjZTFcE6yG1vqcpDqUWsuaa6mvE1XbAMsg=;
        b=oMwVN/ss2HOKHq75hnNyNTcuK5fV5SQ4YDPCGguwUMOqCdscPWlG7WF69IaBRQrVT3
         /3PKx4ZA4q8/KgkB7yr+eTYczPpdsUgWV1TFWYgn/DC4K5SXgGGRTz5LNK74xf7zt9et
         h37KDiFDnrLMZifVk48HEUe1W6+zHi6t7ZZTOsrRmNYjv/t3ZbwusgPYz6P40/hZnlNK
         60Urv259Xr2e9ho1aiAEXEI50EwqmPt8KGzx7nAwxZs0EbGqC7qkK1f+zpPuBy9q82AV
         dHDTH2AQt05a9xBxE9zTiSE02l3q2A5bUI3XHzAnIkZ0dPQjo1CDg6AW4STeSeRIIPKt
         K2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dBcmk8hgXkjZTFcE6yG1vqcpDqUWsuaa6mvE1XbAMsg=;
        b=t147aCD8Lt8TuVLvkc0imf86OQxhqEM3RRaH0OtRmcOKegvsYx1YQQOsHbwgSqFqw/
         vxszrv6/kcCHx6egtMaLTqNl2QC32iTnjBQ4FqbXIqaQIQRYYZgALwe8nHdJWx7peLr/
         o+1s7FZ3XVVLQOVG+nAWqGUPta7wn4yT3MLyebjAA0i/BZiCC6x7XjFeKFZJ9MF0jSBV
         hzMuEtZ+IBBPrAv6QR+K5dMAp81rv84egnFYqeJvUpK+FEnP7tCU+nBieSC4UerC8AqY
         Fk+dDl7C4Bczgdrkq7029JaSErg1vB2Lyrv1V17SD6f5uLoTxP4BHuFe44yZnd3QJHhb
         guGQ==
X-Gm-Message-State: AOAM533IZfNNXiAIGdxQi9IMfJblGlNVWX40ixaFthKks+IndJ7ZM6kF
        ex4+m81vDG00Tmc1KegiiKJdNg==
X-Google-Smtp-Source: ABdhPJzbpG1zPQ6+aTwmTVndvPfi9rweVWIbPB1ft6iKFlkbTuUjHK1CvEwbDNcNkroEORV1jz/nyA==
X-Received: by 2002:a5d:6086:: with SMTP id w6mr1405236wrt.208.1617964653327;
        Fri, 09 Apr 2021 03:37:33 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:20a6:106c:24d6:628])
        by smtp.gmail.com with ESMTPSA id w7sm4087650wro.43.2021.04.09.03.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 03:37:33 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, linux-doc@vger.kernel.org,
        suzuki.poulose@arm.com
Cc:     yabinc@google.com, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, tingwei@codeaurora.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v6 03/10] coresight: config: Add configuration and feature generic functions
Date:   Fri,  9 Apr 2021 11:37:15 +0100
Message-Id: <20210409103722.26290-4-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210409103722.26290-1-mike.leach@linaro.org>
References: <20210409103722.26290-1-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a set of generic support functions that allow devices to set and save
features values on the device, and enable and disable configurations.

Additional functions for other common operations including feature
reset.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/Makefile          |   2 +-
 .../hwtracing/coresight/coresight-config.c    | 275 ++++++++++++++++++
 .../hwtracing/coresight/coresight-config.h    |   9 +
 .../hwtracing/coresight/coresight-syscfg.c    |   3 +-
 4 files changed, 287 insertions(+), 2 deletions(-)
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
index 000000000000..3c501e027bc0
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-config.c
@@ -0,0 +1,275 @@
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
+	int i;
+
+	spin_lock(feat_csdev->drv_spinlock);
+	for (i = 0; i < feat_csdev->nr_regs; i++)
+		cscfg_set_reg(&feat_csdev->regs_csdev[i]);
+	spin_unlock(feat_csdev->drv_spinlock);
+	dev_dbg(&feat_csdev->csdev->dev, "Feature %s: %s",
+		feat_csdev->feat_desc->name, "set on enable");
+	return 0;
+}
+
+/* copy back values from the driver locations referenced in cscfg_reg_csdev */
+static void cscfg_save_on_disable(struct cscfg_feature_csdev *feat_csdev)
+{
+	int i;
+
+	spin_lock(feat_csdev->drv_spinlock);
+	for (i = 0; i < feat_csdev->nr_regs; i++)
+		cscfg_save_reg(&feat_csdev->regs_csdev[i]);
+	spin_unlock(feat_csdev->drv_spinlock);
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
+	if (!err)
+		config_csdev->enabled = true;
+	return err;
+}
+
+void cscfg_csdev_disable_config(struct cscfg_config_csdev *config_csdev)
+{
+	if (config_csdev->enabled) {
+		cscfg_prog_config(config_csdev, false);
+		config_csdev->enabled = false;
+	}
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
index e93e62c1efbb..c7f48d6b48f5 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg.c
+++ b/drivers/hwtracing/coresight/coresight-syscfg.c
@@ -190,9 +190,10 @@ static int cscfg_load_feat_csdev(struct coresight_device *csdev,
 	if (err)
 		return err;
 
-	/* add to internal csdev feature list */
+	/* add to internal csdev feature list & initialise using reset call */
 	mutex_lock(&cscfg_csdev_mutex);
 	list_add(&feat_csdev->node, &csdev->feature_csdev_list);
+	cscfg_reset_feat(feat_csdev);
 	mutex_unlock(&cscfg_csdev_mutex);
 
 	return 0;
-- 
2.17.1

