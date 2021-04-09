Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1769B359C41
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 12:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbhDIKiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 06:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233519AbhDIKhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 06:37:50 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAB6C061761
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 03:37:36 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id s7so5020420wru.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 03:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8efoKnLMcNGx9K9jtqD6t1w/9lJFWQwoudidfCPdxNo=;
        b=ptRTx2MaSwPRETznnjIfxE1vY9qy5fQOUU8ggudPkbzOpBLU0Sq8tp6rhoRfEw4+tv
         aldn+kVzWJJGtGaflqE6k9GH7R7teEAMl58O849afzkPze4NF0Wd9/alxPbQojS4XxqC
         h1rDhzaE2b1ESoN6wMCKjXtRrRM5ug25siLne7qtsXrX1qY+fcLVS/kWyeD/OdP3d2ne
         KfQaRVxWfgF0VpVpm42AK5Ku/qXRKPP/tLdGwl2fDrxncDDNt38KMFdD7pQuIeMiFtfH
         jKYRK97EZsOramdJhgOJFnsgo63PzS4Lf3NTiV14dKAhMXxeHRDztih8dgyKqU2NQfLN
         wVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8efoKnLMcNGx9K9jtqD6t1w/9lJFWQwoudidfCPdxNo=;
        b=ia/SuHxxkgQxW2xrVSIRgg3R2+ZQMy0+0PRqB+Moz5+FEG2g62JCHo8nm6l+5crT0l
         2Sz7JtNj15Y4JRwIDBhskvevOoFgYreJY/BSizvABz0fe9Ne1IBlQoFkMflj/+3SLA5g
         hr1PqyxftyHdRO2LTg6Odn3F+7gqEYsD/UOzD3KDQr4ljKGHHzRGXqpBCrFFhP13B9vK
         vOCp7u/kBiXuBgIgLdTt9nk4CJIX4zLvtbr/T2G5ljKSY53iSKD5rFiC3IRH6EsXCxfB
         lcvdc7RRAbgNPdgRG23x/IIxuAth84y1ycWh/ktPpc9EQnBSllBXN9x5xXJIxZJB8Uqy
         Jn+A==
X-Gm-Message-State: AOAM533+HpzURlpjUUfaSSMn30voJCzhz9igbCfzfoAH9dQQYtQKn7xW
        zeymOdCZu0DDxhDn1Izx7K3fzg==
X-Google-Smtp-Source: ABdhPJxd3W9JPAyKxgZ1EaXteXvXkN5wMeMJNT6fNXTBMUrJxVNJ17fhJuFQL2m4q+OcBq6x3/JV9A==
X-Received: by 2002:adf:ee89:: with SMTP id b9mr12325839wro.126.1617964655478;
        Fri, 09 Apr 2021 03:37:35 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:20a6:106c:24d6:628])
        by smtp.gmail.com with ESMTPSA id w7sm4087650wro.43.2021.04.09.03.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 03:37:35 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, linux-doc@vger.kernel.org,
        suzuki.poulose@arm.com
Cc:     yabinc@google.com, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, tingwei@codeaurora.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v6 05/10] coresight: syscfg: Add API to activate and enable configurations
Date:   Fri,  9 Apr 2021 11:37:17 +0100
Message-Id: <20210409103722.26290-6-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210409103722.26290-1-mike.leach@linaro.org>
References: <20210409103722.26290-1-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configurations are first activated, then when any coresight device is
enabled, the active configurations are checked and any matching
one is enabled.

This patch provides the activation / enable API.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../hwtracing/coresight/coresight-config.h    |   2 +
 .../hwtracing/coresight/coresight-syscfg.c    | 172 ++++++++++++++++++
 .../hwtracing/coresight/coresight-syscfg.h    |   8 +
 include/linux/coresight.h                     |   2 +
 4 files changed, 184 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
index 0667581822c1..25eb6c632692 100644
--- a/drivers/hwtracing/coresight/coresight-config.h
+++ b/drivers/hwtracing/coresight/coresight-config.h
@@ -127,6 +127,7 @@ struct cscfg_feature_desc {
  * @nr_total_params:	Sum of all parameters declared by used features
  * @presets:		Array of preset values.
  * @event_ea:		Extended attribute for perf event value
+ * @active_cnt:		ref count for activate on this configuration.
  *
  */
 struct cscfg_config_desc {
@@ -139,6 +140,7 @@ struct cscfg_config_desc {
 	int nr_total_params;
 	const u64 *presets; /* nr_presets * nr_total_params */
 	struct dev_ext_attribute *event_ea;
+	atomic_t active_cnt;
 };
 
 /**
diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
index e35f8c0ac2f8..b234e45c153f 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg.c
+++ b/drivers/hwtracing/coresight/coresight-syscfg.c
@@ -283,6 +283,7 @@ static int cscfg_load_config(struct cscfg_config_desc *config_desc)
 		return err;
 
 	list_add(&config_desc->item, &cscfg_mgr->config_desc_list);
+	atomic_set(&config_desc->active_cnt, 0);
 	return 0;
 }
 
@@ -468,6 +469,176 @@ void cscfg_unregister_csdev(struct coresight_device *csdev)
 }
 EXPORT_SYMBOL_GPL(cscfg_unregister_csdev);
 
+/**
+ * cscfg_csdev_reset_feats - reset features for a CoreSight device.
+ *
+ * Resets all parameters and register values for any features loaded
+ * into @csdev to their default values.
+ *
+ * @csdev: The CoreSight device.
+ */
+void cscfg_csdev_reset_feats(struct coresight_device *csdev)
+{
+	struct cscfg_feature_csdev *feat_csdev;
+
+	mutex_lock(&cscfg_csdev_mutex);
+	if (list_empty(&csdev->feature_csdev_list))
+		goto unlock_exit;
+
+	list_for_each_entry(feat_csdev, &csdev->feature_csdev_list, node)
+		cscfg_reset_feat(feat_csdev);
+
+unlock_exit:
+	mutex_unlock(&cscfg_csdev_mutex);
+}
+EXPORT_SYMBOL_GPL(cscfg_csdev_reset_feats);
+
+/**
+ * cscfg_activate_config -  Mark a configuration descriptor as active.
+ *
+ * This will be seen when csdev devices are enabled in the system.
+ * Only activated configurations can be enabled on individual devices.
+ * Activation protects the configuration from alteration or removal while
+ * active.
+ *
+ * Selection by hash value - generated from the configuration name when it
+ * was loaded and added to the cs_etm/configurations file system for selection
+ * by perf.
+ *
+ * Increments the configuration descriptor active count and the global active
+ * count.
+ *
+ * @cfg_hash: Hash value of the selected configuration name.
+ */
+int cscfg_activate_config(unsigned long cfg_hash)
+{
+	struct cscfg_config_desc *config_desc;
+	int err = -EINVAL;
+
+	mutex_lock(&cscfg_mutex);
+
+	list_for_each_entry(config_desc, &cscfg_mgr->config_desc_list, item) {
+		if ((unsigned long)config_desc->event_ea->var == cfg_hash) {
+			/*
+			 * increment the global active count - control changes to
+			 * active configurations
+			 */
+			atomic_inc(&cscfg_mgr->sys_active_cnt);
+
+			/*
+			 * mark the descriptor as active so enable config on a
+			 * device instance will use it
+			 */
+			atomic_inc(&config_desc->active_cnt);
+
+			err = 0;
+			dev_dbg(cscfg_device(), "Activate config %s.\n", config_desc->name);
+			break;
+		}
+	}
+	mutex_unlock(&cscfg_mutex);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(cscfg_activate_config);
+
+/**
+ * cscfg_deactivate_config -  Mark a config descriptor as inactive.
+ *
+ * Decrement the configuration and global active counts.
+ *
+ * @cfg_hash: Hash value of the selected configuration name.
+ */
+void cscfg_deactivate_config(unsigned long cfg_hash)
+{
+	struct cscfg_config_desc *config_desc;
+
+	mutex_lock(&cscfg_mutex);
+
+	list_for_each_entry(config_desc, &cscfg_mgr->config_desc_list, item) {
+		if ((unsigned long)config_desc->event_ea->var == cfg_hash) {
+			atomic_dec(&config_desc->active_cnt);
+			atomic_dec(&cscfg_mgr->sys_active_cnt);
+			dev_dbg(cscfg_device(), "Deactivate config %s.\n", config_desc->name);
+			break;
+		}
+	}
+	mutex_unlock(&cscfg_mutex);
+}
+EXPORT_SYMBOL_GPL(cscfg_deactivate_config);
+
+/**
+ * cscfg_csdev_enable_active_config - Enable matching active configuration for device.
+ *
+ * Enables the configuration selected by @cfg_hash if the configuration is supported
+ * on the device and has been activated.
+ *
+ * If active and supported the CoreSight device @csdev will be programmed with the
+ * configuration, using @preset parameters.
+ *
+ * Should be called before driver hardware enable for the requested device, prior to
+ * programming and enabling the physical hardware.
+ *
+ * @csdev:	CoreSight device to program.
+ * @cfg_hash:	Selector for the configuration.
+ * @preset:	Preset parameter values to use, 0 for current / default values.
+ */
+int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
+				     unsigned long cfg_hash, int preset)
+{
+	struct cscfg_config_csdev *config_csdev_active = NULL, *config_csdev_item;
+	const struct cscfg_config_desc *config_desc;
+	int err = 0;
+
+	/* quickly check global count */
+	if (!atomic_read(&cscfg_mgr->sys_active_cnt))
+		return 0;
+
+	mutex_lock(&cscfg_csdev_mutex);
+	list_for_each_entry(config_csdev_item, &csdev->config_csdev_list, node) {
+		config_desc = config_csdev_item->config_desc;
+		if ((atomic_read(&config_desc->active_cnt)) &&
+		    ((unsigned long)config_desc->event_ea->var == cfg_hash)) {
+			config_csdev_active = config_csdev_item;
+			break;
+		}
+	}
+	if (config_csdev_active) {
+		err = cscfg_csdev_enable_config(config_csdev_active, preset);
+		if (!err)
+			csdev->active_cscfg_ctxt = (void *)config_csdev_active;
+	}
+	mutex_unlock(&cscfg_csdev_mutex);
+	return err;
+}
+EXPORT_SYMBOL_GPL(cscfg_csdev_enable_active_config);
+
+/**
+ * cscfg_csdev_disable_active_config - disable an active config on the device.
+ *
+ * Disables the active configuration on the CoreSight device @csdev.
+ * Disable will save the values of any registers marked in the configurations
+ * as save on disable.
+ *
+ * Should be called after driver hardware disable for the requested device,
+ * after disabling the physical hardware and reading back registers.
+ *
+ * @csdev: The CoreSight device.
+ */
+void cscfg_csdev_disable_active_config(struct coresight_device *csdev)
+{
+	struct cscfg_config_csdev *config_csdev;
+
+	mutex_lock(&cscfg_csdev_mutex);
+	config_csdev = (struct cscfg_config_csdev *)csdev->active_cscfg_ctxt;
+	if (config_csdev) {
+		cscfg_csdev_disable_config(config_csdev);
+		csdev->active_cscfg_ctxt = NULL;
+	}
+	mutex_unlock(&cscfg_csdev_mutex);
+}
+EXPORT_SYMBOL_GPL(cscfg_csdev_disable_active_config);
+
 /* Initialise system configuration management device. */
 
 struct device *cscfg_device(void)
@@ -536,6 +707,7 @@ int __init cscfg_init(void)
 	INIT_LIST_HEAD(&cscfg_mgr->csdev_desc_list);
 	INIT_LIST_HEAD(&cscfg_mgr->feat_desc_list);
 	INIT_LIST_HEAD(&cscfg_mgr->config_desc_list);
+	atomic_set(&cscfg_mgr->sys_active_cnt, 0);
 
 	dev_info(cscfg_device(), "CoreSight Configuration manager initialised");
 	return 0;
diff --git a/drivers/hwtracing/coresight/coresight-syscfg.h b/drivers/hwtracing/coresight/coresight-syscfg.h
index 5bcae3b374c6..a52775890670 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg.h
+++ b/drivers/hwtracing/coresight/coresight-syscfg.h
@@ -24,12 +24,14 @@
  * @csdev_desc_list:	List of coresight devices registered with the configuration manager.
  * @feat_desc_list:	List of feature descriptors to load into registered devices.
  * @config_desc_list:	List of system configuration descriptors to load into registered devices.
+ * @sys_active_cnt:	Total number of active config descriptor references.
  */
 struct cscfg_manager {
 	struct device dev;
 	struct list_head csdev_desc_list;
 	struct list_head feat_desc_list;
 	struct list_head config_desc_list;
+	atomic_t sys_active_cnt;
 };
 
 /* get reference to dev in cscfg_manager */
@@ -61,5 +63,11 @@ int cscfg_load_config_sets(struct cscfg_config_desc **cfg_descs,
 int cscfg_register_csdev(struct coresight_device *csdev, u32 match_flags,
 			 struct cscfg_csdev_feat_ops *ops);
 void cscfg_unregister_csdev(struct coresight_device *csdev);
+int cscfg_activate_config(unsigned long cfg_hash);
+void cscfg_deactivate_config(unsigned long cfg_hash);
+void cscfg_csdev_reset_feats(struct coresight_device *csdev);
+int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
+				     unsigned long cfg_hash, int preset);
+void cscfg_csdev_disable_active_config(struct coresight_device *csdev);
 
 #endif /* CORESIGHT_SYSCFG_H */
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 6fb516e1b22e..a348049ee08b 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -222,6 +222,7 @@ struct coresight_sysfs_link {
  * @has_conns_grp: Have added a "connections" group for sysfs links.
  * @feature_csdev_list: List of complex feature programming added to the device.
  * @config_csdev_list:  List of system configurations added to the device.
+ * @active_cscfg_ctxt:  Context information for current active system configuration.
  */
 struct coresight_device {
 	struct coresight_platform_data *pdata;
@@ -246,6 +247,7 @@ struct coresight_device {
 	/* system configuration and feature lists */
 	struct list_head feature_csdev_list;
 	struct list_head config_csdev_list;
+	void *active_cscfg_ctxt;
 };
 
 /*
-- 
2.17.1

