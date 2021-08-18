Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC91A3F0BF3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 21:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbhHRTlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 15:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbhHRTlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 15:41:07 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05A8C0613D9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 12:40:32 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id c17so3385030pgc.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 12:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aeoAZiqrJudcFRqe2L7kqQjbLOevb2i3jtWyZhhcVM0=;
        b=oBdDuSiyFOFOdpYn1RJgjW5KLLCU5TQjX+C4h/S4R37iRaDuIVdQNTsXwyg2odnuCb
         FhmfnkwThEl1UwqW561BOFc65/i601RL113elpzghdzdHy82QKCf/aJu9z351ArgC3rw
         r6UxguTVROYQnbR58O7ZM8vBQkKkDgs3E7ma3LaRos+l2HVz3AVYS+GfqLhTey8uF6ar
         uVpSM4LpaWl7sHs2vGtcSQ1uTqSfto89X9Z8oFTr3kx0zFizels8pk5xWBCQtudDePBu
         Nb1obByCy3bfoSlmHxk+ojDX4fsdzaoGQ52wcebJE0/Z26kIlMXHKsgLudYmp53S1B6/
         XkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aeoAZiqrJudcFRqe2L7kqQjbLOevb2i3jtWyZhhcVM0=;
        b=WOOtr0SI6obVjCbL2kp/Pnk/i/145eHGQR4gJFeO2ngfA0axsCfeH+inT9HQ+ekBtp
         gby8DI937MToXGl1XL/YgTUOjkjOxvgMbNAm9YkNF7Ke4mGkqrK4Z9fIpXg0lrzuNPnW
         doxoGeJribOy+n1hB7Vy9isPqEWbxSMfqIFpmY4MqmBMxwZkhsbJsHZ0+bRGala0I3JE
         rPGzv8D2rrMtG/W9Q4dkh99FTyIayxIt67ZRb9UvbCwPY48vXrXWAARMoPLL7E+KhhiW
         jghusPwdbqwwyxEReh5NHZU2sBJq/+96fs1FW5jwAdLtLmBekEL11sudXvfe4wqFF6Jq
         6w8A==
X-Gm-Message-State: AOAM533zZhcDF+Tr84Ki8hJlDUw1A79xmRfrZI965sySCrO5pj0vxr2O
        Tr5OhvQ5fvANe0ReYf2Rb1KjUA==
X-Google-Smtp-Source: ABdhPJz2cMSyAb/xAkdl6SWT8LGEXq6Nf5QqIvk8NyYUY5QSjaBODpjCHN5qrilZ/dpF2YQiK8mgLg==
X-Received: by 2002:a62:e90b:0:b029:30e:4530:8dca with SMTP id j11-20020a62e90b0000b029030e45308dcamr11079086pfh.17.1629315632195;
        Wed, 18 Aug 2021 12:40:32 -0700 (PDT)
Received: from p14s.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id k12sm2960137pjg.6.2021.08.18.12.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 12:40:31 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] coresight: syscfg: Add API to activate and enable configurations
Date:   Wed, 18 Aug 2021 13:40:16 -0600
Message-Id: <20210818194022.379573-6-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210818194022.379573-1-mathieu.poirier@linaro.org>
References: <20210818194022.379573-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Leach <mike.leach@linaro.org>

Configurations are first activated, then when any coresight device is
enabled, the active configurations are checked and any matching
one is enabled.

This patch provides the activation / enable API.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Link: https://lore.kernel.org/r/20210723165444.1048-6-mike.leach@linaro.org
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../hwtracing/coresight/coresight-config.h    |   2 +
 .../hwtracing/coresight/coresight-syscfg.c    | 215 ++++++++++++++++++
 .../hwtracing/coresight/coresight-syscfg.h    |   8 +
 include/linux/coresight.h                     |   2 +
 4 files changed, 227 insertions(+)

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
index b93f2b4a777e..795dba576fea 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg.c
+++ b/drivers/hwtracing/coresight/coresight-syscfg.c
@@ -282,6 +282,7 @@ static int cscfg_load_config(struct cscfg_config_desc *config_desc)
 		return err;
 
 	list_add(&config_desc->item, &cscfg_mgr->config_desc_list);
+	atomic_set(&config_desc->active_cnt, 0);
 	return 0;
 }
 
@@ -468,6 +469,219 @@ void cscfg_unregister_csdev(struct coresight_device *csdev)
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
+	/*
+	 * Look for matching configuration - set the active configuration
+	 * context if found.
+	 */
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
@@ -536,6 +750,7 @@ int __init cscfg_init(void)
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
2.25.1

