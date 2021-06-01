Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01B1396D74
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 08:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbhFAGii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 02:38:38 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2922 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbhFAGih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 02:38:37 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FvMnL31lbz68Tw;
        Tue,  1 Jun 2021 14:33:58 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 14:36:55 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 14:36:54 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Lee Jones <lee.jones@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] mfd: asic3: Use DEFINE_RES_MEM() and DEFINE_RES_IRQ() to simplify code
Date:   Tue, 1 Jun 2021 14:36:48 +0800
Message-ID: <20210601063648.9883-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/mfd/asic3.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/asic3.c b/drivers/mfd/asic3.c
index a6bd2134cea2ae8..8d58c8df46cfb83 100644
--- a/drivers/mfd/asic3.c
+++ b/drivers/mfd/asic3.c
@@ -723,16 +723,8 @@ static struct tmio_mmc_data asic3_mmc_data = {
 };
 
 static struct resource asic3_mmc_resources[] = {
-	{
-		.start = ASIC3_SD_CTRL_BASE,
-		.end   = ASIC3_SD_CTRL_BASE + 0x3ff,
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.start = 0,
-		.end   = 0,
-		.flags = IORESOURCE_IRQ,
-	},
+	DEFINE_RES_MEM(ASIC3_SD_CTRL_BASE, 0x400),
+	DEFINE_RES_IRQ(0)
 };
 
 static int asic3_mmc_enable(struct platform_device *pdev)
-- 
2.26.0.106.g9fadedd


