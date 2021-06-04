Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C2139B6BF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 12:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhFDKKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 06:10:10 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3062 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhFDKKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 06:10:09 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FxJHq1fmJzWrPT
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 18:03:35 +0800 (CST)
Received: from dggemi758-chm.china.huawei.com (10.1.198.144) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 18:08:20 +0800
Received: from huawei.com (10.175.101.6) by dggemi758-chm.china.huawei.com
 (10.1.198.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 4 Jun
 2021 18:08:20 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>, <chenxiaosong2@huawei.com>
Subject: [PATCH -next] perf: qcom: Remove redundant dev_err call in qcom_l3_cache_pmu_probe()
Date:   Fri, 4 Jun 2021 18:14:43 +0800
Message-ID: <20210604101443.3657531-1-chenxiaosong2@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggemi758-chm.china.huawei.com (10.1.198.144)
X-CFilter-Loop: Reflected
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
---
 drivers/perf/qcom_l3_pmu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/perf/qcom_l3_pmu.c b/drivers/perf/qcom_l3_pmu.c
index 081273543c6b..c76f6f21d2a8 100644
--- a/drivers/perf/qcom_l3_pmu.c
+++ b/drivers/perf/qcom_l3_pmu.c
@@ -767,10 +767,8 @@ static int qcom_l3_cache_pmu_probe(struct platform_device *pdev)
 
 	memrc = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	l3pmu->regs = devm_ioremap_resource(&pdev->dev, memrc);
-	if (IS_ERR(l3pmu->regs)) {
-		dev_err(&pdev->dev, "Can't map PMU @%pa\n", &memrc->start);
+	if (IS_ERR(l3pmu->regs))
 		return PTR_ERR(l3pmu->regs);
-	}
 
 	qcom_l3_cache__init(l3pmu);
 
-- 
2.25.4

