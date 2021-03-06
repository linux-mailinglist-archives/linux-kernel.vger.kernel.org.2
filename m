Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA72032F717
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 01:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhCFAGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 19:06:03 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:50047 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhCFAFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 19:05:48 -0500
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2CA2D22234;
        Sat,  6 Mar 2021 01:05:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1614989147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YqQNslft2DFJ1qUx8R7Et19hRAFsFtbLVljEtaEmLfc=;
        b=nt90sCNMJ80JTnZVwBwRs8cHJvZXsWAP7niawhXhtsxKl4m5uABSzukCLVwOh4CBzBVo9B
        o5nEEGzI3bSY7e8ElIFOiZqtxsgq+7FdBHeXVJgGs9pEY1rZ1hAkfd00/dH6nRTQ20bKRE
        Y5OUr9ezL+saCVCVvuRzRd4UqR8Toxc=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v4 2/4] mtd: spi-nor: implement OTP support for Winbond and similar flashes
Date:   Sat,  6 Mar 2021 01:05:33 +0100
Message-Id: <20210306000535.9890-3-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210306000535.9890-1-michael@walle.cc>
References: <20210306000535.9890-1-michael@walle.cc>
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

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/core.c  |   2 +-
 drivers/mtd/spi-nor/core.h  |   6 ++
 drivers/mtd/spi-nor/otp.c   | 164 ++++++++++++++++++++++++++++++++++++
 include/linux/mtd/spi-nor.h |   9 ++
 4 files changed, 180 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 0c5c757fa95b..ef7df26896f1 100644
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
index ec8da1243846..dfbf6ba42b57 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -496,6 +496,7 @@ int spi_nor_read_sr(struct spi_nor *nor, u8 *sr);
 int spi_nor_read_cr(struct spi_nor *nor, u8 *cr);
 int spi_nor_write_sr(struct spi_nor *nor, const u8 *sr, size_t len);
 int spi_nor_write_sr_and_check(struct spi_nor *nor, u8 sr1);
+int spi_nor_write_16bit_cr_and_check(struct spi_nor *nor, u8 cr);
 
 int spi_nor_xread_sr(struct spi_nor *nor, u8 *sr);
 ssize_t spi_nor_read_data(struct spi_nor *nor, loff_t from, size_t len,
@@ -503,6 +504,11 @@ ssize_t spi_nor_read_data(struct spi_nor *nor, loff_t from, size_t len,
 ssize_t spi_nor_write_data(struct spi_nor *nor, loff_t to, size_t len,
 			   const u8 *buf);
 
+int spi_nor_otp_read_secr(struct spi_nor *nor, loff_t addr, size_t len, u8 *buf);
+int spi_nor_otp_write_secr(struct spi_nor *nor, loff_t addr, size_t len, u8 *buf);
+int spi_nor_otp_lock_sr2(struct spi_nor *nor, unsigned int region);
+int spi_nor_otp_is_locked_sr2(struct spi_nor *nor, unsigned int region);
+
 int spi_nor_hwcaps_read2cmd(u32 hwcaps);
 u8 spi_nor_convert_3to4_read(u8 opcode);
 void spi_nor_set_read_settings(struct spi_nor_read_command *read,
diff --git a/drivers/mtd/spi-nor/otp.c b/drivers/mtd/spi-nor/otp.c
index 4e301fd5156b..4e8da9108c77 100644
--- a/drivers/mtd/spi-nor/otp.c
+++ b/drivers/mtd/spi-nor/otp.c
@@ -15,6 +15,170 @@
 #define spi_nor_otp_region_len(nor) ((nor)->params->otp.org->len)
 #define spi_nor_otp_n_regions(nor) ((nor)->params->otp.org->n_regions)
 
+/**
+ * spi_nor_otp_read_secr() - read OTP data
+ * @nor:	pointer to 'struct spi_nor'
+ * @from:       offset to read from
+ * @len:        number of bytes to read
+ * @buf:        pointer to dst buffer
+ *
+ * Read OTP data from one region by using the SPINOR_OP_RSECR commands. This
+ * method is used on GigaDevice and Winbond flashes.
+ *
+ * Return: number of bytes read successfully, -errno otherwise
+ */
+int spi_nor_otp_read_secr(struct spi_nor *nor, loff_t addr, size_t len, u8 *buf)
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
+ * Write OTP data to one region by using the SPINOR_OP_PSECR commands. This
+ * method is used on GigaDevice and Winbond flashes.
+ *
+ * Please note, the write must not span multiple OTP regions.
+ *
+ * Return: number of bytes written successfully, -errno otherwise
+ */
+int spi_nor_otp_write_secr(struct spi_nor *nor, loff_t addr, size_t len, u8 *buf)
+{
+	enum spi_nor_protocol write_proto;
+	struct spi_mem_dirmap_desc *wdesc;
+	u8 addr_width, program_opcode;
+	int ret, written;
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
+	written = spi_nor_write_data(nor, addr, len, buf);
+	if (written < 0)
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
+	return ret ?: written;
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
+	int ret, lock_bit;
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
+	int ret, lock_bit;
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
+
 static loff_t spi_nor_otp_region_start(const struct spi_nor *nor, int region)
 {
 	const struct spi_nor_otp_organization *org = nor->params->otp.org;
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

