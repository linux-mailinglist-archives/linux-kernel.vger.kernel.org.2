Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE86638B3D8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 17:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbhETQAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 12:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbhETQAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 12:00:25 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2309C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 08:59:03 -0700 (PDT)
Received: from mwalle01.fritz.box (ip4d17858c.dynamic.kabel-deutschland.de [77.23.133.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 7611622256;
        Thu, 20 May 2021 17:59:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1621526342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oMLJWICOr1vU7e/tL3zhEjEozu06hjLJr825CZwdaJ8=;
        b=g3Ph7HVi06ML5O/t2WNcyqQqisxNq1JyyTcggGbh84nPwErkNajFN+mRpfxdq6485yoxQc
        ILRbGkq6ztASnAuhNnd5/i7U9eWyM+uPx+IokFms3g2sgX7La6us1DyoCcXKalj4r2efTr
        p4RwTSkhJvuinmSQiS5YwwCB3yYwYZg=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v3 2/3] mtd: spi-nor: otp: use more consistent wording
Date:   Thu, 20 May 2021 17:58:53 +0200
Message-Id: <20210520155854.16547-3-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210520155854.16547-1-michael@walle.cc>
References: <20210520155854.16547-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the wording as used in the datasheet to describe the access methods
of the security registers (aka OTP storage). This will also match the
function names.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/otp.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/spi-nor/otp.c b/drivers/mtd/spi-nor/otp.c
index 91a4c510ed51..ec0c1b33f7cc 100644
--- a/drivers/mtd/spi-nor/otp.c
+++ b/drivers/mtd/spi-nor/otp.c
@@ -15,14 +15,16 @@
 #define spi_nor_otp_n_regions(nor) ((nor)->params->otp.org->n_regions)
 
 /**
- * spi_nor_otp_read_secr() - read OTP data
+ * spi_nor_otp_read_secr() - read security register
  * @nor:	pointer to 'struct spi_nor'
  * @addr:       offset to read from
  * @len:        number of bytes to read
  * @buf:        pointer to dst buffer
  *
- * Read OTP data from one region by using the SPINOR_OP_RSECR commands. This
- * method is used on GigaDevice and Winbond flashes.
+ * Read a security register by using the SPINOR_OP_RSECR commands. This method
+ * is used on GigaDevice and Winbond flashes to access OTP data.
+ *
+ * Please note, the read must not span multiple registers.
  *
  * Return: number of bytes read successfully, -errno otherwise
  */
@@ -56,16 +58,16 @@ int spi_nor_otp_read_secr(struct spi_nor *nor, loff_t addr, size_t len, u8 *buf)
 }
 
 /**
- * spi_nor_otp_write_secr() - write OTP data
+ * spi_nor_otp_write_secr() - write security register
  * @nor:        pointer to 'struct spi_nor'
  * @addr:       offset to write to
  * @len:        number of bytes to write
  * @buf:        pointer to src buffer
  *
- * Write OTP data to one region by using the SPINOR_OP_PSECR commands. This
- * method is used on GigaDevice and Winbond flashes.
+ * Write a security register by using the SPINOR_OP_PSECR commands. This method
+ * is used on GigaDevice and Winbond flashes to access OTP data.
  *
- * Please note, the write must not span multiple OTP regions.
+ * Please note, the write must not span multiple registers.
  *
  * Return: number of bytes written successfully, -errno otherwise
  */
@@ -88,7 +90,7 @@ int spi_nor_otp_write_secr(struct spi_nor *nor, loff_t addr, size_t len,
 
 	/*
 	 * We only support a write to one single page. For now all winbond
-	 * flashes only have one page per OTP region.
+	 * flashes only have one page per security register.
 	 */
 	ret = spi_nor_write_enable(nor);
 	if (ret)
-- 
2.20.1

