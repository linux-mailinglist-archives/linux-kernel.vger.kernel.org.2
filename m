Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8DB3D3DED
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 18:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhGWQO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 12:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbhGWQOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 12:14:19 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2ECCC061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 09:54:51 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z8so3054858wru.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 09:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jV/niZMfFIZkK/NVRGMGDq9DblliD2VXOphjcecDOCY=;
        b=Mg1T5TX3vpSrwEYMD9aqo6mwr5umbtmi4hmkOHZ3f9FjCb8XuhMW8UKVcB6Pp8rlMo
         WWmzHEuSZPWTq4+G5E+63aooM+sSffq8Um3aXiOIQDcR4u2BE8APNIV24zqiiEZ1bcm2
         ULR6Sl6pVZOZWiWm8DrQlW0pSH8oyo1PVwwTz4fLEvyYa6GZM9Lz0d6NhZ3BonAn6U7P
         kvw+MtIu/3wsm8rAQd4LWHK8IZxlDHtk6JkjE+i81az9+Wl8fzZ1D8dwSLgAz9m26mVr
         bdRqo4sPY3CcIrh6BLnb76P8e8FWMH7A/Nq+1I91JamRvzw70Bct4qEX7ot10RJ82m8p
         GIXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jV/niZMfFIZkK/NVRGMGDq9DblliD2VXOphjcecDOCY=;
        b=EKbngl/R1lQep22/MhTWWVKXEIj0pRyna4uY/n5JjweK7kzjS9nJUH/QUKC3BYJAyI
         +5VaZ/t2ThX6DTHB7pjq/I8p9HkZLYchcYGuzXA9sBLlYKIy/Dj/ewgw+607q/T7aJSA
         B/Xzouo7KWU4vRdm/ymUkZ9yy55N2VAMYJbnPnXfM034kFBv+vqql0c+QCxt31YolIOH
         BKl6Iic7D4Yyls4eGWce7Zg734wEQXt5X8BbqZr5Kqkv+248jYF5xvX3117lRtorMkkJ
         5tuNdaKqTUAbLIuxucLLsnceIynVB61YVohMUHApC4RV5Afa48RxiipEyoU7YZusieqX
         g3dA==
X-Gm-Message-State: AOAM533ipcB9xZhpf961Cf4HCcjyl8TC9tIpCsqJjJt/0gxh3mBF8cn6
        aGamnVYEqfYhrci6eMtnNnWMJA==
X-Google-Smtp-Source: ABdhPJxwRswrzNTSWdVUiICEr/XYoWsuToHJqIwOmNTw4Ey5vwpp91qsn6cK7yeIB1LeJfv2nj23ug==
X-Received: by 2002:a05:6000:1801:: with SMTP id m1mr837952wrh.198.1627059290224;
        Fri, 23 Jul 2021 09:54:50 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:fdab:eb9d:1515:bff3])
        by smtp.gmail.com with ESMTPSA id z11sm33193225wru.65.2021.07.23.09.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 09:54:49 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, suzuki.poulose@arm.com
Cc:     yabinc@google.com, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, tingwei@codeaurora.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v9 04/10] coresight: etm-perf: update to handle configuration selection
Date:   Fri, 23 Jul 2021 17:54:38 +0100
Message-Id: <20210723165444.1048-5-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210723165444.1048-1-mike.leach@linaro.org>
References: <20210723165444.1048-1-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Loaded coresight configurations are registered in the cs_etm\events sub
directory. This extends the etm-perf code to handle these registrations,
and the cs_syscfg driver to perform the registration on load.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
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
2.17.1

