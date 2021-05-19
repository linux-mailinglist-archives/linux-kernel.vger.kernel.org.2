Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E85388B2C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 11:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346344AbhESJxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 05:53:43 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4529 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346596AbhESJxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 05:53:36 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FlSkw1ntTzsRCG;
        Wed, 19 May 2021 17:49:28 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 17:52:14 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema757-chm.china.huawei.com (10.1.198.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 19 May 2021 17:52:13 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v2 1/9] perf: Add EVENT_ATTR_ID to simplify event attributes
Date:   Wed, 19 May 2021 17:51:51 +0800
Message-ID: <1621417919-6632-2-git-send-email-liuqi115@huawei.com>
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

Similar EVENT_ATTR macros are defined in many PMU drivers,
like HiSilicon PMU driver, Arm PMU driver, Arm SMMU PMU
driver. So Add a generic macro to simplify code.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Qi Liu <liuqi115@huawei.com>
---
 include/linux/perf_event.h | 6 ++++++
 kernel/events/core.c       | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index f5a6a2f..d0aa74e 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1576,6 +1576,12 @@ static struct perf_pmu_events_attr _var = {				    \
 	.event_str	= _str,						    \
 };
 
+#define PMU_EVENT_ATTR_ID(_name, _id)					     \
+	(&((struct perf_pmu_events_attr[]) {				     \
+		{ .attr = __ATTR(_name, 0444, perf_event_sysfs_show, NULL),  \
+		  .id = _id, }						     \
+	})[0].attr.attr)
+
 #define PMU_FORMAT_ATTR(_name, _format)					\
 static ssize_t								\
 _name##_show(struct device *dev,					\
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0ac818b..330d9cc 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13295,6 +13295,8 @@ ssize_t perf_event_sysfs_show(struct device *dev, struct device_attribute *attr,
 
 	if (pmu_attr->event_str)
 		return sprintf(page, "%s\n", pmu_attr->event_str);
+	else
+		return sprintf(page, "config=%#llx\n", pmu_attr->id);
 
 	return 0;
 }
-- 
2.7.4

