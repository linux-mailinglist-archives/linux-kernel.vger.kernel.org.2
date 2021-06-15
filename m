Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3273A7E62
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 14:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhFOMux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 08:50:53 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:4787 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbhFOMuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 08:50:52 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G47KY6PWYzXg87;
        Tue, 15 Jun 2021 20:43:45 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 20:48:46 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 15 Jun
 2021 20:48:45 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-imx@nxp.com>
CC:     <shawnguo@kernel.org>
Subject: [PATCH -next v2 2/2] ARM: imx: add missing clk_disable_unprepare()
Date:   Tue, 15 Jun 2021 20:52:39 +0800
Message-ID: <20210615125239.1348845-3-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210615125239.1348845-1-yangyingliang@huawei.com>
References: <20210615125239.1348845-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clock source is prepared and enabled by clk_prepare_enable()
in probe function, but no disable or unprepare in remove and
error path.

Fixes: 9454a0caff6a ("ARM: imx: add mmdc ipg clock operation for mmdc")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 arch/arm/mach-imx/mmdc.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
index 8e57691aafe2..4a6f1359e1e9 100644
--- a/arch/arm/mach-imx/mmdc.c
+++ b/arch/arm/mach-imx/mmdc.c
@@ -103,6 +103,7 @@ struct mmdc_pmu {
 	struct perf_event *mmdc_events[MMDC_NUM_COUNTERS];
 	struct hlist_node node;
 	struct fsl_mmdc_devtype_data *devtype_data;
+	struct clk *mmdc_ipg_clk;
 };
 
 /*
@@ -463,11 +464,13 @@ static int imx_mmdc_remove(struct platform_device *pdev)
 	cpuhp_state_remove_instance_nocalls(cpuhp_mmdc_state, &pmu_mmdc->node);
 	perf_pmu_unregister(&pmu_mmdc->pmu);
 	iounmap(pmu_mmdc->mmdc_base);
+	clk_disable_unprepare(pmu_mmdc->mmdc_ipg_clk);
 	kfree(pmu_mmdc);
 	return 0;
 }
 
-static int imx_mmdc_perf_init(struct platform_device *pdev, void __iomem *mmdc_base)
+static int imx_mmdc_perf_init(struct platform_device *pdev, void __iomem *mmdc_base,
+			      struct clk *mmdc_ipg_clk)
 {
 	struct mmdc_pmu *pmu_mmdc;
 	char *name;
@@ -495,6 +498,7 @@ static int imx_mmdc_perf_init(struct platform_device *pdev, void __iomem *mmdc_b
 	}
 
 	mmdc_num = mmdc_pmu_init(pmu_mmdc, mmdc_base, &pdev->dev);
+	pmu_mmdc->mmdc_ipg_clk = mmdc_ipg_clk;
 	if (mmdc_num == 0)
 		name = "mmdc";
 	else
@@ -568,9 +572,11 @@ static int imx_mmdc_probe(struct platform_device *pdev)
 	val &= ~(1 << BP_MMDC_MAPSR_PSD);
 	writel_relaxed(val, reg);
 
-	err = imx_mmdc_perf_init(pdev, mmdc_base);
-	if (err)
+	err = imx_mmdc_perf_init(pdev, mmdc_base, mmdc_ipg_clk);
+	if (err) {
 		iounmap(mmdc_base);
+		clk_disable_unprepare(mmdc_ipg_clk);
+	}
 
 	return err;
 }
-- 
2.25.1

