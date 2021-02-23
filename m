Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5AEA323192
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 20:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbhBWTlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 14:41:16 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:29750 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbhBWTk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 14:40:56 -0500
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 23 Feb 2021 11:39:28 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 23 Feb 2021 11:39:27 -0800
X-QCInternal: smtphost
Received: from mdalam-linux.qualcomm.com ([10.201.2.71])
  by ironmsg02-blr.qualcomm.com with ESMTP; 24 Feb 2021 01:09:06 +0530
Received: by mdalam-linux.qualcomm.com (Postfix, from userid 466583)
        id 0340A20E1F; Wed, 24 Feb 2021 01:09:05 +0530 (IST)
From:   Md Sadre Alam <mdalam@codeaurora.org>
To:     miquel.raynal@bootlin.com, mani@kernel.org,
        boris.brezillon@collabora.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mdalam@codeaurora.org, sricharan@codeaurora.org
Subject: [PATCH 2/5] mtd: rawnand: qcom: Add helper to check last code word
Date:   Wed, 24 Feb 2021 01:08:58 +0530
Message-Id: <1614109141-7531-2-git-send-email-mdalam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614109141-7531-1-git-send-email-mdalam@codeaurora.org>
References: <1614109141-7531-1-git-send-email-mdalam@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the qcom_nandc_is_last_cw() helper which checks if
the input cw index is the last one or not.

Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
---
 drivers/mtd/nand/raw/qcom_nandc.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 4898d32..9a890ef 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -662,6 +662,12 @@ static void nandc_set_reg(struct nand_chip *chip, int offset,
 		*reg = cpu_to_le32(val);
 }
 
+/* Helper to check the code word, whether it is last cw or not */
+static bool qcom_nandc_is_last_cw(struct nand_ecc_ctrl *ecc, int cw)
+{
+	return cw == (ecc->steps - 1);
+}
+
 /* helper to configure address register values */
 static void set_address(struct qcom_nand_host *host, u16 column, int page)
 {
@@ -1629,7 +1635,7 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, struct nand_chip *chip,
 	data_size1 = mtd->writesize - host->cw_size * (ecc->steps - 1);
 	oob_size1 = host->bbm_size;
 
-	if (cw == (ecc->steps - 1)) {
+	if (qcom_nandc_is_last_cw(ecc, cw)) {
 		data_size2 = ecc->size - data_size1 -
 			     ((ecc->steps - 1) * 4);
 		oob_size2 = (ecc->steps * 4) + host->ecc_bytes_hw +
@@ -1710,7 +1716,7 @@ check_for_erased_page(struct qcom_nand_host *host, u8 *data_buf,
 	}
 
 	for_each_set_bit(cw, &uncorrectable_cws, ecc->steps) {
-		if (cw == (ecc->steps - 1)) {
+		if (qcom_nandc_is_last_cw(ecc, cw)) {
 			data_size = ecc->size - ((ecc->steps - 1) * 4);
 			oob_size = (ecc->steps * 4) + host->ecc_bytes_hw;
 		} else {
@@ -1770,7 +1776,7 @@ static int parse_read_errors(struct qcom_nand_host *host, u8 *data_buf,
 		u32 flash, buffer, erased_cw;
 		int data_len, oob_len;
 
-		if (i == (ecc->steps - 1)) {
+		if (qcom_nandc_is_last_cw(ecc, i)) {
 			data_len = ecc->size - ((ecc->steps - 1) << 2);
 			oob_len = ecc->steps << 2;
 		} else {
@@ -1869,7 +1875,7 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
 	for (i = 0; i < ecc->steps; i++) {
 		int data_size, oob_size;
 
-		if (i == (ecc->steps - 1)) {
+		if (qcom_nandc_is_last_cw(ecc, i)) {
 			data_size = ecc->size - ((ecc->steps - 1) << 2);
 			oob_size = (ecc->steps << 2) + host->ecc_bytes_hw +
 				   host->spare_bytes;
@@ -2048,7 +2054,7 @@ static int qcom_nandc_write_page(struct nand_chip *chip, const uint8_t *buf,
 	for (i = 0; i < ecc->steps; i++) {
 		int data_size, oob_size;
 
-		if (i == (ecc->steps - 1)) {
+		if (qcom_nandc_is_last_cw(ecc, i)) {
 			data_size = ecc->size - ((ecc->steps - 1) << 2);
 			oob_size = (ecc->steps << 2) + host->ecc_bytes_hw +
 				   host->spare_bytes;
@@ -2068,7 +2074,7 @@ static int qcom_nandc_write_page(struct nand_chip *chip, const uint8_t *buf,
 		 * itself. For the last codeword, we skip the bbm positions and
 		 * write to the free oob area.
 		 */
-		if (i == (ecc->steps - 1)) {
+		if (qcom_nandc_is_last_cw(ecc, i)) {
 			oob_buf += host->bbm_size;
 
 			write_data_dma(nandc, FLASH_BUF_ACC + data_size,
@@ -2123,7 +2129,7 @@ static int qcom_nandc_write_page_raw(struct nand_chip *chip,
 		data_size1 = mtd->writesize - host->cw_size * (ecc->steps - 1);
 		oob_size1 = host->bbm_size;
 
-		if (i == (ecc->steps - 1)) {
+		if (qcom_nandc_is_last_cw(ecc, i)) {
 			data_size2 = ecc->size - data_size1 -
 				     ((ecc->steps - 1) << 2);
 			oob_size2 = (ecc->steps << 2) + host->ecc_bytes_hw +
-- 
2.7.4

