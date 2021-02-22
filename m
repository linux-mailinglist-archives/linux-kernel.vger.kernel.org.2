Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AACD9321174
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 08:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhBVHgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 02:36:48 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:24324 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbhBVHgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 02:36:43 -0500
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 21 Feb 2021 23:36:03 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 21 Feb 2021 23:36:01 -0800
X-QCInternal: smtphost
Received: from mdalam-linux.qualcomm.com ([10.201.2.71])
  by ironmsg01-blr.qualcomm.com with ESMTP; 22 Feb 2021 13:05:46 +0530
Received: by mdalam-linux.qualcomm.com (Postfix, from userid 466583)
        id 8E8BC21DA8; Mon, 22 Feb 2021 13:05:44 +0530 (IST)
From:   Md Sadre Alam <mdalam@codeaurora.org>
To:     miquel.raynal@bootlin.com, mani@kernel.org,
        boris.brezillon@collabora.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Md Sadre Alam <mdalam@codeaurora.org>
Subject: [PATCH] mtd: rawnand: qcom: Rename parameter name in macro
Date:   Mon, 22 Feb 2021 13:05:42 +0530
Message-Id: <1613979342-23572-1-git-send-email-mdalam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change will rename parameter name in macro
nandc_set_read_loc().renamed parameter names are
cw_offset, read_size, is_last_read_loc.
Sinc in QPIC V2 on-wards there is separate location
register to read last code word, so to just differnciate
b/w is_last_read_loc from last_cw this change needed.

Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
---
 drivers/mtd/nand/raw/qcom_nandc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 4189a7f..bfefb4e 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -181,11 +181,11 @@
 #define	ECC_BCH_4BIT	BIT(2)
 #define	ECC_BCH_8BIT	BIT(3)
 
-#define nandc_set_read_loc(nandc, reg, offset, size, is_last)	\
+#define nandc_set_read_loc(nandc, reg, cw_offset, read_size, is_last_read_loc)	\
 nandc_set_reg(nandc, NAND_READ_LOCATION_##reg,			\
-	      ((offset) << READ_LOCATION_OFFSET) |		\
-	      ((size) << READ_LOCATION_SIZE) |			\
-	      ((is_last) << READ_LOCATION_LAST))
+	      ((cw_offset) << READ_LOCATION_OFFSET) |		\
+	      ((read_size) << READ_LOCATION_SIZE) |			\
+	      ((is_last_read_loc) << READ_LOCATION_LAST))
 
 /*
  * Returns the actual register address for all NAND_DEV_ registers
-- 
2.7.4

