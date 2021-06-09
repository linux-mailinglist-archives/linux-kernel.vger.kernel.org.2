Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC353A0CA2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 08:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236915AbhFIGoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 02:44:12 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8104 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236857AbhFIGoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 02:44:01 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G0HWm461szYsWX;
        Wed,  9 Jun 2021 14:39:16 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 14:42:00 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema757-chm.china.huawei.com (10.1.198.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 9 Jun 2021 14:41:59 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <will@kernel.org>
CC:     <linuxarm@huawei.com>, Frank Li <Frank.li@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 6/7] drivers/perf: Simplify EVENT ATTR macro in fsl_imx8_ddr_perf.c
Date:   Wed, 9 Jun 2021 14:41:02 +0800
Message-ID: <1623220863-58233-7-git-send-email-liuqi115@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623220863-58233-1-git-send-email-liuqi115@huawei.com>
References: <1623220863-58233-1-git-send-email-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema757-chm.china.huawei.com (10.1.198.199)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use common macro PMU_EVENT_ATTR_ID to simplify IMX8_DDR_PMU_EVENT_ATTR

Cc: Frank Li <Frank.li@nxp.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Reviewed by Frank Li <Frank .li@nxp.com>
Signed-off-by: Qi Liu <liuqi115@huawei.com>
---
 drivers/perf/fsl_imx8_ddr_perf.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
index df048fe..2a1d787 100644
--- a/drivers/perf/fsl_imx8_ddr_perf.c
+++ b/drivers/perf/fsl_imx8_ddr_perf.c
@@ -222,11 +222,8 @@ ddr_pmu_event_show(struct device *dev, struct device_attribute *attr,
 	return sysfs_emit(page, "event=0x%02llx\n", pmu_attr->id);
 }
 
-#define IMX8_DDR_PMU_EVENT_ATTR(_name, _id)				\
-	(&((struct perf_pmu_events_attr[]) {				\
-		{ .attr = __ATTR(_name, 0444, ddr_pmu_event_show, NULL),\
-		  .id = _id, }						\
-	})[0].attr.attr)
+#define IMX8_DDR_PMU_EVENT_ATTR(_name, _id)		\
+	PMU_EVENT_ATTR_ID(_name, ddr_pmu_event_show, _id)
 
 static struct attribute *ddr_perf_events_attrs[] = {
 	IMX8_DDR_PMU_EVENT_ATTR(cycles, EVENT_CYCLES_ID),
-- 
2.7.4

