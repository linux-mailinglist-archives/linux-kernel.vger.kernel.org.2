Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331893080A8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 22:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhA1Vk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 16:40:57 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:32154 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbhA1VkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 16:40:24 -0500
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 28 Jan 2021 13:39:42 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 28 Jan 2021 13:39:41 -0800
X-QCInternal: smtphost
Received: from mdalam-linux.qualcomm.com ([10.201.2.71])
  by ironmsg02-blr.qualcomm.com with ESMTP; 29 Jan 2021 03:09:24 +0530
Received: by mdalam-linux.qualcomm.com (Postfix, from userid 466583)
        id C16CE2192C; Fri, 29 Jan 2021 03:09:23 +0530 (IST)
From:   Md Sadre Alam <mdalam@codeaurora.org>
To:     miquel.raynal@bootlin.com, boris.brezillon@collabora.com,
        manivannan.sadhasivam@linaro.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, vigneshr@ti.com
Cc:     mdalam@codeaurora.org, sricharan@codeaurora.org
Subject: [PATCH V4] mtd: rawnand: qcom: update last code word register
Date:   Fri, 29 Jan 2021 03:09:19 +0530
Message-Id: <1611869959-5109-1-git-send-email-mdalam@codeaurora.org>
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
[V4]
 * Modified condition for nandc_set_read_loc_last() in qcom_nandc_read_cw_raw().
 * Added one additional argument "last_cw" to the function config_nand_cw_read()
   to handle last code word condition.
 * Changed total number of last code word register "NAND_READ_LOCATION_LAST_CW_0" to 4
   while doing code word configuration.
 drivers/mtd/nand/raw/qcom_nandc.c | 110 +++++++++++++++++++++++++++++---------
 1 file changed, 84 insertions(+), 26 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 667e4bf..9484be8 100644
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
@@ -187,6 +191,12 @@ nandc_set_reg(nandc, NAND_READ_LOCATION_##reg,			\
 	      ((size) << READ_LOCATION_SIZE) |			\
 	      ((is_last) << READ_LOCATION_LAST))
 
+#define nandc_set_read_loc_last(nandc, reg, offset, size, is_last)	\
+nandc_set_reg(nandc, NAND_READ_LOCATION_LAST_CW_##reg,			\
+	      ((offset) << READ_LOCATION_OFFSET) |		\
+	      ((size) << READ_LOCATION_SIZE) |			\
+	      ((is_last) << READ_LOCATION_LAST))
+
 /*
  * Returns the actual register address for all NAND_DEV_ registers
  * (i.e. NAND_DEV_CMD0, NAND_DEV_CMD1, NAND_DEV_CMD2 and NAND_DEV_CMD_VLD)
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
@@ -719,9 +741,14 @@ static void update_rw_regs(struct qcom_nand_host *host, int num_cw, bool read)
 	nandc_set_reg(nandc, NAND_READ_STATUS, host->clrreadstatus);
 	nandc_set_reg(nandc, NAND_EXEC_CMD, 1);
 
-	if (read)
-		nandc_set_read_loc(nandc, 0, 0, host->use_ecc ?
-				   host->cw_data : host->cw_size, 1);
+	if (read) {
+		if (nandc->props->qpic_v2)
+			nandc_set_read_loc_last(nandc, 0, 0, host->use_ecc ?
+					host->cw_data : host->cw_size, 1);
+		else
+			nandc_set_read_loc(nandc, 0, 0, host->use_ecc ?
+					host->cw_data : host->cw_size, 1);
+	}
 }
 
 /*
@@ -1094,11 +1121,16 @@ static void config_nand_page_read(struct qcom_nand_controller *nandc)
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
@@ -1118,10 +1150,10 @@ config_nand_cw_read(struct qcom_nand_controller *nandc, bool use_ecc)
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
@@ -1215,7 +1247,7 @@ static int nandc_param(struct qcom_nand_host *host)
 	nandc->buf_count = 512;
 	memset(nandc->data_buffer, 0xff, nandc->buf_count);
 
-	config_nand_single_cw_page_read(nandc, false);
+	config_nand_single_cw_page_read(nandc, false, false);
 
 	read_data_dma(nandc, FLASH_BUF_ACC, nandc->data_buffer,
 		      nandc->buf_count, 0);
@@ -1633,19 +1665,32 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, struct nand_chip *chip,
 	}
 
 	if (nandc->props->is_bam) {
-		nandc_set_read_loc(nandc, 0, read_loc, data_size1, 0);
-		read_loc += data_size1;
+		if (nandc->props->qpic_v2 && cw == (ecc->steps - 1)) {
+			nandc_set_read_loc_last(nandc, 0, read_loc, data_size1, 0);
+			read_loc += data_size1;
+
+			nandc_set_read_loc_last(nandc, 1, read_loc, oob_size1, 0);
+			read_loc += oob_size1;
 
-		nandc_set_read_loc(nandc, 1, read_loc, oob_size1, 0);
-		read_loc += oob_size1;
+			nandc_set_read_loc_last(nandc, 2, read_loc, data_size2, 0);
+			read_loc += data_size2;
 
-		nandc_set_read_loc(nandc, 2, read_loc, data_size2, 0);
-		read_loc += data_size2;
+			nandc_set_read_loc_last(nandc, 3, read_loc, oob_size2, 1);
+		} else {
+			nandc_set_read_loc(nandc, 0, read_loc, data_size1, 0);
+			read_loc += data_size1;
+
+			nandc_set_read_loc(nandc, 1, read_loc, oob_size1, 0);
+			read_loc += oob_size1;
 
-		nandc_set_read_loc(nandc, 3, read_loc, oob_size2, 1);
+			nandc_set_read_loc(nandc, 2, read_loc, data_size2, 0);
+			read_loc += data_size2;
+
+			nandc_set_read_loc(nandc, 3, read_loc, oob_size2, 1);
+		}
 	}
 
-	config_nand_cw_read(nandc, false);
+	config_nand_cw_read(nandc, false, cw == ecc->steps - 1 ? true : false);
 
 	read_data_dma(nandc, reg_off, data_buf, data_size1, 0);
 	reg_off += data_size1;
@@ -1873,18 +1918,31 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
 
 		if (nandc->props->is_bam) {
 			if (data_buf && oob_buf) {
-				nandc_set_read_loc(nandc, 0, 0, data_size, 0);
-				nandc_set_read_loc(nandc, 1, data_size,
-						   oob_size, 1);
+				if (nandc->props->qpic_v2 && i == (ecc->steps - 1)) {
+					nandc_set_read_loc_last(nandc, 0, 0, data_size, 0);
+					nandc_set_read_loc_last(nandc, 1, data_size,
+								oob_size, 1);
+				} else {
+					nandc_set_read_loc(nandc, 0, 0, data_size, 0);
+					nandc_set_read_loc(nandc, 1, data_size,
+							   oob_size, 1);
+				}
 			} else if (data_buf) {
-				nandc_set_read_loc(nandc, 0, 0, data_size, 1);
+				if (nandc->props->qpic_v2 && i == (ecc->steps - 1))
+					nandc_set_read_loc_last(nandc, 0, 0, data_size, 1);
+				else
+					nandc_set_read_loc(nandc, 0, 0, data_size, 1);
 			} else {
-				nandc_set_read_loc(nandc, 0, data_size,
-						   oob_size, 1);
+				if (nandc->props->qpic_v2 && i == (ecc->steps - 1))
+					nandc_set_read_loc_last(nandc, 0, data_size,
+								oob_size, 1);
+				else
+					nandc_set_read_loc(nandc, 0, data_size,
+							   oob_size, 1);
 			}
 		}
 
-		config_nand_cw_read(nandc, true);
+		config_nand_cw_read(nandc, true, i == ecc->steps - 1 ? true : false);
 
 		if (data_buf)
 			read_data_dma(nandc, FLASH_BUF_ACC, data_buf,
@@ -1946,7 +2004,7 @@ static int copy_last_cw(struct qcom_nand_host *host, int page)
 	set_address(host, host->cw_size * (ecc->steps - 1), page);
 	update_rw_regs(host, 1, true);
 
-	config_nand_single_cw_page_read(nandc, host->use_ecc);
+	config_nand_single_cw_page_read(nandc, host->use_ecc, true);
 
 	read_data_dma(nandc, FLASH_BUF_ACC, nandc->data_buffer, size, 0);
 
-- 
2.7.4

