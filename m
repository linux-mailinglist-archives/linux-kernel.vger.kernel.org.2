Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDB7457152
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 16:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbhKSPG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 10:06:28 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:46485 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbhKSPG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 10:06:26 -0500
Received: (Authenticated sender: herve.codina@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPA id 4541F1C0007;
        Fri, 19 Nov 2021 15:03:23 +0000 (UTC)
From:   Herve Codina <herve.codina@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Herve Codina <herve.codina@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v3 1/4] mtd: rawnand: Fix nand_erase_op delay
Date:   Fri, 19 Nov 2021 16:03:13 +0100
Message-Id: <20211119150316.43080-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211119150316.43080-1-herve.codina@bootlin.com>
References: <20211119150316.43080-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NAND_OP_CMD() expects a delay parameter in nanoseconds.
The delay value is wrongly given in milliseconds.

Fix the conversion macro used in order to set this
delay in nanoseconds.

Fixes: d7a773e8812b ("mtd: rawnand: Access SDR and NV-DDR timings through a common macro")
Fixes: 8878b126df76 ("mtd: nand: add ->exec_op() implementation")
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
Changes v1 -> v2:
- Commit log reword

Changes v2 -> v3:
- Fix commit log typo
- Added 'Fixes' references

 drivers/mtd/nand/raw/nand_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 3d6c6e880520..5c6b065837ef 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -1837,7 +1837,7 @@ int nand_erase_op(struct nand_chip *chip, unsigned int eraseblock)
 			NAND_OP_CMD(NAND_CMD_ERASE1, 0),
 			NAND_OP_ADDR(2, addrs, 0),
 			NAND_OP_CMD(NAND_CMD_ERASE2,
-				    NAND_COMMON_TIMING_MS(conf, tWB_max)),
+				    NAND_COMMON_TIMING_NS(conf, tWB_max)),
 			NAND_OP_WAIT_RDY(NAND_COMMON_TIMING_MS(conf, tBERS_max),
 					 0),
 		};
-- 
2.31.1

