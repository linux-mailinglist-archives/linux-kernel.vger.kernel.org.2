Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8525321AC6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 16:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbhBVPHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 10:07:10 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:8745 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbhBVPGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 10:06:48 -0500
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 22 Feb 2021 07:06:06 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 22 Feb 2021 07:06:04 -0800
X-QCInternal: smtphost
Received: from mdalam-linux.qualcomm.com ([10.201.2.71])
  by ironmsg02-blr.qualcomm.com with ESMTP; 22 Feb 2021 20:35:45 +0530
Received: by mdalam-linux.qualcomm.com (Postfix, from userid 466583)
        id 7279421DA8; Mon, 22 Feb 2021 20:35:45 +0530 (IST)
From:   Md Sadre Alam <mdalam@codeaurora.org>
To:     miquel.raynal@bootlin.com, mani@kernel.org,
        boris.brezillon@collabora.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mdalam@codeaurora.org, sricharan@codeaurora.org
Subject: [PATCH] mtd: rawnand: qcom: Add helper to configure location register
Date:   Mon, 22 Feb 2021 20:35:43 +0530
Message-Id: <1614006343-5947-1-git-send-email-mdalam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change will add helper nandc_set_read_loc() to configure
location register value. QPIC V2 on wards there is separate
location register to read the last code word. This helper
will use to configure location register for last code word
as well.

Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
---
 drivers/mtd/nand/raw/qcom_nandc.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index bfefb4e..82d083ad 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -181,8 +181,8 @@
 #define	ECC_BCH_4BIT	BIT(2)
 #define	ECC_BCH_8BIT	BIT(3)
 
-#define nandc_set_read_loc(nandc, reg, cw_offset, read_size, is_last_read_loc)	\
-nandc_set_reg(nandc, NAND_READ_LOCATION_##reg,			\
+#define nandc_set_read_loc_first(nandc, reg, cw_offset, read_size, is_last_read_loc)	\
+nandc_set_reg(nandc, reg,			\
 	      ((cw_offset) << READ_LOCATION_OFFSET) |		\
 	      ((read_size) << READ_LOCATION_SIZE) |			\
 	      ((is_last_read_loc) << READ_LOCATION_LAST))
@@ -667,6 +667,20 @@ static bool qcom_nandc_is_last_cw(struct nand_ecc_ctrl *ecc, int cw)
 	return cw == (ecc->steps - 1);
 }
 
+/* helper to configure location register values */
+static void nandc_set_read_loc(struct nand_chip *chip, int cw, int reg,
+			       int cw_offset, int read_size, int is_last_read_loc)
+{
+	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
+
+	int reg_base = NAND_READ_LOCATION_0;
+
+	reg_base += reg * 4;
+
+	return nandc_set_read_loc_first(nandc, reg_base, cw_offset,
+			read_size, is_last_read_loc);
+}
+
 /* helper to configure address register values */
 static void set_address(struct qcom_nand_host *host, u16 column, int page)
 {
@@ -726,7 +740,7 @@ static void update_rw_regs(struct qcom_nand_host *host, int num_cw, bool read)
 	nandc_set_reg(nandc, NAND_EXEC_CMD, 1);
 
 	if (read)
-		nandc_set_read_loc(nandc, 0, 0, host->use_ecc ?
+		nandc_set_read_loc(chip, 0, 0, 0, host->use_ecc ?
 				   host->cw_data : host->cw_size, 1);
 }
 
@@ -1221,7 +1235,7 @@ static int nandc_param(struct qcom_nand_host *host)
 		nandc_set_reg(nandc, NAND_DEV_CMD_VLD_RESTORE, nandc->vld);
 	}
 
-	nandc_set_read_loc(nandc, 0, 0, 512, 1);
+	nandc_set_read_loc(chip, 0, 0, 0, 512, 1);
 
 	if (!nandc->props->qpic_v2) {
 		write_reg_dma(nandc, NAND_DEV_CMD_VLD, 1, 0);
@@ -1649,16 +1663,16 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, struct nand_chip *chip,
 	}
 
 	if (nandc->props->is_bam) {
-		nandc_set_read_loc(nandc, 0, read_loc, data_size1, 0);
+		nandc_set_read_loc(chip, cw, 0, read_loc, data_size1, 0);
 		read_loc += data_size1;
 
-		nandc_set_read_loc(nandc, 1, read_loc, oob_size1, 0);
+		nandc_set_read_loc(chip, cw, 1, read_loc, oob_size1, 0);
 		read_loc += oob_size1;
 
-		nandc_set_read_loc(nandc, 2, read_loc, data_size2, 0);
+		nandc_set_read_loc(chip, cw, 2, read_loc, data_size2, 0);
 		read_loc += data_size2;
 
-		nandc_set_read_loc(nandc, 3, read_loc, oob_size2, 1);
+		nandc_set_read_loc(chip, cw, 3, read_loc, oob_size2, 1);
 	}
 
 	config_nand_cw_read(chip, false);
@@ -1889,13 +1903,13 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
 
 		if (nandc->props->is_bam) {
 			if (data_buf && oob_buf) {
-				nandc_set_read_loc(nandc, 0, 0, data_size, 0);
-				nandc_set_read_loc(nandc, 1, data_size,
+				nandc_set_read_loc(chip, i, 0, 0, data_size, 0);
+				nandc_set_read_loc(chip, i, 1, data_size,
 						   oob_size, 1);
 			} else if (data_buf) {
-				nandc_set_read_loc(nandc, 0, 0, data_size, 1);
+				nandc_set_read_loc(chip, i, 0, 0, data_size, 1);
 			} else {
-				nandc_set_read_loc(nandc, 0, data_size,
+				nandc_set_read_loc(chip, i, 0, data_size,
 						   oob_size, 1);
 			}
 		}
-- 
2.7.4

