Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2E5307BEB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 18:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbhA1RMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 12:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbhA1RK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 12:10:28 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACBDC061793
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 09:09:47 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id c12so6164331wrc.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 09:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+I84Ah9HAhQFQY+9ttYXjL9562Vmyn65bXiKqmg1hRw=;
        b=y8ci6GQd3Slwv2A7+rmC8thvr/qTmgEX0ZMe6/eK3DGQ+CO/lwEB+u1//Tpv4nF/L8
         oePvv24cxhSh5RNhUbJJgTtIiSPU/bRaRFLXd5+OTY7cft3+H9bFHewID+I2bptTR9Lw
         U8PLV9ltG5/PAwC4f2FJSHCxpHyn7Jdm6rI6tR96GcwzoUJ+5wSVWnWFZbcAnqO1W1jf
         4g7rBoucgslp31h+qPCaEwoLuVlp3rLyaDaVNfSc9KOTr4GYFTrmv4vSYInhyUhd96VG
         qshcqXqjQH2e6kVjgIULDLLg/E2DdMDvbKo9BP//TsCT1bHpqSlNw1U7Vs5GFr54T6Ty
         CVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+I84Ah9HAhQFQY+9ttYXjL9562Vmyn65bXiKqmg1hRw=;
        b=lzUcQMSfkfsD2d3hoIg6A2/MRe0ItPeNZSFy6B39u0VYyqcSZ447LtCA4Ig1HgCEjX
         0jFs9AVSdqyxIbWqGRqu9v8VrAYX/8io9z5XhMHtf9IT9QFtc9sCt3/MhMgu123319aR
         aFEyURKbZwAQRZz5SJArdiU67yx5kjh1L9+pBcaoNUaHBr16bPZ+6DTqG4CCo1KJ9xXv
         DnIWLCIpxk6akNjmkzd6IM1ARS7AvqeF4Q9vIkuyh5d+5qtl2J/IVBPbk+trdoBs/kKy
         WV/6qFRNnWt19sE/fqeejSqyW4+rFce0F9zL9koWj3FjePhtYW6isZItv1mN+sQh3kOc
         Qy2w==
X-Gm-Message-State: AOAM531xk1SITNW5+dZShs1FIj2Ayg/16FEW8l8VXnF7jr+BHh/sHKpk
        tlSwLROoo9AAeNm6Hk+IlE0eRw==
X-Google-Smtp-Source: ABdhPJyJkPW89dQwrN2i9PxaUDEvS6ZnIU355J4pfYr/VzvnZpIs6X7RP8mAdxZOYPDqFpoitmuaGw==
X-Received: by 2002:a5d:58c2:: with SMTP id o2mr19164wrf.31.1611853785919;
        Thu, 28 Jan 2021 09:09:45 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6801:1801:40:2fca:953a:e6ba])
        by smtp.gmail.com with ESMTPSA id p15sm7622355wrt.15.2021.01.28.09.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 09:09:45 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, linux-doc@vger.kernel.org,
        suzuki.poulose@arm.com
Cc:     yabinc@google.com, corbet@lwn.net, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, tingwei@codeaurora.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v4 01/10] coresight: syscfg: Initial coresight system configuration
Date:   Thu, 28 Jan 2021 17:09:27 +0000
Message-Id: <20210128170936.9222-2-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210128170936.9222-1-mike.leach@linaro.org>
References: <20210128170936.9222-1-mike.leach@linaro.org>
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
---
 drivers/hwtracing/coresight/Makefile          |   2 +-
 .../hwtracing/coresight/coresight-config.h    | 167 +++++++++++++++
 drivers/hwtracing/coresight/coresight-core.c  |  12 +-
 .../hwtracing/coresight/coresight-etm-perf.c  |   2 +-
 .../hwtracing/coresight/coresight-etm-perf.h  |   2 +-
 .../hwtracing/coresight/coresight-syscfg.c    | 197 ++++++++++++++++++
 .../hwtracing/coresight/coresight-syscfg.h    |  54 +++++
 7 files changed, 432 insertions(+), 4 deletions(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-config.h
 create mode 100644 drivers/hwtracing/coresight/coresight-syscfg.c
 create mode 100644 drivers/hwtracing/coresight/coresight-syscfg.h

diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index f20e357758d1..4ce854c434b1 100644
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
index 000000000000..3fedf8ab3cee
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-config.h
@@ -0,0 +1,167 @@
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
+#define	CS_CFG_MATCH_CLASS_SRC_ALL	0x0001	/* match any source */
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
+ * Representation of register value.
+ *
+ * Supports full 64 bit register value, or 32 bit value with optional mask
+ * value.
+ *
+ * @type:	define register usage and interpretation.
+ * @offset:	the address offset for register in the hardware device (per device specification).
+ * @hw_info:	optional hardware device type specific information. (ETM / CTI specific etc)
+ * @val64:	64 bit value.
+ * @val32:	32 bit value.
+ * @mask32:	32 bit mask when using 32 bit value to access device register.
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
+	};
+};
+
+/**
+ * Device feature descriptor - combination of registers and parameters to
+ * program a device to implement a specific complex function.
+ *
+ * @name:	feature name.
+ * @brief:	brief description of the feature.
+ * @item:	List entry.
+ * @match_flags: matching information if loading into a device
+ * @nr_params:  number of parameters used.
+ * @params:	array of parameters used.
+ * @nr_regs:	number of registers used.
+ * @reg:	array of registers used.
+ */
+struct cscfg_feature_desc {
+	const char *name;
+	const char *brief;
+	struct list_head item;
+	u32 match_flags;
+	int nr_params;
+	struct cscfg_parameter_desc *params;
+	int nr_regs;
+	struct cscfg_regval_desc *regs;
+};
+
+/**
+ * Match descriptor - Device / feature matching when loading into devices
+ *
+ * Used by loading configurations to define which class or specific devices
+ * they want to match used features to, and registered devices to specify which
+ * matching class and information they support.
+ *
+ * The load process uses these matching pairs to load feature instances into
+ * matching devices.
+ *
+ * @match_flags:	used to match to a particular class of device.
+ *
+ */
+struct cscfg_match_desc {
+	u32 match_flags;
+};
+
+/**
+ * Descriptor for features referenced by a configuration.
+ *
+ * @name:	name of feature to use. Match against the @name in struct
+ *		cscfg_feature_desc.
+ * @match:	match info for the feature when used in this configuration -
+ *		may be all devices of a class or a specific device in that class.
+ */
+struct cscfg_config_feat_ref {
+	const char *name;
+	struct cscfg_match_desc match;
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
+ * @name:	name of the configuration - used for selection.
+ * @brief:	description of the purpose of the configuration.
+ * @item:	list entry.
+ * @nr_refs:	Number of features used in this configuration.
+ * @refs:	references to features used in this configuration..
+ * @nr_presets:	Number of sets of presets supplied by this configuration.
+ * @nr_total_params: Sum of all parameters declared by used features
+ * @presets:	Array of preset values.
+ *
+ */
+struct cscfg_config_desc {
+	const char *name;
+	const char *brief;
+	struct list_head item;
+	int nr_refs;
+	struct cscfg_config_feat_ref *refs;
+	int nr_presets;
+	int nr_total_params;
+	const u64 *presets; /* nr_presets * nr_total_params */
+};
+
+#endif /* _CORESIGHT_CORESIGHT_CONFIG_H */
diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 0062c8935653..6bd41de46648 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -21,6 +21,7 @@
 
 #include "coresight-etm-perf.h"
 #include "coresight-priv.h"
+#include "coresight-syscfg.h"
 
 static DEFINE_MUTEX(coresight_mutex);
 
@@ -1739,13 +1740,22 @@ static int __init coresight_init(void)
 
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
index bdc34ca449f7..a608081bd446 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -627,7 +627,7 @@ int __init etm_perf_init(void)
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
index 000000000000..f7e396a5f9cb
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-syscfg.c
@@ -0,0 +1,197 @@
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
+	struct cscfg_feature_desc *curr_item;
+
+	list_for_each_entry(curr_item, &cscfg_mgr->data.feat_desc_list, item) {
+		if (strcmp(curr_item->name, name) == 0)
+			return true;
+	}
+	return false;
+}
+
+/* check all feat needed for cfg are in the list - call with mutex locked. */
+static int cscfg_check_feat_for_cfg(struct cscfg_config_desc *cfg_desc)
+{
+	int i;
+
+	for (i = 0; i < cfg_desc->nr_refs; i++)
+		if (!cscfg_match_list_feat(cfg_desc->refs[i].name))
+			return -EINVAL;
+	return 0;
+}
+
+/*
+ * load feature - add to feature list.
+ */
+static int cscfg_load_feat(struct cscfg_feature_desc *feat_desc)
+{
+	list_add(&feat_desc->item, &cscfg_mgr->data.feat_desc_list);
+
+	return 0;
+}
+
+/*
+ * load config into the system - validate used features exist then add to
+ * config list.
+ */
+static int cscfg_load_config(struct cscfg_config_desc *cfg_desc)
+{
+	int err;
+
+	/* validate features are present */
+	err = cscfg_check_feat_for_cfg(cfg_desc);
+	if (err)
+		return err;
+
+	list_add(&cfg_desc->item, &cscfg_mgr->data.config_desc_list);
+
+	return 0;
+}
+
+/*
+ * External API function to load feature and config sets.
+ * Take a 0 terminated array of feature descriptors and/or configuration
+ * descriptors and load into the system.
+ * Features are loaded first to ensure configuration dependencies can be met.
+ */
+int cscfg_load_config_sets(struct cscfg_config_desc **cfg_descs,
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
+				goto do_unlock;
+			}
+			i++;
+		}
+	}
+
+	/* next any configurations to check feature dependencies */
+	i = 0;
+	if (cfg_descs) {
+		while (cfg_descs[i]) {
+			err = cscfg_load_config(cfg_descs[i]);
+			if (err) {
+				pr_err("coresight-syscfg: Failed to load configuration %s\n",
+				       cfg_descs[i]->name);
+				goto do_unlock;
+			}
+			i++;
+		}
+	}
+
+do_unlock:
+	mutex_unlock(&cscfg_mutex);
+	return err;
+}
+EXPORT_SYMBOL_GPL(cscfg_load_config_sets);
+
+/* Initialise system configuration management device. */
+
+struct device *to_device_cscfg(void)
+{
+	return cscfg_mgr ? &cscfg_mgr->dev : NULL;
+}
+
+/* Must have a release function or the kernel will complain on module unload */
+void cscfg_dev_release(struct device *dev)
+{
+	kfree(cscfg_mgr);
+	cscfg_mgr = NULL;
+}
+
+/* a device is needed to "own" some kernel elements such as sysfs entries.  */
+int cscfg_create_device(void)
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
+	dev = to_device_cscfg();
+	dev->release = cscfg_dev_release;
+	dev->init_name = "system_cfg";
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
+void cscfg_clear_device(void)
+{
+	mutex_lock(&cscfg_mutex);
+	device_unregister(to_device_cscfg());
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
+	INIT_LIST_HEAD(&cscfg_mgr->data.csdev_desc_list);
+	INIT_LIST_HEAD(&cscfg_mgr->data.feat_desc_list);
+	INIT_LIST_HEAD(&cscfg_mgr->data.config_desc_list);
+	cscfg_mgr->data.nr_csdev = 0;
+
+	dev_info(to_device_cscfg(), "CoreSight Configuration manager initialised");
+	return 0;
+}
+
+void __exit cscfg_exit(void)
+{
+	cscfg_clear_device();
+}
diff --git a/drivers/hwtracing/coresight/coresight-syscfg.h b/drivers/hwtracing/coresight/coresight-syscfg.h
new file mode 100644
index 000000000000..907ba8d3efea
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-syscfg.h
@@ -0,0 +1,54 @@
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
+ * System configuration manager API data.
+ *
+ * @csdev_list:		List of coresight devices registered with the configuration manager.
+ * @feat_desc_list:	List of feature descriptors to load into registered devices.
+ * @config_desc_list:	List of system configuration descriptors to load into registered devices.
+ * @nr_csdev:	Number of registered devices with the cscfg system
+ */
+struct cscfg_api_data {
+	struct list_head csdev_desc_list;
+	struct list_head feat_desc_list;
+	struct list_head config_desc_list;
+	int nr_csdev;
+};
+
+/* internal core operations for cscfg */
+int __init cscfg_init(void);
+void __exit cscfg_exit(void);
+
+/* syscfg manager external API */
+int cscfg_load_config_sets(struct cscfg_config_desc **cfg_descs,
+			   struct cscfg_feature_desc **feat_descs);
+
+/**
+ * System configuration manager device.
+ *
+ * Need a device to 'own' some coresight system wide sysfs entries in
+ * perf events, configfs etc.
+ *
+ * @dev:	The device.
+ * @data:	The API data.
+ */
+struct cscfg_manager {
+	struct device dev;
+	struct cscfg_api_data data;
+};
+
+/* get reference to dev in cscfg_manager */
+struct device *to_device_cscfg(void);
+
+#endif /* CORESIGHT_SYSCFG_H */
-- 
2.17.1

