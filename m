Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABEB238733D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 09:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240598AbhERHZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 03:25:31 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2965 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240132AbhERHZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 03:25:14 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FknVD6FmhzCtlk;
        Tue, 18 May 2021 15:21:08 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 15:23:54 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema757-chm.china.huawei.com (10.1.198.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 18 May 2021 15:23:54 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <john.garry@huawei.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangshaokun@hisilicon.com>
Subject: [PATCH 5/9] drivers/perf: Remove redundant macro and functions in qcom_l3_pmu.c
Date:   Tue, 18 May 2021 15:23:44 +0800
Message-ID: <1621322628-9945-6-git-send-email-liuqi115@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621322628-9945-1-git-send-email-liuqi115@huawei.com>
References: <1621322628-9945-1-git-send-email-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema757-chm.china.huawei.com (10.1.198.199)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove L3CACHE_EVENT_ATTR and l3cache_pmu_event_show(), as there is
a general function for this.

Signed-off-by: Qi Liu <liuqi115@huawei.com>
---
 drivers/perf/qcom_l3_pmu.c | 30 +++++++-----------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

diff --git a/drivers/perf/qcom_l3_pmu.c b/drivers/perf/qcom_l3_pmu.c
index bba0780..a163c9a 100644
--- a/drivers/perf/qcom_l3_pmu.c
+++ b/drivers/perf/qcom_l3_pmu.c
@@ -636,30 +636,14 @@ static const struct attribute_group qcom_l3_cache_pmu_format_group = {
 };
 
 /* events */
-
-static ssize_t l3cache_pmu_event_show(struct device *dev,
-				     struct device_attribute *attr, char *page)
-{
-	struct perf_pmu_events_attr *pmu_attr;
-
-	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
-	return sysfs_emit(page, "event=0x%02llx\n", pmu_attr->id);
-}
-
-#define L3CACHE_EVENT_ATTR(_name, _id)					     \
-	(&((struct perf_pmu_events_attr[]) {				     \
-		{ .attr = __ATTR(_name, 0444, l3cache_pmu_event_show, NULL), \
-		  .id = _id, }						     \
-	})[0].attr.attr)
-
 static struct attribute *qcom_l3_cache_pmu_events[] = {
-	L3CACHE_EVENT_ATTR(cycles, L3_EVENT_CYCLES),
-	L3CACHE_EVENT_ATTR(read-hit, L3_EVENT_READ_HIT),
-	L3CACHE_EVENT_ATTR(read-miss, L3_EVENT_READ_MISS),
-	L3CACHE_EVENT_ATTR(read-hit-d-side, L3_EVENT_READ_HIT_D),
-	L3CACHE_EVENT_ATTR(read-miss-d-side, L3_EVENT_READ_MISS_D),
-	L3CACHE_EVENT_ATTR(write-hit, L3_EVENT_WRITE_HIT),
-	L3CACHE_EVENT_ATTR(write-miss, L3_EVENT_WRITE_MISS),
+	PMU_EVENT_ATTR_ID(cycles, L3_EVENT_CYCLES),
+	PMU_EVENT_ATTR_ID(read-hit, L3_EVENT_READ_HIT),
+	PMU_EVENT_ATTR_ID(read-miss, L3_EVENT_READ_MISS),
+	PMU_EVENT_ATTR_ID(read-hit-d-side, L3_EVENT_READ_HIT_D),
+	PMU_EVENT_ATTR_ID(read-miss-d-side, L3_EVENT_READ_MISS_D),
+	PMU_EVENT_ATTR_ID(write-hit, L3_EVENT_WRITE_HIT),
+	PMU_EVENT_ATTR_ID(write-miss, L3_EVENT_WRITE_MISS),
 	NULL
 };
 
-- 
2.7.4

