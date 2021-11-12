Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC1044E918
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 15:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235252AbhKLOmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 09:42:24 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:65143 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235228AbhKLOmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 09:42:22 -0500
Received: (Authenticated sender: herve.codina@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPA id 1973C40005;
        Fri, 12 Nov 2021 14:39:31 +0000 (UTC)
From:   Herve Codina <herve.codina@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Herve Codina <herve.codina@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 2/4] mtd: rawnand: fsmc: Force to use 8 bits access when expected
Date:   Fri, 12 Nov 2021 15:38:53 +0100
Message-Id: <20211112143855.2678989-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211112143855.2678989-1-herve.codina@bootlin.com>
References: <20211112143855.2678989-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some data transfers are expected on 8 bits by the nand core.
The fsmc driver did not check this constraint and these transfers
can be done on 32 bits depending on buffer alignment and transfers
data size.

This patch ensures that these transfers will be 8bits transfers in
all cases.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/mtd/nand/raw/fsmc_nand.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/fsmc_nand.c b/drivers/mtd/nand/raw/fsmc_nand.c
index 658f0cbe7ce8..7f057cfee6c4 100644
--- a/drivers/mtd/nand/raw/fsmc_nand.c
+++ b/drivers/mtd/nand/raw/fsmc_nand.c
@@ -540,12 +540,12 @@ static int dma_xfer(struct fsmc_nand_data *host, void *buffer, int len,
  * @len:	number of bytes to write
  */
 static void fsmc_write_buf(struct fsmc_nand_data *host, const u8 *buf,
-			   int len)
+			   int len, bool force_8bit)
 {
 	int i;
 
 	if (IS_ALIGNED((uintptr_t)buf, sizeof(u32)) &&
-	    IS_ALIGNED(len, sizeof(u32))) {
+	    IS_ALIGNED(len, sizeof(u32)) && !force_8bit) {
 		u32 *p = (u32 *)buf;
 
 		len = len >> 2;
@@ -563,12 +563,13 @@ static void fsmc_write_buf(struct fsmc_nand_data *host, const u8 *buf,
  * @buf:	buffer to store date
  * @len:	number of bytes to read
  */
-static void fsmc_read_buf(struct fsmc_nand_data *host, u8 *buf, int len)
+static void fsmc_read_buf(struct fsmc_nand_data *host, u8 *buf, int len,
+			  bool force_8bit)
 {
 	int i;
 
 	if (IS_ALIGNED((uintptr_t)buf, sizeof(u32)) &&
-	    IS_ALIGNED(len, sizeof(u32))) {
+	    IS_ALIGNED(len, sizeof(u32)) && !force_8bit) {
 		u32 *p = (u32 *)buf;
 
 		len = len >> 2;
@@ -646,7 +647,8 @@ static int fsmc_exec_op(struct nand_chip *chip, const struct nand_operation *op,
 						  instr->ctx.data.len);
 			else
 				fsmc_read_buf(host, instr->ctx.data.buf.in,
-					      instr->ctx.data.len);
+					      instr->ctx.data.len,
+					      instr->ctx.data.force_8bit);
 			break;
 
 		case NAND_OP_DATA_OUT_INSTR:
@@ -656,7 +658,8 @@ static int fsmc_exec_op(struct nand_chip *chip, const struct nand_operation *op,
 						   instr->ctx.data.len);
 			else
 				fsmc_write_buf(host, instr->ctx.data.buf.out,
-					       instr->ctx.data.len);
+					       instr->ctx.data.len,
+					       instr->ctx.data.force_8bit);
 			break;
 
 		case NAND_OP_WAITRDY_INSTR:
-- 
2.31.1

