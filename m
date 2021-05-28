Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B3B393D0A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 08:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhE1GTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 02:19:23 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:2330 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhE1GTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 02:19:21 -0400
Received: from dggeml714-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4FrvW92NnNz1BFv5;
        Fri, 28 May 2021 14:13:09 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggeml714-chm.china.huawei.com (10.3.17.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 28 May 2021 14:17:45 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 28
 May 2021 14:17:44 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 -next] perf: arm_spe: use DEVICE_ATTR_RO macro
Date:   Fri, 28 May 2021 14:17:38 +0800
Message-ID: <20210528061738.23392-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEVICE_ATTR_RO() helper instead of plain DEVICE_ATTR(),
which makes the code a bit shorter and easier to read.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: Fix build error

 drivers/perf/arm_spe_pmu.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index e3711cb4c1b5..773285dd539f 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -231,15 +231,14 @@ static const struct attribute_group arm_spe_pmu_format_group = {
 	.attrs	= arm_spe_pmu_formats_attr,
 };
 
-static ssize_t arm_spe_pmu_get_attr_cpumask(struct device *dev,
-					    struct device_attribute *attr,
-					    char *buf)
+static ssize_t cpumask_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
 {
 	struct arm_spe_pmu *spe_pmu = dev_get_drvdata(dev);
 
 	return cpumap_print_to_pagebuf(true, buf, &spe_pmu->supported_cpus);
 }
-static DEVICE_ATTR(cpumask, S_IRUGO, arm_spe_pmu_get_attr_cpumask, NULL);
+static DEVICE_ATTR_RO(cpumask);
 
 static struct attribute *arm_spe_pmu_attrs[] = {
 	&dev_attr_cpumask.attr,
-- 
2.17.1

