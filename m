Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6DD2307CF9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 18:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhA1RsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 12:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbhA1RML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 12:12:11 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18351C061351
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 09:09:51 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id u14so5170204wmq.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 09:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SdaolgZ8umxvWIrsixiVmJfRgd3EaOoeeUES+E2W5FI=;
        b=nXqcB3dFVIWb7EP9jQyfBXuH2W9JTK7GZ+z8IOom347NgmOCOcHYje8ky8Ktb46KXH
         CNSxdff3g0dtnkQ5sYJ85w4+fg4PP1V622rehpIgybUTzL3ZQwfvTnLh7m3K3dqQGm8B
         VQUMTjAFR3nEoLqkz9Y7yOq6GA3x9X/T/kiTJx5gqIJs15iTLmDCbdfalfXjfcfclAhS
         hfUcrX42XLxaidQU21vivj9GU/SO2ETUPD3Yc9xedCKy0sUtC3En2s/Sddd1zTB7witT
         FKYf6BNYLozEXJ8A3JwG3WK23xQ1jRCr0aGoccZ8z5Ohjrfcj62A5me1+G/xU/eUiJVJ
         1FtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SdaolgZ8umxvWIrsixiVmJfRgd3EaOoeeUES+E2W5FI=;
        b=MVn+mxD5jwP8kyapm8AAq5LF/WQ74OTYF6W8/uZVFq9U+8R+YWcla1pZTze12eazsN
         Ka+JMjH02KpyXhVYd1zaGq1M/cix1qPS7oQ6fzjPEazO9dqsUFoKFVkT2glp0Obo29eG
         LkBA7EtxeABs4heWRJ2GFwgXOQzrjEO5H78yFQHWH4iuMW55g2HtSs8q9GEM4NiG60f1
         XCYx3xk1bdx4zoVJtGqO5s0juBAFLCW3Fy1n6FRPbhcgMEZ+cU/lzVUAPlZHG/bgrPVQ
         orWYekfjoym8SpzLT06FQtwnOjqjf6fzRCsT5PakjZKVI+uQCuF4Jzm3lPqVQ29MAbwW
         pgAQ==
X-Gm-Message-State: AOAM5314of1ou0y+p653o+6kleUDtonQrxcbXXyUFUOhWStXENjRHhKi
        LEabC+veWNlVRESTew82jKAw1g==
X-Google-Smtp-Source: ABdhPJzxNITKdrrLRtD1snawJDsZYJfX0r4PFaTtAFPC2jLJHXSqMQJTgB1YkH2pF4U9cA4tIcTfyw==
X-Received: by 2002:a1c:4b14:: with SMTP id y20mr231864wma.166.1611853789733;
        Thu, 28 Jan 2021 09:09:49 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6801:1801:40:2fca:953a:e6ba])
        by smtp.gmail.com with ESMTPSA id p15sm7622355wrt.15.2021.01.28.09.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 09:09:49 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, linux-doc@vger.kernel.org,
        suzuki.poulose@arm.com
Cc:     yabinc@google.com, corbet@lwn.net, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, tingwei@codeaurora.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v4 05/10] coresight: syscfg: Add API to activate and enable configurations
Date:   Thu, 28 Jan 2021 17:09:31 +0000
Message-Id: <20210128170936.9222-6-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210128170936.9222-1-mike.leach@linaro.org>
References: <20210128170936.9222-1-mike.leach@linaro.org>
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
 .../hwtracing/coresight/coresight-syscfg.c    | 127 ++++++++++++++++++
 .../hwtracing/coresight/coresight-syscfg.h    |  10 +-
 include/linux/coresight.h                     |   2 +
 4 files changed, 140 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
index 98380b496046..26396b70c826 100644
--- a/drivers/hwtracing/coresight/coresight-config.h
+++ b/drivers/hwtracing/coresight/coresight-config.h
@@ -156,6 +156,7 @@ struct cscfg_config_feat_ref {
  * @presets:	Array of preset values.
  * @id_ea:	Extended attribute for perf configid value
  * @event_ea:	Extended attribute for perf event value
+ * @active_cnt: ref count for activate on this configuration.
  */
 struct cscfg_config_desc {
 	const char *name;
@@ -168,6 +169,7 @@ struct cscfg_config_desc {
 	const u64 *presets; /* nr_presets * nr_total_params */
 	struct dev_ext_attribute *id_ea;
 	struct dev_ext_attribute *event_ea;
+	atomic_t active_cnt;
 };
 
 /**
diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
index a070f135eca3..d79cf5b36758 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg.c
+++ b/drivers/hwtracing/coresight/coresight-syscfg.c
@@ -298,6 +298,7 @@ static int cscfg_load_config(struct cscfg_config_desc *cfg_desc)
 		return err;
 
 	list_add(&cfg_desc->item, &cscfg_mgr->data.config_desc_list);
+	atomic_set(&cfg_desc->active_cnt, 0);
 	return 0;
 }
 
@@ -477,6 +478,131 @@ void cscfg_unregister_csdev(struct coresight_device *csdev)
 }
 EXPORT_SYMBOL_GPL(cscfg_unregister_csdev);
 
+void cscfg_csdev_reset_feats(struct coresight_device *csdev)
+{
+	struct cscfg_feature_csdev *feat;
+
+	mutex_lock(&cscfg_csdev_mutex);
+	if (list_empty(&csdev->feature_csdev_list))
+		goto unlock_exit;
+
+	list_for_each_entry(feat, &csdev->feature_csdev_list, node)
+		cscfg_reset_feat(feat);
+
+unlock_exit:
+	mutex_unlock(&cscfg_csdev_mutex);
+}
+EXPORT_SYMBOL_GPL(cscfg_csdev_reset_feats);
+
+/**
+ * Mark a config descriptor as active.
+ * This will be seen when csdev devices are activated in the system.
+ *
+ * Selection by hash value - generated from the configuration name when it
+ * was loaded and added to the cs_etm/configurations file system for selection
+ * by perf.
+ *
+ * @cfg_hash: Hash value of the selected configuration name.
+ */
+int cscfg_activate_config(unsigned long cfg_hash)
+{
+	struct cscfg_config_desc *curr_item, *match_item = 0;
+
+	mutex_lock(&cscfg_mutex);
+
+	list_for_each_entry(curr_item, &cscfg_mgr->data.config_desc_list, item) {
+		if ((unsigned long)curr_item->id_ea->var == cfg_hash) {
+			match_item = curr_item;
+			atomic_inc(&cscfg_mgr->data.sys_active_cnt);
+			break;
+		}
+	}
+	mutex_unlock(&cscfg_mutex);
+
+	if (!match_item)
+		return -EINVAL;
+
+	dev_dbg(to_device_cscfg(), "Activate config %s.\n", match_item->name);
+
+	/* mark the descriptors as active so enable config will use them */
+	mutex_lock(&cscfg_csdev_mutex);
+	atomic_inc(&match_item->active_cnt);
+	mutex_unlock(&cscfg_csdev_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cscfg_activate_config);
+
+void cscfg_deactivate_config(unsigned long cfg_hash)
+{
+	struct cscfg_config_desc *curr_item, *match_item = 0;
+
+	mutex_lock(&cscfg_mutex);
+
+	list_for_each_entry(curr_item, &cscfg_mgr->data.config_desc_list, item) {
+		if ((unsigned long)curr_item->id_ea->var == cfg_hash) {
+			match_item = curr_item;
+			break;
+		}
+	}
+	mutex_unlock(&cscfg_mutex);
+	if (!match_item)
+		return;
+
+	dev_dbg(to_device_cscfg(), "Deactivate config %s.\n", match_item->name);
+
+	mutex_lock(&cscfg_csdev_mutex);
+	atomic_dec(&match_item->active_cnt);
+	mutex_unlock(&cscfg_csdev_mutex);
+
+	atomic_dec(&cscfg_mgr->data.sys_active_cnt);
+}
+EXPORT_SYMBOL_GPL(cscfg_deactivate_config);
+
+/* Find and program any active config for the supplied device.*/
+int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
+				     unsigned long id_hash, int preset)
+{
+	struct cscfg_config_csdev *cfg = NULL, *item;
+	const struct cscfg_config_desc *desc;
+	int err = 0;
+
+	/* quickly check global count */
+	if (!atomic_read(&cscfg_mgr->data.sys_active_cnt))
+		return 0;
+
+	mutex_lock(&cscfg_csdev_mutex);
+	list_for_each_entry(item, &csdev->config_csdev_list, node) {
+		desc = item->desc;
+		if ((atomic_read(&desc->active_cnt)) &&
+		    ((unsigned long)desc->id_ea->var == id_hash)) {
+			cfg = item;
+			break;
+		}
+	}
+	if (cfg) {
+		err = cscfg_csdev_enable_config(cfg, preset);
+		if (!err)
+			csdev->active_cfg_ctxt = (void *)cfg;
+	}
+	mutex_unlock(&cscfg_csdev_mutex);
+	return err;
+}
+EXPORT_SYMBOL_GPL(cscfg_csdev_enable_active_config);
+
+/* save and disable the active config for the device */
+void cscfg_csdev_disable_active_config(struct coresight_device *csdev)
+{
+	struct cscfg_config_csdev *cfg;
+
+	mutex_lock(&cscfg_csdev_mutex);
+	cfg = (struct cscfg_config_csdev *)csdev->active_cfg_ctxt;
+	if (cfg)
+		cscfg_csdev_disable_config(cfg);
+	mutex_unlock(&cscfg_csdev_mutex);
+}
+EXPORT_SYMBOL_GPL(cscfg_csdev_disable_active_config);
+
 /* Initialise system configuration management device. */
 
 struct device *to_device_cscfg(void)
@@ -546,6 +672,7 @@ int __init cscfg_init(void)
 	INIT_LIST_HEAD(&cscfg_mgr->data.feat_desc_list);
 	INIT_LIST_HEAD(&cscfg_mgr->data.config_desc_list);
 	cscfg_mgr->data.nr_csdev = 0;
+	atomic_set(&cscfg_mgr->data.sys_active_cnt, 0);
 
 	dev_info(to_device_cscfg(), "CoreSight Configuration manager initialised");
 	return 0;
diff --git a/drivers/hwtracing/coresight/coresight-syscfg.h b/drivers/hwtracing/coresight/coresight-syscfg.h
index ebf5e1491d86..301e26e1e98f 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg.h
+++ b/drivers/hwtracing/coresight/coresight-syscfg.h
@@ -17,13 +17,15 @@
  * @csdev_list:		List of coresight devices registered with the configuration manager.
  * @feat_desc_list:	List of feature descriptors to load into registered devices.
  * @config_desc_list:	List of system configuration descriptors to load into registered devices.
- * @nr_csdev:	Number of registered devices with the cscfg system
+ * @nr_csdev:		Number of registered devices with the cscfg system
+ * @sys_active_cnt:	Total number of active config descriptor references.
  */
 struct cscfg_api_data {
 	struct list_head csdev_desc_list;
 	struct list_head feat_desc_list;
 	struct list_head config_desc_list;
 	int nr_csdev;
+	atomic_t sys_active_cnt;
 };
 
 /**
@@ -53,6 +55,12 @@ int cscfg_register_csdev(struct coresight_device *csdev,
 			 struct cscfg_match_desc *info,
 			 struct cscfg_csdev_feat_ops *ops);
 void cscfg_unregister_csdev(struct coresight_device *csdev);
+int cscfg_activate_config(unsigned long cfg_hash);
+void cscfg_deactivate_config(unsigned long cfg_hash);
+void cscfg_csdev_reset_feats(struct coresight_device *csdev);
+int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
+				     unsigned long id_hash, int preset);
+void cscfg_csdev_disable_active_config(struct coresight_device *csdev);
 
 /**
  * System configuration manager device.
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index d0126ed326a6..3941854e8280 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -221,6 +221,7 @@ struct coresight_sysfs_link {
  * @has_conns_grp: Have added a "connections" group for sysfs links.
  * @feature_csdev_list: List of complex feature programming added to the device.
  * @config_csdev_list:  List of system configurations added to the device.
+ * @active_cfg_ctxt:    Context information for current active congfig.
  */
 struct coresight_device {
 	struct coresight_platform_data *pdata;
@@ -245,6 +246,7 @@ struct coresight_device {
 	/* system configuration and feature lists */
 	struct list_head feature_csdev_list;
 	struct list_head config_csdev_list;
+	void *active_cfg_ctxt;
 };
 
 /*
-- 
2.17.1

