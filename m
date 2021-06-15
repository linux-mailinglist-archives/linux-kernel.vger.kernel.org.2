Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C963A7E63
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 14:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhFOMuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 08:50:54 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:10074 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhFOMuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 08:50:52 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G47Mz055nzZfC6;
        Tue, 15 Jun 2021 20:45:51 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 20:48:45 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 15 Jun
 2021 20:48:45 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-imx@nxp.com>
CC:     <shawnguo@kernel.org>
Subject: [PATCH -next v2 1/2] ARM: imx: add missing iounmap()
Date:   Tue, 15 Jun 2021 20:52:38 +0800
Message-ID: <20210615125239.1348845-2-yangyingliang@huawei.com>
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

Commit e76bdfd7403a ("ARM: imx: Added perf functionality to mmdc driver")
introduced imx_mmdc_remove(), the mmdc_base need be unmapped in it if
config PERF_EVENTS is enabled.

If imx_mmdc_perf_init() fails, the mmdc_base also need be unmapped.

Fixes: e76bdfd7403a ("ARM: imx: Added perf functionality to mmdc driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 arch/arm/mach-imx/mmdc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
index 0dfd0ae7a63d..8e57691aafe2 100644
--- a/arch/arm/mach-imx/mmdc.c
+++ b/arch/arm/mach-imx/mmdc.c
@@ -462,6 +462,7 @@ static int imx_mmdc_remove(struct platform_device *pdev)
 
 	cpuhp_state_remove_instance_nocalls(cpuhp_mmdc_state, &pmu_mmdc->node);
 	perf_pmu_unregister(&pmu_mmdc->pmu);
+	iounmap(pmu_mmdc->mmdc_base);
 	kfree(pmu_mmdc);
 	return 0;
 }
@@ -567,7 +568,11 @@ static int imx_mmdc_probe(struct platform_device *pdev)
 	val &= ~(1 << BP_MMDC_MAPSR_PSD);
 	writel_relaxed(val, reg);
 
-	return imx_mmdc_perf_init(pdev, mmdc_base);
+	err = imx_mmdc_perf_init(pdev, mmdc_base);
+	if (err)
+		iounmap(mmdc_base);
+
+	return err;
 }
 
 int imx_mmdc_get_ddr_type(void)
-- 
2.25.1

