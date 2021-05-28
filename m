Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B30393B1E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 03:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbhE1BnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 21:43:14 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2067 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbhE1BnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 21:43:12 -0400
Received: from dggeml715-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FrnNX74sVzWnqr;
        Fri, 28 May 2021 09:37:00 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggeml715-chm.china.huawei.com (10.3.17.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 28 May 2021 09:41:36 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 28
 May 2021 09:41:36 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>,
        <julien.thierry.kdev@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] perf: arm_pmu: use DEVICE_ATTR_RO macro
Date:   Fri, 28 May 2021 09:41:30 +0800
Message-ID: <20210528014130.7708-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEVICE_ATTR_RO helper instead of plain DEVICE_ATTR,
which makes the code a bit shorter and easier to read.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/perf/arm_pmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index e57b348c1628..a64e254a731b 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -563,14 +563,14 @@ static int armpmu_filter_match(struct perf_event *event)
 	return ret;
 }
 
-static ssize_t armpmu_cpumask_show(struct device *dev,
-				   struct device_attribute *attr, char *buf)
+static ssize_t cpus_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(dev_get_drvdata(dev));
 	return cpumap_print_to_pagebuf(true, buf, &armpmu->supported_cpus);
 }
 
-static DEVICE_ATTR(cpus, S_IRUGO, armpmu_cpumask_show, NULL);
+static DEVICE_ATTR_RO(cpus);
 
 static struct attribute *armpmu_common_attrs[] = {
 	&dev_attr_cpus.attr,
-- 
2.17.1

