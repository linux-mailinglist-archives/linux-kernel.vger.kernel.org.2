Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C46D3F3975
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 09:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbhHUH7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 03:59:34 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:49907 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbhHUH7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 03:59:30 -0400
Received: from pop-os.home ([90.126.253.178])
        by mwinf5d09 with ME
        id k7yn2500M3riaq2037ynGU; Sat, 21 Aug 2021 09:58:50 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 21 Aug 2021 09:58:50 +0200
X-ME-IP: 90.126.253.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        boris.brezillon@collabora.com, lee.jones@linaro.org,
        segher@kernel.crashing.org, dwmw2@infradead.org
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] mtd: rawnand: cafe: Fix a resource leak in the error handling path of 'cafe_nand_probe()'
Date:   Sat, 21 Aug 2021 09:58:45 +0200
Message-Id: <fd313d3fb787458bcc73189e349f481133a2cdc9.1629532640.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A successful 'init_rs_non_canonical()' call should be balanced by a
corresponding 'free_rs()' call in the error handling path of the probe, as
already done in the remove function.

Update the error handling path accordingly.

Fixes: 8c61b7a7f4d4 ("[MTD] [NAND] Use rslib for CAFÉ ECC")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/mtd/nand/raw/cafe_nand.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/cafe_nand.c b/drivers/mtd/nand/raw/cafe_nand.c
index d0e8ffd55c22..cba2eaddb0fc 100644
--- a/drivers/mtd/nand/raw/cafe_nand.c
+++ b/drivers/mtd/nand/raw/cafe_nand.c
@@ -751,7 +751,7 @@ static int cafe_nand_probe(struct pci_dev *pdev,
 			  "CAFE NAND", mtd);
 	if (err) {
 		dev_warn(&pdev->dev, "Could not register IRQ %d\n", pdev->irq);
-		goto out_ior;
+		goto our_free_rs;
 	}
 
 	/* Disable master reset, enable NAND clock */
@@ -795,6 +795,8 @@ static int cafe_nand_probe(struct pci_dev *pdev,
 	/* Disable NAND IRQ in global IRQ mask register */
 	cafe_writel(cafe, ~1 & cafe_readl(cafe, GLOBAL_IRQ_MASK), GLOBAL_IRQ_MASK);
 	free_irq(pdev->irq, mtd);
+ our_free_rs:
+	free_rs(cafe->rs);
  out_ior:
 	pci_iounmap(pdev, cafe->mmio);
  out_free_mtd:
-- 
2.30.2

