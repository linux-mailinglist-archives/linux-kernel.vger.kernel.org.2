Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA4331C4BB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 02:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbhBPBAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 20:00:36 -0500
Received: from mo-csw-fb1115.securemx.jp ([210.130.202.174]:40688 "EHLO
        mo-csw-fb.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhBPBAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 20:00:35 -0500
X-Greylist: delayed 1207 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Feb 2021 20:00:33 EST
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1115) id 11G0egeW026957; Tue, 16 Feb 2021 09:40:42 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 11G0c839023879; Tue, 16 Feb 2021 09:38:08 +0900
X-Iguazu-Qid: 2wGqn5DuWvVM6sYQCW
X-Iguazu-QSIG: v=2; s=0; t=1613435888; q=2wGqn5DuWvVM6sYQCW; m=jnHDndSUrFfAQglWXjmb49JJo8sxPyZ3Gev6yI5lHw8=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
        by relay.securemx.jp (mx-mr1110) id 11G0c5PV015544;
        Tue, 16 Feb 2021 09:38:06 +0900
Received: from enc01.toshiba.co.jp ([106.186.93.100])
        by imx2.toshiba.co.jp  with ESMTP id 11G0c5oW005610;
        Tue, 16 Feb 2021 09:38:05 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 11G0c59I026414;
        Tue, 16 Feb 2021 09:38:05 +0900
From:   Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] mtd: nand: Fix BBT update issue
Date:   Tue, 16 Feb 2021 09:37:55 +0900
X-TSB-HOP: ON
Message-Id: <b04b128eaca91961597fa9586c7ccaa3934aaa03.1612501067.git.ytc-mb-yfuruyama7@kioxia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1613435875-6846-1-git-send-email-ytc-mb-yfuruyama7@kioxia.com>
References: <1613435875-6846-1-git-send-email-ytc-mb-yfuruyama7@kioxia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed issue of manages BBT (Bad Block Table).
It didn't mark correctly when a specific block was bad block.

This issue occurs when the bad block mark (3-bit chunk) is 
crosses over 32 bit (e.g. Block10, Block21...) unit.

Signed-off-by: Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
---
 drivers/mtd/nand/bbt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/bbt.c b/drivers/mtd/nand/bbt.c
index 044adf913854..979c47e61381 100644
--- a/drivers/mtd/nand/bbt.c
+++ b/drivers/mtd/nand/bbt.c
@@ -112,18 +112,20 @@ int nanddev_bbt_set_block_status(struct nand_device *nand, unsigned int entry,
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
 		unsigned int rbits = bits_per_block + offs - BITS_PER_LONG;
 
 		pos[1] &= ~GENMASK(rbits - 1, 0);
-		pos[1] |= val >> rbits;
+		pos[1] |= (val >> (BITS_PER_LONG - offs));
 	}
 
 	return 0;
-- 
2.25.1
