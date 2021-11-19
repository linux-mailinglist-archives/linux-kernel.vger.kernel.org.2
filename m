Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97578457154
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 16:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbhKSPGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 10:06:34 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:42061 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbhKSPGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 10:06:30 -0500
Received: (Authenticated sender: herve.codina@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPA id 5E8281C0019;
        Fri, 19 Nov 2021 15:03:27 +0000 (UTC)
From:   Herve Codina <herve.codina@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Herve Codina <herve.codina@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v3 3/4] mtd: rawnand: fsmc: Take instruction delay into account
Date:   Fri, 19 Nov 2021 16:03:15 +0100
Message-Id: <20211119150316.43080-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211119150316.43080-1-herve.codina@bootlin.com>
References: <20211119150316.43080-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FSMC NAND controller should apply a delay after the
instruction has been issued on the bus.
The FSMC NAND controller driver did not handle this delay.

Add this waiting delay in the FSMC NAND controller driver.

Fixes: 4da712e70294 ("mtd: nand: fsmc: use ->exec_op()")
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
Changes v1 -> v2:
- Commit log reword

Changes v2 -> v3:
- Added 'Fixes' reference

 drivers/mtd/nand/raw/fsmc_nand.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/nand/raw/fsmc_nand.c b/drivers/mtd/nand/raw/fsmc_nand.c
index 658f0cbe7ce8..0a6c9ef0ea8b 100644
--- a/drivers/mtd/nand/raw/fsmc_nand.c
+++ b/drivers/mtd/nand/raw/fsmc_nand.c
@@ -15,6 +15,7 @@
 
 #include <linux/clk.h>
 #include <linux/completion.h>
+#include <linux/delay.h>
 #include <linux/dmaengine.h>
 #include <linux/dma-direction.h>
 #include <linux/dma-mapping.h>
@@ -664,6 +665,9 @@ static int fsmc_exec_op(struct nand_chip *chip, const struct nand_operation *op,
 						instr->ctx.waitrdy.timeout_ms);
 			break;
 		}
+
+		if (instr->delay_ns)
+			ndelay(instr->delay_ns);
 	}
 
 	return ret;
-- 
2.31.1

