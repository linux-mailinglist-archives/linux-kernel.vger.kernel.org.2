Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A248388B30
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 11:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347167AbhESJx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 05:53:56 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4532 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346724AbhESJxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 05:53:37 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FlSkz0vCLzsRZP;
        Wed, 19 May 2021 17:49:31 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 17:52:14 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema757-chm.china.huawei.com (10.1.198.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 19 May 2021 17:52:13 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 3/9] drivers/perf: Remove redundant macro and functions in SMMU PMU driver
Date:   Wed, 19 May 2021 17:51:53 +0800
Message-ID: <1621417919-6632-4-git-send-email-liuqi115@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621417919-6632-1-git-send-email-liuqi115@huawei.com>
References: <1621417919-6632-1-git-send-email-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema757-chm.china.huawei.com (10.1.198.199)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove SMMU_EVENT_ATTR and smmu_event_sysfs_show(), as there is
a general function for this.

Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Qi Liu <liuqi115@huawei.com>
---
 drivers/perf/arm_smmuv3_pmu.c | 33 ++++++++-------------------------
 1 file changed, 8 insertions(+), 25 deletions(-)

diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index ff6fab4..9d745a1 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -498,32 +498,15 @@ static const struct attribute_group smmu_pmu_cpumask_group = {
 };
 
 /* Events */
-
-static ssize_t smmu_pmu_event_show(struct device *dev,
-				   struct device_attribute *attr, char *page)
-{
-	struct perf_pmu_events_attr *pmu_attr;
-
-	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
-
-	return sysfs_emit(page, "event=0x%02llx\n", pmu_attr->id);
-}
-
-#define SMMU_EVENT_ATTR(name, config)					\
-	(&((struct perf_pmu_events_attr) {				\
-		.attr = __ATTR(name, 0444, smmu_pmu_event_show, NULL),	\
-		.id = config,						\
-	}).attr.attr)
-
 static struct attribute *smmu_pmu_events[] = {
-	SMMU_EVENT_ATTR(cycles, 0),
-	SMMU_EVENT_ATTR(transaction, 1),
-	SMMU_EVENT_ATTR(tlb_miss, 2),
-	SMMU_EVENT_ATTR(config_cache_miss, 3),
-	SMMU_EVENT_ATTR(trans_table_walk_access, 4),
-	SMMU_EVENT_ATTR(config_struct_access, 5),
-	SMMU_EVENT_ATTR(pcie_ats_trans_rq, 6),
-	SMMU_EVENT_ATTR(pcie_ats_trans_passed, 7),
+	PMU_EVENT_ATTR_ID(cycles, 0),
+	PMU_EVENT_ATTR_ID(transaction, 1),
+	PMU_EVENT_ATTR_ID(tlb_miss, 2),
+	PMU_EVENT_ATTR_ID(config_cache_miss, 3),
+	PMU_EVENT_ATTR_ID(trans_table_walk_access, 4),
+	PMU_EVENT_ATTR_ID(config_struct_access, 5),
+	PMU_EVENT_ATTR_ID(pcie_ats_trans_rq, 6),
+	PMU_EVENT_ATTR_ID(pcie_ats_trans_passed, 7),
 	NULL
 };
 
-- 
2.7.4

