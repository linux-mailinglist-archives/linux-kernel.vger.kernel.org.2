Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C556388B2B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 11:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346903AbhESJxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 05:53:40 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:3039 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346633AbhESJxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 05:53:36 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FlSlV42g5zmXMm;
        Wed, 19 May 2021 17:49:58 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 17:52:14 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema757-chm.china.huawei.com (10.1.198.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 19 May 2021 17:52:14 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Andy Gross <agross@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 4/9] drivers/perf: Remove redundant macro and functions in qcom_l2_pmu.c
Date:   Wed, 19 May 2021 17:51:54 +0800
Message-ID: <1621417919-6632-5-git-send-email-liuqi115@huawei.com>
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

Remove L2CACHE_EVENT_ATTR and l2cache_pmu_event_show(), as there is
a general function for this.

Cc: Andy Gross <agross@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Qi Liu <liuqi115@huawei.com>
---
 drivers/perf/qcom_l2_pmu.c | 37 +++++++++++--------------------------
 1 file changed, 11 insertions(+), 26 deletions(-)

diff --git a/drivers/perf/qcom_l2_pmu.c b/drivers/perf/qcom_l2_pmu.c
index fc54a80..aa3ae21 100644
--- a/drivers/perf/qcom_l2_pmu.c
+++ b/drivers/perf/qcom_l2_pmu.c
@@ -670,33 +670,18 @@ static const struct attribute_group l2_cache_pmu_format_group = {
 	.attrs = l2_cache_pmu_formats,
 };
 
-static ssize_t l2cache_pmu_event_show(struct device *dev,
-				      struct device_attribute *attr, char *page)
-{
-	struct perf_pmu_events_attr *pmu_attr;
-
-	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
-	return sysfs_emit(page, "event=0x%02llx\n", pmu_attr->id);
-}
-
-#define L2CACHE_EVENT_ATTR(_name, _id)					     \
-	(&((struct perf_pmu_events_attr[]) {				     \
-		{ .attr = __ATTR(_name, 0444, l2cache_pmu_event_show, NULL), \
-		  .id = _id, }						     \
-	})[0].attr.attr)
-
 static struct attribute *l2_cache_pmu_events[] = {
-	L2CACHE_EVENT_ATTR(cycles, L2_EVENT_CYCLES),
-	L2CACHE_EVENT_ATTR(dcache-ops, L2_EVENT_DCACHE_OPS),
-	L2CACHE_EVENT_ATTR(icache-ops, L2_EVENT_ICACHE_OPS),
-	L2CACHE_EVENT_ATTR(tlbi, L2_EVENT_TLBI),
-	L2CACHE_EVENT_ATTR(barriers, L2_EVENT_BARRIERS),
-	L2CACHE_EVENT_ATTR(total-reads, L2_EVENT_TOTAL_READS),
-	L2CACHE_EVENT_ATTR(total-writes, L2_EVENT_TOTAL_WRITES),
-	L2CACHE_EVENT_ATTR(total-requests, L2_EVENT_TOTAL_REQUESTS),
-	L2CACHE_EVENT_ATTR(ldrex, L2_EVENT_LDREX),
-	L2CACHE_EVENT_ATTR(strex, L2_EVENT_STREX),
-	L2CACHE_EVENT_ATTR(clrex, L2_EVENT_CLREX),
+	PMU_EVENT_ATTR_ID(cycles, L2_EVENT_CYCLES),
+	PMU_EVENT_ATTR_ID(dcache-ops, L2_EVENT_DCACHE_OPS),
+	PMU_EVENT_ATTR_ID(icache-ops, L2_EVENT_ICACHE_OPS),
+	PMU_EVENT_ATTR_ID(tlbi, L2_EVENT_TLBI),
+	PMU_EVENT_ATTR_ID(barriers, L2_EVENT_BARRIERS),
+	PMU_EVENT_ATTR_ID(total-reads, L2_EVENT_TOTAL_READS),
+	PMU_EVENT_ATTR_ID(total-writes, L2_EVENT_TOTAL_WRITES),
+	PMU_EVENT_ATTR_ID(total-requests, L2_EVENT_TOTAL_REQUESTS),
+	PMU_EVENT_ATTR_ID(ldrex, L2_EVENT_LDREX),
+	PMU_EVENT_ATTR_ID(strex, L2_EVENT_STREX),
+	PMU_EVENT_ATTR_ID(clrex, L2_EVENT_CLREX),
 	NULL
 };
 
-- 
2.7.4

