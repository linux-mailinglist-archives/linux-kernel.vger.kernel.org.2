Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 729DB3EA3DD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 13:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237001AbhHLLik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 07:38:40 -0400
Received: from mail.ispras.ru ([83.149.199.84]:59262 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231467AbhHLLii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 07:38:38 -0400
Received: from hellwig.intra.ispras.ru (unknown [10.10.2.182])
        by mail.ispras.ru (Postfix) with ESMTPS id 1227C40A2BB0;
        Thu, 12 Aug 2021 11:38:06 +0000 (UTC)
From:   Evgeny Novikov <novikov@ispras.ru>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Evgeny Novikov <novikov@ispras.ru>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kirill Shilimanov <kirill.shilimanov@huawei.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] mtd: rawnand: mxic: Enable and prepare clocks in probe
Date:   Thu, 12 Aug 2021 14:38:00 +0300
Message-Id: <20210812113800.12466-1-novikov@ispras.ru>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that mxic_nfc_probe() missed invocation of
mxic_nfc_clk_enable(). The patch fixed that. In addition, error handling
was refined appropriately.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
Co-developed-by: Kirill Shilimanov <kirill.shilimanov@huawei.com>
Signed-off-by: Kirill Shilimanov <kirill.shilimanov@huawei.com>
---
 drivers/mtd/nand/raw/mxic_nand.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/mxic_nand.c b/drivers/mtd/nand/raw/mxic_nand.c
index da1070993994..37e75bf60ee5 100644
--- a/drivers/mtd/nand/raw/mxic_nand.c
+++ b/drivers/mtd/nand/raw/mxic_nand.c
@@ -509,9 +509,15 @@ static int mxic_nfc_probe(struct platform_device *pdev)
 	if (IS_ERR(nfc->send_dly_clk))
 		return PTR_ERR(nfc->send_dly_clk);
 
+	err = mxic_nfc_clk_enable(nfc);
+	if (err)
+		return err;
+
 	nfc->regs = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(nfc->regs))
-		return PTR_ERR(nfc->regs);
+	if (IS_ERR(nfc->regs)) {
+		err = PTR_ERR(nfc->regs);
+		goto fail;
+	}
 
 	nand_chip = &nfc->chip;
 	mtd = nand_to_mtd(nand_chip);
@@ -527,8 +533,10 @@ static int mxic_nfc_probe(struct platform_device *pdev)
 	nand_chip->controller = &nfc->controller;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
+	if (irq < 0) {
+		err = irq;
+		goto fail;
+	}
 
 	mxic_nfc_hw_init(nfc);
 
-- 
2.26.2

