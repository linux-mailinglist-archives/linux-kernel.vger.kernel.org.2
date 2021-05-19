Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E55388B2A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 11:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346850AbhESJxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 05:53:38 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4528 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346605AbhESJxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 05:53:35 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FlSkx2jYzzsRD1;
        Wed, 19 May 2021 17:49:29 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 17:52:15 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema757-chm.china.huawei.com (10.1.198.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 19 May 2021 17:52:14 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 8/9] drivers/perf: Remove redundant macro and functions in arm_dsu_pmu.c
Date:   Wed, 19 May 2021 17:51:58 +0800
Message-ID: <1621417919-6632-9-git-send-email-liuqi115@huawei.com>
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

Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Remove DSU_EVENT_ATTR and dsu_pmu_sysfs_event_show(), as there is
a general function for this.

Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Qi Liu <liuqi115@huawei.com>
---
 drivers/perf/arm_dsu_pmu.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
index 196faea..33bb97e 100644
--- a/drivers/perf/arm_dsu_pmu.c
+++ b/drivers/perf/arm_dsu_pmu.c
@@ -81,9 +81,6 @@
 		}							\
 	})[0].attr.attr)
 
-#define DSU_EVENT_ATTR(_name, _config)		\
-	DSU_EXT_ATTR(_name, dsu_pmu_sysfs_event_show, (unsigned long)_config)
-
 #define DSU_FORMAT_ATTR(_name, _config)		\
 	DSU_EXT_ATTR(_name, dsu_pmu_sysfs_format_show, (char *)_config)
 
@@ -130,15 +127,6 @@ static inline struct dsu_pmu *to_dsu_pmu(struct pmu *pmu)
 	return container_of(pmu, struct dsu_pmu, pmu);
 }
 
-static ssize_t dsu_pmu_sysfs_event_show(struct device *dev,
-					struct device_attribute *attr,
-					char *buf)
-{
-	struct dev_ext_attribute *eattr = container_of(attr,
-					struct dev_ext_attribute, attr);
-	return sysfs_emit(buf, "event=0x%lx\n", (unsigned long)eattr->var);
-}
-
 static ssize_t dsu_pmu_sysfs_format_show(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
@@ -183,14 +171,14 @@ static const struct attribute_group dsu_pmu_format_attr_group = {
 };
 
 static struct attribute *dsu_pmu_event_attrs[] = {
-	DSU_EVENT_ATTR(cycles, 0x11),
-	DSU_EVENT_ATTR(bus_access, 0x19),
-	DSU_EVENT_ATTR(memory_error, 0x1a),
-	DSU_EVENT_ATTR(bus_cycles, 0x1d),
-	DSU_EVENT_ATTR(l3d_cache_allocate, 0x29),
-	DSU_EVENT_ATTR(l3d_cache_refill, 0x2a),
-	DSU_EVENT_ATTR(l3d_cache, 0x2b),
-	DSU_EVENT_ATTR(l3d_cache_wb, 0x2c),
+	PMU_EVENT_ATTR_ID(cycles, 0x11),
+	PMU_EVENT_ATTR_ID(bus_access, 0x19),
+	PMU_EVENT_ATTR_ID(memory_error, 0x1a),
+	PMU_EVENT_ATTR_ID(bus_cycles, 0x1d),
+	PMU_EVENT_ATTR_ID(l3d_cache_allocate, 0x29),
+	PMU_EVENT_ATTR_ID(l3d_cache_refill, 0x2a),
+	PMU_EVENT_ATTR_ID(l3d_cache, 0x2b),
+	PMU_EVENT_ATTR_ID(l3d_cache_wb, 0x2c),
 	NULL,
 };
 
-- 
2.7.4

