Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9559E382AAC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 13:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236675AbhEQLO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 07:14:27 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2953 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236679AbhEQLOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 07:14:24 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FkGd83pSrzCsgp;
        Mon, 17 May 2021 19:10:20 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 17 May 2021 19:13:05 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 17 May
 2021 19:13:04 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-imx@nxp.com>, <shawnguo@kernel.org>
Subject: [PATCH -next] ARM: imx: add missing clk_disable_unprepare() in imx_mmdc_remove()
Date:   Mon, 17 May 2021 19:15:23 +0800
Message-ID: <20210517111523.477889-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clock source is prepared and enabled by clk_prepare_enable()
in probe function, but no disable or unprepare in remove.

Fixes: 9454a0caff6a ("ARM: imx: add mmdc ipg clock operation for mmdc")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 arch/arm/mach-imx/mmdc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
index 0dfd0ae7a63d..7d87fa8c70a9 100644
--- a/arch/arm/mach-imx/mmdc.c
+++ b/arch/arm/mach-imx/mmdc.c
@@ -77,6 +77,7 @@ static const struct of_device_id imx_mmdc_dt_ids[] = {
 	{ /* sentinel */ }
 };
 
+struct clk *mmdc_ipg_clk;
 #ifdef CONFIG_PERF_EVENTS
 
 static enum cpuhp_state cpuhp_mmdc_state;
@@ -463,6 +464,7 @@ static int imx_mmdc_remove(struct platform_device *pdev)
 	cpuhp_state_remove_instance_nocalls(cpuhp_mmdc_state, &pmu_mmdc->node);
 	perf_pmu_unregister(&pmu_mmdc->pmu);
 	kfree(pmu_mmdc);
+	clk_disable_unprepare(mmdc_ipg_clk);
 	return 0;
 }
 
@@ -536,7 +538,6 @@ static int imx_mmdc_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	void __iomem *mmdc_base, *reg;
-	struct clk *mmdc_ipg_clk;
 	u32 val;
 	int err;
 
-- 
2.25.1

