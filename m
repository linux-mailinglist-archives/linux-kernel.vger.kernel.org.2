Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4DF3435D3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 00:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhCUXwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 19:52:13 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:48919 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhCUXvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 19:51:50 -0400
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id DBBC922253;
        Mon, 22 Mar 2021 00:51:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1616370709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7pVgZhYEGnaY7ZyodtaxdbrPf8RrPat3Gjq9g+Zbg9g=;
        b=On6P/TW4uuPZWXKyBGd6I6RdKokSF2yYPaP/OannPEgOS4y+CAaBsGCXJOFTzldTRCqjrn
        UVjAXyW2BI3NTt7kDXavoknFRQVHdY0mEXsL9KewJw9tZNHu9/j4aluR5mIH0uMjSEub6p
        sl5VRv5U5SFIBwDY00dCKVeJTJtbZIM=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v5 3/3] mtd: spi-nor: winbond: add OTP support to w25q32fw/jw
Date:   Mon, 22 Mar 2021 00:51:40 +0100
Message-Id: <20210321235140.8308-4-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210321235140.8308-1-michael@walle.cc>
References: <20210321235140.8308-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With all the helper functions in place, add OTP support for the Winbond
W25Q32JW and W25Q32FW.

Both were tested on a LS1028A SoC with a NXP FSPI controller.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/winbond.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index 20b2c6f19d6f..9a81c67a60c6 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -54,14 +54,18 @@ static const struct flash_info winbond_parts[] = {
 	{ "w25q32", INFO(0xef4016, 0, 64 * 1024,  64, SECT_4K) },
 	{ "w25q32dw", INFO(0xef6016, 0, 64 * 1024,  64,
 			   SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			   SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
+			   SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
+			   OTP_INFO(256, 3, 0x1000, 0x1000)
+	},
+
 	{ "w25q32jv", INFO(0xef7016, 0, 64 * 1024,  64,
 			   SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
 			   SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
 	},
 	{ "w25q32jwm", INFO(0xef8016, 0, 64 * 1024,  64,
 			    SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			    SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
+			    SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
+			    OTP_INFO(256, 3, 0x1000, 0x1000) },
 	{ "w25q64jwm", INFO(0xef8017, 0, 64 * 1024, 128,
 			    SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
 			    SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
@@ -132,9 +136,18 @@ static int winbond_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
 	return spi_nor_write_disable(nor);
 }
 
+static const struct spi_nor_otp_ops winbond_otp_ops = {
+	.read = spi_nor_otp_read_secr,
+	.write = spi_nor_otp_write_secr,
+	.lock = spi_nor_otp_lock_sr2,
+	.is_locked = spi_nor_otp_is_locked_sr2,
+};
+
 static void winbond_default_init(struct spi_nor *nor)
 {
 	nor->params->set_4byte_addr_mode = winbond_set_4byte_addr_mode;
+	if (nor->params->otp.org->n_regions)
+		nor->params->otp.ops = &winbond_otp_ops;
 }
 
 static const struct spi_nor_fixups winbond_fixups = {
-- 
2.20.1

