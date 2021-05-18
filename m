Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C40387341
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 09:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347214AbhERHZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 03:25:43 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3008 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241161AbhERHZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 03:25:14 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FknTP6md1zQplm;
        Tue, 18 May 2021 15:20:25 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
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
Subject: [PATCH 7/9] drivers/perf: Remove redundant macro and functions in  fsl_imx8_ddr_perf.c
Date:   Tue, 18 May 2021 15:23:46 +0800
Message-ID: <1621322628-9945-8-git-send-email-liuqi115@huawei.com>
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

Remove IMX8_DDR_PMU_EVENT_ATTR and ddr_pmu_event_show(), as there is
a general function for this.

Signed-off-by: Qi Liu <liuqi115@huawei.com>
---
 drivers/perf/fsl_imx8_ddr_perf.c | 80 ++++++++++++++++------------------------
 1 file changed, 32 insertions(+), 48 deletions(-)

diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
index 2bbb931..8f2c4dd 100644
--- a/drivers/perf/fsl_imx8_ddr_perf.c
+++ b/drivers/perf/fsl_imx8_ddr_perf.c
@@ -212,55 +212,39 @@ static const struct attribute_group ddr_perf_cpumask_attr_group = {
 	.attrs = ddr_perf_cpumask_attrs,
 };
 
-static ssize_t
-ddr_pmu_event_show(struct device *dev, struct device_attribute *attr,
-		   char *page)
-{
-	struct perf_pmu_events_attr *pmu_attr;
-
-	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
-	return sysfs_emit(page, "event=0x%02llx\n", pmu_attr->id);
-}
-
-#define IMX8_DDR_PMU_EVENT_ATTR(_name, _id)				\
-	(&((struct perf_pmu_events_attr[]) {				\
-		{ .attr = __ATTR(_name, 0444, ddr_pmu_event_show, NULL),\
-		  .id = _id, }						\
-	})[0].attr.attr)
-
 static struct attribute *ddr_perf_events_attrs[] = {
-	IMX8_DDR_PMU_EVENT_ATTR(cycles, EVENT_CYCLES_ID),
-	IMX8_DDR_PMU_EVENT_ATTR(selfresh, 0x01),
-	IMX8_DDR_PMU_EVENT_ATTR(read-accesses, 0x04),
-	IMX8_DDR_PMU_EVENT_ATTR(write-accesses, 0x05),
-	IMX8_DDR_PMU_EVENT_ATTR(read-queue-depth, 0x08),
-	IMX8_DDR_PMU_EVENT_ATTR(write-queue-depth, 0x09),
-	IMX8_DDR_PMU_EVENT_ATTR(lp-read-credit-cnt, 0x10),
-	IMX8_DDR_PMU_EVENT_ATTR(hp-read-credit-cnt, 0x11),
-	IMX8_DDR_PMU_EVENT_ATTR(write-credit-cnt, 0x12),
-	IMX8_DDR_PMU_EVENT_ATTR(read-command, 0x20),
-	IMX8_DDR_PMU_EVENT_ATTR(write-command, 0x21),
-	IMX8_DDR_PMU_EVENT_ATTR(read-modify-write-command, 0x22),
-	IMX8_DDR_PMU_EVENT_ATTR(hp-read, 0x23),
-	IMX8_DDR_PMU_EVENT_ATTR(hp-req-nocredit, 0x24),
-	IMX8_DDR_PMU_EVENT_ATTR(hp-xact-credit, 0x25),
-	IMX8_DDR_PMU_EVENT_ATTR(lp-req-nocredit, 0x26),
-	IMX8_DDR_PMU_EVENT_ATTR(lp-xact-credit, 0x27),
-	IMX8_DDR_PMU_EVENT_ATTR(wr-xact-credit, 0x29),
-	IMX8_DDR_PMU_EVENT_ATTR(read-cycles, 0x2a),
-	IMX8_DDR_PMU_EVENT_ATTR(write-cycles, 0x2b),
-	IMX8_DDR_PMU_EVENT_ATTR(read-write-transition, 0x30),
-	IMX8_DDR_PMU_EVENT_ATTR(precharge, 0x31),
-	IMX8_DDR_PMU_EVENT_ATTR(activate, 0x32),
-	IMX8_DDR_PMU_EVENT_ATTR(load-mode, 0x33),
-	IMX8_DDR_PMU_EVENT_ATTR(perf-mwr, 0x34),
-	IMX8_DDR_PMU_EVENT_ATTR(read, 0x35),
-	IMX8_DDR_PMU_EVENT_ATTR(read-activate, 0x36),
-	IMX8_DDR_PMU_EVENT_ATTR(refresh, 0x37),
-	IMX8_DDR_PMU_EVENT_ATTR(write, 0x38),
-	IMX8_DDR_PMU_EVENT_ATTR(raw-hazard, 0x39),
-	IMX8_DDR_PMU_EVENT_ATTR(axid-read, 0x41),
-	IMX8_DDR_PMU_EVENT_ATTR(axid-write, 0x42),
+	PMU_EVENT_ATTR_ID(cycles, EVENT_CYCLES_ID),
+	PMU_EVENT_ATTR_ID(selfresh, 0x01),
+	PMU_EVENT_ATTR_ID(read-accesses, 0x04),
+	PMU_EVENT_ATTR_ID(write-accesses, 0x05),
+	PMU_EVENT_ATTR_ID(read-queue-depth, 0x08),
+	PMU_EVENT_ATTR_ID(write-queue-depth, 0x09),
+	PMU_EVENT_ATTR_ID(lp-read-credit-cnt, 0x10),
+	PMU_EVENT_ATTR_ID(hp-read-credit-cnt, 0x11),
+	PMU_EVENT_ATTR_ID(write-credit-cnt, 0x12),
+	PMU_EVENT_ATTR_ID(read-command, 0x20),
+	PMU_EVENT_ATTR_ID(write-command, 0x21),
+	PMU_EVENT_ATTR_ID(read-modify-write-command, 0x22),
+	PMU_EVENT_ATTR_ID(hp-read, 0x23),
+	PMU_EVENT_ATTR_ID(hp-req-nocredit, 0x24),
+	PMU_EVENT_ATTR_ID(hp-xact-credit, 0x25),
+	PMU_EVENT_ATTR_ID(lp-req-nocredit, 0x26),
+	PMU_EVENT_ATTR_ID(lp-xact-credit, 0x27),
+	PMU_EVENT_ATTR_ID(wr-xact-credit, 0x29),
+	PMU_EVENT_ATTR_ID(read-cycles, 0x2a),
+	PMU_EVENT_ATTR_ID(write-cycles, 0x2b),
+	PMU_EVENT_ATTR_ID(read-write-transition, 0x30),
+	PMU_EVENT_ATTR_ID(precharge, 0x31),
+	PMU_EVENT_ATTR_ID(activate, 0x32),
+	PMU_EVENT_ATTR_ID(load-mode, 0x33),
+	PMU_EVENT_ATTR_ID(perf-mwr, 0x34),
+	PMU_EVENT_ATTR_ID(read, 0x35),
+	PMU_EVENT_ATTR_ID(read-activate, 0x36),
+	PMU_EVENT_ATTR_ID(refresh, 0x37),
+	PMU_EVENT_ATTR_ID(write, 0x38),
+	PMU_EVENT_ATTR_ID(raw-hazard, 0x39),
+	PMU_EVENT_ATTR_ID(axid-read, 0x41),
+	PMU_EVENT_ATTR_ID(axid-write, 0x42),
 	NULL,
 };
 
-- 
2.7.4

