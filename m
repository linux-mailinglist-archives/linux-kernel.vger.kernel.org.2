Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531D9354ACF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 04:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243335AbhDFCRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 22:17:20 -0400
Received: from mo-csw-fb1115.securemx.jp ([210.130.202.174]:38840 "EHLO
        mo-csw-fb.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238828AbhDFCRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 22:17:18 -0400
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1115) id 1361lpr0002650; Tue, 6 Apr 2021 10:47:52 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 1361lUwb008479; Tue, 6 Apr 2021 10:47:30 +0900
X-Iguazu-Qid: 2wGrBJasm3hdJ6uKHL
X-Iguazu-QSIG: v=2; s=0; t=1617673650; q=2wGrBJasm3hdJ6uKHL; m=GP88N+NcFEyBcPCzzwJsFRf8/vyZgOZVf7KUXtPOf0U=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1113) id 1361lSqw038187
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 6 Apr 2021 10:47:29 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id CFF6B1000AC;
        Tue,  6 Apr 2021 10:47:28 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 1361lS6q013306;
        Tue, 6 Apr 2021 10:47:28 +0900
From:   Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] Fix the issue for clearing status process
Date:   Tue,  6 Apr 2021 10:47:26 +0900
X-TSB-HOP: ON
Message-Id: <e52bf38913c20467e96c66ddf058129a5f063273.1616635406.git.ytc-mb-yfuruyama7@kioxia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1616635406.git.ytc-mb-yfuruyama7@kioxia.com>
References: <cover.1616635406.git.ytc-mb-yfuruyama7@kioxia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the unlikely event of bad block,
it should update its block status to BBT, 
In this case, there are 2 kind of issue for handling
a) Mark bad block status to BBT:  It was fixed by Patric's patch
b) Clear status to BBT:  I posted patch for this issue 

Patch:
Issue of handing BBT (Bad Block Table) for 
some particular blocks (Ex:10, 11)
Updating status is, first clear status, second set bad block status.
Patrick's patch is only fixed the issue for setting status process,
so this patch fix the clearing status process.

Signed-off-by: Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
---
 drivers/mtd/nand/bbt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/bbt.c b/drivers/mtd/nand/bbt.c
index 64af6898131d..0780896eaafe 100644
--- a/drivers/mtd/nand/bbt.c
+++ b/drivers/mtd/nand/bbt.c
@@ -112,11 +112,13 @@ int nanddev_bbt_set_block_status(struct nand_device *nand, unsigned int entry,
 			     ((entry * bits_per_block) / BITS_PER_LONG);
 	unsigned int offs = (entry * bits_per_block) % BITS_PER_LONG;
 	unsigned long val = status & GENMASK(bits_per_block - 1, 0);
+	unsigned long shift = ((bits_per_block + offs <= BITS_PER_LONG) ?
+					(offs + bits_per_block - 1) : (BITS_PER_LONG - 1));
 
 	if (entry >= nanddev_neraseblocks(nand))
 		return -ERANGE;
 
-	pos[0] &= ~GENMASK(offs + bits_per_block - 1, offs);
+	pos[0] &= ~GENMASK(shift, offs);
 	pos[0] |= val << offs;
 
 	if (bits_per_block + offs > BITS_PER_LONG) {
-- 
2.25.1

