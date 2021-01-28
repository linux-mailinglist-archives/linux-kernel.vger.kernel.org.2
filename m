Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723B2307CFF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 18:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbhA1RuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 12:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbhA1RK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 12:10:29 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E0AC061794
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 09:09:48 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id j18so4910149wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 09:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WBMJjKwLmtSeS700sltQEAd7gwZv9CAX55ksnY87WLc=;
        b=LbTsJ4H8H0YDnpW1WBjcC4VcKibzRXfXGeZtIzy1MepjLHgBRB1zQAgahLxH9Jg2ra
         izXMFaG7GwHosbpmLGq+rdQabjXuPkk+nXiaktkO5KA+8S3MmBgL5P2B5Q6o0oXmvcXT
         WhGaea/OJfCS1dERandLRvXgzQ1SEUp+Cj3W8anPyoGZUinufJDJRQms7J4GokMgbwAY
         paULEDAVbIRHOPjfqR9YC0HflLbq6vBET9teYKe3/au9iyCEBDVD5hOtZbn83LDdVLRC
         kDwQ+kFpfzT17IeFrAHgIZvLCdT0KxW3+aoKu2/YxuE+DQ+A655D5pp1rSKMyqhFcvTH
         gRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WBMJjKwLmtSeS700sltQEAd7gwZv9CAX55ksnY87WLc=;
        b=nF1aeAPwe4VAsl5WVNbRQUCs8Fmf7Xbi9qp4zOk7QZzwqaviT2A3swoVyrQNO9xeYe
         Zdmt/pDyn1dDhQ9AxlQtvviPsohsOWqFQNKnFMS0R9RTIp78drWVRB5jP6A/idfkii9e
         3lCbcIYNd1po7hT/wQMSvlv7Ktj7ErCbSY6jCW+NDDOPwngew1xAWU2g4/dqZqOxJ1pP
         9cislFcS76+YB9TeW5SbFbtyHnMUkiAfNeG/xoz+sSFyjpShhubP2+Ty+Lr+UI7ZIOQP
         L3qjuK+69LFXJeu5PMh17rrSAgx9pCDYSmo3lrcilpiVANJsrFTBLbYBQXnOEUcDBcwr
         L0ww==
X-Gm-Message-State: AOAM531bL6Oaq6iuu0AhzW0o+laQmL9iztEGRz7Z0QqYeGWXl9znjU8i
        nR+t5Z4K0rwggy9V+E8/znZoJg==
X-Google-Smtp-Source: ABdhPJxVGC1hJAPqP9irGz3HLKRLWrX8JqHsr0MdZ33bX1eMslQS8dR2aLDIMni3XMMkHie/S4dDQQ==
X-Received: by 2002:a05:600c:4f50:: with SMTP id m16mr181493wmq.175.1611853786894;
        Thu, 28 Jan 2021 09:09:46 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6801:1801:40:2fca:953a:e6ba])
        by smtp.gmail.com with ESMTPSA id p15sm7622355wrt.15.2021.01.28.09.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 09:09:46 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, linux-doc@vger.kernel.org,
        suzuki.poulose@arm.com
Cc:     yabinc@google.com, corbet@lwn.net, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, tingwei@codeaurora.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v4 02/10] coresight: syscfg: Add registration and feature loading for cs devices
Date:   Thu, 28 Jan 2021 17:09:28 +0000
Message-Id: <20210128170936.9222-3-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210128170936.9222-1-mike.leach@linaro.org>
References: <20210128170936.9222-1-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

API for individual devices to register with the syscfg management
system is added.

Devices register with matching information, and any features or
configurations that match will be loaded into the device.

The feature and configuration loading is extended so that on load these
are loaded into any currently registered devices. This allows
configuration loading after devices have been registered.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 .../hwtracing/coresight/coresight-config.h    |  98 +++++
 .../hwtracing/coresight/coresight-syscfg.c    | 348 ++++++++++++++++++
 .../hwtracing/coresight/coresight-syscfg.h    |  20 +
 include/linux/coresight.h                     |   5 +
 4 files changed, 471 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
index 3fedf8ab3cee..75ecdecf7013 100644
--- a/drivers/hwtracing/coresight/coresight-config.h
+++ b/drivers/hwtracing/coresight/coresight-config.h
@@ -164,4 +164,102 @@ struct cscfg_config_desc {
 	const u64 *presets; /* nr_presets * nr_total_params */
 };
 
+/**
+ * config register instance - part of a loaded feature.
+ *                            maps register values to csdev driver structures
+ *
+ * @value:	value to use when setting feature on device / store for
+ *		readback of volatile values.
+ * @drv_store:	pointer to internal driver element used to set the value
+ *		in hardware.
+ */
+struct cscfg_reg_csdev {
+	struct cscfg_regval_desc value;
+	void *drv_store;
+};
+
+/**
+ * config parameter instance - part of a loaded feature.
+ *
+ * @feat:		parent feature
+ * @reg:		register value updated by this parameter.
+ * @current_value:	current value of parameter - may be set by user via
+ *			sysfs, or modified during device operation.
+ * @val64:		true if 64 bit value
+ */
+struct cscfg_parameter_csdev {
+	struct cscfg_feature_csdev *feat;
+	struct cscfg_reg_csdev *reg;
+	u64 current_value;
+	bool val64;
+};
+
+/**
+ * Feature instance loaded into a CoreSight device.
+ *
+ * When a feature is loaded into a specific device, then this structure holds
+ * the connections between the register / parameter values used and the
+ * internal data structures that are written when the feature is enabled.
+ *
+ * Since applying a feature modifies internal data structures in the device,
+ * then we have a reference to the device spinlock to protect access to these
+ * structures (@csdev_spinlock).
+ *
+ * @desc:		pointer to the static descriptor for this feature.
+ * @csdev:		parent CoreSight device instance.
+ * @node:		list entry into feature list for this device.
+ * @csdev_spinlock:	device spinlock from csdev instance..
+ * @nr_params:		number of parameters.
+ * @params:		current parameter values on this device
+ * @nr_regs:		number of registers to be programmed.
+ * @regs:		Programming details for the registers
+ */
+struct cscfg_feature_csdev {
+	const struct cscfg_feature_desc *desc;
+	struct coresight_device *csdev;
+	struct list_head node;
+	spinlock_t *csdev_spinlock;
+	int nr_params;
+	struct cscfg_parameter_csdev *params;
+	int nr_regs;
+	struct cscfg_reg_csdev *regs;
+};
+
+/**
+ * Configuration instance when loaded into a CoreSight device.
+ *
+ * The instance contains references to loaded features on this device that are
+ * used by the configuration.
+ *
+ * @desc:	reference to the descriptor for this configuration
+ * @csdev:	parent coresight device for this configuration instance.
+ * @node:	list entry within the coresight device
+ * @nr_feat:	Number of features on this device that are used in the
+ *		 configuration.
+ * @feats:	reference to the device features to enable.
+ * @enabled:	true if configuration is enabled on this device.
+ */
+struct cscfg_config_csdev {
+	const struct cscfg_config_desc *desc;
+	struct coresight_device *csdev;
+	struct list_head node;
+	int nr_feat;
+	struct cscfg_feature_csdev **feats;
+	bool enabled;
+};
+
+/**
+ * Coresight device operations.
+ *
+ * Registered coresight devices provide these operations to manage feature
+ * instances compatible with the device hardware and drivers
+ *
+ * @load_feat:	Pass a feature descriptor into the device and create the
+ *		loaded feature instance (struct cscfg_feature_csdev).
+ */
+struct cscfg_csdev_feat_ops {
+	int (*load_feat)(struct coresight_device *csdev,
+			 struct cscfg_feature_csdev *feat);
+};
+
 #endif /* _CORESIGHT_CORESIGHT_CONFIG_H */
diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
index f7e396a5f9cb..c04cea0c1db2 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg.c
+++ b/drivers/hwtracing/coresight/coresight-syscfg.c
@@ -25,6 +25,212 @@ static struct cscfg_manager *cscfg_mgr;
 
 /* load features and configuations into the lists */
 
+/* protect the cfg lists in the csdev instances */
+static DEFINE_MUTEX(cscfg_csdev_mutex);
+
+/* get name feature instance from a coresight device list of features */
+static struct cscfg_feature_csdev *
+cscfg_get_feat_csdev(struct coresight_device *csdev, const char *name)
+{
+	struct cscfg_feature_csdev *feat = NULL;
+
+	list_for_each_entry(feat, &csdev->feature_csdev_list, node) {
+		if (strcmp(feat->desc->name, name) == 0)
+			return feat;
+	}
+	return NULL;
+}
+
+/* allocate the device config instance - with max number of used features */
+static struct cscfg_config_csdev *
+cscfg_alloc_csdev_cfg(struct coresight_device *csdev, int nr_feats)
+{
+	struct cscfg_config_csdev *dev_cfg = NULL;
+	struct device *dev = csdev->dev.parent;
+
+	/* this is being allocated using the devm for the coresight device */
+	dev_cfg = devm_kzalloc(dev, sizeof(struct cscfg_config_csdev), GFP_KERNEL);
+	if (!dev_cfg)
+		return NULL;
+
+	dev_cfg->csdev = csdev;
+	dev_cfg->feats = devm_kcalloc(dev, nr_feats,
+				      sizeof(struct cscfg_feature_csdev *),
+				      GFP_KERNEL);
+	if (!dev_cfg->feats)
+		dev_cfg = NULL;
+	return dev_cfg;
+}
+
+/* check match info between used feature from the config and a regisered device */
+static bool cscfg_match_feat_info(struct cscfg_match_desc *used_cmp,
+				  struct cscfg_match_desc *reg_dev)
+{
+	/* if flags don't match then fail early */
+	if (!(used_cmp->match_flags & reg_dev->match_flags))
+		return false;
+
+	return true;
+}
+
+/* Load a config into a device if there are feature matches between config and device  */
+static int cscfg_add_csdev_cfg(struct coresight_device *csdev,
+			       struct cscfg_match_desc *match_info,
+			       struct cscfg_config_desc *cfg_desc)
+{
+	struct cscfg_config_csdev *dev_cfg = NULL;
+	struct cscfg_config_feat_ref *feat_ref;
+	struct cscfg_feature_csdev *feat;
+	int checked;
+
+	/* look at each required feature and see if it matches any feature on the device */
+	for (checked = 0; checked < cfg_desc->nr_refs; checked++) {
+		feat_ref = &cfg_desc->refs[checked];
+		if (cscfg_match_feat_info(&feat_ref->match, match_info)) {
+			/* device matched - get the feature */
+			feat = cscfg_get_feat_csdev(csdev, feat_ref->name);
+			if (!feat)
+				return -EINVAL;
+			if (!dev_cfg) {
+				dev_cfg = cscfg_alloc_csdev_cfg(csdev, cfg_desc->nr_refs);
+				if (!dev_cfg)
+					return -ENOMEM;
+				dev_cfg->desc = cfg_desc;
+			}
+			dev_cfg->feats[dev_cfg->nr_feat++] = feat;
+		}
+	}
+	/* if matched features, add config to device.*/
+	if (dev_cfg) {
+		mutex_lock(&cscfg_csdev_mutex);
+		list_add(&dev_cfg->node, &csdev->config_csdev_list);
+		mutex_unlock(&cscfg_csdev_mutex);
+	}
+
+	return 0;
+}
+
+/*
+ * Add the config to the set of registered devices - call with mutex locked.
+ * Iterates through devices - any device that matches one or more of the
+ * configuration features will load it, the others will ignore it.
+ */
+static int cscfg_add_cfg_to_csdevs(struct cscfg_config_desc *cfg_desc)
+{
+	struct cscfg_csdev_register *curr_item;
+	int err;
+
+	list_for_each_entry(curr_item, &cscfg_mgr->data.csdev_desc_list, item) {
+		err = cscfg_add_csdev_cfg(curr_item->csdev, &curr_item->match_info, cfg_desc);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
+/*
+ * Allocate a feature object for load into a csdev.
+ * memory allocated using the csdev->dev object using devm managed allocator.
+ */
+static struct cscfg_feature_csdev *
+cscfg_alloc_csdev_feat(struct coresight_device *csdev, struct cscfg_feature_desc *feat_desc)
+{
+	struct cscfg_feature_csdev *feat = NULL;
+	struct device *dev = csdev->dev.parent;
+	int i;
+
+	feat = devm_kzalloc(dev, sizeof(struct cscfg_feature_csdev), GFP_KERNEL);
+	if (!feat)
+		return NULL;
+
+	/* parameters are optional - could be 0 */
+	feat->nr_params = feat_desc->nr_params;
+
+	/*
+	 * if we need parameters, zero alloc the space here, the load routine in
+	 * the csdev device driver will fill out some information according to
+	 * feature descriptor.
+	 */
+	if (feat->nr_params) {
+		feat->params = devm_kcalloc(dev, feat->nr_params,
+					    sizeof(struct cscfg_parameter_csdev),
+					    GFP_KERNEL);
+		if (!feat->params)
+			return NULL;
+
+		/*
+		 * fill in the feature reference in the param - other fields
+		 * handled by loader in csdev.
+		 */
+		for (i = 0; i < feat->nr_params; i++)
+			feat->params[i].feat = feat;
+	}
+
+	/*
+	 * Always have registers to program - again the load routine in csdev device
+	 * will fill out according to feature descriptor and device requirements.
+	 */
+	feat->nr_regs = feat_desc->nr_regs;
+	feat->regs = devm_kcalloc(dev, feat->nr_regs,
+				  sizeof(struct cscfg_reg_csdev), GFP_KERNEL);
+	if (!feat->regs)
+		return NULL;
+
+	/* load the feature default values */
+	feat->desc = feat_desc;
+	feat->csdev = csdev;
+
+	return feat;
+}
+
+/* load one feature into one coresight device */
+static int cscfg_load_feat_csdev(struct coresight_device *csdev,
+				 struct cscfg_feature_desc *feat_desc,
+				 struct cscfg_csdev_feat_ops *ops)
+{
+	struct cscfg_feature_csdev *feat_csdev;
+	int err;
+
+	if (!ops->load_feat)
+		return -EINVAL;
+
+	feat_csdev = cscfg_alloc_csdev_feat(csdev, feat_desc);
+	if (!feat_csdev)
+		return -ENOMEM;
+
+	/* load the feature into the device - may modify default ops*/
+	err = ops->load_feat(csdev, feat_csdev);
+	if (err)
+		return err;
+
+	/* add to internal csdev feature list */
+	mutex_lock(&cscfg_csdev_mutex);
+	list_add(&feat_csdev->node, &csdev->feature_csdev_list);
+	mutex_unlock(&cscfg_csdev_mutex);
+
+	return 0;
+}
+
+/*
+ * Add feature to any matching devices - call with mutex locked.
+ * Iterates through devices - any device that matches the feature will be
+ * called to load it.
+ */
+static int cscfg_add_feat_to_csdevs(struct cscfg_feature_desc *feat_desc)
+{
+	struct cscfg_csdev_register *curr_item;
+	int err;
+
+	list_for_each_entry(curr_item, &cscfg_mgr->data.csdev_desc_list, item) {
+		if (curr_item->match_info.match_flags & feat_desc->match_flags) {
+			err = cscfg_load_feat_csdev(curr_item->csdev, feat_desc, &curr_item->ops);
+			if (err)
+				return err;
+		}
+	}
+	return 0;
+}
+
 /* check feature list for a named feature - call with mutex locked. */
 static bool cscfg_match_list_feat(const char *name)
 {
@@ -53,6 +259,13 @@ static int cscfg_check_feat_for_cfg(struct cscfg_config_desc *cfg_desc)
  */
 static int cscfg_load_feat(struct cscfg_feature_desc *feat_desc)
 {
+	int err;
+
+	/* add feature to any matching registered devices */
+	err = cscfg_add_feat_to_csdevs(feat_desc);
+	if (err)
+		return err;
+
 	list_add(&feat_desc->item, &cscfg_mgr->data.feat_desc_list);
 
 	return 0;
@@ -71,6 +284,11 @@ static int cscfg_load_config(struct cscfg_config_desc *cfg_desc)
 	if (err)
 		return err;
 
+	/* add config to any matching registered device */
+	err = cscfg_add_cfg_to_csdevs(cfg_desc);
+	if (err)
+		return err;
+
 	list_add(&cfg_desc->item, &cscfg_mgr->data.config_desc_list);
 
 	return 0;
@@ -122,6 +340,136 @@ int cscfg_load_config_sets(struct cscfg_config_desc **cfg_descs,
 }
 EXPORT_SYMBOL_GPL(cscfg_load_config_sets);
 
+/* Handle coresight device registration and add configs and features to devices */
+
+/* iterate through config lists and load matching configs to device */
+static int cscfg_add_cfgs_csdev(struct coresight_device *csdev,
+				struct cscfg_match_desc *info)
+{
+	struct cscfg_config_desc *curr_item;
+	int err = 0;
+
+	list_for_each_entry(curr_item, &cscfg_mgr->data.config_desc_list, item) {
+		err = cscfg_add_csdev_cfg(csdev, info, curr_item);
+		if (err)
+			break;
+	}
+	return err;
+}
+
+/* iterate through feature lists and load matching features to device */
+static int cscfg_add_feats_csdev(struct coresight_device *csdev,
+				 struct cscfg_match_desc *info,
+				 struct cscfg_csdev_feat_ops *ops)
+{
+	struct cscfg_feature_desc *curr_item;
+	int err = 0;
+
+	if (!ops->load_feat)
+		return -EINVAL;
+
+	list_for_each_entry(curr_item, &cscfg_mgr->data.feat_desc_list, item) {
+		if (curr_item->match_flags & info->match_flags) {
+			err = cscfg_load_feat_csdev(csdev, curr_item, ops);
+			if (err)
+				break;
+		}
+	}
+	return err;
+}
+
+/* Add coresight device to list and copy its matching info */
+static int cscfg_list_add_csdev(struct coresight_device *csdev,
+				struct cscfg_match_desc *info,
+				struct cscfg_csdev_feat_ops *ops)
+{
+	struct cscfg_csdev_register *list_entry;
+
+	/* allocate the list entry structure */
+	list_entry = kzalloc(sizeof(struct cscfg_csdev_register), GFP_KERNEL);
+	if (!list_entry)
+		return -ENOMEM;
+
+	list_entry->csdev = csdev;
+	list_entry->match_info.match_flags = info->match_flags;
+	list_entry->ops.load_feat = ops->load_feat;
+	list_add(&list_entry->item, &cscfg_mgr->data.csdev_desc_list);
+
+	INIT_LIST_HEAD(&csdev->feature_csdev_list);
+	INIT_LIST_HEAD(&csdev->config_csdev_list);
+	cscfg_mgr->data.nr_csdev++;
+
+	return 0;
+}
+
+/* remove a coresight device from the list and free data */
+static void cscfg_list_remove_csdev(struct coresight_device *csdev)
+{
+	struct cscfg_csdev_register *curr_item, *tmp;
+
+	list_for_each_entry_safe(curr_item, tmp, &cscfg_mgr->data.csdev_desc_list, item) {
+		if (curr_item->csdev == csdev) {
+			list_del(&curr_item->item);
+			kfree(curr_item);
+			cscfg_mgr->data.nr_csdev--;
+			break;
+		}
+	}
+}
+
+/* register a coresight device with the syscfg api */
+int cscfg_register_csdev(struct coresight_device *csdev,
+			 struct cscfg_match_desc *info,
+			 struct cscfg_csdev_feat_ops *ops)
+{
+	int ret = 0;
+
+	mutex_lock(&cscfg_mutex);
+
+	/* add device to list of registered devices  */
+	ret = cscfg_list_add_csdev(csdev, info, ops);
+	if (ret)
+		goto reg_csdev_unlock;
+
+	/* now load any registered features and configs matching the device. */
+	ret = cscfg_add_feats_csdev(csdev, info, ops);
+	if (ret) {
+		cscfg_list_remove_csdev(csdev);
+		goto reg_csdev_unlock;
+	}
+
+	ret = cscfg_add_cfgs_csdev(csdev, info);
+	if (ret) {
+		cscfg_list_remove_csdev(csdev);
+		goto reg_csdev_unlock;
+	}
+
+	pr_info("CSCFG registered %s", dev_name(&csdev->dev));
+
+reg_csdev_unlock:
+	mutex_unlock(&cscfg_mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cscfg_register_csdev);
+
+/* remove coresight device and update counts - syscfg device at 0 */
+void cscfg_unregister_csdev(struct coresight_device *csdev)
+{
+	struct cscfg_csdev_register *curr_item, *tmp;
+
+	mutex_lock(&cscfg_mutex);
+	list_for_each_entry_safe(curr_item, tmp, &cscfg_mgr->data.csdev_desc_list, item) {
+		if (curr_item->csdev == csdev) {
+			list_del(&curr_item->item);
+			kfree(curr_item);
+			cscfg_mgr->data.nr_csdev--;
+			break;
+		}
+	}
+	mutex_unlock(&cscfg_mutex);
+}
+EXPORT_SYMBOL_GPL(cscfg_unregister_csdev);
+
 /* Initialise system configuration management device. */
 
 struct device *to_device_cscfg(void)
diff --git a/drivers/hwtracing/coresight/coresight-syscfg.h b/drivers/hwtracing/coresight/coresight-syscfg.h
index 907ba8d3efea..ebf5e1491d86 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg.h
+++ b/drivers/hwtracing/coresight/coresight-syscfg.h
@@ -26,6 +26,22 @@ struct cscfg_api_data {
 	int nr_csdev;
 };
 
+/**
+ * List entry for Coresight devices that are registered as supporting complex
+ * config operations.
+ *
+ * @csdev:	The registered device.
+ * @match_info: The matching type information.
+ * @ops:	Operations supported by the registered device.
+ * @item:	list entry.
+ */
+struct cscfg_csdev_register {
+	struct coresight_device *csdev;
+	struct cscfg_match_desc match_info;
+	struct cscfg_csdev_feat_ops ops;
+	struct list_head item;
+};
+
 /* internal core operations for cscfg */
 int __init cscfg_init(void);
 void __exit cscfg_exit(void);
@@ -33,6 +49,10 @@ void __exit cscfg_exit(void);
 /* syscfg manager external API */
 int cscfg_load_config_sets(struct cscfg_config_desc **cfg_descs,
 			   struct cscfg_feature_desc **feat_descs);
+int cscfg_register_csdev(struct coresight_device *csdev,
+			 struct cscfg_match_desc *info,
+			 struct cscfg_csdev_feat_ops *ops);
+void cscfg_unregister_csdev(struct coresight_device *csdev);
 
 /**
  * System configuration manager device.
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 976ec2697610..d0126ed326a6 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -219,6 +219,8 @@ struct coresight_sysfs_link {
  * @nr_links:   number of sysfs links created to other components from this
  *		device. These will appear in the "connections" group.
  * @has_conns_grp: Have added a "connections" group for sysfs links.
+ * @feature_csdev_list: List of complex feature programming added to the device.
+ * @config_csdev_list:  List of system configurations added to the device.
  */
 struct coresight_device {
 	struct coresight_platform_data *pdata;
@@ -240,6 +242,9 @@ struct coresight_device {
 	int nr_links;
 	bool has_conns_grp;
 	bool ect_enabled; /* true only if associated ect device is enabled */
+	/* system configuration and feature lists */
+	struct list_head feature_csdev_list;
+	struct list_head config_csdev_list;
 };
 
 /*
-- 
2.17.1

