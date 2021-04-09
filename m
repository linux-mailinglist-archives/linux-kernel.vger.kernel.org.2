Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3529D35912C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 03:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbhDIBMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 21:12:37 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16848 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbhDIBMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 21:12:34 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FGg6729DRz9xZl;
        Fri,  9 Apr 2021 09:10:07 +0800 (CST)
Received: from localhost.localdomain (10.175.102.38) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Fri, 9 Apr 2021 09:12:09 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     <weiyongjun1@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC:     <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] coresight: trbe: Fix return value check in arm_trbe_register_coresight_cpu()
Date:   Fri, 9 Apr 2021 01:22:13 +0000
Message-ID: <20210409012213.3664473-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.102.38]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of error, the function devm_kasprintf() returns NULL
pointer not ERR_PTR(). The IS_ERR() test in the return value
check should be replaced with NULL test.

Fixes: 3fbf7f011f24 ("coresight: sink: Add TRBE driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 5ce239875c98..176868496879 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -871,7 +871,7 @@ static void arm_trbe_register_coresight_cpu(struct trbe_drvdata *drvdata, int cp
 
 	dev = &cpudata->drvdata->pdev->dev;
 	desc.name = devm_kasprintf(dev, GFP_KERNEL, "trbe%d", cpu);
-	if (IS_ERR(desc.name))
+	if (!desc.name)
 		goto cpu_clear;
 
 	desc.type = CORESIGHT_DEV_TYPE_SINK;

