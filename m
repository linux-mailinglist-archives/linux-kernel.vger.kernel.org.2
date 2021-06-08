Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39DAE39ED1D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 05:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhFHDfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 23:35:44 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:4391 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbhFHDfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 23:35:38 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FzbMk1tlcz6vTs;
        Tue,  8 Jun 2021 11:29:54 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 11:33:41 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema757-chm.china.huawei.com (10.1.198.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 8 Jun 2021 11:33:41 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Shaokun Zhang <zhangshaokun@hisilicon.com>,
        "Will Deacon" <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v3 2/9] drivers/perf: hisi: Simplify EVENT ATTR macro in HiSilicon PMU driver
Date:   Tue, 8 Jun 2021 11:33:14 +0800
Message-ID: <1623123201-45634-3-git-send-email-liuqi115@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623123201-45634-1-git-send-email-liuqi115@huawei.com>
References: <1623123201-45634-1-git-send-email-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema757-chm.china.huawei.com (10.1.198.199)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use common macro PMU_EVENT_ATTR_ID to simplify HISI_PMU_EVENT_ATTR.

Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Qi Liu <liuqi115@huawei.com>
---
 drivers/perf/hisilicon/hisi_uncore_pmu.c | 7 +++----
 drivers/perf/hisilicon/hisi_uncore_pmu.h | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
index 13c68b5..52e3bcb 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -43,11 +43,10 @@ EXPORT_SYMBOL_GPL(hisi_format_sysfs_show);
 ssize_t hisi_event_sysfs_show(struct device *dev,
 			      struct device_attribute *attr, char *page)
 {
-	struct dev_ext_attribute *eattr;
-
-	eattr = container_of(attr, struct dev_ext_attribute, attr);
+	struct perf_pmu_events_attr *pmu_attr =
+		container_of(attr, struct perf_pmu_events_attr, attr);
 
-	return sysfs_emit(page, "config=0x%lx\n", (unsigned long)eattr->var);
+	return sysfs_emit(page, "config=0x%llx\n", pmu_attr->id);
 }
 EXPORT_SYMBOL_GPL(hisi_event_sysfs_show);
 
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.h b/drivers/perf/hisilicon/hisi_uncore_pmu.h
index ea9d89b..b2504d4 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.h
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.h
@@ -35,7 +35,7 @@
 #define HISI_PMU_FORMAT_ATTR(_name, _config)		\
 	HISI_PMU_ATTR(_name, hisi_format_sysfs_show, (void *)_config)
 #define HISI_PMU_EVENT_ATTR(_name, _config)		\
-	HISI_PMU_ATTR(_name, hisi_event_sysfs_show, (unsigned long)_config)
+	PMU_EVENT_ATTR_ID(_name, hisi_event_sysfs_show, _config)
 
 #define HISI_PMU_EVENT_ATTR_EXTRACTOR(name, config, hi, lo)        \
 	static inline u32 hisi_get_##name(struct perf_event *event)            \
-- 
2.7.4

