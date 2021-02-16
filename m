Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D581F31CE10
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 17:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhBPQ3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 11:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbhBPQ3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 11:29:00 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0400C061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 08:28:19 -0800 (PST)
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2CC5A2224B;
        Tue, 16 Feb 2021 17:28:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1613492895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rkN+nniRYpvJndybcr0+lP5hReUrf9dkbKOshU1axfc=;
        b=olotWwMJlr+NrtrcAxY2BbCHHThSwGe4b+3cWvWcr6YMMx2zsPrPR/JS/dcUNHPva/FotX
        thMP3CbdblCfs0AUBfAh8KUBiZe7wUIssNQYKnco9tdXyb6WZQP7+Up9RjCVAxkptxA/z8
        dKGle8mbA3NJyZtDuAxJDMvN7y3Qdu4=
From:   Michael Walle <michael@walle.cc>
To:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v3 2/2] mtd: spi-nor: implement OTP support for Winbond and similar flashes
Date:   Tue, 16 Feb 2021 17:28:07 +0100
Message-Id: <20210216162807.13509-3-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210216162807.13509-1-michael@walle.cc>
References: <20210216162807.13509-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new OTP ops to implement OTP access on Winbond flashes. Most
Winbond flashes provides up to four different OTP regions ("Security
Registers").

Winbond devices use a special opcode to read and write to the OTP
regions, just like the RDSFDP opcode. In fact, it seems that the
(undocumented) first OTP area of the newer flashes is the actual SFDP
table.

On a side note, Winbond devices also allow erasing the OTP regions as
long as the area isn't locked down.

This was tested on a Winbond W25Q32JW as well as on a W25Q32FW.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/core.c    |   2 +-
 drivers/mtd/spi-nor/core.h    |   6 ++
 drivers/mtd/spi-nor/otp.c     | 163 ++++++++++++++++++++++++++++++++++
 drivers/mtd/spi-nor/winbond.c |  17 +++-
 include/linux/mtd/spi-nor.h   |   9 ++
 5 files changed, 194 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index af9d7f194f01..1115046e2680 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1034,7 +1034,7 @@ static int spi_nor_write_16bit_sr_and_check(struct spi_nor *nor, u8 sr1)
  *
  * Return: 0 on success, -errno otherwise.
  */
-static int spi_nor_write_16bit_cr_and_check(struct spi_nor *nor, u8 cr)
+int spi_nor_write_16bit_cr_and_check(struct spi_nor *nor, u8 cr)
 {
 	int ret;
 	u8 *sr_cr = nor->bouncebuf;
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 5fb54ae08c5b..d755f2bf77e0 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -492,6 +492,7 @@ int spi_nor_read_sr(struct spi_nor *nor, u8 *sr);
 int spi_nor_read_cr(struct spi_nor *nor, u8 *cr);
 int spi_nor_write_sr(struct spi_nor *nor, const u8 *sr, size_t len);
 int spi_nor_write_sr_and_check(struct spi_nor *nor, u8 sr1);
+int spi_nor_write_16bit_cr_and_check(struct spi_nor *nor, u8 cr);
 
 int spi_nor_xread_sr(struct spi_nor *nor, u8 *sr);
 ssize_t spi_nor_read_data(struct spi_nor *nor, loff_t from, size_t len,
@@ -499,6 +500,11 @@ ssize_t spi_nor_read_data(struct spi_nor *nor, loff_t from, size_t len,
 ssize_t spi_nor_write_data(struct spi_nor *nor, loff_t to, size_t len,
 			   const u8 *buf);
 
+int spi_nor_otp_read_secr(struct spi_nor *nor, loff_t addr, uint64_t len, u8 *buf);
+int spi_nor_otp_write_secr(struct spi_nor *nor, loff_t addr, uint64_t len, u8 *buf);
+int spi_nor_otp_lock_sr2(struct spi_nor *nor, unsigned int region);
+int spi_nor_otp_is_locked_sr2(struct spi_nor *nor, unsigned int region);
+
 int spi_nor_hwcaps_read2cmd(u32 hwcaps);
 u8 spi_nor_convert_3to4_read(u8 opcode);
 void spi_nor_set_read_settings(struct spi_nor_read_command *read,
diff --git a/drivers/mtd/spi-nor/otp.c b/drivers/mtd/spi-nor/otp.c
index 59bd1a3f450d..89d055215d1e 100644
--- a/drivers/mtd/spi-nor/otp.c
+++ b/drivers/mtd/spi-nor/otp.c
@@ -10,6 +10,169 @@
 
 #include "core.h"
 
+/**
+ * spi_nor_otp_read_secr() - read OTP data
+ * @nor:	pointer to 'struct spi_nor'
+ * @from:       offset to read from
+ * @len:        number of bytes to read
+ * @buf:        pointer to dst buffer
+ *
+ * Read OTP data by using the SPINOR_OP_RSECR commands. This method is used on
+ * GigaDevice and Winbond flashes.
+ *
+ * Return: number of bytes read successfully, -errno otherwise
+ */
+int spi_nor_otp_read_secr(struct spi_nor *nor, loff_t addr, uint64_t len, u8 *buf)
+{
+	u8 addr_width, read_opcode, read_dummy;
+	struct spi_mem_dirmap_desc *rdesc;
+	enum spi_nor_protocol read_proto;
+	int ret;
+
+	read_opcode = nor->read_opcode;
+	addr_width = nor->addr_width;
+	read_dummy = nor->read_dummy;
+	read_proto = nor->read_proto;
+	rdesc = nor->dirmap.rdesc;
+
+	nor->read_opcode = SPINOR_OP_RSECR;
+	nor->addr_width = 3;
+	nor->read_dummy = 8;
+	nor->read_proto = SNOR_PROTO_1_1_1;
+	nor->dirmap.rdesc = NULL;
+
+	ret = spi_nor_read_data(nor, addr, len, buf);
+
+	nor->read_opcode = read_opcode;
+	nor->addr_width = addr_width;
+	nor->read_dummy = read_dummy;
+	nor->read_proto = read_proto;
+	nor->dirmap.rdesc = rdesc;
+
+	return ret;
+}
+
+/**
+ * spi_nor_otp_write_secr() - write OTP data
+ * @nor:        pointer to 'struct spi_nor'
+ * @to:         offset to write to
+ * @len:        number of bytes to write
+ * @buf:        pointer to src buffer
+ *
+ * Write OTP data by using the SPINOR_OP_PSECR commands. This method is used on
+ * GigaDevice and Winbond flashes.
+ *
+ * Return: number of bytes written successfully, -errno otherwise
+ */
+int spi_nor_otp_write_secr(struct spi_nor *nor, loff_t addr, uint64_t len, u8 *buf)
+{
+	enum spi_nor_protocol write_proto;
+	struct spi_mem_dirmap_desc *wdesc;
+	u8 addr_width, program_opcode;
+	int ret;
+
+	program_opcode = nor->program_opcode;
+	addr_width = nor->addr_width;
+	write_proto = nor->write_proto;
+	wdesc = nor->dirmap.wdesc;
+
+	nor->program_opcode = SPINOR_OP_PSECR;
+	nor->addr_width = 3;
+	nor->write_proto = SNOR_PROTO_1_1_1;
+	nor->dirmap.wdesc = NULL;
+
+	/*
+	 * We only support a write to one single page. For now all winbond
+	 * flashes only have one page per OTP region.
+	 */
+	ret = spi_nor_write_enable(nor);
+	if (ret)
+		goto out;
+
+	ret = spi_nor_write_data(nor, addr, len, buf);
+	if (ret < 0)
+		goto out;
+
+	ret = spi_nor_wait_till_ready(nor);
+
+out:
+	nor->program_opcode = program_opcode;
+	nor->addr_width = addr_width;
+	nor->write_proto = write_proto;
+	nor->dirmap.wdesc = wdesc;
+
+	return ret;
+}
+
+static int spi_nor_otp_lock_bit_cr(unsigned int region)
+{
+	static const int lock_bits[] = { SR2_LB1, SR2_LB2, SR2_LB3 };
+
+	if (region >= ARRAY_SIZE(lock_bits))
+		return -EINVAL;
+
+	return lock_bits[region];
+}
+
+/**
+ * spi_nor_otp_lock_sr2() - lock the OTP region
+ * @nor:        pointer to 'struct spi_nor'
+ * @region:     OTP region
+ *
+ * Lock the OTP region by writing the status register-2. This method is used on
+ * GigaDevice and Winbond flashes.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+int spi_nor_otp_lock_sr2(struct spi_nor *nor, unsigned int region)
+{
+	u8 *cr = nor->bouncebuf;
+	int lock_bit;
+	int ret;
+
+	lock_bit = spi_nor_otp_lock_bit_cr(region);
+	if (lock_bit < 0)
+		return lock_bit;
+
+	ret = spi_nor_read_cr(nor, cr);
+	if (ret)
+		return ret;
+
+	/* no need to write the register if region is already locked */
+	if (cr[0] & lock_bit)
+		return 0;
+
+	cr[0] |= lock_bit;
+
+	return spi_nor_write_16bit_cr_and_check(nor, cr[0]);
+}
+
+/**
+ * spi_nor_otp_is_locked_sr2() - get the OTP region lock status
+ * @nor:        pointer to 'struct spi_nor'
+ * @region:     OTP region
+ *
+ * Retrieve the OTP region lock bit by reading the status register-2. This
+ * method is used on GigaDevice and Winbond flashes.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+int spi_nor_otp_is_locked_sr2(struct spi_nor *nor, unsigned int region)
+{
+	u8 *cr = nor->bouncebuf;
+	int lock_bit;
+	int ret;
+
+	lock_bit = spi_nor_otp_lock_bit_cr(region);
+	if (lock_bit < 0)
+		return lock_bit;
+
+	ret = spi_nor_read_cr(nor, cr);
+	if (ret)
+		return ret;
+
+	return cr[0] & lock_bit;
+}
 static loff_t spi_nor_otp_region_start(struct spi_nor *nor, int region)
 {
 	struct spi_nor_otp_info *info = &nor->params->otp_info;
diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index e5dfa786f190..d3bbd2df7500 100644
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
+	if (nor->params->otp_info.n_otps)
+		nor->params->otp_ops = &winbond_otp_ops;
 }
 
 static const struct spi_nor_fixups winbond_fixups = {
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index a0d572855444..6d1956049e90 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -107,6 +107,11 @@
 #define SPINOR_OP_RD_EVCR      0x65    /* Read EVCR register */
 #define SPINOR_OP_WD_EVCR      0x61    /* Write EVCR register */
 
+/* Used for GigaDevices and Winbond flashes. */
+#define SPINOR_OP_ESECR		0x44	/* Erase Security registers */
+#define SPINOR_OP_PSECR		0x42	/* Program Security registers */
+#define SPINOR_OP_RSECR		0x48	/* Read Security registers */
+
 /* Status Register bits. */
 #define SR_WIP			BIT(0)	/* Write in progress */
 #define SR_WEL			BIT(1)	/* Write enable latch */
@@ -138,8 +143,12 @@
 
 /* Status Register 2 bits. */
 #define SR2_QUAD_EN_BIT1	BIT(1)
+#define SR2_LB1			BIT(3)	/* Security Register Lock Bit 1 */
+#define SR2_LB2			BIT(4)	/* Security Register Lock Bit 2 */
+#define SR2_LB3			BIT(5)	/* Security Register Lock Bit 3 */
 #define SR2_QUAD_EN_BIT7	BIT(7)
 
+
 /* Supported SPI protocols */
 #define SNOR_PROTO_INST_MASK	GENMASK(23, 16)
 #define SNOR_PROTO_INST_SHIFT	16
-- 
2.20.1

