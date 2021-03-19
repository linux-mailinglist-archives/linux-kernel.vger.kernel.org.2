Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6856F341986
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhCSKHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:07:31 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13647 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhCSKHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:07:13 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F1zyZ444wzmZc2;
        Fri, 19 Mar 2021 18:04:38 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Fri, 19 Mar 2021 18:06:56 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <john.garry@huawei.com>, <zhangshaokun@hisilicon.com>,
        <will@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: [PATCH v2 1/3] drivers/perf: convert sysfs snprintf family to sysfs_emit
Date:   Fri, 19 Mar 2021 18:04:31 +0800
Message-ID: <1616148273-16374-2-git-send-email-liuqi115@huawei.com>
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

From: Zihao Tang <tangzihao1@hisilicon.com>

Fix the following coccicheck warning:

./drivers/perf/hisilicon/hisi_uncore_pmu.c:128:8-16: WARNING: use scnprintf or sprintf.
./drivers/perf/fsl_imx8_ddr_perf.c:173:8-16: WARNING: use scnprintf or sprintf.
./drivers/perf/arm_spe_pmu.c:129:8-16: WARNING: use scnprintf or sprintf.
./drivers/perf/arm_smmu_pmu.c:563:8-16: WARNING: use scnprintf or sprintf.
./drivers/perf/arm_dsu_pmu.c:149:8-16: WARNING: use scnprintf or sprintf.
./drivers/perf/arm_dsu_pmu.c:139:8-16: WARNING: use scnprintf or sprintf.
./drivers/perf/arm-cmn.c:563:8-16: WARNING: use scnprintf or sprintf.
./drivers/perf/arm-cmn.c:351:8-16: WARNING: use scnprintf or sprintf.
./drivers/perf/arm-ccn.c:224:8-16: WARNING: use scnprintf or sprintf.
./drivers/perf/arm-cci.c:708:8-16: WARNING: use scnprintf or sprintf.
./drivers/perf/arm-cci.c:699:8-16: WARNING: use scnprintf or sprintf.
./drivers/perf/arm-cci.c:528:8-16: WARNING: use scnprintf or sprintf.
./drivers/perf/arm-cci.c:309:8-16: WARNING: use scnprintf or sprintf.

Signed-off-by: Zihao Tang <tangzihao1@hisilicon.com>
Signed-off-by: Qi Liu <liuqi115@huawei.com>
---
 drivers/perf/arm-cci.c                   | 12 ++++++------
 drivers/perf/arm-ccn.c                   |  4 ++--
 drivers/perf/arm-cmn.c                   | 22 +++++++++++-----------
 drivers/perf/arm_dsu_pmu.c               |  5 ++---
 drivers/perf/arm_smmuv3_pmu.c            |  2 +-
 drivers/perf/arm_spe_pmu.c               |  3 +--
 drivers/perf/fsl_imx8_ddr_perf.c         |  3 +--
 drivers/perf/hisilicon/hisi_uncore_pmu.c |  2 +-
 8 files changed, 25 insertions(+), 28 deletions(-)

diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
index f81e2ec..666d8a9 100644
--- a/drivers/perf/arm-cci.c
+++ b/drivers/perf/arm-cci.c
@@ -306,7 +306,7 @@ static ssize_t cci400_pmu_cycle_event_show(struct device *dev,
 {
 	struct dev_ext_attribute *eattr = container_of(attr,
 				struct dev_ext_attribute, attr);
-	return snprintf(buf, PAGE_SIZE, "config=0x%lx\n", (unsigned long)eattr->var);
+	return sysfs_emit(buf, "config=0x%lx\n", (unsigned long)eattr->var);
 }
 
 static int cci400_get_event_idx(struct cci_pmu *cci_pmu,
@@ -525,8 +525,8 @@ static ssize_t cci5xx_pmu_global_event_show(struct device *dev,
 	struct dev_ext_attribute *eattr = container_of(attr,
 					struct dev_ext_attribute, attr);
 	/* Global events have single fixed source code */
-	return snprintf(buf, PAGE_SIZE, "event=0x%lx,source=0x%x\n",
-				(unsigned long)eattr->var, CCI5xx_PORT_GLOBAL);
+	return sysfs_emit(buf, "event=0x%lx,source=0x%x\n",
+			  (unsigned long)eattr->var, CCI5xx_PORT_GLOBAL);
 }
 
 /*
@@ -696,7 +696,7 @@ static ssize_t cci_pmu_format_show(struct device *dev,
 {
 	struct dev_ext_attribute *eattr = container_of(attr,
 				struct dev_ext_attribute, attr);
-	return snprintf(buf, PAGE_SIZE, "%s\n", (char *)eattr->var);
+	return sysfs_emit(buf, "%s\n", (char *)eattr->var);
 }
 
 static ssize_t cci_pmu_event_show(struct device *dev,
@@ -705,8 +705,8 @@ static ssize_t cci_pmu_event_show(struct device *dev,
 	struct dev_ext_attribute *eattr = container_of(attr,
 				struct dev_ext_attribute, attr);
 	/* source parameter is mandatory for normal PMU events */
-	return snprintf(buf, PAGE_SIZE, "source=?,event=0x%lx\n",
-					 (unsigned long)eattr->var);
+	return sysfs_emit(buf, "source=?,event=0x%lx\n",
+			  (unsigned long)eattr->var);
 }
 
 static int pmu_is_valid_counter(struct cci_pmu *cci_pmu, int idx)
diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
index a0a71c1..3a2ddc0 100644
--- a/drivers/perf/arm-ccn.c
+++ b/drivers/perf/arm-ccn.c
@@ -221,7 +221,7 @@ static ssize_t arm_ccn_pmu_format_show(struct device *dev,
 	struct dev_ext_attribute *ea = container_of(attr,
 			struct dev_ext_attribute, attr);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", (char *)ea->var);
+	return sysfs_emit(buf, "%s\n", (char *)ea->var);
 }
 
 #define CCN_FORMAT_ATTR(_name, _config) \
@@ -476,7 +476,7 @@ static ssize_t arm_ccn_pmu_cmp_mask_show(struct device *dev,
 	struct arm_ccn *ccn = pmu_to_arm_ccn(dev_get_drvdata(dev));
 	u64 *mask = arm_ccn_pmu_get_cmp_mask(ccn, attr->attr.name);
 
-	return mask ? snprintf(buf, PAGE_SIZE, "0x%016llx\n", *mask) : -EINVAL;
+	return mask ? sysfs_emit(buf, "0x%016llx\n", *mask) : -EINVAL;
 }
 
 static ssize_t arm_ccn_pmu_cmp_mask_store(struct device *dev,
diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 1328159f..56a5c35 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -348,19 +348,19 @@ static ssize_t arm_cmn_event_show(struct device *dev,
 	eattr = container_of(attr, typeof(*eattr), attr);
 
 	if (eattr->type == CMN_TYPE_DTC)
-		return snprintf(buf, PAGE_SIZE, "type=0x%x\n", eattr->type);
+		return sysfs_emit(buf, "type=0x%x\n", eattr->type);
 
 	if (eattr->type == CMN_TYPE_WP)
-		return snprintf(buf, PAGE_SIZE,
-				"type=0x%x,eventid=0x%x,wp_dev_sel=?,wp_chn_sel=?,wp_grp=?,wp_val=?,wp_mask=?\n",
-				eattr->type, eattr->eventid);
+		return sysfs_emit(buf,
+				  "type=0x%x,eventid=0x%x,wp_dev_sel=?,wp_chn_sel=?,wp_grp=?,wp_val=?,wp_mask=?\n",
+				  eattr->type, eattr->eventid);
 
 	if (arm_cmn_is_occup_event(eattr->type, eattr->eventid))
-		return snprintf(buf, PAGE_SIZE, "type=0x%x,eventid=0x%x,occupid=0x%x\n",
-				eattr->type, eattr->eventid, eattr->occupid);
+		return sysfs_emit(buf, "type=0x%x,eventid=0x%x,occupid=0x%x\n",
+				  eattr->type, eattr->eventid, eattr->occupid);
 
-	return snprintf(buf, PAGE_SIZE, "type=0x%x,eventid=0x%x\n",
-			eattr->type, eattr->eventid);
+	return sysfs_emit(buf, "type=0x%x,eventid=0x%x\n", eattr->type,
+			  eattr->eventid);
 }
 
 static umode_t arm_cmn_event_attr_is_visible(struct kobject *kobj,
@@ -560,12 +560,12 @@ static ssize_t arm_cmn_format_show(struct device *dev,
 	int lo = __ffs(fmt->field), hi = __fls(fmt->field);
 
 	if (lo == hi)
-		return snprintf(buf, PAGE_SIZE, "config:%d\n", lo);
+		return sysfs_emit(buf, "config:%d\n", lo);
 
 	if (!fmt->config)
-		return snprintf(buf, PAGE_SIZE, "config:%d-%d\n", lo, hi);
+		return sysfs_emit(buf, "config:%d-%d\n", lo, hi);
 
-	return snprintf(buf, PAGE_SIZE, "config%d:%d-%d\n", fmt->config, lo, hi);
+	return sysfs_emit(buf, "config%d:%d-%d\n", fmt->config, lo, hi);
 }
 
 #define _CMN_FORMAT_ATTR(_name, _cfg, _fld)				\
diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
index 0459a34..196faea 100644
--- a/drivers/perf/arm_dsu_pmu.c
+++ b/drivers/perf/arm_dsu_pmu.c
@@ -136,8 +136,7 @@ static ssize_t dsu_pmu_sysfs_event_show(struct device *dev,
 {
 	struct dev_ext_attribute *eattr = container_of(attr,
 					struct dev_ext_attribute, attr);
-	return snprintf(buf, PAGE_SIZE, "event=0x%lx\n",
-					 (unsigned long)eattr->var);
+	return sysfs_emit(buf, "event=0x%lx\n", (unsigned long)eattr->var);
 }
 
 static ssize_t dsu_pmu_sysfs_format_show(struct device *dev,
@@ -146,7 +145,7 @@ static ssize_t dsu_pmu_sysfs_format_show(struct device *dev,
 {
 	struct dev_ext_attribute *eattr = container_of(attr,
 					struct dev_ext_attribute, attr);
-	return snprintf(buf, PAGE_SIZE, "%s\n", (char *)eattr->var);
+	return sysfs_emit(buf, "%s\n", (char *)eattr->var);
 }
 
 static ssize_t dsu_pmu_cpumask_show(struct device *dev,
diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index 8ff7a67..fa9dfbc 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -560,7 +560,7 @@ static ssize_t smmu_pmu_identifier_attr_show(struct device *dev,
 {
 	struct smmu_pmu *smmu_pmu = to_smmu_pmu(dev_get_drvdata(dev));
 
-	return snprintf(page, PAGE_SIZE, "0x%08x\n", smmu_pmu->iidr);
+	return sysfs_emit(page, "0x%08x\n", smmu_pmu->iidr);
 }
 
 static umode_t smmu_pmu_identifier_attr_visible(struct kobject *kobj,
diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index d3929cc..8a1e86a 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -126,8 +126,7 @@ static ssize_t arm_spe_pmu_cap_show(struct device *dev,
 		container_of(attr, struct dev_ext_attribute, attr);
 	int cap = (long)ea->var;
 
-	return snprintf(buf, PAGE_SIZE, "%u\n",
-		arm_spe_pmu_cap_get(spe_pmu, cap));
+	return sysfs_emit(buf, "%u\n", arm_spe_pmu_cap_get(spe_pmu, cap));
 }
 
 #define SPE_EXT_ATTR_ENTRY(_name, _func, _var)				\
diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
index be1f26b..c126fd8 100644
--- a/drivers/perf/fsl_imx8_ddr_perf.c
+++ b/drivers/perf/fsl_imx8_ddr_perf.c
@@ -170,8 +170,7 @@ static ssize_t ddr_perf_filter_cap_show(struct device *dev,
 		container_of(attr, struct dev_ext_attribute, attr);
 	int cap = (long)ea->var;
 
-	return snprintf(buf, PAGE_SIZE, "%u\n",
-			ddr_perf_filter_cap_get(pmu, cap));
+	return sysfs_emit(buf, "%u\n", ddr_perf_filter_cap_get(pmu, cap));
 }
 
 #define PERF_EXT_ATTR_ENTRY(_name, _func, _var)				\
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
index 9dbdc3f..64ccf5e 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -125,7 +125,7 @@ ssize_t hisi_uncore_pmu_identifier_attr_show(struct device *dev,
 {
 	struct hisi_pmu *hisi_pmu = to_hisi_pmu(dev_get_drvdata(dev));
 
-	return snprintf(page, PAGE_SIZE, "0x%08x\n", hisi_pmu->identifier);
+	return sysfs_emit(page, "0x%08x\n", hisi_pmu->identifier);
 }
 EXPORT_SYMBOL_GPL(hisi_uncore_pmu_identifier_attr_show);
 
-- 
2.8.1

