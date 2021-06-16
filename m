Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962AD3A8F9B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 05:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhFPDuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 23:50:22 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:7287 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhFPDuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 23:50:21 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G4WHP2vCNz1BN1k;
        Wed, 16 Jun 2021 11:43:13 +0800 (CST)
Received: from dggemi762-chm.china.huawei.com (10.1.198.148) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 11:48:14 +0800
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 dggemi762-chm.china.huawei.com (10.1.198.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 16 Jun 2021 11:48:13 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <miquel.raynal@bootlin.com>, <nagasure@xilinx.com>,
        <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] mtd: rawnand: arasan: Fix missing clk_disable_unprepare() on error in anfc_probe()
Date:   Wed, 16 Jun 2021 12:06:44 +0800
Message-ID: <1623816404-66213-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggemi762-chm.china.huawei.com (10.1.198.148)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the missing clk_disable_unprepare() before return
from anfc_probe() in the error handling case.

Fixes: 61622f6791a1 ("mtd: rawnand: arasan: Use the right DMA mask")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/mtd/nand/raw/arasan-nand-controller.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/arasan-nand-controller.c b/drivers/mtd/nand/raw/arasan-nand-controller.c
index 8317d97..9cbcc69 100644
--- a/drivers/mtd/nand/raw/arasan-nand-controller.c
+++ b/drivers/mtd/nand/raw/arasan-nand-controller.c
@@ -1452,7 +1452,7 @@ static int anfc_probe(struct platform_device *pdev)
 
 	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
 	if (ret)
-		return ret;
+		goto disable_bus_clk;
 
 	ret = anfc_parse_cs(nfc);
 	if (ret)
-- 
2.6.2

