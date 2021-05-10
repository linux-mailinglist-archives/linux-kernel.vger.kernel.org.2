Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D97B378A9F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 14:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236839AbhEJLpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 07:45:52 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:5641 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbhEJK6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:58:15 -0400
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 10 May 2021 03:57:09 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 10 May 2021 03:57:08 -0700
X-QCInternal: smtphost
Received: from mdalam-linux.qualcomm.com ([10.201.2.71])
  by ironmsg02-blr.qualcomm.com with ESMTP; 10 May 2021 16:26:50 +0530
Received: by mdalam-linux.qualcomm.com (Postfix, from userid 466583)
        id D0E6120DF0; Mon, 10 May 2021 16:26:48 +0530 (IST)
From:   Md Sadre Alam <mdalam@codeaurora.org>
To:     miquel.raynal@bootlin.com, mani@kernel.org,
        boris.brezillon@collabora.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mdalam@codeaurora.org, sricharan@codeaurora.org
Subject: [PATCH V2] mtd: rawnand: qcom: avoid writing to obsolete register
Date:   Mon, 10 May 2021 16:26:46 +0530
Message-Id: <1620644206-2250-1-git-send-email-mdalam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QPIC_EBI2_ECC_BUF_CFG register got obsolete from QPIC V2.0 onwards.
Avoid writing this register if QPIC version is V2.0 or newer.

Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
---
[V2]
 * Updated commit message
 drivers/mtd/nand/raw/qcom_nandc.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index a64fb6c..32f4641 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -762,7 +762,8 @@ static void update_rw_regs(struct qcom_nand_host *host, int num_cw, bool read, i
 	nandc_set_reg(chip, NAND_DEV0_CFG0, cfg0);
 	nandc_set_reg(chip, NAND_DEV0_CFG1, cfg1);
 	nandc_set_reg(chip, NAND_DEV0_ECC_CFG, ecc_bch_cfg);
-	nandc_set_reg(chip, NAND_EBI2_ECC_BUF_CFG, host->ecc_buf_cfg);
+	if (!nandc->props->qpic_v2)
+		nandc_set_reg(chip, NAND_EBI2_ECC_BUF_CFG, host->ecc_buf_cfg);
 	nandc_set_reg(chip, NAND_FLASH_STATUS, host->clrflashstatus);
 	nandc_set_reg(chip, NAND_READ_STATUS, host->clrreadstatus);
 	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
@@ -1133,7 +1134,8 @@ static void config_nand_page_read(struct nand_chip *chip)
 
 	write_reg_dma(nandc, NAND_ADDR0, 2, 0);
 	write_reg_dma(nandc, NAND_DEV0_CFG0, 3, 0);
-	write_reg_dma(nandc, NAND_EBI2_ECC_BUF_CFG, 1, 0);
+	if (!nandc->props->qpic_v2)
+		write_reg_dma(nandc, NAND_EBI2_ECC_BUF_CFG, 1, 0);
 	write_reg_dma(nandc, NAND_ERASED_CW_DETECT_CFG, 1, 0);
 	write_reg_dma(nandc, NAND_ERASED_CW_DETECT_CFG, 1,
 		      NAND_ERASED_CW_SET | NAND_BAM_NEXT_SGL);
@@ -1191,8 +1193,9 @@ static void config_nand_page_write(struct nand_chip *chip)
 
 	write_reg_dma(nandc, NAND_ADDR0, 2, 0);
 	write_reg_dma(nandc, NAND_DEV0_CFG0, 3, 0);
-	write_reg_dma(nandc, NAND_EBI2_ECC_BUF_CFG, 1,
-		      NAND_BAM_NEXT_SGL);
+	if (!nandc->props->qpic_v2)
+		write_reg_dma(nandc, NAND_EBI2_ECC_BUF_CFG, 1,
+			      NAND_BAM_NEXT_SGL);
 }
 
 /*
@@ -1248,7 +1251,8 @@ static int nandc_param(struct qcom_nand_host *host)
 					| 2 << WR_RD_BSY_GAP
 					| 0 << WIDE_FLASH
 					| 1 << DEV0_CFG1_ECC_DISABLE);
-	nandc_set_reg(chip, NAND_EBI2_ECC_BUF_CFG, 1 << ECC_CFG_ECC_DISABLE);
+	if (!nandc->props->qpic_v2)
+		nandc_set_reg(chip, NAND_EBI2_ECC_BUF_CFG, 1 << ECC_CFG_ECC_DISABLE);
 
 	/* configure CMD1 and VLD for ONFI param probing in QPIC v1 */
 	if (!nandc->props->qpic_v2) {
@@ -2689,7 +2693,8 @@ static int qcom_nand_attach_chip(struct nand_chip *chip)
 				| ecc_mode << ECC_MODE
 				| host->ecc_bytes_hw << ECC_PARITY_SIZE_BYTES_BCH;
 
-	host->ecc_buf_cfg = 0x203 << NUM_STEPS;
+	if (!nandc->props->qpic_v2)
+		host->ecc_buf_cfg = 0x203 << NUM_STEPS;
 
 	host->clrflashstatus = FS_READY_BSY_N;
 	host->clrreadstatus = 0xc0;
-- 
2.7.4

