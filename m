Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019853AB365
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 14:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbhFQMUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 08:20:17 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7471 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhFQMUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 08:20:16 -0400
Received: from dggeme764-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G5Lbc5lmHzZj8g;
        Thu, 17 Jun 2021 20:15:08 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggeme764-chm.china.huawei.com (10.3.19.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 17 Jun 2021 20:18:04 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <Frank.li@nxp.com>, <will@kernel.org>, <mark.rutland@arm.com>,
        <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <kernel@pengutronix.de>, <festevam@gmail.com>, <linux-imx@nxp.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <jingxiangfeng@huawei.com>
Subject: [PATCH] drivers/perf: fix the missed ida_simple_remove() in ddr_perf_probe()
Date:   Thu, 17 Jun 2021 20:26:14 +0800
Message-ID: <20210617122614.166823-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme764-chm.china.huawei.com (10.3.19.110)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ddr_perf_probe() misses to call ida_simple_remove() in an error path.
Jump to cpuhp_state_err to fix it.

Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/perf/fsl_imx8_ddr_perf.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
index 2bbb93188064..7b87aaf267d5 100644
--- a/drivers/perf/fsl_imx8_ddr_perf.c
+++ b/drivers/perf/fsl_imx8_ddr_perf.c
@@ -705,8 +705,10 @@ static int ddr_perf_probe(struct platform_device *pdev)
 
 	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, DDR_PERF_DEV_NAME "%d",
 			      num);
-	if (!name)
-		return -ENOMEM;
+	if (!name) {
+		ret = -ENOMEM;
+		goto cpuhp_state_err;
+	}
 
 	pmu->devtype_data = of_device_get_match_data(&pdev->dev);
 
-- 
2.26.0.106.g9fadedd

