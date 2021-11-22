Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD768458F4D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 14:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239309AbhKVNYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 08:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239195AbhKVNYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 08:24:50 -0500
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF59C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 05:21:43 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:e4da:38c:79e9:48bf])
        by laurent.telenet-ops.be with bizsmtp
        id MRMg2600V4yPVd601RMgip; Mon, 22 Nov 2021 14:21:41 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mp9GO-00EJ8H-B7; Mon, 22 Nov 2021 14:21:40 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mp9GN-00GMM7-Tu; Mon, 22 Nov 2021 14:21:39 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] mtd: rawnand: mpc5121: Remove unused variable in ads5121_select_chip()
Date:   Mon, 22 Nov 2021 14:21:38 +0100
Message-Id: <20211122132138.3899138-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/mtd/nand/raw/mpc5121_nfc.c: In function ‘ads5121_select_chip’:
drivers/mtd/nand/raw/mpc5121_nfc.c:294:19: warning: unused variable ‘mtd’ [-Wunused-variable]
  294 |  struct mtd_info *mtd = nand_to_mtd(nand);
      |                   ^~~

Fixes: 758b56f58b66bebc ("mtd: rawnand: Pass a nand_chip object to chip->select_chip()")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/mtd/nand/raw/mpc5121_nfc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/mpc5121_nfc.c b/drivers/mtd/nand/raw/mpc5121_nfc.c
index cb293c50acb876fe..5b9271b9c32655b4 100644
--- a/drivers/mtd/nand/raw/mpc5121_nfc.c
+++ b/drivers/mtd/nand/raw/mpc5121_nfc.c
@@ -291,7 +291,6 @@ static int ads5121_chipselect_init(struct mtd_info *mtd)
 /* Control chips select signal on ADS5121 board */
 static void ads5121_select_chip(struct nand_chip *nand, int chip)
 {
-	struct mtd_info *mtd = nand_to_mtd(nand);
 	struct mpc5121_nfc_prv *prv = nand_get_controller_data(nand);
 	u8 v;
 
-- 
2.25.1

