Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3041940C328
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 11:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237546AbhIOJ7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 05:59:35 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:52234 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237017AbhIOJ7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 05:59:25 -0400
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 15 Sep 2021 02:58:07 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 15 Sep 2021 02:58:06 -0700
X-QCInternal: smtphost
Received: from mdalam-linux.qualcomm.com ([10.201.2.71])
  by ironmsg02-blr.qualcomm.com with ESMTP; 15 Sep 2021 15:28:06 +0530
Received: by mdalam-linux.qualcomm.com (Postfix, from userid 466583)
        id F1BF922353; Wed, 15 Sep 2021 15:28:04 +0530 (IST)
From:   Md Sadre Alam <mdalam@codeaurora.org>
To:     miquel.raynal@bootlin.com, mani@kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mdalam@codeaurora.org, sricharan@codeaurora.org
Subject: [PATCH 3/3] mtd: rawnand: qcom: Add support for page scope read
Date:   Wed, 15 Sep 2021 15:27:31 +0530
Message-Id: <1631699851-12172-4-git-send-email-mdalam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631699851-12172-1-git-send-email-mdalam@codeaurora.org>
References: <1631699851-12172-1-git-send-email-mdalam@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QPIC V2.0 onwards QPIC controller support enhanced read mode
like page scope read and multi page read.

In QPIC V1, SW is needed to write EXEC_CMD register for each
Code word and collect any Status related to that CW before
issueing EXEC_CMD for next CW.

Page scope command is truly a page mode command where SW is
required to issue EXEC_CMD only once for a page. Controller
HW takes care of Codeword specific details and automatically
returns status associated with each CW to BAM pipe, dedicated
for status deposition.

With this command, SW now can issue one read command for a page
and upon receiving completion interrupt, can process status,
that have already been deposited in memory through status BAM pipe.

Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
---
 drivers/mtd/nand/raw/qcom_nandc.c | 77 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 71 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 07448c4..257dec7e 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -157,6 +157,10 @@
 #define	OP_FETCH_ID			0xb
 #define	OP_RESET_DEVICE			0xd
 
+/* Auto status val and mask */
+#define	AUTO_STS_VAL			0x000B000B
+#define PAGE_SCOPE_READ			BIT(23)
+
 /* Default Value for NAND_DEV_CMD_VLD */
 #define NAND_DEV_CMD_VLD_VAL		(READ_START_VLD | WRITE_START_VLD | \
 					 ERASE_START_VLD | SEQ_READ_START_VLD)
@@ -336,6 +340,8 @@ struct nandc_regs {
 
 	__le32 erased_cw_detect_cfg_clr;
 	__le32 erased_cw_detect_cfg_set;
+
+	__le32 auto_sts_en;
 };
 
 /*
@@ -421,6 +427,9 @@ struct qcom_nand_controller {
 
 	u32 cmd1, vld;
 	const struct qcom_nandc_props *props;
+
+	__le32 *status_buf;
+	int sts_buf_size;
 };
 
 /*
@@ -487,6 +496,7 @@ struct qcom_nandc_props {
 	bool is_bam;
 	bool is_qpic;
 	bool qpic_v2;
+	bool page_scope;
 	u32 dev_cmd_reg_start;
 };
 
@@ -656,6 +666,8 @@ static __le32 *offset_to_nandc_reg(struct nandc_regs *regs, int offset)
 		return &regs->cfg1;
 	case NAND_DEV0_ECC_CFG:
 		return &regs->ecc_bch_cfg;
+	case NAND_AUTO_STATUS_EN:
+		return &regs->auto_sts_en;
 	case NAND_READ_STATUS:
 		return &regs->clrreadstatus;
 	case NAND_DEV_CMD1:
@@ -756,10 +768,13 @@ static void update_rw_regs(struct qcom_nand_host *host, int num_cw, bool read, i
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 
 	if (read) {
-		if (host->use_ecc)
+		if (host->use_ecc) {
 			cmd = OP_PAGE_READ_WITH_ECC | PAGE_ACC | LAST_PAGE;
-		else
+			if (nandc->props->qpic_v2 && nandc->props->page_scope)
+				cmd |= PAGE_SCOPE_READ;
+		} else {
 			cmd = OP_PAGE_READ | PAGE_ACC | LAST_PAGE;
+		}
 	} else {
 		cmd = OP_PROGRAM_PAGE | PAGE_ACC | LAST_PAGE;
 	}
@@ -788,6 +803,9 @@ static void update_rw_regs(struct qcom_nand_host *host, int num_cw, bool read, i
 	nandc_set_reg(chip, NAND_READ_STATUS, host->clrreadstatus);
 	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
 
+	if (nandc->props->qpic_v2 && nandc->props->page_scope)
+		nandc_set_reg(chip, NAND_AUTO_STATUS_EN, AUTO_STS_VAL);
+
 	if (read)
 		nandc_set_read_loc(chip, cw, 0, 0, host->use_ecc ?
 				   host->cw_data : host->cw_size, 1);
@@ -1040,6 +1058,26 @@ static int prep_adm_dma_desc(struct qcom_nand_controller *nandc, bool read,
 }
 
 /*
+ * read_status_data_dma: prepares a DMA descriptor to transfer status from the
+ *			 controller's status registers to buffer 'vaddr'
+ * @reg_off:             offset within the controller's data buffer
+ * @vaddr:               virtual address of the buffer we want to write to
+ * @size:                DMA transaction size in bytes
+ * @flags:               flags to control DMA descriptor preparation
+ */
+static int read_status_data_dma(struct qcom_nand_controller *nandc, int reg_off,
+				const u8 *vaddr, int size, unsigned int flags)
+{
+	struct bam_transaction *bam_txn = nandc->bam_txn;
+
+	sg_set_buf(&bam_txn->sts_sgl[bam_txn->sts_sgl_pos],
+		   vaddr, size);
+	bam_txn->sts_sgl_pos++;
+
+	return 0;
+}
+
+/*
  * read_reg_dma:	prepares a descriptor to read a given number of
  *			contiguous registers to the reg_read_buf pointer
  *
@@ -1186,13 +1224,20 @@ config_nand_cw_read(struct nand_chip *chip, bool use_ecc, int cw)
 		write_reg_dma(nandc, reg, 4, NAND_BAM_NEXT_SGL);
 
 	write_reg_dma(nandc, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
-	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
 
 	if (use_ecc) {
-		read_reg_dma(nandc, NAND_FLASH_STATUS, 2, 0);
-		read_reg_dma(nandc, NAND_ERASED_CW_DETECT_STATUS, 1,
-			     NAND_BAM_NEXT_SGL);
+		if (nandc->props->qpic_v2 && nandc->props->page_scope) {
+			if (qcom_nandc_is_last_cw(ecc, cw))
+				write_reg_dma(nandc, NAND_EXEC_CMD, 1,
+					      NAND_BAM_NEXT_SGL);
+		} else {
+			write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
+			read_reg_dma(nandc, NAND_FLASH_STATUS, 2, 0);
+			read_reg_dma(nandc, NAND_ERASED_CW_DETECT_STATUS, 1,
+				     NAND_BAM_NEXT_SGL);
+		}
 	} else {
+		write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
 		read_reg_dma(nandc, NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
 	}
 }
@@ -1959,6 +2004,8 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	u8 *data_buf_start = data_buf, *oob_buf_start = oob_buf;
 	int i, ret;
+	__le32 *status_buf_start = nandc->status_buf;
+	__le32 *status_buf_cw = nandc->status_buf;
 
 	config_nand_page_read(chip);
 
@@ -1994,6 +2041,12 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
 			read_data_dma(nandc, FLASH_BUF_ACC, data_buf,
 				      data_size, 0);
 
+		if (nandc->props->qpic_v2 && nandc->props->page_scope) {
+			read_status_data_dma(nandc, FLASH_BUF_ACC, (void *)status_buf_cw,
+					     (nandc->sts_buf_size >> 2), 0);
+			status_buf_cw += (nandc->sts_buf_size >> 4);
+		}
+
 		/*
 		 * when ecc is enabled, the controller doesn't read the real
 		 * or dummy bad block markers in each chunk. To maintain a
@@ -2025,6 +2078,9 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
 		return ret;
 	}
 
+	if (nandc->props->qpic_v2 && nandc->props->page_scope)
+		memmove(nandc->reg_read_buf, status_buf_start, nandc->sts_buf_size);
+
 	return parse_read_errors(host, data_buf_start, oob_buf_start, page);
 }
 
@@ -3005,6 +3061,14 @@ static int qcom_nand_host_init_and_register(struct qcom_nand_controller *nandc,
 		}
 	}
 
+	if (nandc->props->qpic_v2 && nandc->props->page_scope) {
+		nandc->sts_buf_size = mtd->writesize == SZ_2K ? 48 : 96;
+		nandc->status_buf = devm_kzalloc(nandc->dev, nandc->sts_buf_size,
+						 GFP_KERNEL);
+		if (!nandc->status_buf)
+			return -ENOMEM;
+	}
+
 	ret = mtd_device_parse_register(mtd, probes, NULL, NULL, 0);
 	if (ret)
 		nand_cleanup(chip);
@@ -3197,6 +3261,7 @@ static const struct qcom_nandc_props sdx55_nandc_props = {
 	.is_bam = true,
 	.is_qpic = true,
 	.qpic_v2 = true,
+	.page_scope = true,
 	.dev_cmd_reg_start = 0x7000,
 };
 
-- 
2.7.4

