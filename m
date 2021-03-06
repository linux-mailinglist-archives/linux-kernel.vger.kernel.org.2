Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FED732F71B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 01:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhCFAGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 19:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhCFAFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 19:05:50 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBC2C061760
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 16:05:50 -0800 (PST)
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 7AEBD22253;
        Sat,  6 Mar 2021 01:05:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1614989147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=weTdU66tSCxLJBT01o5XqtCOf1ThA21CkumoJ/idyVo=;
        b=t3UmZa/7Ewtr6aYTqTRXnKoo+EPvciYUfLJBZ7XSYGzRVTGjqXD+PLeJ4BuHCdG615EzMQ
        VbsSLlCrP3HBpw4TqMF8hNsUNzHmGPNxvuX1FAkMpRjYSRU+4aIyCiHKMMEygyYB92RcXm
        OqlFDBpyh4R+YL5fAyH4jFxjwgQSpU8=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v4 3/4] mtd: spi-nor: winbond: add OTP support to w25q32fw/jw
Date:   Sat,  6 Mar 2021 01:05:34 +0100
Message-Id: <20210306000535.9890-4-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210306000535.9890-1-michael@walle.cc>
References: <20210306000535.9890-1-michael@walle.cc>
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
index e5dfa786f190..9a3f8ff007fd 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -55,14 +55,18 @@ static const struct flash_info winbond_parts[] = {
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
@@ -131,9 +135,18 @@ static int winbond_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
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

