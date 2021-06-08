Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F9F39EEF3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 08:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhFHGut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 02:50:49 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:38773 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFHGus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 02:50:48 -0400
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 07 Jun 2021 23:48:56 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 07 Jun 2021 23:48:55 -0700
X-QCInternal: smtphost
Received: from mdalam-linux.qualcomm.com ([10.201.2.71])
  by ironmsg02-blr.qualcomm.com with ESMTP; 08 Jun 2021 12:18:40 +0530
Received: by mdalam-linux.qualcomm.com (Postfix, from userid 466583)
        id 44056220CF; Tue,  8 Jun 2021 12:18:39 +0530 (IST)
From:   Md Sadre Alam <mdalam@codeaurora.org>
To:     miquel.raynal@bootlin.com, mani@kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mdalam@codeaurora.org, sricharan@codeaurora.org
Subject: [PATCH V4] mtd: rawnand: qcom: avoid writing to obsolete register
Date:   Tue,  8 Jun 2021 12:18:36 +0530
Message-Id: <1623134916-562-1-git-send-email-mdalam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QPIC_EBI2_ECC_BUF_CFG register got obsolete from QPIC V2.0 onwards.
Avoid writing this register if QPIC version is V2.0 or newer.

Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
---
[V4]
 * Removed reported by
 drivers/mtd/nand/raw/qcom_nandc.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index a64fb6c..ee5985d 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -734,6 +734,7 @@ static void update_rw_regs(struct qcom_nand_host *host, int num_cw, bool read, i
 {
 	struct nand_chip *chip = &host->chip;
 	u32 cmd, cfg0, cfg1, ecc_bch_cfg;
+	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 
 	if (read) {
 		if (host->use_ecc)
@@ -762,7 +763,8 @@ static void update_rw_regs(struct qcom_nand_host *host, int num_cw, bool read, i
 	nandc_set_reg(chip, NAND_DEV0_CFG0, cfg0);
 	nandc_set_reg(chip, NAND_DEV0_CFG1, cfg1);
 	nandc_set_reg(chip, NAND_DEV0_ECC_CFG, ecc_bch_cfg);
-	nandc_set_reg(chip, NAND_EBI2_ECC_BUF_CFG, host->ecc_buf_cfg);
+	if (!nandc->props->qpic_v2)
+		nandc_set_reg(chip, NAND_EBI2_ECC_BUF_CFG, host->ecc_buf_cfg);
 	nandc_set_reg(chip, NAND_FLASH_STATUS, host->clrflashstatus);
 	nandc_set_reg(chip, NAND_READ_STATUS, host->clrreadstatus);
 	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
@@ -1133,7 +1135,8 @@ static void config_nand_page_read(struct nand_chip *chip)
 
 	write_reg_dma(nandc, NAND_ADDR0, 2, 0);
 	write_reg_dma(nandc, NAND_DEV0_CFG0, 3, 0);
-	write_reg_dma(nandc, NAND_EBI2_ECC_BUF_CFG, 1, 0);
+	if (!nandc->props->qpic_v2)
+		write_reg_dma(nandc, NAND_EBI2_ECC_BUF_CFG, 1, 0);
 	write_reg_dma(nandc, NAND_ERASED_CW_DETECT_CFG, 1, 0);
 	write_reg_dma(nandc, NAND_ERASED_CW_DETECT_CFG, 1,
 		      NAND_ERASED_CW_SET | NAND_BAM_NEXT_SGL);
@@ -1191,8 +1194,9 @@ static void config_nand_page_write(struct nand_chip *chip)
 
 	write_reg_dma(nandc, NAND_ADDR0, 2, 0);
 	write_reg_dma(nandc, NAND_DEV0_CFG0, 3, 0);
-	write_reg_dma(nandc, NAND_EBI2_ECC_BUF_CFG, 1,
-		      NAND_BAM_NEXT_SGL);
+	if (!nandc->props->qpic_v2)
+		write_reg_dma(nandc, NAND_EBI2_ECC_BUF_CFG, 1,
+			      NAND_BAM_NEXT_SGL);
 }
 
 /*
@@ -1248,7 +1252,8 @@ static int nandc_param(struct qcom_nand_host *host)
 					| 2 << WR_RD_BSY_GAP
 					| 0 << WIDE_FLASH
 					| 1 << DEV0_CFG1_ECC_DISABLE);
-	nandc_set_reg(chip, NAND_EBI2_ECC_BUF_CFG, 1 << ECC_CFG_ECC_DISABLE);
+	if (!nandc->props->qpic_v2)
+		nandc_set_reg(chip, NAND_EBI2_ECC_BUF_CFG, 1 << ECC_CFG_ECC_DISABLE);
 
 	/* configure CMD1 and VLD for ONFI param probing in QPIC v1 */
 	if (!nandc->props->qpic_v2) {
@@ -2689,7 +2694,8 @@ static int qcom_nand_attach_chip(struct nand_chip *chip)
 				| ecc_mode << ECC_MODE
 				| host->ecc_bytes_hw << ECC_PARITY_SIZE_BYTES_BCH;
 
-	host->ecc_buf_cfg = 0x203 << NUM_STEPS;
+	if (!nandc->props->qpic_v2)
+		host->ecc_buf_cfg = 0x203 << NUM_STEPS;
 
 	host->clrflashstatus = FS_READY_BSY_N;
 	host->clrreadstatus = 0xc0;
-- 
2.7.4

