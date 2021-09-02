Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB1F3FE8E3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 07:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbhIBFuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 01:50:39 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:37007 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbhIBFui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 01:50:38 -0400
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 01 Sep 2021 22:49:39 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 01 Sep 2021 22:49:38 -0700
X-QCInternal: smtphost
Received: from mdalam-linux.qualcomm.com ([10.201.2.71])
  by ironmsg01-blr.qualcomm.com with ESMTP; 02 Sep 2021 11:19:27 +0530
Received: by mdalam-linux.qualcomm.com (Postfix, from userid 466583)
        id CA1A922372; Thu,  2 Sep 2021 11:19:25 +0530 (IST)
From:   Md Sadre Alam <mdalam@codeaurora.org>
To:     miquel.raynal@bootlin.com, mani@kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mdalam@codeaurora.org, sricharan@codeaurora.org, stable@kernel.org
Subject: [PATCH V4] mtd: rawnand: qcom: Update code word value for raw read
Date:   Thu,  2 Sep 2021 11:19:23 +0530
Message-Id: <1630561763-18486-1-git-send-email-mdalam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From QPIC V2 onwards there is a separate register to read
last code word "QPIC_NAND_READ_LOCATION_LAST_CW_n".

qcom_nandc_read_cw_raw() is used to read only one code word
at a time. If we will configure number of code words to 1 in
in QPIC_NAND_DEV0_CFG0 register then QPIC controller thinks
its reading the last code word, since from QPIC V2 onwards
we are having separate register to read the last code word,
we have to configure "QPIC_NAND_READ_LOCATION_LAST_CW_n"
register to fetch data from controller buffer to system
memory.

Fixes: 503ee5aa ("mtd: rawnand: qcom: update last code word register")
Cc: stable@kernel.org
Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
---
[V4]
 * Added commit message
 * Added changelog

 In commit 503ee5aa added QPIC V2 support. Since QPIC V2 onwards there
 is separate register to get last CW data. If total number of CW configred is 1 
 then , QPIC controller treat this as last CW and software shhould copy data to memory
 via QPIC_NAND_READ_LOCATION_LAST_CW_n register instead of QPIC_NAND_READ_LOCATION_n.
 Since in raw read we are configuring total number of CW 1, this change fixes
 this if total number of CW 1 then make this as last CW.  raw_cw = ecc->steps - 1;
 since ecc->steps holds total number of CWs.

 drivers/mtd/nand/raw/qcom_nandc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index ef0bade..04e6f7b 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -1676,13 +1676,17 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, struct nand_chip *chip,
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	int data_size1, data_size2, oob_size1, oob_size2;
 	int ret, reg_off = FLASH_BUF_ACC, read_loc = 0;
+	int raw_cw = cw;
 
 	nand_read_page_op(chip, page, 0, NULL, 0);
 	host->use_ecc = false;
 
+	if (nandc->props->qpic_v2)
+		raw_cw = ecc->steps - 1;
+
 	clear_bam_transaction(nandc);
 	set_address(host, host->cw_size * cw, page);
-	update_rw_regs(host, 1, true, cw);
+	update_rw_regs(host, 1, true, raw_cw);
 	config_nand_page_read(chip);
 
 	data_size1 = mtd->writesize - host->cw_size * (ecc->steps - 1);
@@ -1711,7 +1715,7 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, struct nand_chip *chip,
 		nandc_set_read_loc(chip, cw, 3, read_loc, oob_size2, 1);
 	}
 
-	config_nand_cw_read(chip, false, cw);
+	config_nand_cw_read(chip, false, raw_cw);
 
 	read_data_dma(nandc, reg_off, data_buf, data_size1, 0);
 	reg_off += data_size1;
-- 
2.7.4

