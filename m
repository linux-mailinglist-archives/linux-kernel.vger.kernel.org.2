Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0F130982C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 21:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbhA3UIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 15:08:21 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:40468 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbhA3UIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 15:08:20 -0500
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 30 Jan 2021 12:07:39 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 30 Jan 2021 12:07:38 -0800
X-QCInternal: smtphost
Received: from mdalam-linux.qualcomm.com ([10.201.2.71])
  by ironmsg01-blr.qualcomm.com with ESMTP; 31 Jan 2021 01:37:19 +0530
Received: by mdalam-linux.qualcomm.com (Postfix, from userid 466583)
        id 1C76821C96; Sun, 31 Jan 2021 01:37:19 +0530 (IST)
From:   Md Sadre Alam <mdalam@codeaurora.org>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        boris.brezillon@collabora.com, manivannan.sadhasivam@linaro.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mdalam@codeaurora.org, sricharan@codeaurora.org
Subject: [PATCH] mtd: rawnand: qcom: Update register macro name for 0x2c offset
Date:   Sun, 31 Jan 2021 01:37:16 +0530
Message-Id: <1612037236-7954-1-git-send-email-mdalam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change will remove unused register name macro NAND_DEV1_ECC_CFG.
Since this register was only available in QPIC version 1.4.20 ipq40xx
and it was not used. In QPIC version 1.5 on wards this register got
removed.In QPIC version 2.0 0x2c offset is updated with register
NAND_AUTO_STATUS_EN So adding this register macro NAND_AUTO_STATUS_EN
with offset 0x2c.

Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
---
 drivers/mtd/nand/raw/qcom_nandc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 9484be8..c238a35 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -27,7 +27,7 @@
 #define	NAND_DEV0_CFG0			0x20
 #define	NAND_DEV0_CFG1			0x24
 #define	NAND_DEV0_ECC_CFG		0x28
-#define	NAND_DEV1_ECC_CFG		0x2c
+#define	NAND_AUTO_STATUS_EN		0x2c
 #define	NAND_DEV1_CFG0			0x30
 #define	NAND_DEV1_CFG1			0x34
 #define	NAND_READ_ID			0x40
-- 
2.7.4

