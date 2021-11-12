Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E60544E919
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 15:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235222AbhKLOm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 09:42:27 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:46075 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235228AbhKLOmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 09:42:25 -0500
Received: (Authenticated sender: herve.codina@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPA id 7EC804000F;
        Fri, 12 Nov 2021 14:39:33 +0000 (UTC)
From:   Herve Codina <herve.codina@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Herve Codina <herve.codina@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 3/4] mtd: rawnand: fsmc: Take instruction delay into account
Date:   Fri, 12 Nov 2021 15:38:54 +0100
Message-Id: <20211112143855.2678989-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211112143855.2678989-1-herve.codina@bootlin.com>
References: <20211112143855.2678989-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FSMC nand controller should apply a delay after the
instruction has been issued on the bus.
The FSMC nand controller driver did not handle this delay.

This patch adds this waiting delay in the FSMC nand
controller driver.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/mtd/nand/raw/fsmc_nand.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/nand/raw/fsmc_nand.c b/drivers/mtd/nand/raw/fsmc_nand.c
index 7f057cfee6c4..bff09219ce3a 100644
--- a/drivers/mtd/nand/raw/fsmc_nand.c
+++ b/drivers/mtd/nand/raw/fsmc_nand.c
@@ -15,6 +15,7 @@
 
 #include <linux/clk.h>
 #include <linux/completion.h>
+#include <linux/delay.h>
 #include <linux/dmaengine.h>
 #include <linux/dma-direction.h>
 #include <linux/dma-mapping.h>
@@ -667,6 +668,9 @@ static int fsmc_exec_op(struct nand_chip *chip, const struct nand_operation *op,
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

