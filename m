Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E10341983
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhCSKH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:07:27 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13645 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhCSKHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:07:10 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F1zyZ4L8fzmZcf;
        Fri, 19 Mar 2021 18:04:38 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Fri, 19 Mar 2021 18:06:57 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <john.garry@huawei.com>, <zhangshaokun@hisilicon.com>,
        <will@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: [PATCH v2 3/3] drivers/perf: convert sysfs sprintf family to sysfs_emit
Date:   Fri, 19 Mar 2021 18:04:33 +0800
Message-ID: <1616148273-16374-4-git-send-email-liuqi115@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1616148273-16374-1-git-send-email-liuqi115@huawei.com>
References: <1616148273-16374-1-git-send-email-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sprintf does not know the PAGE_SIZE maximum of the temporary buffer
used for sysfs content and it's possible to overrun the buffer length.

Use sysfs_emit() function to ensures that no overrun is done.

Signed-off-by: Qi Liu <liuqi115@huawei.com>
---
 drivers/perf/arm_dmc620_pmu.c            | 2 +-
 drivers/perf/arm_smmuv3_pmu.c            | 2 +-
 drivers/perf/fsl_imx8_ddr_perf.c         | 4 ++--
 drivers/perf/hisilicon/hisi_uncore_pmu.c | 6 +++---
 drivers/perf/qcom_l2_pmu.c               | 2 +-
 drivers/perf/qcom_l3_pmu.c               | 4 ++--
 drivers/perf/thunderx2_pmu.c             | 4 ++--
 drivers/perf/xgene_pmu.c                 | 4 ++--
 8 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/perf/arm_dmc620_pmu.c b/drivers/perf/arm_dmc620_pmu.c
index 66ad5b3..8e9002a 100644
--- a/drivers/perf/arm_dmc620_pmu.c
+++ b/drivers/perf/arm_dmc620_pmu.c
@@ -113,7 +113,7 @@ dmc620_pmu_event_show(struct device *dev,
 
 	eattr = container_of(attr, typeof(*eattr), attr);
 
-	return sprintf(page, "event=0x%x,clkdiv2=0x%x\n", eattr->eventid, eattr->clkdiv2);
+	return sysfs_emit(page, "event=0x%x,clkdiv2=0x%x\n", eattr->eventid, eattr->clkdiv2);
 }
 
 #define DMC620_PMU_EVENT_ATTR(_name, _eventid, _clkdiv2)		\
diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index fa9dfbc..45a399f 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -506,7 +506,7 @@ static ssize_t smmu_pmu_event_show(struct device *dev,
 
 	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
 
-	return sprintf(page, "event=0x%02llx\n", pmu_attr->id);
+	return sysfs_emit(page, "event=0x%02llx\n", pmu_attr->id);
 }
 
 #define SMMU_EVENT_ATTR(name, config) \
diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
index c126fd8..2bbb931 100644
--- a/drivers/perf/fsl_imx8_ddr_perf.c
+++ b/drivers/perf/fsl_imx8_ddr_perf.c
@@ -110,7 +110,7 @@ static ssize_t ddr_perf_identifier_show(struct device *dev,
 {
 	struct ddr_pmu *pmu = dev_get_drvdata(dev);
 
-	return sprintf(page, "%s\n", pmu->devtype_data->identifier);
+	return sysfs_emit(page, "%s\n", pmu->devtype_data->identifier);
 }
 
 static umode_t ddr_perf_identifier_attr_visible(struct kobject *kobj,
@@ -219,7 +219,7 @@ ddr_pmu_event_show(struct device *dev, struct device_attribute *attr,
 	struct perf_pmu_events_attr *pmu_attr;
 
 	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
-	return sprintf(page, "event=0x%02llx\n", pmu_attr->id);
+	return sysfs_emit(page, "event=0x%02llx\n", pmu_attr->id);
 }
 
 #define IMX8_DDR_PMU_EVENT_ATTR(_name, _id)				\
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
index 64ccf5e..5e2b5e1 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -33,7 +33,7 @@ ssize_t hisi_format_sysfs_show(struct device *dev,
 
 	eattr = container_of(attr, struct dev_ext_attribute, attr);
 
-	return sprintf(buf, "%s\n", (char *)eattr->var);
+	return sysfs_emit(buf, "%s\n", (char *)eattr->var);
 }
 EXPORT_SYMBOL_GPL(hisi_format_sysfs_show);
 
@@ -47,7 +47,7 @@ ssize_t hisi_event_sysfs_show(struct device *dev,
 
 	eattr = container_of(attr, struct dev_ext_attribute, attr);
 
-	return sprintf(page, "config=0x%lx\n", (unsigned long)eattr->var);
+	return sysfs_emit(page, "config=0x%lx\n", (unsigned long)eattr->var);
 }
 EXPORT_SYMBOL_GPL(hisi_event_sysfs_show);
 
@@ -59,7 +59,7 @@ ssize_t hisi_cpumask_sysfs_show(struct device *dev,
 {
 	struct hisi_pmu *hisi_pmu = to_hisi_pmu(dev_get_drvdata(dev));
 
-	return sprintf(buf, "%d\n", hisi_pmu->on_cpu);
+	return sysfs_emit(buf, "%d\n", hisi_pmu->on_cpu);
 }
 EXPORT_SYMBOL_GPL(hisi_cpumask_sysfs_show);
 
diff --git a/drivers/perf/qcom_l2_pmu.c b/drivers/perf/qcom_l2_pmu.c
index 8883af9..fc54a80 100644
--- a/drivers/perf/qcom_l2_pmu.c
+++ b/drivers/perf/qcom_l2_pmu.c
@@ -676,7 +676,7 @@ static ssize_t l2cache_pmu_event_show(struct device *dev,
 	struct perf_pmu_events_attr *pmu_attr;
 
 	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
-	return sprintf(page, "event=0x%02llx\n", pmu_attr->id);
+	return sysfs_emit(page, "event=0x%02llx\n", pmu_attr->id);
 }
 
 #define L2CACHE_EVENT_ATTR(_name, _id)					     \
diff --git a/drivers/perf/qcom_l3_pmu.c b/drivers/perf/qcom_l3_pmu.c
index fb34b87..bba0780 100644
--- a/drivers/perf/qcom_l3_pmu.c
+++ b/drivers/perf/qcom_l3_pmu.c
@@ -615,7 +615,7 @@ static ssize_t l3cache_pmu_format_show(struct device *dev,
 	struct dev_ext_attribute *eattr;
 
 	eattr = container_of(attr, struct dev_ext_attribute, attr);
-	return sprintf(buf, "%s\n", (char *) eattr->var);
+	return sysfs_emit(buf, "%s\n", (char *) eattr->var);
 }
 
 #define L3CACHE_PMU_FORMAT_ATTR(_name, _config)				      \
@@ -643,7 +643,7 @@ static ssize_t l3cache_pmu_event_show(struct device *dev,
 	struct perf_pmu_events_attr *pmu_attr;
 
 	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
-	return sprintf(page, "event=0x%02llx\n", pmu_attr->id);
+	return sysfs_emit(page, "event=0x%02llx\n", pmu_attr->id);
 }
 
 #define L3CACHE_EVENT_ATTR(_name, _id)					     \
diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
index e116815..06a6d56 100644
--- a/drivers/perf/thunderx2_pmu.c
+++ b/drivers/perf/thunderx2_pmu.c
@@ -128,7 +128,7 @@ __tx2_pmu_##_var##_show(struct device *dev,				\
 			       char *page)				\
 {									\
 	BUILD_BUG_ON(sizeof(_format) >= PAGE_SIZE);			\
-	return sprintf(page, _format "\n");				\
+	return sysfs_emit(page, _format "\n");				\
 }									\
 									\
 static struct device_attribute format_attr_##_var =			\
@@ -176,7 +176,7 @@ static ssize_t tx2_pmu_event_show(struct device *dev,
 	struct dev_ext_attribute *eattr;
 
 	eattr = container_of(attr, struct dev_ext_attribute, attr);
-	return sprintf(buf, "event=0x%lx\n", (unsigned long) eattr->var);
+	return sysfs_emit(buf, "event=0x%lx\n", (unsigned long) eattr->var);
 }
 
 #define TX2_EVENT_ATTR(name, config) \
diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index 44faa51..ffe3bde 100644
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -170,7 +170,7 @@ static ssize_t xgene_pmu_format_show(struct device *dev,
 	struct dev_ext_attribute *eattr;
 
 	eattr = container_of(attr, struct dev_ext_attribute, attr);
-	return sprintf(buf, "%s\n", (char *) eattr->var);
+	return sysfs_emit(buf, "%s\n", (char *) eattr->var);
 }
 
 #define XGENE_PMU_FORMAT_ATTR(_name, _config)		\
@@ -281,7 +281,7 @@ static ssize_t xgene_pmu_event_show(struct device *dev,
 	struct dev_ext_attribute *eattr;
 
 	eattr = container_of(attr, struct dev_ext_attribute, attr);
-	return sprintf(buf, "config=0x%lx\n", (unsigned long) eattr->var);
+	return sysfs_emit(buf, "config=0x%lx\n", (unsigned long) eattr->var);
 }
 
 #define XGENE_PMU_EVENT_ATTR(_name, _config)		\
-- 
2.8.1

