Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E16139DB44
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 13:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhFGL3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 07:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbhFGL3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 07:29:43 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88985C061787
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 04:27:52 -0700 (PDT)
Received: from mwalle01.fritz.box (ip4d17858c.dynamic.kabel-deutschland.de [77.23.133.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 953892224B;
        Mon,  7 Jun 2021 13:27:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1623065270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QTGOuq0Tp1H1o8U2iUjRUlYX6F/stIxQslHbe9vhQ+E=;
        b=NVcqAo8x1MVfaVGPUINY/ET7nLeIku9B8jbZmEFC7Aqcq2265DoAORl0MSBqaEaPNv9VpZ
        5t/+VkCpn2Y6AKIHU4bfgbWGclyM3YJeNUOgUk1+g3X1eQeN3hyeaD+HIktrHD4hkptTXx
        tW41bO7hQqHGS+Hkf+ZAyRCfQjF0od4=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v6 2/4] mtd: spi-nor: otp: use more consistent wording
Date:   Mon,  7 Jun 2021 13:27:42 +0200
Message-Id: <20210607112744.21587-3-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210607112744.21587-1-michael@walle.cc>
References: <20210607112744.21587-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the wording as used in the datasheet to describe the access methods
of the security registers (aka OTP storage). This will also match the
function names.

Signed-off-by: Michael Walle <michael@walle.cc>
Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/otp.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/spi-nor/otp.c b/drivers/mtd/spi-nor/otp.c
index 91a4c510ed51..3898ed67ba1c 100644
--- a/drivers/mtd/spi-nor/otp.c
+++ b/drivers/mtd/spi-nor/otp.c
@@ -15,14 +15,21 @@
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
+ * Read a security register by using the SPINOR_OP_RSECR commands.
+ *
+ * In Winbond/GigaDevice datasheets the term "security register" stands for
+ * an one-time-programmable memory area, consisting of multiple bytes (usually
+ * 256). Thus one "security register" maps to one OTP region.
+ *
+ * This method is used on GigaDevice and Winbond flashes.
+ *
+ * Please note, the read must not span multiple registers.
  *
  * Return: number of bytes read successfully, -errno otherwise
  */
@@ -56,16 +63,20 @@ int spi_nor_otp_read_secr(struct spi_nor *nor, loff_t addr, size_t len, u8 *buf)
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
+ * Write a security register by using the SPINOR_OP_PSECR commands.
+ *
+ * For more information on the term "security register", see the documentation
+ * of spi_nor_otp_read_secr().
+ *
+ * This method is used on GigaDevice and Winbond flashes.
  *
- * Please note, the write must not span multiple OTP regions.
+ * Please note, the write must not span multiple registers.
  *
  * Return: number of bytes written successfully, -errno otherwise
  */
@@ -88,7 +99,7 @@ int spi_nor_otp_write_secr(struct spi_nor *nor, loff_t addr, size_t len,
 
 	/*
 	 * We only support a write to one single page. For now all winbond
-	 * flashes only have one page per OTP region.
+	 * flashes only have one page per security register.
 	 */
 	ret = spi_nor_write_enable(nor);
 	if (ret)
-- 
2.20.1

