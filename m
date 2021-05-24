Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4A038E150
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 09:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbhEXHEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 03:04:05 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5672 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbhEXHDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 03:03:51 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FpSkW3B4Bz1BPSm;
        Mon, 24 May 2021 14:59:31 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 15:02:21 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 24 May
 2021 15:02:21 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-imx@nxp.com>
CC:     <shawnguo@kernel.org>
Subject: [PATCH -next 2/2] ARM: imx: add missing clk_disable_unprepare() in imx_mmdc_remove()
Date:   Mon, 24 May 2021 15:07:00 +0800
Message-ID: <20210524070700.3032039-3-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210524070700.3032039-1-yangyingliang@huawei.com>
References: <20210524070700.3032039-1-yangyingliang@huawei.com>
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
index c313eb1f614c..9de929f8cf6c 100644
--- a/arch/arm/mach-imx/mmdc.c
+++ b/arch/arm/mach-imx/mmdc.c
@@ -78,6 +78,7 @@ static const struct of_device_id imx_mmdc_dt_ids[] = {
 };
 
 static void __iomem *mmdc_base;
+static struct clk *mmdc_ipg_clk;
 
 #ifdef CONFIG_PERF_EVENTS
 
@@ -533,6 +534,7 @@ static int imx_mmdc_remove(struct platform_device *pdev)
 	kfree(pmu_mmdc);
 #endif
 	iounmap(mmdc_base);
+	clk_disable_unprepare(mmdc_ipg_clk);
 	return 0;
 }
 
@@ -540,7 +542,6 @@ static int imx_mmdc_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	void *reg;
-	struct clk *mmdc_ipg_clk;
 	u32 val;
 	int err;
 
-- 
2.25.1

