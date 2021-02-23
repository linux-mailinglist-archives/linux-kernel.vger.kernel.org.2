Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF95323190
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 20:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbhBWTlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 14:41:03 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:53559 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbhBWTkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 14:40:49 -0500
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 23 Feb 2021 11:39:27 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 23 Feb 2021 11:39:26 -0800
X-QCInternal: smtphost
Received: from mdalam-linux.qualcomm.com ([10.201.2.71])
  by ironmsg02-blr.qualcomm.com with ESMTP; 24 Feb 2021 01:09:10 +0530
Received: by mdalam-linux.qualcomm.com (Postfix, from userid 466583)
        id 651A420E1F; Wed, 24 Feb 2021 01:09:10 +0530 (IST)
From:   Md Sadre Alam <mdalam@codeaurora.org>
To:     miquel.raynal@bootlin.com, mani@kernel.org,
        boris.brezillon@collabora.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mdalam@codeaurora.org, sricharan@codeaurora.org
Subject: [PATCH 4/5] mtd: rawnand: qcom: Add helper to configure location register
Date:   Wed, 24 Feb 2021 01:09:00 +0530
Message-Id: <1614109141-7531-4-git-send-email-mdalam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614109141-7531-1-git-send-email-mdalam@codeaurora.org>
References: <1614109141-7531-1-git-send-email-mdalam@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a nandc_set_read_loc() helper to abstract the
configuration of the location register.

QPIC v2 onwards features a separate location register
for the last codeword, so introducing this extra helper
which will simplify the addition of QPIC v2 support.

Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
---
 drivers/mtd/nand/raw/qcom_nandc.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index f1aafee..57d2ad02 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -181,8 +181,8 @@
 #define	ECC_BCH_4BIT	BIT(2)
 #define	ECC_BCH_8BIT	BIT(3)
 
-#define nandc_set_read_loc(chip, reg, cw_offset, read_size, is_last_read_loc)	\
-nandc_set_reg(chip, NAND_READ_LOCATION_##reg,			\
+#define nandc_set_read_loc_first(chip, reg, cw_offset, read_size, is_last_read_loc)	\
+nandc_set_reg(chip, reg,			\
 	      ((cw_offset) << READ_LOCATION_OFFSET) |		\
 	      ((read_size) << READ_LOCATION_SIZE) |			\
 	      ((is_last_read_loc) << READ_LOCATION_LAST))
@@ -668,6 +668,18 @@ static bool qcom_nandc_is_last_cw(struct nand_ecc_ctrl *ecc, int cw)
 	return cw == (ecc->steps - 1);
 }
 
+/* helper to configure location register values */
+static void nandc_set_read_loc(struct nand_chip *chip, int cw, int reg,
+			       int cw_offset, int read_size, int is_last_read_loc)
+{
+	int reg_base = NAND_READ_LOCATION_0;
+
+	reg_base += reg * 4;
+
+	return nandc_set_read_loc_first(chip, reg_base, cw_offset,
+			read_size, is_last_read_loc);
+}
+
 /* helper to configure address register values */
 static void set_address(struct qcom_nand_host *host, u16 column, int page)
 {
@@ -725,7 +737,7 @@ static void update_rw_regs(struct qcom_nand_host *host, int num_cw, bool read)
 	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
 
 	if (read)
-		nandc_set_read_loc(chip, 0, 0, host->use_ecc ?
+		nandc_set_read_loc(chip, 0, 0, 0, host->use_ecc ?
 				   host->cw_data : host->cw_size, 1);
 }
 
@@ -1218,7 +1230,7 @@ static int nandc_param(struct qcom_nand_host *host)
 		nandc_set_reg(chip, NAND_DEV_CMD_VLD_RESTORE, nandc->vld);
 	}
 
-	nandc_set_read_loc(chip, 0, 0, 512, 1);
+	nandc_set_read_loc(chip, 0, 0, 0, 512, 1);
 
 	if (!nandc->props->qpic_v2) {
 		write_reg_dma(nandc, NAND_DEV_CMD_VLD, 1, 0);
@@ -1646,16 +1658,16 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, struct nand_chip *chip,
 	}
 
 	if (nandc->props->is_bam) {
-		nandc_set_read_loc(chip, 0, read_loc, data_size1, 0);
+		nandc_set_read_loc(chip, cw, 0, read_loc, data_size1, 0);
 		read_loc += data_size1;
 
-		nandc_set_read_loc(chip, 1, read_loc, oob_size1, 0);
+		nandc_set_read_loc(chip, cw, 1, read_loc, oob_size1, 0);
 		read_loc += oob_size1;
 
-		nandc_set_read_loc(chip, 2, read_loc, data_size2, 0);
+		nandc_set_read_loc(chip, cw, 2, read_loc, data_size2, 0);
 		read_loc += data_size2;
 
-		nandc_set_read_loc(chip, 3, read_loc, oob_size2, 1);
+		nandc_set_read_loc(chip, cw, 3, read_loc, oob_size2, 1);
 	}
 
 	config_nand_cw_read(chip, false);
@@ -1886,13 +1898,13 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
 
 		if (nandc->props->is_bam) {
 			if (data_buf && oob_buf) {
-				nandc_set_read_loc(chip, 0, 0, data_size, 0);
-				nandc_set_read_loc(chip, 1, data_size,
+				nandc_set_read_loc(chip, i, 0, 0, data_size, 0);
+				nandc_set_read_loc(chip, i, 1, data_size,
 						   oob_size, 1);
 			} else if (data_buf) {
-				nandc_set_read_loc(chip, 0, 0, data_size, 1);
+				nandc_set_read_loc(chip, i, 0, 0, data_size, 1);
 			} else {
-				nandc_set_read_loc(chip, 0, data_size,
+				nandc_set_read_loc(chip, i, 0, data_size,
 						   oob_size, 1);
 			}
 		}
-- 
2.7.4

