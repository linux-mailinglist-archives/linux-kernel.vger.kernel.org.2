Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293773D3DE9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 18:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbhGWQOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 12:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbhGWQOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 12:14:16 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4253C061757
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 09:54:49 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id w12so2993507wro.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 09:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iNV5pLTyliKqoxM8P1Othuq2Un2xNNKB/N8//46DbZ8=;
        b=OC9K9sykMyPQ9MGSxQO2eppVx6SNsP8H6tSqUrVihW9++X4fuicSsqo2RTqGVIGVmt
         VyjKE+fRdmNMIQI4ndwnuw2hHvj+8p5h08uXzARHQlxW1N1IV/gPIJdvvezuyEww3CCG
         +kSa/uk4Jx9A6TmtQom/ylqITcV3JtPoMk7MOtaApZ6hOF87R105fAB2R+rARQ24NM0g
         Zi49B0Gb4M/vPzjQBi+bB3xlAORGj7gELa2YHC2Kryj/RH+eLDVsUk8am+Tw61FuNoF5
         8IE+kQF+WQs01n7APjDipxiH8N36OP+oi6TePiB+7YM1yYihdpcrQ3GD+o00iRUhBuNQ
         TAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iNV5pLTyliKqoxM8P1Othuq2Un2xNNKB/N8//46DbZ8=;
        b=KBGGCOOffypNnqHNlT20pQ2zemLAYGZ9/Q324UubZLeIQgpzn5rngO6jC0KRLLKnG9
         uUA7kunr96O/xcRSgWiYMxGIGIu6rfgX1dCVNwQ0cqS2mrVeB/oaferrPcqG1mhDMZAS
         115eY3OEB29fUK4hQMevlXuHkj+Y9QW2bloKAomOSZOev6JhX7M7MeVbOA9G1jADXHxP
         V+lr3jgfD+giWD68hK5onYNTE8t6bH7jg2s5dPJugbrn0iwtgoZSYJsofoc9u7rvvL+w
         ogeFvPSx2FWI44NszE6RZsabj2xwq5lUq+ddKWQnp3fjRAkb6eFwL496cgRqIgTH/pu1
         nogw==
X-Gm-Message-State: AOAM533JgR4oGR1O79V9GqGwmf9qwDD6oPoBgKtAW4mX+tQGZuS1ja44
        lUX5LnuHDAHT2Jsh95V9OKMEtQ==
X-Google-Smtp-Source: ABdhPJwlDuCvQTaS1o1MmWIy/SpLwFAwXc89CHdYcduOpoxTh4+a3jpdB//SP0/8yoBvhqUoS6RBzg==
X-Received: by 2002:a5d:4e81:: with SMTP id e1mr6340360wru.48.1627059288053;
        Fri, 23 Jul 2021 09:54:48 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:fdab:eb9d:1515:bff3])
        by smtp.gmail.com with ESMTPSA id z11sm33193225wru.65.2021.07.23.09.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 09:54:47 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, suzuki.poulose@arm.com
Cc:     yabinc@google.com, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, tingwei@codeaurora.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v9 01/10] coresight: syscfg: Initial coresight system configuration
Date:   Fri, 23 Jul 2021 17:54:35 +0100
Message-Id: <20210723165444.1048-2-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210723165444.1048-1-mike.leach@linaro.org>
References: <20210723165444.1048-1-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Creates an system management API to allow complex configurations and
features to be programmed into a CoreSight infrastructure.

A feature is defined as a programming set for a device or class of
devices.

A configuration is a set of features across the system that are enabled
for a trace session.

The API will manage system wide configuration, and allow complex
programmed features to be added to individual device instances, and
provide for system wide configuration selection on trace capture
operations.

This patch creates the initial data object and the initial API for
loading configurations and features.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/Makefile          |   2 +-
 .../hwtracing/coresight/coresight-config.h    | 142 +++++++++++++
 drivers/hwtracing/coresight/coresight-core.c  |  12 +-
 .../hwtracing/coresight/coresight-etm-perf.c  |   2 +-
 .../hwtracing/coresight/coresight-etm-perf.h  |   2 +-
 .../hwtracing/coresight/coresight-syscfg.c    | 199 ++++++++++++++++++
 .../hwtracing/coresight/coresight-syscfg.h    |  46 ++++
 7 files changed, 401 insertions(+), 4 deletions(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-config.h
 create mode 100644 drivers/hwtracing/coresight/coresight-syscfg.c
 create mode 100644 drivers/hwtracing/coresight/coresight-syscfg.h

diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index d60816509755..3d037f17aade 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -4,7 +4,7 @@
 #
 obj-$(CONFIG_CORESIGHT) += coresight.o
 coresight-y := coresight-core.o  coresight-etm-perf.o coresight-platform.o \
-		coresight-sysfs.o
+		coresight-sysfs.o coresight-syscfg.o
 obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o
 coresight-tmc-y := coresight-tmc-core.o coresight-tmc-etf.o \
 		      coresight-tmc-etr.o
diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
new file mode 100644
index 000000000000..21aa7464dcdc
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-config.h
@@ -0,0 +1,142 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2020 Linaro Limited, All rights reserved.
+ * Author: Mike Leach <mike.leach@linaro.org>
+ */
+
+#ifndef _CORESIGHT_CORESIGHT_CONFIG_H
+#define _CORESIGHT_CORESIGHT_CONFIG_H
+
+#include <linux/coresight.h>
+#include <linux/types.h>
+
+/* CoreSight Configuration Management - component and system wide configuration */
+
+/*
+ * Register type flags for register value descriptor:
+ * describe how the value is interpreted, and handled.
+ */
+#define CS_CFG_REG_TYPE_STD		0x80	/* reg is standard reg */
+#define CS_CFG_REG_TYPE_RESOURCE	0x40	/* reg is a resource */
+#define CS_CFG_REG_TYPE_VAL_PARAM	0x08	/* reg value uses param */
+#define CS_CFG_REG_TYPE_VAL_MASK	0x04	/* reg value bit masked */
+#define CS_CFG_REG_TYPE_VAL_64BIT	0x02	/* reg value 64 bit */
+#define CS_CFG_REG_TYPE_VAL_SAVE	0x01	/* reg value save on disable */
+
+/*
+ * flags defining what device class a feature will match to when processing a
+ * system configuration - used by config data and devices.
+ */
+#define CS_CFG_MATCH_CLASS_SRC_ALL	0x0001	/* match any source */
+#define CS_CFG_MATCH_CLASS_SRC_ETM4	0x0002	/* match any ETMv4 device */
+
+/* flags defining device instance matching - used in config match desc data. */
+#define CS_CFG_MATCH_INST_ANY		0x80000000 /* any instance of a class */
+
+/*
+ * Limit number of presets in a configuration
+ * This is related to the number of bits (4) we use to select the preset on
+ * the perf command line. Preset 0 is always none selected.
+ * See PMU_FORMAT_ATTR(preset, "config:0-3") in coresight-etm-perf.c
+ */
+#define CS_CFG_CONFIG_PRESET_MAX 15
+
+/**
+ * Parameter descriptor for a device feature.
+ *
+ * @name:  Name of parameter.
+ * @value: Initial or default value.
+ */
+struct cscfg_parameter_desc {
+	const char *name;
+	u64 value;
+};
+
+/**
+ * Representation of register value and a descriptor of register usage.
+ *
+ * Used as a descriptor in the feature descriptors.
+ * Used as a value in when in a feature loading into a csdev.
+ *
+ * Supports full 64 bit register value, or 32 bit value with optional mask
+ * value.
+ *
+ * @type:	define register usage and interpretation.
+ * @offset:	the address offset for register in the hardware device (per device specification).
+ * @hw_info:	optional hardware device type specific information. (ETM / CTI specific etc)
+ * @val64:	64 bit value.
+ * @val32:	32 bit value.
+ * @mask32:	32 bit mask when using 32 bit value to access device register - if mask type.
+ * @param_idx:	parameter index value into parameter array if param type.
+ */
+struct cscfg_regval_desc {
+	struct {
+		u32 type:8;
+		u32 offset:12;
+		u32 hw_info:12;
+	};
+	union {
+		u64 val64;
+		struct {
+			u32 val32;
+			u32 mask32;
+		};
+		u32 param_idx;
+	};
+};
+
+/**
+ * Device feature descriptor - combination of registers and parameters to
+ * program a device to implement a specific complex function.
+ *
+ * @name:	 feature name.
+ * @description: brief description of the feature.
+ * @item:	 List entry.
+ * @match_flags: matching information if loading into a device
+ * @nr_params:   number of parameters used.
+ * @params_desc: array of parameters used.
+ * @nr_regs:	 number of registers used.
+ * @regs_desc:	 array of registers used.
+ */
+struct cscfg_feature_desc {
+	const char *name;
+	const char *description;
+	struct list_head item;
+	u32 match_flags;
+	int nr_params;
+	struct cscfg_parameter_desc *params_desc;
+	int nr_regs;
+	struct cscfg_regval_desc *regs_desc;
+};
+
+/**
+ * Configuration descriptor - describes selectable system configuration.
+ *
+ * A configuration describes device features in use, and may provide preset
+ * values for the parameters in those features.
+ *
+ * A single set of presets is the sum of the parameters declared by
+ * all the features in use - this value is @nr_total_params.
+ *
+ * @name:		name of the configuration - used for selection.
+ * @description:	description of the purpose of the configuration.
+ * @item:		list entry.
+ * @nr_feat_refs:	Number of features used in this configuration.
+ * @feat_ref_names:	references to features used in this configuration.
+ * @nr_presets:		Number of sets of presets supplied by this configuration.
+ * @nr_total_params:	Sum of all parameters declared by used features
+ * @presets:		Array of preset values.
+ *
+ */
+struct cscfg_config_desc {
+	const char *name;
+	const char *description;
+	struct list_head item;
+	int nr_feat_refs;
+	const char **feat_ref_names;
+	int nr_presets;
+	int nr_total_params;
+	const u64 *presets; /* nr_presets * nr_total_params */
+};
+
+#endif /* _CORESIGHT_CORESIGHT_CONFIG_H */
diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 1002605db8ba..8a18c71df37a 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -21,6 +21,7 @@
 
 #include "coresight-etm-perf.h"
 #include "coresight-priv.h"
+#include "coresight-syscfg.h"
 
 static DEFINE_MUTEX(coresight_mutex);
 static DEFINE_PER_CPU(struct coresight_device *, csdev_sink);
@@ -1763,13 +1764,22 @@ static int __init coresight_init(void)
 
 	ret = etm_perf_init();
 	if (ret)
-		bus_unregister(&coresight_bustype);
+		goto exit_bus_unregister;
 
+	/* initialise the coresight syscfg API */
+	ret = cscfg_init();
+	if (!ret)
+		return 0;
+
+	etm_perf_exit();
+exit_bus_unregister:
+	bus_unregister(&coresight_bustype);
 	return ret;
 }
 
 static void __exit coresight_exit(void)
 {
+	cscfg_exit();
 	etm_perf_exit();
 	bus_unregister(&coresight_bustype);
 }
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 6f398377fec9..b582e92cdea4 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -748,7 +748,7 @@ int __init etm_perf_init(void)
 	return ret;
 }
 
-void __exit etm_perf_exit(void)
+void etm_perf_exit(void)
 {
 	perf_pmu_unregister(&etm_pmu);
 }
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
index 3e4f2ad5e193..29d90dfeba31 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.h
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
@@ -83,6 +83,6 @@ static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
 #endif /* CONFIG_CORESIGHT */
 
 int __init etm_perf_init(void);
-void __exit etm_perf_exit(void);
+void etm_perf_exit(void);
 
 #endif
diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
new file mode 100644
index 000000000000..417db3f92c2f
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-syscfg.c
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 Linaro Limited, All rights reserved.
+ * Author: Mike Leach <mike.leach@linaro.org>
+ */
+
+#include <linux/platform_device.h>
+
+#include "coresight-config.h"
+#include "coresight-syscfg.h"
+
+/*
+ * cscfg_ API manages configurations and features for the entire coresight
+ * infrastructure.
+ *
+ * It allows the loading of configurations and features, and loads these into
+ * coresight devices as appropriate.
+ */
+
+/* protect the cscsg_data and device */
+static DEFINE_MUTEX(cscfg_mutex);
+
+/* only one of these */
+static struct cscfg_manager *cscfg_mgr;
+
+/* load features and configuations into the lists */
+
+/* check feature list for a named feature - call with mutex locked. */
+static bool cscfg_match_list_feat(const char *name)
+{
+	struct cscfg_feature_desc *feat_desc;
+
+	list_for_each_entry(feat_desc, &cscfg_mgr->feat_desc_list, item) {
+		if (strcmp(feat_desc->name, name) == 0)
+			return true;
+	}
+	return false;
+}
+
+/* check all feat needed for cfg are in the list - call with mutex locked. */
+static int cscfg_check_feat_for_cfg(struct cscfg_config_desc *config_desc)
+{
+	int i;
+
+	for (i = 0; i < config_desc->nr_feat_refs; i++)
+		if (!cscfg_match_list_feat(config_desc->feat_ref_names[i]))
+			return -EINVAL;
+	return 0;
+}
+
+/*
+ * load feature - add to feature list.
+ */
+static int cscfg_load_feat(struct cscfg_feature_desc *feat_desc)
+{
+	list_add(&feat_desc->item, &cscfg_mgr->feat_desc_list);
+
+	return 0;
+}
+
+/*
+ * load config into the system - validate used features exist then add to
+ * config list.
+ */
+static int cscfg_load_config(struct cscfg_config_desc *config_desc)
+{
+	int err;
+
+	/* validate features are present */
+	err = cscfg_check_feat_for_cfg(config_desc);
+	if (err)
+		return err;
+
+	list_add(&config_desc->item, &cscfg_mgr->config_desc_list);
+	return 0;
+}
+
+/**
+ * cscfg_load_config_sets - API function to load feature and config sets.
+ *
+ * Take a 0 terminated array of feature descriptors and/or configuration
+ * descriptors and load into the system.
+ * Features are loaded first to ensure configuration dependencies can be met.
+ *
+ * @config_descs: 0 terminated array of configuration descriptors.
+ * @feat_descs:   0 terminated array of feature descriptors.
+ */
+int cscfg_load_config_sets(struct cscfg_config_desc **config_descs,
+			   struct cscfg_feature_desc **feat_descs)
+{
+	int err, i = 0;
+
+	mutex_lock(&cscfg_mutex);
+
+	/* load features first */
+	if (feat_descs) {
+		while (feat_descs[i]) {
+			err = cscfg_load_feat(feat_descs[i]);
+			if (err) {
+				pr_err("coresight-syscfg: Failed to load feature %s\n",
+				       feat_descs[i]->name);
+				goto exit_unlock;
+			}
+			i++;
+		}
+	}
+
+	/* next any configurations to check feature dependencies */
+	i = 0;
+	if (config_descs) {
+		while (config_descs[i]) {
+			err = cscfg_load_config(config_descs[i]);
+			if (err) {
+				pr_err("coresight-syscfg: Failed to load configuration %s\n",
+				       config_descs[i]->name);
+				goto exit_unlock;
+			}
+			i++;
+		}
+	}
+
+exit_unlock:
+	mutex_unlock(&cscfg_mutex);
+	return err;
+}
+EXPORT_SYMBOL_GPL(cscfg_load_config_sets);
+
+/* Initialise system configuration management device. */
+
+struct device *cscfg_device(void)
+{
+	return cscfg_mgr ? &cscfg_mgr->dev : NULL;
+}
+
+/* Must have a release function or the kernel will complain on module unload */
+static void cscfg_dev_release(struct device *dev)
+{
+	kfree(cscfg_mgr);
+	cscfg_mgr = NULL;
+}
+
+/* a device is needed to "own" some kernel elements such as sysfs entries.  */
+static int cscfg_create_device(void)
+{
+	struct device *dev;
+	int err = -ENOMEM;
+
+	mutex_lock(&cscfg_mutex);
+	if (cscfg_mgr) {
+		err = -EINVAL;
+		goto create_dev_exit_unlock;
+	}
+
+	cscfg_mgr = kzalloc(sizeof(struct cscfg_manager), GFP_KERNEL);
+	if (!cscfg_mgr)
+		goto create_dev_exit_unlock;
+
+	/* setup the device */
+	dev = cscfg_device();
+	dev->release = cscfg_dev_release;
+	dev->init_name = "cs_system_cfg";
+
+	err = device_register(dev);
+	if (err)
+		cscfg_dev_release(dev);
+
+create_dev_exit_unlock:
+	mutex_unlock(&cscfg_mutex);
+	return err;
+}
+
+static void cscfg_clear_device(void)
+{
+	mutex_lock(&cscfg_mutex);
+	device_unregister(cscfg_device());
+	mutex_unlock(&cscfg_mutex);
+}
+
+/* Initialise system config management API device  */
+int __init cscfg_init(void)
+{
+	int err = 0;
+
+	err = cscfg_create_device();
+	if (err)
+		return err;
+
+	INIT_LIST_HEAD(&cscfg_mgr->csdev_desc_list);
+	INIT_LIST_HEAD(&cscfg_mgr->feat_desc_list);
+	INIT_LIST_HEAD(&cscfg_mgr->config_desc_list);
+
+	dev_info(cscfg_device(), "CoreSight Configuration manager initialised");
+	return 0;
+}
+
+void cscfg_exit(void)
+{
+	cscfg_clear_device();
+}
diff --git a/drivers/hwtracing/coresight/coresight-syscfg.h b/drivers/hwtracing/coresight/coresight-syscfg.h
new file mode 100644
index 000000000000..18be9b58cd0b
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-syscfg.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Coresight system configuration driver.
+ */
+
+#ifndef CORESIGHT_SYSCFG_H
+#define CORESIGHT_SYSCFG_H
+
+#include <linux/coresight.h>
+#include <linux/device.h>
+
+#include "coresight-config.h"
+
+/**
+ * System configuration manager device.
+ *
+ * Contains lists of the loaded configurations and features, plus a list of CoreSight devices
+ * registered with the system as supporting configuration management.
+ *
+ * Need a device to 'own' some coresight system wide sysfs entries in
+ * perf events, configfs etc.
+ *
+ * @dev:		The device.
+ * @csdev_desc_list:	List of coresight devices registered with the configuration manager.
+ * @feat_desc_list:	List of feature descriptors to load into registered devices.
+ * @config_desc_list:	List of system configuration descriptors to load into registered devices.
+ */
+struct cscfg_manager {
+	struct device dev;
+	struct list_head csdev_desc_list;
+	struct list_head feat_desc_list;
+	struct list_head config_desc_list;
+};
+
+/* get reference to dev in cscfg_manager */
+struct device *cscfg_device(void);
+
+/* internal core operations for cscfg */
+int __init cscfg_init(void);
+void cscfg_exit(void);
+
+/* syscfg manager external API */
+int cscfg_load_config_sets(struct cscfg_config_desc **cfg_descs,
+			   struct cscfg_feature_desc **feat_descs);
+
+#endif /* CORESIGHT_SYSCFG_H */
-- 
2.17.1

