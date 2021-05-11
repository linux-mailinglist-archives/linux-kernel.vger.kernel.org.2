Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5681379CD3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 04:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhEKCSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 22:18:44 -0400
Received: from twhmllg3.macronix.com ([211.75.127.131]:47984 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbhEKCSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 22:18:36 -0400
Received: from TWHMLLG3.macronix.com (localhost [127.0.0.2] (may be forged))
        by TWHMLLG3.macronix.com with ESMTP id 14B1fatk037045
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 09:41:36 +0800 (GMT-8)
        (envelope-from ycllin@mxic.com.tw)
Received: from localhost.localdomain ([172.17.195.95])
        by TWHMLLG3.macronix.com with ESMTP id 14B1esOa036551;
        Tue, 11 May 2021 09:40:54 +0800 (GMT-8)
        (envelope-from ycllin@mxic.com.tw)
From:   YouChing Lin <ycllin@mxic.com.tw>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        juliensu@mxic.com.tw, YouChing Lin <ycllin@mxic.com.tw>
Subject: [PATCH 2/2] mtd: nand: ecc-hamming: Fix the double counting of ECC stat
Date:   Tue, 11 May 2021 09:40:35 +0800
Message-Id: <1620697235-7829-3-git-send-email-ycllin@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1620697235-7829-1-git-send-email-ycllin@mxic.com.tw>
References: <1620697235-7829-1-git-send-email-ycllin@mxic.com.tw>
X-MAIL: TWHMLLG3.macronix.com 14B1esOa036551
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you use SPI-NAND with SW-ECC engine, the ECC related statistics
(ecc_stats.failed & ecc_stats.corrected) will be doubled, because
those numbers will be double-counted in ecc-sw-hamming.c and
drivers/mtd/nand/spi/core.c.

This can be found by using nandtest/nandbiterrs validation.

Signed-off-by: YouChing Lin <ycllin@mxic.com.tw>
---
 drivers/mtd/nand/ecc-sw-hamming.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/ecc-sw-hamming.c b/drivers/mtd/nand/ecc-sw-hamming.c
index a7655b6..e8a30cf 100644
--- a/drivers/mtd/nand/ecc-sw-hamming.c
+++ b/drivers/mtd/nand/ecc-sw-hamming.c
@@ -625,11 +625,12 @@ static int nand_ecc_sw_hamming_finish_io_req(struct nand_device *nand,
 							&ecccode[i],
 							&ecccalc[i]);
 		if (stat < 0) {
-			mtd->ecc_stats.failed++;
-		} else {
-			mtd->ecc_stats.corrected += stat;
-			max_bitflips = max_t(unsigned int, max_bitflips, stat);
+			nand_ecc_restore_req(&engine_conf->req_ctx, req);
+
+			return -EBADMSG;
 		}
+
+		max_bitflips = max_t(unsigned int, max_bitflips, stat);
 	}
 
 	nand_ecc_restore_req(&engine_conf->req_ctx, req);
-- 
1.9.1

