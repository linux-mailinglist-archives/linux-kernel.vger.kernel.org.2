Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237E83D3DEE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 18:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbhGWQOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 12:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbhGWQOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 12:14:19 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C617C061757
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 09:54:52 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l11-20020a7bc34b0000b029021f84fcaf75so3907907wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 09:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QzS3zk45Mu5NBXAL9sYKWYH+I3IqB0YMcnw3oj5y5M4=;
        b=t7yUbZgtX1ZgejwG+gYeCpdaosQEmxpdAi5+wG/puZ7oHZ6PpaeaxIuM/C8D0QhePy
         mdk2G+osaqnj/2zXV2q9pjJ+DW6E/cw367VyYlNPD80D/4SV9mpgqnjdaiFTO9ShL6dD
         bP4GRh/9V1ovFlsrM2DSoChlJ5Ye6owlS9v0sTUoq534AfHfNT2L0TYWee795C12/eK8
         4/IcLQ7s567eP6bSYOUGu4wH1xP3unPlxdZ2fO3UXKmGM2u0N8KVZUEgI1c0yRLFQttE
         ah3Brdyo9vVhgfTP+LWpCDAaCu52+u0U1xJT9WT4iZCeBj9VVpF6JEC/wDJLfe/09jCq
         tBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QzS3zk45Mu5NBXAL9sYKWYH+I3IqB0YMcnw3oj5y5M4=;
        b=LmUoi6WsqLijsynygPV2yyezE/tvw6RHirMxBORFlvqX3b9DROWYCPfsVztjEzKint
         AVbweO8EtlilHLp3NtSuj+PwhKLmktlSEKv4hiC5pSf97EmAa+N0/++Pf4S6CeNBvQb3
         08AHE8gq+C+vDjrl4gOPtosK5SVhdnVpq20d4QFnrKaL+2bzR4c3IWyxtQnG/oF/yVDq
         qPYJ6SSlujuuWSLX5Wbt47iwZxWr2ndgUhjAEq4eUzFwLMShGtKTavhu9hw7l+A6Gngw
         lva7HFf5lYGzP74EIjFSBOSURxrYTKr75QXKDB3uC6OgafJSVm/HAvPco3Qje3JtgrzN
         KIZA==
X-Gm-Message-State: AOAM530I2RiSkfsdz7GpsYJ4jsefJkdX0FYygs5ZkkQgm+M8+fwTLTsx
        Gcn8LV7dOZHb4DKfA1vBszIdAg==
X-Google-Smtp-Source: ABdhPJz2snKebTjGhzx8OEUQZbfuKjIYQs4yqKpgpC0s/cRE3+T3fFi+QN/MgEsyQ/rmzVccMJIWQw==
X-Received: by 2002:a1c:62c4:: with SMTP id w187mr5374839wmb.27.1627059290917;
        Fri, 23 Jul 2021 09:54:50 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:fdab:eb9d:1515:bff3])
        by smtp.gmail.com with ESMTPSA id z11sm33193225wru.65.2021.07.23.09.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 09:54:50 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, suzuki.poulose@arm.com
Cc:     yabinc@google.com, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, tingwei@codeaurora.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v9 05/10] coresight: syscfg: Add API to activate and enable configurations
Date:   Fri, 23 Jul 2021 17:54:39 +0100
Message-Id: <20210723165444.1048-6-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210723165444.1048-1-mike.leach@linaro.org>
References: <20210723165444.1048-1-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configurations are first activated, then when any coresight device is
enabled, the active configurations are checked and any matching
one is enabled.

This patch provides the activation / enable API.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 .../hwtracing/coresight/coresight-config.h    |   2 +
 .../hwtracing/coresight/coresight-syscfg.c    | 212 ++++++++++++++++++
 .../hwtracing/coresight/coresight-syscfg.h    |   8 +
 include/linux/coresight.h                     |   2 +
 4 files changed, 224 insertions(+)

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
index b93f2b4a777e..8903aab36c51 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg.c
+++ b/drivers/hwtracing/coresight/coresight-syscfg.c
@@ -282,6 +282,7 @@ static int cscfg_load_config(struct cscfg_config_desc *config_desc)
 		return err;
 
 	list_add(&config_desc->item, &cscfg_mgr->config_desc_list);
+	atomic_set(&config_desc->active_cnt, 0);
 	return 0;
 }
 
@@ -468,6 +469,216 @@ void cscfg_unregister_csdev(struct coresight_device *csdev)
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
+	unsigned long flags;
+
+	spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
+	if (list_empty(&csdev->feature_csdev_list))
+		goto unlock_exit;
+
+	list_for_each_entry(feat_csdev, &csdev->feature_csdev_list, node)
+		cscfg_reset_feat(feat_csdev);
+
+unlock_exit:
+	spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
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
+	unsigned long flags;
+	int err = 0;
+
+	/* quickly check global count */
+	if (!atomic_read(&cscfg_mgr->sys_active_cnt))
+		return 0;
+
+	/* look for matching config - set in_enable flag if found */
+	spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
+	list_for_each_entry(config_csdev_item, &csdev->config_csdev_list, node) {
+		config_desc = config_csdev_item->config_desc;
+		if ((atomic_read(&config_desc->active_cnt)) &&
+		    ((unsigned long)config_desc->event_ea->var == cfg_hash)) {
+			config_csdev_active = config_csdev_item;
+			csdev->active_cscfg_ctxt = (void *)config_csdev_active;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
+
+	/*
+	 * If found, attempt to enable
+	 */
+	if (config_csdev_active) {
+		/*
+		 * Call the generic routine that will program up the internal
+		 * driver structures prior to programming up the hardware.
+		 * This routine takes the driver spinlock saved in the configs.
+		 */
+		err = cscfg_csdev_enable_config(config_csdev_active, preset);
+		if (!err) {
+			/*
+			 * Successful programming. Check the active_cscfg_ctxt
+			 * pointer to ensure no pre-emption disabled it via
+			 * cscfg_csdev_disable_active_config() before
+			 * we could start.
+			 *
+			 * Set enabled if OK, err if not.
+			 */
+			spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
+			if (csdev->active_cscfg_ctxt)
+				config_csdev_active->enabled = true;
+			else
+				err = -EBUSY;
+			spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
+		}
+	}
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
+	unsigned long flags;
+
+	/*
+	 * Check if we have an active config, and that it was successfully enabled.
+	 * If it was not enabled, we have no work to do, otherwise mark as disabled.
+	 * Clear the active config pointer.
+	 */
+	spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
+	config_csdev = (struct cscfg_config_csdev *)csdev->active_cscfg_ctxt;
+	if (config_csdev) {
+		if (!config_csdev->enabled)
+			config_csdev = NULL;
+		else
+			config_csdev->enabled = false;
+	}
+	csdev->active_cscfg_ctxt = NULL;
+	spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
+
+	/* true if there was an enabled active config */
+	if (config_csdev)
+		cscfg_csdev_disable_config(config_csdev);
+}
+EXPORT_SYMBOL_GPL(cscfg_csdev_disable_active_config);
+
 /* Initialise system configuration management device. */
 
 struct device *cscfg_device(void)
@@ -536,6 +747,7 @@ int __init cscfg_init(void)
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
index 16544ae2b532..93a2922b7653 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -223,6 +223,7 @@ struct coresight_sysfs_link {
  * @feature_csdev_list: List of complex feature programming added to the device.
  * @config_csdev_list:  List of system configurations added to the device.
  * @cscfg_csdev_lock:	Protect the lists of configurations and features.
+ * @active_cscfg_ctxt:  Context information for current active system configuration.
  */
 struct coresight_device {
 	struct coresight_platform_data *pdata;
@@ -248,6 +249,7 @@ struct coresight_device {
 	struct list_head feature_csdev_list;
 	struct list_head config_csdev_list;
 	spinlock_t cscfg_csdev_lock;
+	void *active_cscfg_ctxt;
 };
 
 /*
-- 
2.17.1

