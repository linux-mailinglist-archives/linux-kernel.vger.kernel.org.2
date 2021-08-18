Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8233F0BF1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 21:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbhHRTlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 15:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbhHRTlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 15:41:06 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5389FC061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 12:40:31 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id w8so3377060pgf.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 12:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BKK6GCj1XIDVJxHe90NCqlt7jeTSriotfSvfITU6TMc=;
        b=njjHP6W1+kWtcSSeoM4kPyPpyO7hoHKgtRt4ULCIMh7wHP0HWSk2uDVKhqhPDNZNID
         aOv9RWQnuvw1YoDBDN9FoCMdqCbY4XhSwSqqvj0w6Uqbgq645DjFt94FxCSSr+cGjPFS
         GMovPKlfdiSd784PRXgqQ8Fc+nejlhSyewqJh7lhBNNNf+nFHoyCsjCFq9kf2uoAEdrP
         A5mI+CSv0PjKgSBAfV1SGIRQEsGAuSBUJxcrH/9kdhK54ce5MqpcyomFMcP7mG3WZ39A
         QWmbSTk03jm/PrdhY7Ci3QKTMr+YmBY1Y3H4fKDTWSA9uVI2Tz/F5QaHFkL77VtWl60f
         8ltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BKK6GCj1XIDVJxHe90NCqlt7jeTSriotfSvfITU6TMc=;
        b=eYe6iS3algWOcIxq7OZcCbgsTXZ3/PLfKKYK6C/CAHFsMDZihLG817DyifYz6V7WSY
         36V8lbCXWz6CB2I8wVP+FvWvgsL/IPpZ89pag32tVUtVNJqslaNDS6QsdhNSA+f07Ygv
         ctlM5TIIPMLK6S1W+fhmgx6CEyQLM81JcWMAK1GZnySa+XUzwKXuIky3lF/7AUJCP8kS
         aysh/TUiudRrHIkDuD6rIdX+kOckwfAqgT+HHaJjSjmJ4zPpUVJSGufWzmG+k3QPigO8
         h+F/QMj4h58kcdwpUtH3CznM7RxeGXiwKXqxVxlmgd8gx5+4HTVWcwJ4rH9x8ZivUuta
         lv7w==
X-Gm-Message-State: AOAM533e3F5fwGB4k39+345kxIIXmHR2cHO45BSzSSEKl9bAxmRYrj+C
        Wq2xa4Fy/hm9WLO29IA5hjlDnw==
X-Google-Smtp-Source: ABdhPJyZ9Qz2gapwZZ6t7idoqz1dMCXz1CUskRsJOhw1Uin5E4SyezE0/9V+2OTcU9kpFWHz2X40tg==
X-Received: by 2002:a63:f341:: with SMTP id t1mr10488251pgj.149.1629315630826;
        Wed, 18 Aug 2021 12:40:30 -0700 (PDT)
Received: from p14s.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id k12sm2960137pjg.6.2021.08.18.12.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 12:40:30 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] coresight: etm-perf: Update to handle configuration selection
Date:   Wed, 18 Aug 2021 13:40:15 -0600
Message-Id: <20210818194022.379573-5-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210818194022.379573-1-mathieu.poirier@linaro.org>
References: <20210818194022.379573-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Leach <mike.leach@linaro.org>

Loaded coresight configurations are registered in the cs_etm\events sub
directory. This extends the etm-perf code to handle these registrations,
and the cs_syscfg driver to perform the registration on load.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Link: https://lore.kernel.org/r/20210723165444.1048-5-mike.leach@linaro.org
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../hwtracing/coresight/coresight-config.h    |   2 +
 .../hwtracing/coresight/coresight-etm-perf.c  | 134 ++++++++++++++----
 .../hwtracing/coresight/coresight-etm-perf.h  |   8 ++
 .../hwtracing/coresight/coresight-syscfg.c    |  11 ++
 4 files changed, 127 insertions(+), 28 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
index 5a39cbbc38a4..0667581822c1 100644
--- a/drivers/hwtracing/coresight/coresight-config.h
+++ b/drivers/hwtracing/coresight/coresight-config.h
@@ -126,6 +126,7 @@ struct cscfg_feature_desc {
  * @nr_presets:		Number of sets of presets supplied by this configuration.
  * @nr_total_params:	Sum of all parameters declared by used features
  * @presets:		Array of preset values.
+ * @event_ea:		Extended attribute for perf event value
  *
  */
 struct cscfg_config_desc {
@@ -137,6 +138,7 @@ struct cscfg_config_desc {
 	int nr_presets;
 	int nr_total_params;
 	const u64 *presets; /* nr_presets * nr_total_params */
+	struct dev_ext_attribute *event_ea;
 };
 
 /**
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index b582e92cdea4..e42ab919ddc3 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -18,8 +18,10 @@
 #include <linux/types.h>
 #include <linux/workqueue.h>
 
+#include "coresight-config.h"
 #include "coresight-etm-perf.h"
 #include "coresight-priv.h"
+#include "coresight-syscfg.h"
 
 static struct pmu etm_pmu;
 static bool etm_perf_up;
@@ -57,8 +59,13 @@ PMU_FORMAT_ATTR(contextid1,	"config:" __stringify(ETM_OPT_CTXTID));
 PMU_FORMAT_ATTR(contextid2,	"config:" __stringify(ETM_OPT_CTXTID2));
 PMU_FORMAT_ATTR(timestamp,	"config:" __stringify(ETM_OPT_TS));
 PMU_FORMAT_ATTR(retstack,	"config:" __stringify(ETM_OPT_RETSTK));
+/* preset - if sink ID is used as a configuration selector */
+PMU_FORMAT_ATTR(preset,		"config:0-3");
 /* Sink ID - same for all ETMs */
 PMU_FORMAT_ATTR(sinkid,		"config2:0-31");
+/* config ID - set if a system configuration is selected */
+PMU_FORMAT_ATTR(configid,	"config2:32-63");
+
 
 /*
  * contextid always traces the "PID".  The PID is in CONTEXTIDR_EL1
@@ -88,6 +95,8 @@ static struct attribute *etm_config_formats_attr[] = {
 	&format_attr_timestamp.attr,
 	&format_attr_retstack.attr,
 	&format_attr_sinkid.attr,
+	&format_attr_preset.attr,
+	&format_attr_configid.attr,
 	NULL,
 };
 
@@ -105,9 +114,19 @@ static const struct attribute_group etm_pmu_sinks_group = {
 	.attrs  = etm_config_sinks_attr,
 };
 
+static struct attribute *etm_config_events_attr[] = {
+	NULL,
+};
+
+static const struct attribute_group etm_pmu_events_group = {
+	.name   = "events",
+	.attrs  = etm_config_events_attr,
+};
+
 static const struct attribute_group *etm_pmu_attr_groups[] = {
 	&etm_pmu_format_group,
 	&etm_pmu_sinks_group,
+	&etm_pmu_events_group,
 	NULL,
 };
 
@@ -286,7 +305,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 	INIT_WORK(&event_data->work, free_event_data);
 
 	/* First get the selected sink from user space. */
-	if (event->attr.config2) {
+	if (event->attr.config2 & GENMASK_ULL(31, 0)) {
 		id = (u32)event->attr.config2;
 		sink = user_sink = coresight_get_sink_by_id(id);
 	}
@@ -658,68 +677,127 @@ static ssize_t etm_perf_sink_name_show(struct device *dev,
 	return scnprintf(buf, PAGE_SIZE, "0x%lx\n", (unsigned long)(ea->var));
 }
 
-int etm_perf_add_symlink_sink(struct coresight_device *csdev)
+static struct dev_ext_attribute *
+etm_perf_add_symlink_group(struct device *dev, const char *name, const char *group_name)
 {
-	int ret;
+	struct dev_ext_attribute *ea;
 	unsigned long hash;
-	const char *name;
+	int ret;
 	struct device *pmu_dev = etm_pmu.dev;
-	struct device *dev = &csdev->dev;
-	struct dev_ext_attribute *ea;
-
-	if (csdev->type != CORESIGHT_DEV_TYPE_SINK &&
-	    csdev->type != CORESIGHT_DEV_TYPE_LINKSINK)
-		return -EINVAL;
-
-	if (csdev->ea != NULL)
-		return -EINVAL;
 
 	if (!etm_perf_up)
-		return -EPROBE_DEFER;
+		return ERR_PTR(-EPROBE_DEFER);
 
 	ea = devm_kzalloc(dev, sizeof(*ea), GFP_KERNEL);
 	if (!ea)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
-	name = dev_name(dev);
-	/* See function coresight_get_sink_by_id() to know where this is used */
+	/*
+	 * If this function is called adding a sink then the hash is used for
+	 * sink selection - see function coresight_get_sink_by_id().
+	 * If adding a configuration then the hash is used for selection in
+	 * cscfg_activate_config()
+	 */
 	hash = hashlen_hash(hashlen_string(NULL, name));
 
 	sysfs_attr_init(&ea->attr.attr);
 	ea->attr.attr.name = devm_kstrdup(dev, name, GFP_KERNEL);
 	if (!ea->attr.attr.name)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	ea->attr.attr.mode = 0444;
-	ea->attr.show = etm_perf_sink_name_show;
 	ea->var = (unsigned long *)hash;
 
 	ret = sysfs_add_file_to_group(&pmu_dev->kobj,
-				      &ea->attr.attr, "sinks");
+				      &ea->attr.attr, group_name);
 
-	if (!ret)
-		csdev->ea = ea;
+	return ret ? ERR_PTR(ret) : ea;
+}
 
-	return ret;
+int etm_perf_add_symlink_sink(struct coresight_device *csdev)
+{
+	const char *name;
+	struct device *dev = &csdev->dev;
+	int err = 0;
+
+	if (csdev->type != CORESIGHT_DEV_TYPE_SINK &&
+	    csdev->type != CORESIGHT_DEV_TYPE_LINKSINK)
+		return -EINVAL;
+
+	if (csdev->ea != NULL)
+		return -EINVAL;
+
+	name = dev_name(dev);
+	csdev->ea = etm_perf_add_symlink_group(dev, name, "sinks");
+	if (IS_ERR(csdev->ea)) {
+		err = PTR_ERR(csdev->ea);
+		csdev->ea = NULL;
+	} else
+		csdev->ea->attr.show = etm_perf_sink_name_show;
+
+	return err;
 }
 
-void etm_perf_del_symlink_sink(struct coresight_device *csdev)
+static void etm_perf_del_symlink_group(struct dev_ext_attribute *ea, const char *group_name)
 {
 	struct device *pmu_dev = etm_pmu.dev;
-	struct dev_ext_attribute *ea = csdev->ea;
 
+	sysfs_remove_file_from_group(&pmu_dev->kobj,
+				     &ea->attr.attr, group_name);
+}
+
+void etm_perf_del_symlink_sink(struct coresight_device *csdev)
+{
 	if (csdev->type != CORESIGHT_DEV_TYPE_SINK &&
 	    csdev->type != CORESIGHT_DEV_TYPE_LINKSINK)
 		return;
 
-	if (!ea)
+	if (!csdev->ea)
 		return;
 
-	sysfs_remove_file_from_group(&pmu_dev->kobj,
-				     &ea->attr.attr, "sinks");
+	etm_perf_del_symlink_group(csdev->ea, "sinks");
 	csdev->ea = NULL;
 }
 
+static ssize_t etm_perf_cscfg_event_show(struct device *dev,
+					 struct device_attribute *dattr,
+					 char *buf)
+{
+	struct dev_ext_attribute *ea;
+
+	ea = container_of(dattr, struct dev_ext_attribute, attr);
+	return scnprintf(buf, PAGE_SIZE, "configid=0x%lx\n", (unsigned long)(ea->var));
+}
+
+int etm_perf_add_symlink_cscfg(struct device *dev, struct cscfg_config_desc *config_desc)
+{
+	int err = 0;
+
+	if (config_desc->event_ea != NULL)
+		return 0;
+
+	config_desc->event_ea = etm_perf_add_symlink_group(dev, config_desc->name, "events");
+
+	/* set the show function to the custom cscfg event */
+	if (!IS_ERR(config_desc->event_ea))
+		config_desc->event_ea->attr.show = etm_perf_cscfg_event_show;
+	else {
+		err = PTR_ERR(config_desc->event_ea);
+		config_desc->event_ea = NULL;
+	}
+
+	return err;
+}
+
+void etm_perf_del_symlink_cscfg(struct cscfg_config_desc *config_desc)
+{
+	if (!config_desc->event_ea)
+		return;
+
+	etm_perf_del_symlink_group(config_desc->event_ea, "events");
+	config_desc->event_ea = NULL;
+}
+
 int __init etm_perf_init(void)
 {
 	int ret;
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
index 29d90dfeba31..ba617fe2217e 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.h
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
@@ -11,6 +11,7 @@
 #include "coresight-priv.h"
 
 struct coresight_device;
+struct cscfg_config_desc;
 
 /*
  * In both ETMv3 and v4 the maximum number of address comparator implentable
@@ -69,6 +70,9 @@ static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
 		return data->snk_config;
 	return NULL;
 }
+int etm_perf_add_symlink_cscfg(struct device *dev,
+			       struct cscfg_config_desc *config_desc);
+void etm_perf_del_symlink_cscfg(struct cscfg_config_desc *config_desc);
 #else
 static inline int etm_perf_symlink(struct coresight_device *csdev, bool link)
 { return -EINVAL; }
@@ -79,6 +83,10 @@ static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
 {
 	return NULL;
 }
+int etm_perf_add_symlink_cscfg(struct device *dev,
+			       struct cscfg_config_desc *config_desc)
+{ return -EINVAL; }
+void etm_perf_del_symlink_cscfg(struct cscfg_config_desc *config_desc) {}
 
 #endif /* CONFIG_CORESIGHT */
 
diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
index 5e4bd86f369e..b93f2b4a777e 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg.c
+++ b/drivers/hwtracing/coresight/coresight-syscfg.c
@@ -7,6 +7,7 @@
 #include <linux/platform_device.h>
 
 #include "coresight-config.h"
+#include "coresight-etm-perf.h"
 #include "coresight-syscfg.h"
 
 /*
@@ -275,6 +276,11 @@ static int cscfg_load_config(struct cscfg_config_desc *config_desc)
 	if (err)
 		return err;
 
+	/* add config to perf fs to allow selection */
+	err = etm_perf_add_symlink_cscfg(cscfg_device(), config_desc);
+	if (err)
+		return err;
+
 	list_add(&config_desc->item, &cscfg_mgr->config_desc_list);
 	return 0;
 }
@@ -508,7 +514,12 @@ static int cscfg_create_device(void)
 
 static void cscfg_clear_device(void)
 {
+	struct cscfg_config_desc *cfg_desc;
+
 	mutex_lock(&cscfg_mutex);
+	list_for_each_entry(cfg_desc, &cscfg_mgr->config_desc_list, item) {
+		etm_perf_del_symlink_cscfg(cfg_desc);
+	}
 	device_unregister(cscfg_device());
 	mutex_unlock(&cscfg_mutex);
 }
-- 
2.25.1

