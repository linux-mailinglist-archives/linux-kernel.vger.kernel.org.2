Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6EA39ED1F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 05:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhFHDgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 23:36:18 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3099 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbhFHDgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 23:36:12 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FzbMD2kvhzWtTQ;
        Tue,  8 Jun 2021 11:29:28 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 11:33:42 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema757-chm.china.huawei.com (10.1.198.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 8 Jun 2021 11:33:41 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Khuong Dinh <khuong@os.amperecomputing.com>,
        "Will Deacon" <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v3 6/9] drivers/perf: Simplify EVENT ATTR macro in xgene_pmu.c
Date:   Tue, 8 Jun 2021 11:33:18 +0800
Message-ID: <1623123201-45634-7-git-send-email-liuqi115@huawei.com>
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

Use common macro PMU_EVENT_ATTR_ID to simplify XGENE_PMU_EVENT_ATTR.

Cc: Khuong Dinh <khuong@os.amperecomputing.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Qi Liu <liuqi115@huawei.com>
---
 drivers/perf/xgene_pmu.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index ffe3bde..9b47bcd 100644
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -278,17 +278,14 @@ static const struct attribute_group mc_pmu_v3_format_attr_group = {
 static ssize_t xgene_pmu_event_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
-	struct dev_ext_attribute *eattr;
+	struct perf_pmu_events_attr *pmu_attr =
+		container_of(attr, struct perf_pmu_events_attr, attr);
 
-	eattr = container_of(attr, struct dev_ext_attribute, attr);
-	return sysfs_emit(buf, "config=0x%lx\n", (unsigned long) eattr->var);
+	return sysfs_emit(buf, "config=0x%llx\n", pmu_attr->id);
 }
 
 #define XGENE_PMU_EVENT_ATTR(_name, _config)		\
-	(&((struct dev_ext_attribute[]) {		\
-		{ .attr = __ATTR(_name, S_IRUGO, xgene_pmu_event_show, NULL), \
-		  .var = (void *) _config, }		\
-	 })[0].attr.attr)
+	PMU_EVENT_ATTR_ID(_name, xgene_pmu_event_show, _config)
 
 static struct attribute *l3c_pmu_events_attrs[] = {
 	XGENE_PMU_EVENT_ATTR(cycle-count,			0x00),
-- 
2.7.4

