Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF52314E19
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 12:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhBILRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 06:17:48 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:24071 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbhBILM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 06:12:26 -0500
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 09 Feb 2021 03:11:42 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 09 Feb 2021 03:11:40 -0800
X-QCInternal: smtphost
Received: from mdalam-linux.qualcomm.com ([10.201.2.71])
  by ironmsg01-blr.qualcomm.com with ESMTP; 09 Feb 2021 16:41:23 +0530
Received: by mdalam-linux.qualcomm.com (Postfix, from userid 466583)
        id 85D0E211AC; Tue,  9 Feb 2021 16:41:22 +0530 (IST)
From:   Md Sadre Alam <mdalam@codeaurora.org>
To:     tudor.ambarus@microchip.com, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mdalam@codeaurora.org, sricharan@codeaurora.org
Subject: [PATCH] mtd: spi-nor: gigadevice: Add support for gd25lb256e
Date:   Tue,  9 Feb 2021 16:41:19 +0530
Message-Id: <1612869079-19593-1-git-send-email-mdalam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for gd25lb256e. This device tested on IPQ5018
platform with dd from/to the flash for read/write respectly,
and mtd erase for erasing the flash.

Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
---
 drivers/mtd/spi-nor/gigadevice.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/spi-nor/gigadevice.c b/drivers/mtd/spi-nor/gigadevice.c
index 447d84b..8f1e7ec 100644
--- a/drivers/mtd/spi-nor/gigadevice.c
+++ b/drivers/mtd/spi-nor/gigadevice.c
@@ -50,6 +50,9 @@ static const struct flash_info gigadevice_parts[] = {
 			   SPI_NOR_4B_OPCODES | SPI_NOR_HAS_LOCK |
 			   SPI_NOR_HAS_TB | SPI_NOR_TB_SR_BIT6)
 		.fixups = &gd25q256_fixups },
+	{ "gd25lb256e", INFO(0xc86719, 0, 64 * 1024, 512,
+			  SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			  SPI_NOR_4B_OPCODES) },
 };
 
 const struct spi_nor_manufacturer spi_nor_gigadevice = {
-- 
2.7.4

