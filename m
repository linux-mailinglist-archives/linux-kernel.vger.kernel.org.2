Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D95B43132ED
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 14:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhBHNIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 08:08:09 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11704 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhBHNIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 08:08:05 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DZ5qP2qLFzlHfL;
        Mon,  8 Feb 2021 21:05:37 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Mon, 8 Feb 2021 21:07:13 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <john.garry@huawei.com>, <zhangshaokun@hisilicon.com>,
        <will@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: [PATCH] drivers/perf: Simplify the SMMUv3 PMU event attributes
Date:   Mon, 8 Feb 2021 21:04:58 +0800
Message-ID: <1612789498-12957-1-git-send-email-liuqi115@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For each PMU event, there is a SMMU_EVENT_ATTR(xx, XX) and
&smmu_event_attr_xx.attr.attr. Let's redefine the SMMU_EVENT_ATTR
to simplify the smmu_pmu_events.

Signed-off-by: Qi Liu <liuqi115@huawei.com>
---
 drivers/perf/arm_smmuv3_pmu.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index 8ff7a67..4c8cb1b 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -509,27 +509,21 @@ static ssize_t smmu_pmu_event_show(struct device *dev,
 	return sprintf(page, "event=0x%02llx\n", pmu_attr->id);
 }

-#define SMMU_EVENT_ATTR(name, config) \
-	PMU_EVENT_ATTR(name, smmu_event_attr_##name, \
-		       config, smmu_pmu_event_show)
-SMMU_EVENT_ATTR(cycles, 0);
-SMMU_EVENT_ATTR(transaction, 1);
-SMMU_EVENT_ATTR(tlb_miss, 2);
-SMMU_EVENT_ATTR(config_cache_miss, 3);
-SMMU_EVENT_ATTR(trans_table_walk_access, 4);
-SMMU_EVENT_ATTR(config_struct_access, 5);
-SMMU_EVENT_ATTR(pcie_ats_trans_rq, 6);
-SMMU_EVENT_ATTR(pcie_ats_trans_passed, 7);
+#define SMMU_EVENT_ATTR(name, config)					\
+	(&((struct perf_pmu_events_attr) {				\
+		.attr = __ATTR(name, 0444, smmu_pmu_event_show, NULL),	\
+		.id = config,						\
+	}).attr.attr)

 static struct attribute *smmu_pmu_events[] = {
-	&smmu_event_attr_cycles.attr.attr,
-	&smmu_event_attr_transaction.attr.attr,
-	&smmu_event_attr_tlb_miss.attr.attr,
-	&smmu_event_attr_config_cache_miss.attr.attr,
-	&smmu_event_attr_trans_table_walk_access.attr.attr,
-	&smmu_event_attr_config_struct_access.attr.attr,
-	&smmu_event_attr_pcie_ats_trans_rq.attr.attr,
-	&smmu_event_attr_pcie_ats_trans_passed.attr.attr,
+	SMMU_EVENT_ATTR(cycles, 0),
+	SMMU_EVENT_ATTR(transaction, 1),
+	SMMU_EVENT_ATTR(tlb_miss, 2),
+	SMMU_EVENT_ATTR(config_cache_miss, 3),
+	SMMU_EVENT_ATTR(trans_table_walk_access, 4),
+	SMMU_EVENT_ATTR(config_struct_access, 5),
+	SMMU_EVENT_ATTR(pcie_ats_trans_rq, 6),
+	SMMU_EVENT_ATTR(pcie_ats_trans_passed, 7),
 	NULL
 };

--
2.8.1

