Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED05C31B2B7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 22:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhBNVSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 16:18:43 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:12409 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhBNVSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 16:18:40 -0500
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 14 Feb 2021 13:17:59 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 14 Feb 2021 13:17:58 -0800
X-QCInternal: smtphost
Received: from mdalam-linux.qualcomm.com ([10.201.2.71])
  by ironmsg02-blr.qualcomm.com with ESMTP; 15 Feb 2021 02:47:33 +0530
Received: by mdalam-linux.qualcomm.com (Postfix, from userid 466583)
        id 27FA921D7C; Mon, 15 Feb 2021 02:47:34 +0530 (IST)
From:   Md Sadre Alam <mdalam@codeaurora.org>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        boris.brezillon@collabora.com, mani@kernel.org, krzk@kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mdalam@codeaurora.org, sricharan@codeaurora.org
Subject: [PATCH] mtd: rawnand: qcom: update last code word register
Date:   Mon, 15 Feb 2021 02:47:31 +0530
Message-Id: <1613337451-8002-1-git-send-email-mdalam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From QPIC version 2.0 onwards new register got added to
read last codeword. This change will add the READ_LOCATION_LAST_CW_n
register.

For first three code word READ_LOCATION_n register will be
use.For last code word READ_LOCATION_LAST_CW_n register will be
use.

Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
---
[V5]
 * Added helper function to update location register value.
 drivers/mtd/nand/raw/qcom_nandc.c | 136 ++++++++++++++++++++++++++++++--------
 1 file changed, 107 insertions(+), 29 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 667e4bf..6d66dd1 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -48,6 +48,10 @@
 #define	NAND_READ_LOCATION_1		0xf24
 #define	NAND_READ_LOCATION_2		0xf28
 #define	NAND_READ_LOCATION_3		0xf2c
+#define	NAND_READ_LOCATION_LAST_CW_0	0xf40
+#define	NAND_READ_LOCATION_LAST_CW_1	0xf44
+#define	NAND_READ_LOCATION_LAST_CW_2	0xf48
+#define	NAND_READ_LOCATION_LAST_CW_3	0xf4c
 
 /* dummy register offsets, used by write_reg_dma */
 #define	NAND_DEV_CMD1_RESTORE		0xdead
@@ -181,8 +185,14 @@
 #define	ECC_BCH_4BIT	BIT(2)
 #define	ECC_BCH_8BIT	BIT(3)
 
-#define nandc_set_read_loc(nandc, reg, offset, size, is_last)	\
-nandc_set_reg(nandc, NAND_READ_LOCATION_##reg,			\
+#define nandc_set_read_loc_first(nandc, reg, offset, size, is_last)	\
+nandc_set_reg(nandc, reg,					\
+	      ((offset) << READ_LOCATION_OFFSET) |		\
+	      ((size) << READ_LOCATION_SIZE) |			\
+	      ((is_last) << READ_LOCATION_LAST))
+
+#define nandc_set_read_loc_last(nandc, reg, offset, size, is_last)	\
+nandc_set_reg(nandc, reg,					\
 	      ((offset) << READ_LOCATION_OFFSET) |		\
 	      ((size) << READ_LOCATION_SIZE) |			\
 	      ((is_last) << READ_LOCATION_LAST))
@@ -316,6 +326,10 @@ struct nandc_regs {
 	__le32 read_location1;
 	__le32 read_location2;
 	__le32 read_location3;
+	__le32 read_location_last0;
+	__le32 read_location_last1;
+	__le32 read_location_last2;
+	__le32 read_location_last3;
 
 	__le32 erased_cw_detect_cfg_clr;
 	__le32 erased_cw_detect_cfg_set;
@@ -644,6 +658,14 @@ static __le32 *offset_to_nandc_reg(struct nandc_regs *regs, int offset)
 		return &regs->read_location2;
 	case NAND_READ_LOCATION_3:
 		return &regs->read_location3;
+	case NAND_READ_LOCATION_LAST_CW_0:
+		return &regs->read_location_last0;
+	case NAND_READ_LOCATION_LAST_CW_1:
+		return &regs->read_location_last1;
+	case NAND_READ_LOCATION_LAST_CW_2:
+		return &regs->read_location_last2;
+	case NAND_READ_LOCATION_LAST_CW_3:
+		return &regs->read_location_last3;
 	default:
 		return NULL;
 	}
@@ -661,6 +683,26 @@ static void nandc_set_reg(struct qcom_nand_controller *nandc, int offset,
 		*reg = cpu_to_le32(val);
 }
 
+/* helper to configure location register values */
+static void nandc_set_read_loc(struct nand_chip *chip, int cw, int reg,
+			       int offset, int size, int is_last)
+{
+	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
+	struct nand_ecc_ctrl *ecc = &chip->ecc;
+
+	int loc = NAND_READ_LOCATION_0;
+
+	if (nandc->props->qpic_v2 && cw == (ecc->steps - 1))
+		loc = NAND_READ_LOCATION_LAST_CW_0;
+
+	loc += reg * 4;
+
+	if (nandc->props->qpic_v2 && cw == (ecc->steps - 1))
+		return nandc_set_read_loc_last(nandc, loc, offset, size, is_last);
+	else
+		return nandc_set_read_loc_first(nandc, loc, offset, size, is_last);
+}
+
 /* helper to configure address register values */
 static void set_address(struct qcom_nand_host *host, u16 column, int page)
 {
@@ -719,9 +761,14 @@ static void update_rw_regs(struct qcom_nand_host *host, int num_cw, bool read)
 	nandc_set_reg(nandc, NAND_READ_STATUS, host->clrreadstatus);
 	nandc_set_reg(nandc, NAND_EXEC_CMD, 1);
 
-	if (read)
-		nandc_set_read_loc(nandc, 0, 0, host->use_ecc ?
-				   host->cw_data : host->cw_size, 1);
+	if (read) {
+		if (nandc->props->qpic_v2)
+			nandc_set_read_loc(chip, 3, 0, 0, host->use_ecc ?
+					host->cw_data : host->cw_size, 1);
+		else
+			nandc_set_read_loc(chip, 0, 0, 0, host->use_ecc ?
+					host->cw_data : host->cw_size, 1);
+	}
 }
 
 /*
@@ -1094,11 +1141,16 @@ static void config_nand_page_read(struct qcom_nand_controller *nandc)
  * before reading each codeword in NAND page.
  */
 static void
-config_nand_cw_read(struct qcom_nand_controller *nandc, bool use_ecc)
+config_nand_cw_read(struct qcom_nand_controller *nandc, bool use_ecc, bool last_cw)
 {
-	if (nandc->props->is_bam)
-		write_reg_dma(nandc, NAND_READ_LOCATION_0, 4,
-			      NAND_BAM_NEXT_SGL);
+	if (nandc->props->is_bam) {
+		if (nandc->props->qpic_v2 && last_cw)
+			write_reg_dma(nandc, NAND_READ_LOCATION_LAST_CW_0, 4,
+				      NAND_BAM_NEXT_SGL);
+		else
+			write_reg_dma(nandc, NAND_READ_LOCATION_0, 4,
+				      NAND_BAM_NEXT_SGL);
+	}
 
 	write_reg_dma(nandc, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
 	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
@@ -1118,10 +1170,10 @@ config_nand_cw_read(struct qcom_nand_controller *nandc, bool use_ecc)
  */
 static void
 config_nand_single_cw_page_read(struct qcom_nand_controller *nandc,
-				bool use_ecc)
+				bool use_ecc, bool last_cw)
 {
 	config_nand_page_read(nandc);
-	config_nand_cw_read(nandc, use_ecc);
+	config_nand_cw_read(nandc, use_ecc, last_cw);
 }
 
 /*
@@ -1205,7 +1257,7 @@ static int nandc_param(struct qcom_nand_host *host)
 		nandc_set_reg(nandc, NAND_DEV_CMD_VLD_RESTORE, nandc->vld);
 	}
 
-	nandc_set_read_loc(nandc, 0, 0, 512, 1);
+	nandc_set_read_loc(chip, 0, 0, 0, 512, 1);
 
 	if (!nandc->props->qpic_v2) {
 		write_reg_dma(nandc, NAND_DEV_CMD_VLD, 1, 0);
@@ -1215,7 +1267,7 @@ static int nandc_param(struct qcom_nand_host *host)
 	nandc->buf_count = 512;
 	memset(nandc->data_buffer, 0xff, nandc->buf_count);
 
-	config_nand_single_cw_page_read(nandc, false);
+	config_nand_single_cw_page_read(nandc, false, false);
 
 	read_data_dma(nandc, FLASH_BUF_ACC, nandc->data_buffer,
 		      nandc->buf_count, 0);
@@ -1633,19 +1685,32 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, struct nand_chip *chip,
 	}
 
 	if (nandc->props->is_bam) {
-		nandc_set_read_loc(nandc, 0, read_loc, data_size1, 0);
-		read_loc += data_size1;
+		if (nandc->props->qpic_v2 && cw == (ecc->steps - 1)) {
+			nandc_set_read_loc(chip, cw, 0, read_loc, data_size1, 0);
+			read_loc += data_size1;
+
+			nandc_set_read_loc(chip, cw, 1, read_loc, oob_size1, 0);
+			read_loc += oob_size1;
+
+			nandc_set_read_loc(chip, cw, 2, read_loc, data_size2, 0);
+			read_loc += data_size2;
 
-		nandc_set_read_loc(nandc, 1, read_loc, oob_size1, 0);
-		read_loc += oob_size1;
+			nandc_set_read_loc(chip, cw, 3, read_loc, oob_size2, 1);
+		} else {
+			nandc_set_read_loc(chip, cw, 0, read_loc, data_size1, 0);
+			read_loc += data_size1;
+
+			nandc_set_read_loc(chip, cw, 1, read_loc, oob_size1, 0);
+			read_loc += oob_size1;
 
-		nandc_set_read_loc(nandc, 2, read_loc, data_size2, 0);
-		read_loc += data_size2;
+			nandc_set_read_loc(chip, cw, 2, read_loc, data_size2, 0);
+			read_loc += data_size2;
 
-		nandc_set_read_loc(nandc, 3, read_loc, oob_size2, 1);
+			nandc_set_read_loc(chip, cw, 3, read_loc, oob_size2, 1);
+		}
 	}
 
-	config_nand_cw_read(nandc, false);
+	config_nand_cw_read(nandc, false, cw == ecc->steps - 1 ? true : false);
 
 	read_data_dma(nandc, reg_off, data_buf, data_size1, 0);
 	reg_off += data_size1;
@@ -1873,18 +1938,31 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
 
 		if (nandc->props->is_bam) {
 			if (data_buf && oob_buf) {
-				nandc_set_read_loc(nandc, 0, 0, data_size, 0);
-				nandc_set_read_loc(nandc, 1, data_size,
-						   oob_size, 1);
+				if (nandc->props->qpic_v2 && i == (ecc->steps - 1)) {
+					nandc_set_read_loc(chip, i, 0, 0, data_size, 0);
+					nandc_set_read_loc(chip, i, 1, data_size,
+							   oob_size, 1);
+				} else {
+					nandc_set_read_loc(chip, i, 0, 0, data_size, 0);
+					nandc_set_read_loc(chip, i, 1, data_size,
+							   oob_size, 1);
+				}
 			} else if (data_buf) {
-				nandc_set_read_loc(nandc, 0, 0, data_size, 1);
+				if (nandc->props->qpic_v2 && i == (ecc->steps - 1))
+					nandc_set_read_loc(chip, i, 0, 0, data_size, 1);
+				else
+					nandc_set_read_loc(chip, i, 0, 0, data_size, 1);
 			} else {
-				nandc_set_read_loc(nandc, 0, data_size,
-						   oob_size, 1);
+				if (nandc->props->qpic_v2 && i == (ecc->steps - 1))
+					nandc_set_read_loc(chip, i, 0, data_size,
+							   oob_size, 1);
+				else
+					nandc_set_read_loc(chip, i, 0, data_size,
+							   oob_size, 1);
 			}
 		}
 
-		config_nand_cw_read(nandc, true);
+		config_nand_cw_read(nandc, true, i == ecc->steps - 1 ? true : false);
 
 		if (data_buf)
 			read_data_dma(nandc, FLASH_BUF_ACC, data_buf,
@@ -1946,7 +2024,7 @@ static int copy_last_cw(struct qcom_nand_host *host, int page)
 	set_address(host, host->cw_size * (ecc->steps - 1), page);
 	update_rw_regs(host, 1, true);
 
-	config_nand_single_cw_page_read(nandc, host->use_ecc);
+	config_nand_single_cw_page_read(nandc, host->use_ecc, true);
 
 	read_data_dma(nandc, FLASH_BUF_ACC, nandc->data_buffer, size, 0);
 
-- 
2.7.4

