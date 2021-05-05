Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22BE3748F9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 22:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbhEEUB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 16:01:27 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:44979 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbhEEUBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 16:01:23 -0400
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id BDC6D22236;
        Wed,  5 May 2021 22:00:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1620244824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=N1BSknxA49h5IS27l3mw2cxZXI+1xejX5tUeLmyRBs4=;
        b=MMKqB9G7wt+dEJwdsG7rn8p6K3A2pTfkXhGwX1EF2JuhI79hNKUjx1Z35M/LwVkEuZh3Tl
        fJYCFNDY8iD4VSZKuyUruuKvePYEs+mi+fxR0w3nc/bAVsXQVVZsZeqwnkYFSoyM0GgZzV
        0uNCTb+pNXT2Ty3geqox40QKNpqVh3w=
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] mtd: spi-nor: otp: fix kerneldoc typos
Date:   Wed,  5 May 2021 22:00:17 +0200
Message-Id: <20210505200017.17499-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the correct argument names in the kerneldoc.

Reported-by: Pratyush Yadav <p.yadav@ti.com>
Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/otp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/otp.c b/drivers/mtd/spi-nor/otp.c
index fcf38d260345..61036c716abb 100644
--- a/drivers/mtd/spi-nor/otp.c
+++ b/drivers/mtd/spi-nor/otp.c
@@ -17,7 +17,7 @@
 /**
  * spi_nor_otp_read_secr() - read OTP data
  * @nor:	pointer to 'struct spi_nor'
- * @from:       offset to read from
+ * @addr:       offset to read from
  * @len:        number of bytes to read
  * @buf:        pointer to dst buffer
  *
@@ -59,7 +59,7 @@ int spi_nor_otp_read_secr(struct spi_nor *nor, loff_t addr, size_t len, u8 *buf)
 /**
  * spi_nor_otp_write_secr() - write OTP data
  * @nor:        pointer to 'struct spi_nor'
- * @to:         offset to write to
+ * @addr:       offset to write to
  * @len:        number of bytes to write
  * @buf:        pointer to src buffer
  *
-- 
2.20.1

