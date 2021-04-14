Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27D635FB8E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 21:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353333AbhDNTU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 15:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353247AbhDNTTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 15:19:38 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88F3C061343
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 12:19:14 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id b136-20020a1c1b8e0000b029012c69da2040so3724024wmb.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 12:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2fs9yzgZefmIkPvtPeZDfAhTO9TS4pRwu9mbuRA3gso=;
        b=xskKtKVs1VVBGxZ1M+P5OObpsddAfevle6FkX7M++GruAtxbUF1WtPSHXGSO9m6XWv
         GWgk93I2jrmayP8/utJ/lrB30GnT1yGTnO6o4y5gZMwZFsgcIUpQNlE/1ncHcONu4oAv
         c4JbIor6op5e9kanjPTq1ybBDIPX9g3Zntdt+VvLExPIZpNnG7OxhocEUzGsE6s4I+bE
         6D6BvUJvjwJNE4mWoOGGICf7hA15uwY15xVlbhClhlS6zM1fp08oO6DDC05S+AM9BpiR
         vGlSwiXl1iNhesXxHFbY2LX3vAgnBu0Dl8Xk1ZBxWoFBvcEpdNw7FRbDmKBYx9TCU4JB
         Ligw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2fs9yzgZefmIkPvtPeZDfAhTO9TS4pRwu9mbuRA3gso=;
        b=aJ3W4XQG6tCZTPgjq6r3TU96adXwIzhCmXgnrGO3w2JXZcvV7YpuF4FDzIrap6j4lq
         N5MxsDNc6psonwA9Tebd0jLhNV0rXq/IyfvauLrmsaioYcb6cw2xtLpQ/irFQwBJEYeB
         lG9HAvaRbL6fdB8ouzk/pBIL9AiyReXv5GuO40odEb5W4i9ziMSLjkN1G6A4//wD8kHH
         Py5Wl8XY6cAETJOzR0wDgGzM4zY7v5qV81FJRQav2HcUc5DItWHqfOrh2nw8UoksDLbo
         MhLq5NkawWV7XAel9yIiDtDk2EDTO/x8XUVzM0KBILi0NT2Wsh7SkmTyJ33FR6piJlID
         cH/A==
X-Gm-Message-State: AOAM5313X8Fvrs9luR/OLC6lgZUZlG2xXKKp0J/rvAmfbI/+vHxJdvEy
        W0NtavDRnzMd/j98PZZkhE6bRw==
X-Google-Smtp-Source: ABdhPJx2AaOdj5WpfZvbJav6Jv+ssiRUBQrj9NzjIQ1yDkRH36Kdxe9lOseZXKN04Q08XYfVT3PjmQ==
X-Received: by 2002:a7b:c394:: with SMTP id s20mr4496532wmj.4.1618427953346;
        Wed, 14 Apr 2021 12:19:13 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:546d:7d59:1703:bf96])
        by smtp.gmail.com with ESMTPSA id a3sm327073wru.40.2021.04.14.12.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 12:19:13 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, linux-doc@vger.kernel.org,
        suzuki.poulose@arm.com
Cc:     yabinc@google.com, corbet@lwn.net, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, tingwei@codeaurora.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v7 09/10] coresight: syscfg: Add initial configfs support
Date:   Wed, 14 Apr 2021 20:19:02 +0100
Message-Id: <20210414191903.18349-10-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210414191903.18349-1-mike.leach@linaro.org>
References: <20210414191903.18349-1-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds configfs subsystem and attributes to the configuration manager
to enable the listing of loaded configurations and features.

The default values of feature parameters can be accessed and altered
from these attributes to affect all installed devices using the feature.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/Makefile          |   3 +-
 .../coresight/coresight-syscfg-configfs.c     | 396 ++++++++++++++++++
 .../coresight/coresight-syscfg-configfs.h     |  45 ++
 .../hwtracing/coresight/coresight-syscfg.c    |  76 ++++
 .../hwtracing/coresight/coresight-syscfg.h    |   7 +
 5 files changed, 526 insertions(+), 1 deletion(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-syscfg-configfs.c
 create mode 100644 drivers/hwtracing/coresight/coresight-syscfg-configfs.h

diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index ad44f0fe3069..b6c4a48140ec 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -5,7 +5,8 @@
 obj-$(CONFIG_CORESIGHT) += coresight.o
 coresight-y := coresight-core.o  coresight-etm-perf.o coresight-platform.o \
 		coresight-sysfs.o coresight-syscfg.o coresight-config.o \
-		coresight-cfg-preload.o coresight-cfg-afdo.o
+		coresight-cfg-preload.o coresight-cfg-afdo.o \
+		coresight-syscfg-configfs.o
 obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o
 coresight-tmc-y := coresight-tmc-core.o coresight-tmc-etf.o \
 		      coresight-tmc-etr.o
diff --git a/drivers/hwtracing/coresight/coresight-syscfg-configfs.c b/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
new file mode 100644
index 000000000000..c547816b9000
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
@@ -0,0 +1,396 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 Linaro Limited, All rights reserved.
+ * Author: Mike Leach <mike.leach@linaro.org>
+ */
+
+#include <linux/configfs.h>
+
+#include "coresight-syscfg-configfs.h"
+
+/* create a default ci_type. */
+static inline struct config_item_type *cscfg_create_ci_type(void)
+{
+	struct config_item_type *ci_type;
+
+	ci_type = devm_kzalloc(cscfg_device(), sizeof(*ci_type), GFP_KERNEL);
+	if (ci_type)
+		ci_type->ct_owner = THIS_MODULE;
+
+	return ci_type;
+}
+
+/* configurations sub-group */
+
+/* attributes for the config view group */
+static ssize_t cscfg_cfg_description_show(struct config_item *item, char *page)
+{
+	struct cscfg_fs_config *fs_config = container_of(to_config_group(item),
+							 struct cscfg_fs_config, group);
+
+	return scnprintf(page, PAGE_SIZE, "%s", fs_config->config_desc->description);
+}
+CONFIGFS_ATTR_RO(cscfg_cfg_, description);
+
+static ssize_t cscfg_cfg_feature_refs_show(struct config_item *item, char *page)
+{
+	struct cscfg_fs_config *fs_config = container_of(to_config_group(item),
+							 struct cscfg_fs_config, group);
+	const struct cscfg_config_desc *config_desc = fs_config->config_desc;
+	ssize_t ch_used = 0;
+	int i;
+
+	for (i = 0; i < config_desc->nr_feat_refs; i++)
+		ch_used += scnprintf(page + ch_used, PAGE_SIZE - ch_used,
+				     "%s\n", config_desc->feat_ref_names[i]);
+	return ch_used;
+}
+CONFIGFS_ATTR_RO(cscfg_cfg_, feature_refs);
+
+/* list preset values in order of features and params */
+static ssize_t cscfg_cfg_values_show(struct config_item *item, char *page)
+{
+	const struct cscfg_feature_desc *feat_desc;
+	const struct cscfg_config_desc *config_desc;
+	struct cscfg_fs_preset *fs_preset;
+	int i, j, val_idx, preset_idx;
+	ssize_t used = 0;
+
+	fs_preset = container_of(to_config_group(item), struct cscfg_fs_preset, group);
+	config_desc = fs_preset->config_desc;
+
+	if (!config_desc->nr_presets)
+		return 0;
+
+	preset_idx = fs_preset->preset_num - 1;
+
+	/* start index on the correct array line */
+	val_idx = config_desc->nr_total_params * preset_idx;
+
+	/*
+	 * A set of presets is the sum of all params in used features,
+	 * in order of declaration of features and params in the features
+	 */
+	for (i = 0; i < config_desc->nr_feat_refs; i++) {
+		feat_desc = cscfg_get_named_feat_desc(config_desc->feat_ref_names[i]);
+		for (j = 0; j < feat_desc->nr_params; j++) {
+			used += scnprintf(page + used, PAGE_SIZE - used,
+					  "%s.%s = 0x%llx ",
+					  feat_desc->name,
+					  feat_desc->params_desc[j].name,
+					  config_desc->presets[val_idx++]);
+		}
+	}
+	used += scnprintf(page + used, PAGE_SIZE - used, "\n");
+
+	return used;
+}
+CONFIGFS_ATTR_RO(cscfg_cfg_, values);
+
+static struct configfs_attribute *cscfg_config_view_attrs[] = {
+	&cscfg_cfg_attr_description,
+	&cscfg_cfg_attr_feature_refs,
+	NULL,
+};
+
+static struct config_item_type cscfg_config_view_type = {
+	.ct_owner = THIS_MODULE,
+	.ct_attrs = cscfg_config_view_attrs,
+};
+
+static struct configfs_attribute *cscfg_config_preset_attrs[] = {
+	&cscfg_cfg_attr_values,
+	NULL,
+};
+
+static struct config_item_type cscfg_config_preset_type = {
+	.ct_owner = THIS_MODULE,
+	.ct_attrs = cscfg_config_preset_attrs,
+};
+
+static int cscfg_add_preset_groups(struct cscfg_fs_config *cfg_view)
+{
+	int preset_num;
+	struct cscfg_fs_preset *cfg_fs_preset;
+	struct cscfg_config_desc *config_desc = cfg_view->config_desc;
+	char name[CONFIGFS_ITEM_NAME_LEN];
+
+	if (!config_desc->nr_presets)
+		return 0;
+
+	for (preset_num = 1; preset_num <= config_desc->nr_presets; preset_num++) {
+		cfg_fs_preset = devm_kzalloc(cscfg_device(),
+					     sizeof(struct cscfg_fs_preset), GFP_KERNEL);
+
+		if (!cfg_fs_preset)
+			return -ENOMEM;
+
+		snprintf(name, CONFIGFS_ITEM_NAME_LEN, "preset%d", preset_num);
+		cfg_fs_preset->preset_num = preset_num;
+		cfg_fs_preset->config_desc = cfg_view->config_desc;
+		config_group_init_type_name(&cfg_fs_preset->group, name,
+					    &cscfg_config_preset_type);
+		configfs_add_default_group(&cfg_fs_preset->group, &cfg_view->group);
+	}
+	return 0;
+}
+
+static struct config_group *cscfg_create_config_group(struct cscfg_config_desc *config_desc)
+{
+	struct cscfg_fs_config *cfg_view;
+	struct device *dev = cscfg_device();
+	int err;
+
+	if (!dev)
+		return ERR_PTR(-EINVAL);
+
+	cfg_view = devm_kzalloc(dev, sizeof(struct cscfg_fs_config), GFP_KERNEL);
+	if (!cfg_view)
+		return ERR_PTR(-ENOMEM);
+
+	cfg_view->config_desc = config_desc;
+	config_group_init_type_name(&cfg_view->group, config_desc->name, &cscfg_config_view_type);
+
+	/* add in a preset<n> dir for each preset */
+	err = cscfg_add_preset_groups(cfg_view);
+	if (err)
+		return ERR_PTR(err);
+
+	return &cfg_view->group;
+}
+
+/* attributes for features view */
+
+static ssize_t cscfg_feat_description_show(struct config_item *item, char *page)
+{
+	struct cscfg_fs_feature *fs_feat = container_of(to_config_group(item),
+							struct cscfg_fs_feature, group);
+
+	return scnprintf(page, PAGE_SIZE, "%s", fs_feat->feat_desc->description);
+}
+CONFIGFS_ATTR_RO(cscfg_feat_, description);
+
+static ssize_t cscfg_feat_matches_show(struct config_item *item, char *page)
+{
+	struct cscfg_fs_feature *fs_feat = container_of(to_config_group(item),
+							struct cscfg_fs_feature, group);
+	u32 match_flags = fs_feat->feat_desc->match_flags;
+	int used = 0;
+
+	if (match_flags & CS_CFG_MATCH_CLASS_SRC_ALL)
+		used = scnprintf(page, PAGE_SIZE, "SRC_ALL ");
+
+	if (match_flags & CS_CFG_MATCH_CLASS_SRC_ETM4)
+		used += scnprintf(page + used, PAGE_SIZE - used, "SRC_ETMV4 ");
+
+	used += scnprintf(page + used, PAGE_SIZE - used, "\n");
+	return used;
+}
+CONFIGFS_ATTR_RO(cscfg_feat_, matches);
+
+static ssize_t cscfg_feat_nr_params_show(struct config_item *item, char *page)
+{
+	struct cscfg_fs_feature *fs_feat = container_of(to_config_group(item),
+							struct cscfg_fs_feature, group);
+
+	return scnprintf(page, PAGE_SIZE, "%d\n", fs_feat->feat_desc->nr_params);
+}
+CONFIGFS_ATTR_RO(cscfg_feat_, nr_params);
+
+/* base feature desc attrib structures */
+static struct configfs_attribute *cscfg_feature_view_attrs[] = {
+	&cscfg_feat_attr_description,
+	&cscfg_feat_attr_matches,
+	&cscfg_feat_attr_nr_params,
+	NULL,
+};
+
+static struct config_item_type cscfg_feature_view_type = {
+	.ct_owner = THIS_MODULE,
+	.ct_attrs = cscfg_feature_view_attrs,
+};
+
+static ssize_t cscfg_param_value_show(struct config_item *item, char *page)
+{
+	struct cscfg_fs_param *param_item = container_of(to_config_group(item),
+							 struct cscfg_fs_param, group);
+	u64 value = param_item->feat_desc->params_desc[param_item->param_idx].value;
+
+	return scnprintf(page, PAGE_SIZE, "0x%llx\n", value);
+}
+
+static ssize_t cscfg_param_value_store(struct config_item *item,
+				       const char *page, size_t size)
+{
+	struct cscfg_fs_param *param_item = container_of(to_config_group(item),
+							 struct cscfg_fs_param, group);
+	struct cscfg_feature_desc *feat_desc = param_item->feat_desc;
+	int param_idx = param_item->param_idx;
+	u64 value;
+	int err;
+
+	err = kstrtoull(page, 0, &value);
+	if (!err)
+		err = cscfg_update_feat_param_val(feat_desc, param_idx, value);
+
+	return err ? err : size;
+}
+CONFIGFS_ATTR(cscfg_param_, value);
+
+static struct configfs_attribute *cscfg_param_view_attrs[] = {
+	&cscfg_param_attr_value,
+	NULL,
+};
+
+static struct config_item_type cscfg_param_view_type = {
+	.ct_owner = THIS_MODULE,
+	.ct_attrs = cscfg_param_view_attrs,
+};
+
+/*
+ * configfs has far less functionality provided to add attributes dynamically than sysfs,
+ * and the show and store fns pass the enclosing config_item so the actual attribute cannot
+ * be determined. Therefore we add each item as a group directory, with a value attribute.
+ */
+static int cscfg_create_params_group_items(struct cscfg_feature_desc *feat_desc,
+					   struct config_group *params_group)
+{
+	struct device *dev = cscfg_device();
+	struct cscfg_fs_param *param_item;
+	int i;
+
+	/* parameter items - as groups with default_value attribute */
+	for (i = 0; i < feat_desc->nr_params; i++) {
+		param_item = devm_kzalloc(dev, sizeof(struct cscfg_fs_param), GFP_KERNEL);
+		if (!param_item)
+			return -ENOMEM;
+		param_item->feat_desc = feat_desc;
+		param_item->param_idx = i;
+		config_group_init_type_name(&param_item->group,
+					    feat_desc->params_desc[i].name,
+					    &cscfg_param_view_type);
+		configfs_add_default_group(&param_item->group, params_group);
+	}
+	return 0;
+}
+
+static struct config_group *cscfg_create_feature_group(struct cscfg_feature_desc *feat_desc)
+{
+	struct cscfg_fs_feature *feat_view;
+	struct config_item_type *params_group_type;
+	struct config_group *params_group = NULL;
+	struct device *dev = cscfg_device();
+	int item_err;
+
+	if (!dev)
+		return ERR_PTR(-EINVAL);
+
+	feat_view = devm_kzalloc(dev, sizeof(struct cscfg_fs_feature), GFP_KERNEL);
+	if (!feat_view)
+		return ERR_PTR(-ENOMEM);
+
+	if (feat_desc->nr_params) {
+		params_group = devm_kzalloc(dev, sizeof(struct config_group), GFP_KERNEL);
+		if (!params_group)
+			return ERR_PTR(-ENOMEM);
+
+		params_group_type = cscfg_create_ci_type();
+		if (!params_group_type)
+			return ERR_PTR(-ENOMEM);
+	}
+
+	feat_view->feat_desc = feat_desc;
+	config_group_init_type_name(&feat_view->group,
+				    feat_desc->name,
+				    &cscfg_feature_view_type);
+	if (params_group) {
+		config_group_init_type_name(params_group, "params", params_group_type);
+		configfs_add_default_group(params_group, &feat_view->group);
+		item_err = cscfg_create_params_group_items(feat_desc, params_group);
+		if (item_err)
+			return ERR_PTR(item_err);
+	}
+	return &feat_view->group;
+}
+
+static struct config_item_type cscfg_configs_type = {
+	.ct_owner = THIS_MODULE,
+};
+
+static struct config_group cscfg_configs_grp = {
+	.cg_item = {
+		.ci_namebuf = "configurations",
+		.ci_type = &cscfg_configs_type,
+	},
+};
+
+/* add configuration to configurations group */
+int cscfg_configfs_add_config(struct cscfg_config_desc *config_desc)
+{
+	struct config_group *new_group;
+	int err;
+
+	new_group = cscfg_create_config_group(config_desc);
+	if (IS_ERR(new_group))
+		return PTR_ERR(new_group);
+	err =  configfs_register_group(&cscfg_configs_grp, new_group);
+	return err;
+}
+
+static struct config_item_type cscfg_features_type = {
+	.ct_owner = THIS_MODULE,
+};
+
+static struct config_group cscfg_features_grp = {
+	.cg_item = {
+		.ci_namebuf = "features",
+		.ci_type = &cscfg_features_type,
+	},
+};
+
+/* add feature to features group */
+int cscfg_configfs_add_feature(struct cscfg_feature_desc *feat_desc)
+{
+	struct config_group *new_group;
+	int err;
+
+	new_group = cscfg_create_feature_group(feat_desc);
+	if (IS_ERR(new_group))
+		return PTR_ERR(new_group);
+	err =  configfs_register_group(&cscfg_features_grp, new_group);
+	return err;
+}
+
+int cscfg_configfs_init(struct cscfg_manager *cscfg_mgr)
+{
+	struct configfs_subsystem *subsys;
+	struct config_item_type *ci_type;
+
+	if (!cscfg_mgr)
+		return -EINVAL;
+
+	ci_type = cscfg_create_ci_type();
+	if (!ci_type)
+		return -ENOMEM;
+
+	subsys = &cscfg_mgr->cfgfs_subsys;
+	config_item_set_name(&subsys->su_group.cg_item, CSCFG_FS_SUBSYS_NAME);
+	subsys->su_group.cg_item.ci_type = ci_type;
+
+	config_group_init(&subsys->su_group);
+	mutex_init(&subsys->su_mutex);
+
+	/* Add default groups to subsystem */
+	config_group_init(&cscfg_configs_grp);
+	configfs_add_default_group(&cscfg_configs_grp, &subsys->su_group);
+
+	config_group_init(&cscfg_features_grp);
+	configfs_add_default_group(&cscfg_features_grp, &subsys->su_group);
+
+	return configfs_register_subsystem(subsys);
+}
+
+void cscfg_configfs_release(struct cscfg_manager *cscfg_mgr)
+{
+	configfs_unregister_subsystem(&cscfg_mgr->cfgfs_subsys);
+}
diff --git a/drivers/hwtracing/coresight/coresight-syscfg-configfs.h b/drivers/hwtracing/coresight/coresight-syscfg-configfs.h
new file mode 100644
index 000000000000..7d6ffe35ca4c
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-syscfg-configfs.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Coresight system configuration driver - support for configfs.
+ */
+
+#ifndef CORESIGHT_SYSCFG_CONFIGFS_H
+#define CORESIGHT_SYSCFG_CONFIGFS_H
+
+#include <linux/configfs.h>
+#include "coresight-syscfg.h"
+
+#define CSCFG_FS_SUBSYS_NAME "cs-syscfg"
+
+/* container for configuration view */
+struct cscfg_fs_config {
+	struct cscfg_config_desc *config_desc;
+	struct config_group group;
+};
+
+/* container for feature view */
+struct cscfg_fs_feature {
+	struct cscfg_feature_desc *feat_desc;
+	struct config_group group;
+};
+
+/* container for parameter view */
+struct cscfg_fs_param {
+	int param_idx;
+	struct cscfg_feature_desc *feat_desc;
+	struct config_group group;
+};
+
+/* container for preset view */
+struct cscfg_fs_preset {
+	int preset_num;
+	struct cscfg_config_desc *config_desc;
+	struct config_group group;
+};
+
+int cscfg_configfs_init(struct cscfg_manager *cscfg_mgr);
+void cscfg_configfs_release(struct cscfg_manager *cscfg_mgr);
+int cscfg_configfs_add_config(struct cscfg_config_desc *config_desc);
+int cscfg_configfs_add_feature(struct cscfg_feature_desc *feat_desc);
+
+#endif /* CORESIGHT_SYSCFG_CONFIGFS_H */
diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
index 41f742190639..180202402eb5 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg.c
+++ b/drivers/hwtracing/coresight/coresight-syscfg.c
@@ -9,6 +9,7 @@
 #include "coresight-config.h"
 #include "coresight-etm-perf.h"
 #include "coresight-syscfg.h"
+#include "coresight-syscfg-configfs.h"
 
 /*
  * cscfg_ API manages configurations and features for the entire coresight
@@ -287,6 +288,72 @@ static int cscfg_load_config(struct cscfg_config_desc *config_desc)
 	return 0;
 }
 
+/* get a feature descriptor by name */
+const struct cscfg_feature_desc *cscfg_get_named_feat_desc(const char *name)
+{
+	const struct cscfg_feature_desc *feat_desc = NULL, *feat_desc_item;
+
+	mutex_lock(&cscfg_mutex);
+
+	list_for_each_entry(feat_desc_item, &cscfg_mgr->feat_desc_list, item) {
+		if (strcmp(feat_desc_item->name, name) == 0) {
+			feat_desc = feat_desc_item;
+			break;
+		}
+	}
+
+	mutex_unlock(&cscfg_mutex);
+	return feat_desc;
+}
+
+/* called with cscfg_mutex held */
+static struct cscfg_feature_csdev *
+cscfg_csdev_get_feat_from_desc(struct coresight_device *csdev,
+			       struct cscfg_feature_desc *feat_desc)
+{
+	struct cscfg_feature_csdev *feat_csdev;
+
+	list_for_each_entry(feat_csdev, &csdev->feature_csdev_list, node) {
+		if (feat_csdev->feat_desc == feat_desc)
+			return feat_csdev;
+	}
+	return NULL;
+}
+
+int cscfg_update_feat_param_val(struct cscfg_feature_desc *feat_desc,
+				int param_idx, u64 value)
+{
+	int err = 0;
+	struct cscfg_feature_csdev *feat_csdev;
+	struct cscfg_registered_csdev *csdev_item;
+
+	mutex_lock(&cscfg_mutex);
+
+	/* check if any config active & return busy */
+	if (atomic_read(&cscfg_mgr->sys_active_cnt)) {
+		err = -EBUSY;
+		goto unlock_exit;
+	}
+
+	/* set the value */
+	if ((param_idx < 0) || (param_idx >= feat_desc->nr_params)) {
+		err = -EINVAL;
+		goto unlock_exit;
+	}
+	feat_desc->params_desc[param_idx].value = value;
+
+	/* update loaded instances.*/
+	list_for_each_entry(csdev_item, &cscfg_mgr->csdev_desc_list, item) {
+		feat_csdev = cscfg_csdev_get_feat_from_desc(csdev_item->csdev, feat_desc);
+		if (feat_csdev)
+			feat_csdev->params_csdev[param_idx].current_value = value;
+	}
+
+unlock_exit:
+	mutex_unlock(&cscfg_mutex);
+	return err;
+}
+
 /**
  * cscfg_load_config_sets - API function to load feature and config sets.
  *
@@ -308,6 +375,8 @@ int cscfg_load_config_sets(struct cscfg_config_desc **config_descs,
 	if (feat_descs) {
 		while (feat_descs[i]) {
 			err = cscfg_load_feat(feat_descs[i]);
+			if (!err)
+				err = cscfg_configfs_add_feature(feat_descs[i]);
 			if (err) {
 				pr_err("coresight-syscfg: Failed to load feature %s\n",
 				       feat_descs[i]->name);
@@ -322,6 +391,8 @@ int cscfg_load_config_sets(struct cscfg_config_desc **config_descs,
 	if (config_descs) {
 		while (config_descs[i]) {
 			err = cscfg_load_config(config_descs[i]);
+			if (!err)
+				err = cscfg_configfs_add_config(config_descs[i]);
 			if (err) {
 				pr_err("coresight-syscfg: Failed to load configuration %s\n",
 				       config_descs[i]->name);
@@ -691,6 +762,7 @@ static void cscfg_clear_device(void)
 	list_for_each_entry(cfg_desc, &cscfg_mgr->config_desc_list, item) {
 		etm_perf_del_symlink_cscfg(cfg_desc);
 	}
+	cscfg_configfs_release(cscfg_mgr);
 	device_unregister(cscfg_device());
 	mutex_unlock(&cscfg_mutex);
 }
@@ -704,6 +776,10 @@ int __init cscfg_init(void)
 	if (err)
 		return err;
 
+	err = cscfg_configfs_init(cscfg_mgr);
+	if (err)
+		goto exit_err;
+
 	INIT_LIST_HEAD(&cscfg_mgr->csdev_desc_list);
 	INIT_LIST_HEAD(&cscfg_mgr->feat_desc_list);
 	INIT_LIST_HEAD(&cscfg_mgr->config_desc_list);
diff --git a/drivers/hwtracing/coresight/coresight-syscfg.h b/drivers/hwtracing/coresight/coresight-syscfg.h
index 7bb8c8e497ba..8d018efd6ead 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg.h
+++ b/drivers/hwtracing/coresight/coresight-syscfg.h
@@ -6,6 +6,7 @@
 #ifndef CORESIGHT_SYSCFG_H
 #define CORESIGHT_SYSCFG_H
 
+#include <linux/configfs.h>
 #include <linux/coresight.h>
 #include <linux/device.h>
 
@@ -25,6 +26,7 @@
  * @feat_desc_list:	List of feature descriptors to load into registered devices.
  * @config_desc_list:	List of system configuration descriptors to load into registered devices.
  * @sys_active_cnt:	Total number of active config descriptor references.
+ * @cfgfs_subsys:	configfs subsystem used to manage configurations.
  */
 struct cscfg_manager {
 	struct device dev;
@@ -32,6 +34,7 @@ struct cscfg_manager {
 	struct list_head feat_desc_list;
 	struct list_head config_desc_list;
 	atomic_t sys_active_cnt;
+	struct configfs_subsystem cfgfs_subsys;
 };
 
 /* get reference to dev in cscfg_manager */
@@ -57,6 +60,10 @@ struct cscfg_registered_csdev {
 int __init cscfg_init(void);
 void cscfg_exit(void);
 int cscfg_preload(void);
+const struct cscfg_feature_desc *cscfg_get_named_feat_desc(const char *name);
+int cscfg_update_feat_param_val(struct cscfg_feature_desc *feat_desc,
+				int param_idx, u64 value);
+
 
 /* syscfg manager external API */
 int cscfg_load_config_sets(struct cscfg_config_desc **cfg_descs,
-- 
2.17.1

