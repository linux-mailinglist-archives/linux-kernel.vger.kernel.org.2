Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 500023973A3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 14:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbhFAMze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 08:55:34 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2931 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbhFAMzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 08:55:32 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FvX8D17R9z67R7;
        Tue,  1 Jun 2021 20:50:52 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 20:53:49 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 1 Jun 2021
 20:53:48 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
CC:     <miquel.raynal@bootlin.com>, <daniel@zonque.org>
Subject: [PATCH -next] mtd: rawnand: marvell: add missing clk_disable_unprepare() on error in marvell_nfc_resume()
Date:   Tue, 1 Jun 2021 20:58:14 +0800
Message-ID: <20210601125814.3260364-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clk_disable_unprepare() on error path in marvell_nfc_resume().

Fixes: bd9c3f9b3c00 ("mtd: rawnand: marvell: add suspend and resume hooks")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/mtd/nand/raw/marvell_nand.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index 79da6b02e209..f83525a1ab0e 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -3030,8 +3030,10 @@ static int __maybe_unused marvell_nfc_resume(struct device *dev)
 		return ret;
 
 	ret = clk_prepare_enable(nfc->reg_clk);
-	if (ret < 0)
+	if (ret < 0) {
+		clk_disable_unprepare(nfc->core_clk);
 		return ret;
+	}
 
 	/*
 	 * Reset nfc->selected_chip so the next command will cause the timing
-- 
2.25.1

