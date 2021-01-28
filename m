Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C221307BEC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 18:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbhA1RMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 12:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbhA1RKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 12:10:30 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCFAC0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 09:09:49 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id u14so4909587wml.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 09:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s+5ZOcVrkMkSDksPoofX2PKXc6/0xVmgqp42EKYccvM=;
        b=F5y20DXl129ee2eQSw/9seNHN8aCXuQmIKBxTzW9tg07g7vDWHQuTKd5OAELmL9SQ5
         gOi46HrADo4Np9X0LoIVBD5X33F7im0SPICNfDmM8LP3HLtmBBY/Ah3Bc6m7Mek2x6dK
         iVujCu2P22pDGHCoY2daFtkjoN4lOmQqxdM7FLMmju9BcuC0yd1EElh6IIGwkXqpgEWd
         p5+a0oGyff1pP2PmK5x9kCuTf94kd0Fk3jHUwUhp9LRABKf0RZDTcRAO+zzRUrYL7v7f
         be5/t/5ChEsZ61wjy8pKE8NQuXlwo6yTinRw5pAYyQ/xOrF3X0sDiz1PjREZ+0Ygvg/K
         WwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s+5ZOcVrkMkSDksPoofX2PKXc6/0xVmgqp42EKYccvM=;
        b=lJPohcYJyHhWnV+E1ddOQRwhL+f+fZoWL1POwlNl7qPahFFt39eospMe0TezQ96jGP
         9RdgRgGKck7waa/NwEfVDeVGPGL/9KUB6APUIkQdAGHZyvxWychby/2oxAGErAiPWkz2
         WaW7IEb1ZXzM6voDfXr/Q7EuABqd7uHc6hdMqv95UY+mvCQkZeCXs6Ve4iVIfw20p4Bp
         jzOq0MJFvMRU3ensikatqeDqCyHrAmUI3fL77kHy4zuNYDfgsqmXjtmKjkhN0oxAjg+W
         5a4T84lT8TWt08HPpCueunjBr/k9MjzWXpeEqCkN3JW/eGmEIjb7if6+5JDgte9I6Kll
         E9LA==
X-Gm-Message-State: AOAM533XU4UqIpaE6eEXsZjWj4f9Buyu2FBBm0AtXSc3/q+fwVEdrk8m
        UULrW8DVlp+E7AZJUliVQYNwQQ==
X-Google-Smtp-Source: ABdhPJy2gfw2+pkkOOpwbCvQI6X4ajD5WkEe0lzZ6K6tNH0R/AQzszlGjHicUAqklPPfjLZZo7dmbg==
X-Received: by 2002:a1c:3d56:: with SMTP id k83mr215079wma.25.1611853788018;
        Thu, 28 Jan 2021 09:09:48 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6801:1801:40:2fca:953a:e6ba])
        by smtp.gmail.com with ESMTPSA id p15sm7622355wrt.15.2021.01.28.09.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 09:09:47 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, linux-doc@vger.kernel.org,
        suzuki.poulose@arm.com
Cc:     yabinc@google.com, corbet@lwn.net, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, tingwei@codeaurora.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v4 03/10] coresight: config: Add configuration and feature generic functions
Date:   Thu, 28 Jan 2021 17:09:29 +0000
Message-Id: <20210128170936.9222-4-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210128170936.9222-1-mike.leach@linaro.org>
References: <20210128170936.9222-1-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a set of generic support functions that allow devices to set and save
features values on the device, and enable and disable configurations.

Additional functions for other common operations including feature
reset.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/Makefile          |   2 +-
 .../hwtracing/coresight/coresight-config.c    | 245 ++++++++++++++++++
 .../hwtracing/coresight/coresight-config.h    |  14 +-
 .../hwtracing/coresight/coresight-syscfg.c    |   5 +-
 4 files changed, 262 insertions(+), 4 deletions(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-config.c

diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index 4ce854c434b1..daad9f103a78 100644
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
index 000000000000..6cc4b213d9b6
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-config.c
@@ -0,0 +1,245 @@
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
+ * Write the value held in the register structure into the driver internal memory
+ * location.
+ */
+static void cscfg_set_reg(struct cscfg_reg_csdev *reg)
+{
+	u32 *p_val32 = (u32 *)reg->drv_store;
+	u32 tmp32 = reg->value.val32;
+
+	if (reg->value.type & CS_CFG_REG_TYPE_VAL_64BIT) {
+		*((u64 *)reg->drv_store) = reg->value.val64;
+		return;
+	}
+
+	if (reg->value.type & CS_CFG_REG_TYPE_VAL_MASK) {
+		tmp32 = *p_val32;
+		tmp32 &= ~reg->value.mask32;
+		tmp32 |= reg->value.val32 & reg->value.mask32;
+	}
+	*p_val32 = tmp32;
+}
+
+/*
+ * Read the driver value into the reg if this is marked as one we want to save.
+ */
+static void cscfg_save_reg(struct cscfg_reg_csdev *reg)
+{
+	if (!(reg->value.type & CS_CFG_REG_TYPE_VAL_SAVE))
+		return;
+	if (reg->value.type & CS_CFG_REG_TYPE_VAL_64BIT)
+		reg->value.val64 = *(u64 *)(reg->drv_store);
+	else
+		reg->value.val32 = *(u32 *)(reg->drv_store);
+}
+
+static void cscfg_init_reg_param(struct cscfg_parameter_csdev *param_csdev,
+				 struct cscfg_reg_csdev *reg_csdev)
+{
+	param_csdev->reg = reg_csdev;
+	param_csdev->val64 = reg_csdev->value.type & CS_CFG_REG_TYPE_VAL_64BIT;
+
+	if (param_csdev->val64)
+		param_csdev->reg->value.val64 = param_csdev->current_value;
+	else
+		param_csdev->reg->value.val32 = (u32)param_csdev->current_value;
+}
+
+/* set values into the driver locations referenced in cscfg_reg_csdev */
+static int cscfg_set_on_enable(struct cscfg_feature_csdev *feat)
+{
+	int i;
+
+	spin_lock(feat->csdev_spinlock);
+	for (i = 0; i < feat->nr_regs; i++)
+		cscfg_set_reg(&feat->regs[i]);
+	spin_unlock(feat->csdev_spinlock);
+	dev_dbg(&feat->csdev->dev, "Feature %s: %s", feat->desc->name, "set on enable");
+	return 0;
+}
+
+/* copy back values from the driver locations referenced in cscfg_reg_csdev */
+static void cscfg_save_on_disable(struct cscfg_feature_csdev *feat)
+{
+	int i;
+
+	spin_lock(feat->csdev_spinlock);
+	for (i = 0; i < feat->nr_regs; i++)
+		cscfg_save_reg(&feat->regs[i]);
+	spin_unlock(feat->csdev_spinlock);
+	dev_dbg(&feat->csdev->dev, "Feature %s: %s", feat->desc->name, "save on disable");
+}
+
+/* default reset - restore default values */
+void cscfg_reset_feat(struct cscfg_feature_csdev *feat)
+{
+	struct cscfg_parameter_csdev *param_csdev;
+	struct cscfg_regval_desc *reg_desc;
+	struct cscfg_reg_csdev *reg_csdev;
+	int i;
+
+	/*
+	 * set the default values for all parameters and regs from the
+	 * relevant static descriptors.
+	 */
+	for (i = 0; i < feat->nr_params; i++)
+		feat->params[i].current_value = feat->desc->params[i].value;
+
+	for (i = 0; i < feat->nr_regs; i++) {
+		reg_desc = &feat->desc->regs[i];
+		reg_csdev = &feat->regs[i];
+		reg_csdev->value.type = reg_desc->type;
+
+		/* check if reg set from a parameter otherwise desc default */
+		if (reg_desc->type & CS_CFG_REG_TYPE_VAL_PARAM) {
+			/* for param, reg_desc->val32 is an index */
+			param_csdev = &feat->params[reg_desc->val32];
+			cscfg_init_reg_param(param_csdev, reg_csdev);
+		} else
+			reg_csdev->value.val64 = reg_desc->val64;
+	}
+}
+
+static int cscfg_update_presets(struct cscfg_config_csdev *cfg, int preset)
+{
+	int i, j, line_offset = 0, val_idx = 0, max_idx;
+	struct cscfg_parameter_csdev *param;
+	struct cscfg_feature_csdev *feat;
+	const char *name;
+	u64 val;
+
+	if (preset > cfg->desc->nr_presets)
+		return -EINVAL;
+	/*
+	 * Go through the array of features, assigning preset values to
+	 * feature parameters in the order they appear.
+	 * There should be precisely the same number of preset values as the
+	 * sum of number of parameters over all the features - but we will
+	 * ensure there is no overrun.
+	 */
+	line_offset = (preset-1) * cfg->desc->nr_total_params;
+	max_idx = cfg->desc->nr_total_params;
+	for (i = 0; i < cfg->nr_feat; i++) {
+		feat = cfg->feats[i];
+		if (!feat->nr_params)
+			continue;
+
+		for (j = 0; j < feat->nr_params; j++) {
+			param = &feat->params[j];
+			name = feat->desc->params[j].name;
+			val = cfg->desc->presets[line_offset + val_idx++];
+			if (param->val64) {
+				dev_dbg(&cfg->csdev->dev,
+					"set param %s (%lld)", name, val);
+				param->reg->value.val64 = val;
+			} else {
+				param->reg->value.val32 = (u32)val;
+				dev_dbg(&cfg->csdev->dev,
+					"set param %s (%d)", name, (u32)val);
+			}
+			if (val_idx >= max_idx)
+				break;
+		}
+
+		/* don't overrun the preset array line */
+		if (val_idx >= max_idx)
+			break;
+	}
+	return 0;
+}
+
+/*
+ * if we are not using a preset, then need to update the feature params
+ * with current values.
+ */
+static int cscfg_update_curr_params(struct cscfg_config_csdev *cfg)
+{
+	int i, j;
+	struct cscfg_feature_csdev *feat;
+	struct cscfg_parameter_csdev *param;
+	const char *name;
+	u64 val;
+
+	for (i = 0; i < cfg->nr_feat; i++) {
+		feat = cfg->feats[i];
+		if (!feat->nr_params)
+			continue;
+		for (j = 0; j < feat->nr_params; j++) {
+			param = &feat->params[j];
+			name = feat->desc->params[j].name;
+			val = param->current_value;
+			if (param->val64) {
+				dev_dbg(&cfg->csdev->dev,
+					"set param %s (%lld)", name, val);
+				param->reg->value.val64 = val;
+			} else {
+				param->reg->value.val32 = (u32)val;
+				dev_dbg(&cfg->csdev->dev,
+					"set param %s (%d)", name, (u32)val);
+			}
+		}
+	}
+	return 0;
+}
+
+static int cscfg_prog_config(struct cscfg_config_csdev *cfg, bool enable)
+{
+	int i, err = 0;
+	struct cscfg_feature_csdev *feat;
+	struct coresight_device *csdev;
+
+	for (i = 0; i < cfg->nr_feat; i++) {
+		feat = cfg->feats[i];
+		csdev = feat->csdev;
+		dev_dbg(&csdev->dev, "cfg %s;  %s feature:%s", cfg->desc->name,
+			enable ? "enable" : "disable", feat->desc->name);
+
+		if (enable)
+			err = cscfg_set_on_enable(feat);
+		else
+			cscfg_save_on_disable(feat);
+
+		if (err)
+			break;
+	}
+	return err;
+}
+
+/**
+ * Enable configuration for the device.
+ *
+ * @cfg:	config_csdev to set.
+ * @preset:	preset values to use - 0 for default.
+ */
+int cscfg_csdev_enable_config(struct cscfg_config_csdev *cfg, int preset)
+{
+	int err = 0;
+
+	if (preset)
+		err = cscfg_update_presets(cfg, preset);
+	else
+		err = cscfg_update_curr_params(cfg);
+	if (!err)
+		err = cscfg_prog_config(cfg, true);
+	if (!err)
+		cfg->enabled = true;
+	return err;
+}
+
+void cscfg_csdev_disable_config(struct cscfg_config_csdev *cfg)
+{
+	if (cfg->enabled) {
+		cscfg_prog_config(cfg, false);
+		cfg->enabled = false;
+	}
+}
diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
index 75ecdecf7013..9d66e0071f38 100644
--- a/drivers/hwtracing/coresight/coresight-config.h
+++ b/drivers/hwtracing/coresight/coresight-config.h
@@ -53,7 +53,10 @@ struct cscfg_parameter_desc {
 };
 
 /**
- * Representation of register value.
+ * Representation of register value and a descriptor of register usage.
+ *
+ * Used as a descriptor in the feature descriptors.
+ * Used as a value in when in a feature loading into a csdev.
  *
  * Supports full 64 bit register value, or 32 bit value with optional mask
  * value.
@@ -262,4 +265,13 @@ struct cscfg_csdev_feat_ops {
 			 struct cscfg_feature_csdev *feat);
 };
 
+/* coresight config helper functions*/
+
+/* enable / disable config on a device - called with appropriate locks set.*/
+int cscfg_csdev_enable_config(struct cscfg_config_csdev *cfg, int preset);
+void cscfg_csdev_disable_config(struct cscfg_config_csdev *cfg);
+
+/* reset a feature to default values */
+void cscfg_reset_feat(struct cscfg_feature_csdev *feat);
+
 #endif /* _CORESIGHT_CORESIGHT_CONFIG_H */
diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
index c04cea0c1db2..4b8e4e35e3e7 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg.c
+++ b/drivers/hwtracing/coresight/coresight-syscfg.c
@@ -198,14 +198,15 @@ static int cscfg_load_feat_csdev(struct coresight_device *csdev,
 	if (!feat_csdev)
 		return -ENOMEM;
 
-	/* load the feature into the device - may modify default ops*/
+	/* load the feature into the device */
 	err = ops->load_feat(csdev, feat_csdev);
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

