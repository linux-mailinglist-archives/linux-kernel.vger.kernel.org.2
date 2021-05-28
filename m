Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBFD8393B34
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 03:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbhE1Bvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 21:51:47 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2506 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235596AbhE1Bvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 21:51:40 -0400
Received: from dggeml755-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FrncW3L4NzYqbF;
        Fri, 28 May 2021 09:47:23 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggeml755-chm.china.huawei.com (10.1.199.136) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 28 May 2021 09:50:03 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 28
 May 2021 09:50:02 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <khuong@os.amperecomputing.com>, <will@kernel.org>,
        <mark.rutland@arm.com>, <msalter@redhat.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] perf: xgene_pmu: use DEVICE_ATTR_RO macro
Date:   Fri, 28 May 2021 09:49:40 +0800
Message-ID: <20210528014940.4184-1-yuehaibing@huawei.com>
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

Use DEVICE_ATTR_RO() helper instead of plain DEVICE_ATTR(),
which makes the code a bit shorter and easier to read.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/perf/xgene_pmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index ffe3bdeec845..62d942534a6b 100644
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -604,15 +604,15 @@ static const struct attribute_group mc_pmu_v3_events_attr_group = {
 /*
  * sysfs cpumask attributes
  */
-static ssize_t xgene_pmu_cpumask_show(struct device *dev,
-				      struct device_attribute *attr, char *buf)
+static ssize_t cpumask_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
 {
 	struct xgene_pmu_dev *pmu_dev = to_pmu_dev(dev_get_drvdata(dev));
 
 	return cpumap_print_to_pagebuf(true, buf, &pmu_dev->parent->cpu);
 }
 
-static DEVICE_ATTR(cpumask, S_IRUGO, xgene_pmu_cpumask_show, NULL);
+static DEVICE_ATTR_RO(cpumask);
 
 static struct attribute *xgene_pmu_cpumask_attrs[] = {
 	&dev_attr_cpumask.attr,
-- 
2.17.1

