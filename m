Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A10F333DC2B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 19:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239716AbhCPSIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 14:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239818AbhCPSGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 14:06:02 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2987CC0613DC
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 11:04:07 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso2000918wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 11:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wutFErWWgnh8jJeyt16zA2EMqrwI+2nTDmIAuuTTGOk=;
        b=xBjvV2u4o+s9pTiK++5PmgEB8tA6svoTT0JeuW1wyInyMtlL7XaAob/4TKdDkZqpI0
         jxMs6c4SE+wp8X9LTLOxbMaAw1hiTZL0RFTMEk2UQlaatnX9375zfGTotASmJYqUcGC0
         2tDoCsHM4VrNkjJP5O7cWKpK6WCV89yENJdqgvLigEUz+DAUg8dAOW0bc8GuSiaUln15
         gNnlNEKYsuncTSEfCdDN+N+8Sh2ps+GVP68dJJ9/UP9R6OYyh4juOtiQZYdQu+ju8Lqg
         V9Z2Ry4Xgd31u21bm7DMDrh4Q9toM/yLp0LkV8jp/RarbKCexldsQsPVsCpNPKA0gWDB
         WAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wutFErWWgnh8jJeyt16zA2EMqrwI+2nTDmIAuuTTGOk=;
        b=oskZqi5zHjZuOCgBYCgt8oiRf7+Pdo6gHYEaQCzEqB+o9LDQ2iNbeJPF1Gy3JtVPXd
         8VU1K7Mx74zr0+E2L+Ftzpi0nvDmKA0JMG+EXwmbR1mUBa5s2WpVQtWVKkjB12cH6PuO
         Te36BdoBZ1Gu//rzdW+f20x63CvU92f89349PKIr8+JYzQBqWsk/19xnADAyHgHPwKmN
         kSY33CiJm65WDo8652Ix8R+a29gM8mxNF2I/nDzlLZY4ItxSMjNQb0kSdNV6I6jV5x/b
         nRB49uZasAwaLv7dFmq8wfskfSIBpyxcSCcUGNYdqzjlVSYk16NP6kb+xkhaxf0fob/K
         eLng==
X-Gm-Message-State: AOAM531s71HtRzLLG2mCyLHs/vAFdeR+/Hls1B41iPG0xb6oe02xHEtN
        +SFfOqV/qTWwnh26TIf1D9Xa4A==
X-Google-Smtp-Source: ABdhPJzu6vzcpVYQdBr1jBchSYNBAjXaBHLH7urrmnYRFAqvIwD9IOdSXzWbX/8Tg8+i+2HXThJ6Ig==
X-Received: by 2002:a7b:c759:: with SMTP id w25mr73352wmk.139.1615917845785;
        Tue, 16 Mar 2021 11:04:05 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6801:1801:84a6:25fa:dde:ecca])
        by smtp.gmail.com with ESMTPSA id d13sm23927858wro.23.2021.03.16.11.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 11:04:05 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, linux-doc@vger.kernel.org,
        suzuki.poulose@arm.com
Cc:     yabinc@google.com, corbet@lwn.net, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, tingwei@codeaurora.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v5 04/10] coresight: etm-perf: update to handle configuration selection
Date:   Tue, 16 Mar 2021 18:03:54 +0000
Message-Id: <20210316180400.7184-5-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210316180400.7184-1-mike.leach@linaro.org>
References: <20210316180400.7184-1-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Loaded coresight configurations are registered in the cs_etm\cs_config sub
directory. This extends the etm-perf code to handle these registrations,
and the cs_syscfg driver to perform the registration on load.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 .../hwtracing/coresight/coresight-config.h    |   2 +
 .../hwtracing/coresight/coresight-etm-perf.c  | 139 ++++++++++++++----
 .../hwtracing/coresight/coresight-etm-perf.h  |   8 +
 .../hwtracing/coresight/coresight-syscfg.c    |  12 ++
 4 files changed, 130 insertions(+), 31 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
index f70561c1504b..38fd1c71eb05 100644
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
index 0e392513b2d6..66bda452a2f4 100644
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
@@ -38,8 +40,13 @@ PMU_FORMAT_ATTR(contextid1,	"config:" __stringify(ETM_OPT_CTXTID));
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
@@ -69,6 +76,8 @@ static struct attribute *etm_config_formats_attr[] = {
 	&format_attr_timestamp.attr,
 	&format_attr_retstack.attr,
 	&format_attr_sinkid.attr,
+	&format_attr_preset.attr,
+	&format_attr_configid.attr,
 	NULL,
 };
 
@@ -86,9 +95,19 @@ static const struct attribute_group etm_pmu_sinks_group = {
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
 
@@ -247,7 +266,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 	INIT_WORK(&event_data->work, free_event_data);
 
 	/* First get the selected sink from user space. */
-	if (event->attr.config2) {
+	if (event->attr.config2 & GENMASK_ULL(31, 0)) {
 		id = (u32)event->attr.config2;
 		sink = coresight_get_sink_by_id(id);
 	}
@@ -555,9 +574,9 @@ int etm_perf_symlink(struct coresight_device *csdev, bool link)
 }
 EXPORT_SYMBOL_GPL(etm_perf_symlink);
 
-static ssize_t etm_perf_sink_name_show(struct device *dev,
-				       struct device_attribute *dattr,
-				       char *buf)
+static ssize_t etm_perf_name_show(struct device *dev,
+				  struct device_attribute *dattr,
+				  char *buf)
 {
 	struct dev_ext_attribute *ea;
 
@@ -565,68 +584,126 @@ static ssize_t etm_perf_sink_name_show(struct device *dev,
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
+	ea->attr.show = etm_perf_name_show;
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
+	}
+	return err;
 }
 
-void etm_perf_del_symlink_sink(struct coresight_device *csdev)
+void etm_perf_del_symlink_group(struct dev_ext_attribute *ea, const char *group_name)
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
+	/* override the show function to the custom cscfg event */
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
index 11d1422f0ed3..03014a2142c1 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg.c
+++ b/drivers/hwtracing/coresight/coresight-syscfg.c
@@ -7,6 +7,7 @@
 #include <linux/platform_device.h>
 
 #include "coresight-config.h"
+#include "coresight-etm-perf.h"
 #include "coresight-syscfg.h"
 
 /*
@@ -86,6 +87,7 @@ static int cscfg_add_csdev_cfg(struct coresight_device *csdev,
 			config_csdev->feats_csdev[config_csdev->nr_feat++] = feat_csdev;
 		}
 	}
+
 	/* if matched features, add config to device.*/
 	if (config_csdev) {
 		mutex_lock(&cscfg_csdev_mutex);
@@ -276,6 +278,11 @@ static int cscfg_load_config(struct cscfg_config_desc *config_desc)
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
@@ -490,7 +497,12 @@ int cscfg_create_device(void)
 
 void cscfg_clear_device(void)
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

