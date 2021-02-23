Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2D932318C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 20:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbhBWTkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 14:40:12 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:29750 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbhBWTkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 14:40:06 -0500
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 23 Feb 2021 11:39:24 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 23 Feb 2021 11:39:23 -0800
X-QCInternal: smtphost
Received: from mdalam-linux.qualcomm.com ([10.201.2.71])
  by ironmsg02-blr.qualcomm.com with ESMTP; 24 Feb 2021 01:09:03 +0530
Received: by mdalam-linux.qualcomm.com (Postfix, from userid 466583)
        id D902120E1F; Wed, 24 Feb 2021 01:09:03 +0530 (IST)
From:   Md Sadre Alam <mdalam@codeaurora.org>
To:     miquel.raynal@bootlin.com, mani@kernel.org,
        boris.brezillon@collabora.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mdalam@codeaurora.org, sricharan@codeaurora.org
Subject: [PATCH 1/5] mtd: rawnand: qcom: Convert nandc to chip in Read/Write helper
Date:   Wed, 24 Feb 2021 01:08:57 +0530
Message-Id: <1614109141-7531-1-git-send-email-mdalam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change will convert nandc to chip in Read/Write helper, this
change is needed because if we wnated to access number of steps
in Read/Write helper then we need to get the chip->ecc.steps,
currentlly its not possible.After this change we can directly
acces chip->ecc.steps in Read/Write helper.

Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
---
 drivers/mtd/nand/raw/qcom_nandc.c | 153 ++++++++++++++++++++------------------
 1 file changed, 80 insertions(+), 73 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 667e4bf..4898d32 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -181,8 +181,8 @@
 #define	ECC_BCH_4BIT	BIT(2)
 #define	ECC_BCH_8BIT	BIT(3)
 
-#define nandc_set_read_loc(nandc, reg, offset, size, is_last)	\
-nandc_set_reg(nandc, NAND_READ_LOCATION_##reg,			\
+#define nandc_set_read_loc(chip, reg, offset, size, is_last)	\
+nandc_set_reg(chip, NAND_READ_LOCATION_##reg,			\
 	      ((offset) << READ_LOCATION_OFFSET) |		\
 	      ((size) << READ_LOCATION_SIZE) |			\
 	      ((is_last) << READ_LOCATION_LAST))
@@ -649,9 +649,10 @@ static __le32 *offset_to_nandc_reg(struct nandc_regs *regs, int offset)
 	}
 }
 
-static void nandc_set_reg(struct qcom_nand_controller *nandc, int offset,
+static void nandc_set_reg(struct nand_chip *chip, int offset,
 			  u32 val)
 {
+	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 	struct nandc_regs *regs = nandc->regs;
 	__le32 *reg;
 
@@ -665,13 +666,12 @@ static void nandc_set_reg(struct qcom_nand_controller *nandc, int offset,
 static void set_address(struct qcom_nand_host *host, u16 column, int page)
 {
 	struct nand_chip *chip = &host->chip;
-	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 
 	if (chip->options & NAND_BUSWIDTH_16)
 		column >>= 1;
 
-	nandc_set_reg(nandc, NAND_ADDR0, page << 16 | column);
-	nandc_set_reg(nandc, NAND_ADDR1, page >> 16 & 0xff);
+	nandc_set_reg(chip, NAND_ADDR0, page << 16 | column);
+	nandc_set_reg(chip, NAND_ADDR1, page >> 16 & 0xff);
 }
 
 /*
@@ -684,7 +684,6 @@ static void set_address(struct qcom_nand_host *host, u16 column, int page)
 static void update_rw_regs(struct qcom_nand_host *host, int num_cw, bool read)
 {
 	struct nand_chip *chip = &host->chip;
-	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 	u32 cmd, cfg0, cfg1, ecc_bch_cfg;
 
 	if (read) {
@@ -710,17 +709,17 @@ static void update_rw_regs(struct qcom_nand_host *host, int num_cw, bool read)
 		ecc_bch_cfg = 1 << ECC_CFG_ECC_DISABLE;
 	}
 
-	nandc_set_reg(nandc, NAND_FLASH_CMD, cmd);
-	nandc_set_reg(nandc, NAND_DEV0_CFG0, cfg0);
-	nandc_set_reg(nandc, NAND_DEV0_CFG1, cfg1);
-	nandc_set_reg(nandc, NAND_DEV0_ECC_CFG, ecc_bch_cfg);
-	nandc_set_reg(nandc, NAND_EBI2_ECC_BUF_CFG, host->ecc_buf_cfg);
-	nandc_set_reg(nandc, NAND_FLASH_STATUS, host->clrflashstatus);
-	nandc_set_reg(nandc, NAND_READ_STATUS, host->clrreadstatus);
-	nandc_set_reg(nandc, NAND_EXEC_CMD, 1);
+	nandc_set_reg(chip, NAND_FLASH_CMD, cmd);
+	nandc_set_reg(chip, NAND_DEV0_CFG0, cfg0);
+	nandc_set_reg(chip, NAND_DEV0_CFG1, cfg1);
+	nandc_set_reg(chip, NAND_DEV0_ECC_CFG, ecc_bch_cfg);
+	nandc_set_reg(chip, NAND_EBI2_ECC_BUF_CFG, host->ecc_buf_cfg);
+	nandc_set_reg(chip, NAND_FLASH_STATUS, host->clrflashstatus);
+	nandc_set_reg(chip, NAND_READ_STATUS, host->clrreadstatus);
+	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
 
 	if (read)
-		nandc_set_read_loc(nandc, 0, 0, host->use_ecc ?
+		nandc_set_read_loc(chip, 0, 0, host->use_ecc ?
 				   host->cw_data : host->cw_size, 1);
 }
 
@@ -1079,8 +1078,10 @@ static int write_data_dma(struct qcom_nand_controller *nandc, int reg_off,
  * Helper to prepare DMA descriptors for configuring registers
  * before reading a NAND page.
  */
-static void config_nand_page_read(struct qcom_nand_controller *nandc)
+static void config_nand_page_read(struct nand_chip *chip)
 {
+	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
+
 	write_reg_dma(nandc, NAND_ADDR0, 2, 0);
 	write_reg_dma(nandc, NAND_DEV0_CFG0, 3, 0);
 	write_reg_dma(nandc, NAND_EBI2_ECC_BUF_CFG, 1, 0);
@@ -1094,8 +1095,10 @@ static void config_nand_page_read(struct qcom_nand_controller *nandc)
  * before reading each codeword in NAND page.
  */
 static void
-config_nand_cw_read(struct qcom_nand_controller *nandc, bool use_ecc)
+config_nand_cw_read(struct nand_chip *chip, bool use_ecc)
 {
+	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
+
 	if (nandc->props->is_bam)
 		write_reg_dma(nandc, NAND_READ_LOCATION_0, 4,
 			      NAND_BAM_NEXT_SGL);
@@ -1117,19 +1120,21 @@ config_nand_cw_read(struct qcom_nand_controller *nandc, bool use_ecc)
  * single codeword in page
  */
 static void
-config_nand_single_cw_page_read(struct qcom_nand_controller *nandc,
+config_nand_single_cw_page_read(struct nand_chip *chip,
 				bool use_ecc)
 {
-	config_nand_page_read(nandc);
-	config_nand_cw_read(nandc, use_ecc);
+	config_nand_page_read(chip);
+	config_nand_cw_read(chip, use_ecc);
 }
 
 /*
  * Helper to prepare DMA descriptors used to configure registers needed for
  * before writing a NAND page.
  */
-static void config_nand_page_write(struct qcom_nand_controller *nandc)
+static void config_nand_page_write(struct nand_chip *chip)
 {
+	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
+
 	write_reg_dma(nandc, NAND_ADDR0, 2, 0);
 	write_reg_dma(nandc, NAND_DEV0_CFG0, 3, 0);
 	write_reg_dma(nandc, NAND_EBI2_ECC_BUF_CFG, 1,
@@ -1140,8 +1145,10 @@ static void config_nand_page_write(struct qcom_nand_controller *nandc)
  * Helper to prepare DMA descriptors for configuring registers
  * before writing each codeword in NAND page.
  */
-static void config_nand_cw_write(struct qcom_nand_controller *nandc)
+static void config_nand_cw_write(struct nand_chip *chip)
 {
+	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
+
 	write_reg_dma(nandc, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
 	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
 
@@ -1168,44 +1175,44 @@ static int nandc_param(struct qcom_nand_host *host)
 	 * bytes to read onfi params
 	 */
 	if (nandc->props->qpic_v2)
-		nandc_set_reg(nandc, NAND_FLASH_CMD, OP_PAGE_READ_ONFI_READ |
+		nandc_set_reg(chip, NAND_FLASH_CMD, OP_PAGE_READ_ONFI_READ |
 			      PAGE_ACC | LAST_PAGE);
 	else
-		nandc_set_reg(nandc, NAND_FLASH_CMD, OP_PAGE_READ |
+		nandc_set_reg(chip, NAND_FLASH_CMD, OP_PAGE_READ |
 			      PAGE_ACC | LAST_PAGE);
 
-	nandc_set_reg(nandc, NAND_ADDR0, 0);
-	nandc_set_reg(nandc, NAND_ADDR1, 0);
-	nandc_set_reg(nandc, NAND_DEV0_CFG0, 0 << CW_PER_PAGE
+	nandc_set_reg(chip, NAND_ADDR0, 0);
+	nandc_set_reg(chip, NAND_ADDR1, 0);
+	nandc_set_reg(chip, NAND_DEV0_CFG0, 0 << CW_PER_PAGE
 					| 512 << UD_SIZE_BYTES
 					| 5 << NUM_ADDR_CYCLES
 					| 0 << SPARE_SIZE_BYTES);
-	nandc_set_reg(nandc, NAND_DEV0_CFG1, 7 << NAND_RECOVERY_CYCLES
+	nandc_set_reg(chip, NAND_DEV0_CFG1, 7 << NAND_RECOVERY_CYCLES
 					| 0 << CS_ACTIVE_BSY
 					| 17 << BAD_BLOCK_BYTE_NUM
 					| 1 << BAD_BLOCK_IN_SPARE_AREA
 					| 2 << WR_RD_BSY_GAP
 					| 0 << WIDE_FLASH
 					| 1 << DEV0_CFG1_ECC_DISABLE);
-	nandc_set_reg(nandc, NAND_EBI2_ECC_BUF_CFG, 1 << ECC_CFG_ECC_DISABLE);
+	nandc_set_reg(chip, NAND_EBI2_ECC_BUF_CFG, 1 << ECC_CFG_ECC_DISABLE);
 
 	/* configure CMD1 and VLD for ONFI param probing in QPIC v1 */
 	if (!nandc->props->qpic_v2) {
-		nandc_set_reg(nandc, NAND_DEV_CMD_VLD,
+		nandc_set_reg(chip, NAND_DEV_CMD_VLD,
 			      (nandc->vld & ~READ_START_VLD));
-		nandc_set_reg(nandc, NAND_DEV_CMD1,
+		nandc_set_reg(chip, NAND_DEV_CMD1,
 			      (nandc->cmd1 & ~(0xFF << READ_ADDR))
 			      | NAND_CMD_PARAM << READ_ADDR);
 	}
 
-	nandc_set_reg(nandc, NAND_EXEC_CMD, 1);
+	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
 
 	if (!nandc->props->qpic_v2) {
-		nandc_set_reg(nandc, NAND_DEV_CMD1_RESTORE, nandc->cmd1);
-		nandc_set_reg(nandc, NAND_DEV_CMD_VLD_RESTORE, nandc->vld);
+		nandc_set_reg(chip, NAND_DEV_CMD1_RESTORE, nandc->cmd1);
+		nandc_set_reg(chip, NAND_DEV_CMD_VLD_RESTORE, nandc->vld);
 	}
 
-	nandc_set_read_loc(nandc, 0, 0, 512, 1);
+	nandc_set_read_loc(chip, 0, 0, 512, 1);
 
 	if (!nandc->props->qpic_v2) {
 		write_reg_dma(nandc, NAND_DEV_CMD_VLD, 1, 0);
@@ -1215,7 +1222,7 @@ static int nandc_param(struct qcom_nand_host *host)
 	nandc->buf_count = 512;
 	memset(nandc->data_buffer, 0xff, nandc->buf_count);
 
-	config_nand_single_cw_page_read(nandc, false);
+	config_nand_single_cw_page_read(chip, false);
 
 	read_data_dma(nandc, FLASH_BUF_ACC, nandc->data_buffer,
 		      nandc->buf_count, 0);
@@ -1235,16 +1242,16 @@ static int erase_block(struct qcom_nand_host *host, int page_addr)
 	struct nand_chip *chip = &host->chip;
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 
-	nandc_set_reg(nandc, NAND_FLASH_CMD,
+	nandc_set_reg(chip, NAND_FLASH_CMD,
 		      OP_BLOCK_ERASE | PAGE_ACC | LAST_PAGE);
-	nandc_set_reg(nandc, NAND_ADDR0, page_addr);
-	nandc_set_reg(nandc, NAND_ADDR1, 0);
-	nandc_set_reg(nandc, NAND_DEV0_CFG0,
+	nandc_set_reg(chip, NAND_ADDR0, page_addr);
+	nandc_set_reg(chip, NAND_ADDR1, 0);
+	nandc_set_reg(chip, NAND_DEV0_CFG0,
 		      host->cfg0_raw & ~(7 << CW_PER_PAGE));
-	nandc_set_reg(nandc, NAND_DEV0_CFG1, host->cfg1_raw);
-	nandc_set_reg(nandc, NAND_EXEC_CMD, 1);
-	nandc_set_reg(nandc, NAND_FLASH_STATUS, host->clrflashstatus);
-	nandc_set_reg(nandc, NAND_READ_STATUS, host->clrreadstatus);
+	nandc_set_reg(chip, NAND_DEV0_CFG1, host->cfg1_raw);
+	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
+	nandc_set_reg(chip, NAND_FLASH_STATUS, host->clrflashstatus);
+	nandc_set_reg(chip, NAND_READ_STATUS, host->clrreadstatus);
 
 	write_reg_dma(nandc, NAND_FLASH_CMD, 3, NAND_BAM_NEXT_SGL);
 	write_reg_dma(nandc, NAND_DEV0_CFG0, 2, NAND_BAM_NEXT_SGL);
@@ -1267,12 +1274,12 @@ static int read_id(struct qcom_nand_host *host, int column)
 	if (column == -1)
 		return 0;
 
-	nandc_set_reg(nandc, NAND_FLASH_CMD, OP_FETCH_ID);
-	nandc_set_reg(nandc, NAND_ADDR0, column);
-	nandc_set_reg(nandc, NAND_ADDR1, 0);
-	nandc_set_reg(nandc, NAND_FLASH_CHIP_SELECT,
+	nandc_set_reg(chip, NAND_FLASH_CMD, OP_FETCH_ID);
+	nandc_set_reg(chip, NAND_ADDR0, column);
+	nandc_set_reg(chip, NAND_ADDR1, 0);
+	nandc_set_reg(chip, NAND_FLASH_CHIP_SELECT,
 		      nandc->props->is_bam ? 0 : DM_EN);
-	nandc_set_reg(nandc, NAND_EXEC_CMD, 1);
+	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
 
 	write_reg_dma(nandc, NAND_FLASH_CMD, 4, NAND_BAM_NEXT_SGL);
 	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
@@ -1288,8 +1295,8 @@ static int reset(struct qcom_nand_host *host)
 	struct nand_chip *chip = &host->chip;
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 
-	nandc_set_reg(nandc, NAND_FLASH_CMD, OP_RESET_DEVICE);
-	nandc_set_reg(nandc, NAND_EXEC_CMD, 1);
+	nandc_set_reg(chip, NAND_FLASH_CMD, OP_RESET_DEVICE);
+	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
 
 	write_reg_dma(nandc, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
 	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
@@ -1617,7 +1624,7 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, struct nand_chip *chip,
 	clear_bam_transaction(nandc);
 	set_address(host, host->cw_size * cw, page);
 	update_rw_regs(host, 1, true);
-	config_nand_page_read(nandc);
+	config_nand_page_read(chip);
 
 	data_size1 = mtd->writesize - host->cw_size * (ecc->steps - 1);
 	oob_size1 = host->bbm_size;
@@ -1633,19 +1640,19 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, struct nand_chip *chip,
 	}
 
 	if (nandc->props->is_bam) {
-		nandc_set_read_loc(nandc, 0, read_loc, data_size1, 0);
+		nandc_set_read_loc(chip, 0, read_loc, data_size1, 0);
 		read_loc += data_size1;
 
-		nandc_set_read_loc(nandc, 1, read_loc, oob_size1, 0);
+		nandc_set_read_loc(chip, 1, read_loc, oob_size1, 0);
 		read_loc += oob_size1;
 
-		nandc_set_read_loc(nandc, 2, read_loc, data_size2, 0);
+		nandc_set_read_loc(chip, 2, read_loc, data_size2, 0);
 		read_loc += data_size2;
 
-		nandc_set_read_loc(nandc, 3, read_loc, oob_size2, 1);
+		nandc_set_read_loc(chip, 3, read_loc, oob_size2, 1);
 	}
 
-	config_nand_cw_read(nandc, false);
+	config_nand_cw_read(chip, false);
 
 	read_data_dma(nandc, reg_off, data_buf, data_size1, 0);
 	reg_off += data_size1;
@@ -1856,7 +1863,7 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
 	u8 *data_buf_start = data_buf, *oob_buf_start = oob_buf;
 	int i, ret;
 
-	config_nand_page_read(nandc);
+	config_nand_page_read(chip);
 
 	/* queue cmd descs for each codeword */
 	for (i = 0; i < ecc->steps; i++) {
@@ -1873,18 +1880,18 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
 
 		if (nandc->props->is_bam) {
 			if (data_buf && oob_buf) {
-				nandc_set_read_loc(nandc, 0, 0, data_size, 0);
-				nandc_set_read_loc(nandc, 1, data_size,
+				nandc_set_read_loc(chip, 0, 0, data_size, 0);
+				nandc_set_read_loc(chip, 1, data_size,
 						   oob_size, 1);
 			} else if (data_buf) {
-				nandc_set_read_loc(nandc, 0, 0, data_size, 1);
+				nandc_set_read_loc(chip, 0, 0, data_size, 1);
 			} else {
-				nandc_set_read_loc(nandc, 0, data_size,
+				nandc_set_read_loc(chip, 0, data_size,
 						   oob_size, 1);
 			}
 		}
 
-		config_nand_cw_read(nandc, true);
+		config_nand_cw_read(chip, true);
 
 		if (data_buf)
 			read_data_dma(nandc, FLASH_BUF_ACC, data_buf,
@@ -1946,7 +1953,7 @@ static int copy_last_cw(struct qcom_nand_host *host, int page)
 	set_address(host, host->cw_size * (ecc->steps - 1), page);
 	update_rw_regs(host, 1, true);
 
-	config_nand_single_cw_page_read(nandc, host->use_ecc);
+	config_nand_single_cw_page_read(chip, host->use_ecc);
 
 	read_data_dma(nandc, FLASH_BUF_ACC, nandc->data_buffer, size, 0);
 
@@ -2036,7 +2043,7 @@ static int qcom_nandc_write_page(struct nand_chip *chip, const uint8_t *buf,
 
 	host->use_ecc = true;
 	update_rw_regs(host, ecc->steps, false);
-	config_nand_page_write(nandc);
+	config_nand_page_write(chip);
 
 	for (i = 0; i < ecc->steps; i++) {
 		int data_size, oob_size;
@@ -2068,7 +2075,7 @@ static int qcom_nandc_write_page(struct nand_chip *chip, const uint8_t *buf,
 				       oob_buf, oob_size, 0);
 		}
 
-		config_nand_cw_write(nandc);
+		config_nand_cw_write(chip);
 
 		data_buf += data_size;
 		oob_buf += oob_size;
@@ -2107,7 +2114,7 @@ static int qcom_nandc_write_page_raw(struct nand_chip *chip,
 
 	host->use_ecc = false;
 	update_rw_regs(host, ecc->steps, false);
-	config_nand_page_write(nandc);
+	config_nand_page_write(chip);
 
 	for (i = 0; i < ecc->steps; i++) {
 		int data_size1, data_size2, oob_size1, oob_size2;
@@ -2144,7 +2151,7 @@ static int qcom_nandc_write_page_raw(struct nand_chip *chip,
 		write_data_dma(nandc, reg_off, oob_buf, oob_size2, 0);
 		oob_buf += oob_size2;
 
-		config_nand_cw_write(nandc);
+		config_nand_cw_write(chip);
 	}
 
 	ret = submit_descs(nandc);
@@ -2191,10 +2198,10 @@ static int qcom_nandc_write_oob(struct nand_chip *chip, int page)
 	set_address(host, host->cw_size * (ecc->steps - 1), page);
 	update_rw_regs(host, 1, false);
 
-	config_nand_page_write(nandc);
+	config_nand_page_write(chip);
 	write_data_dma(nandc, FLASH_BUF_ACC,
 		       nandc->data_buffer, data_size + oob_size, 0);
-	config_nand_cw_write(nandc);
+	config_nand_cw_write(chip);
 
 	ret = submit_descs(nandc);
 
@@ -2270,10 +2277,10 @@ static int qcom_nandc_block_markbad(struct nand_chip *chip, loff_t ofs)
 	set_address(host, host->cw_size * (ecc->steps - 1), page);
 	update_rw_regs(host, 1, false);
 
-	config_nand_page_write(nandc);
+	config_nand_page_write(chip);
 	write_data_dma(nandc, FLASH_BUF_ACC,
 		       nandc->data_buffer, host->cw_size, 0);
-	config_nand_cw_write(nandc);
+	config_nand_cw_write(chip);
 
 	ret = submit_descs(nandc);
 
-- 
2.7.4

