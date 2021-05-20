Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC8338B3D7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 17:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbhETQAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 12:00:34 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:49627 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbhETQAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 12:00:25 -0400
Received: from mwalle01.fritz.box (ip4d17858c.dynamic.kabel-deutschland.de [77.23.133.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2111D22259;
        Thu, 20 May 2021 17:59:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1621526342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WLUNlYRfdtICiXJ3dWZ+vGUtIBy0lVjeP4fK0/82nvA=;
        b=WSd7KIiEGPVwaywEIRk6atRMojSznjSsx91xnl9rteJZtNgSBSSDYOy+rsdItH4zkThFtV
        jRXqBLGFTw84qPFLhrYKnK6QAhPZr0r7hiYLKbDWpbhpxjBzMFgsnboTK2LcFzhgAswXYE
        01Vb0wPAp1NIfxo6d501hjpQNvtaDd4=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v3 3/3] mtd: spi-nor: otp: implement erase for Winbond and similar flashes
Date:   Thu, 20 May 2021 17:58:54 +0200
Message-Id: <20210520155854.16547-4-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210520155854.16547-1-michael@walle.cc>
References: <20210520155854.16547-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Winbond flashes with OTP support provide a command to erase the OTP
data. This might come in handy during development.

This was tested with a Winbond W25Q32JW on a LS1028A SoC with the
NXP FSPI controller.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/core.c    |  2 +-
 drivers/mtd/spi-nor/core.h    |  4 +++
 drivers/mtd/spi-nor/otp.c     | 58 +++++++++++++++++++++++++++++++++--
 drivers/mtd/spi-nor/winbond.c |  1 +
 4 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index bd2c7717eb10..9551effb6a44 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1318,7 +1318,7 @@ static u32 spi_nor_convert_addr(struct spi_nor *nor, loff_t addr)
 /*
  * Initiate the erasure of a single sector
  */
-static int spi_nor_erase_sector(struct spi_nor *nor, u32 addr)
+int spi_nor_erase_sector(struct spi_nor *nor, u32 addr)
 {
 	int i;
 
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 28a2e0be97a3..9398a8738857 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -207,6 +207,7 @@ struct spi_nor_otp_organization {
  * @read:	read from the SPI NOR OTP area.
  * @write:	write to the SPI NOR OTP area.
  * @lock:	lock an OTP region.
+ * @erase:	erase an OTP region.
  * @is_locked:	check if an OTP region of the SPI NOR is locked.
  */
 struct spi_nor_otp_ops {
@@ -214,6 +215,7 @@ struct spi_nor_otp_ops {
 	int (*write)(struct spi_nor *nor, loff_t addr, size_t len,
 		     const u8 *buf);
 	int (*lock)(struct spi_nor *nor, unsigned int region);
+	int (*erase)(struct spi_nor *nor, loff_t addr);
 	int (*is_locked)(struct spi_nor *nor, unsigned int region);
 };
 
@@ -503,10 +505,12 @@ ssize_t spi_nor_read_data(struct spi_nor *nor, loff_t from, size_t len,
 			  u8 *buf);
 ssize_t spi_nor_write_data(struct spi_nor *nor, loff_t to, size_t len,
 			   const u8 *buf);
+int spi_nor_erase_sector(struct spi_nor *nor, u32 addr);
 
 int spi_nor_otp_read_secr(struct spi_nor *nor, loff_t addr, size_t len, u8 *buf);
 int spi_nor_otp_write_secr(struct spi_nor *nor, loff_t addr, size_t len,
 			   const u8 *buf);
+int spi_nor_otp_erase_secr(struct spi_nor *nor, loff_t addr);
 int spi_nor_otp_lock_sr2(struct spi_nor *nor, unsigned int region);
 int spi_nor_otp_is_locked_sr2(struct spi_nor *nor, unsigned int region);
 
diff --git a/drivers/mtd/spi-nor/otp.c b/drivers/mtd/spi-nor/otp.c
index ec0c1b33f7cc..2dc315b6bffc 100644
--- a/drivers/mtd/spi-nor/otp.c
+++ b/drivers/mtd/spi-nor/otp.c
@@ -111,6 +111,34 @@ int spi_nor_otp_write_secr(struct spi_nor *nor, loff_t addr, size_t len,
 	return ret ?: written;
 }
 
+/**
+ * spi_nor_otp_erase_secr() - erase a security register
+ * @nor:        pointer to 'struct spi_nor'
+ * @addr:       offset of the security register to be erased
+ *
+ * Erase a security register by using the SPINOR_OP_ESECR command. This method
+ * is used on GigaDevice and Winbond flashes to erase OTP data.
+ *
+ * Return: 0 on success, -errno otherwise
+ */
+int spi_nor_otp_erase_secr(struct spi_nor *nor, loff_t addr)
+{
+	u8 erase_opcode = nor->erase_opcode;
+	int ret;
+
+	ret = spi_nor_write_enable(nor);
+	if (ret)
+		return ret;
+
+	nor->erase_opcode = SPINOR_OP_ESECR;
+	ret = spi_nor_erase_sector(nor, addr);
+	nor->erase_opcode = erase_opcode;
+	if (ret)
+		return ret;
+
+	return spi_nor_wait_till_ready(nor);
+}
+
 static int spi_nor_otp_lock_bit_cr(unsigned int region)
 {
 	static const int lock_bits[] = { SR2_LB1, SR2_LB2, SR2_LB3 };
@@ -316,12 +344,14 @@ static int spi_nor_mtd_otp_write(struct mtd_info *mtd, loff_t to, size_t len,
 	return spi_nor_mtd_otp_read_write(mtd, to, len, retlen, buf, true);
 }
 
-static int spi_nor_mtd_otp_lock(struct mtd_info *mtd, loff_t from, size_t len)
+static int spi_nor_mtd_otp_lock_or_erase(struct mtd_info *mtd, loff_t from,
+					 size_t len, bool is_erase)
 {
 	struct spi_nor *nor = mtd_to_spi_nor(mtd);
 	const struct spi_nor_otp_ops *ops = nor->params->otp.ops;
 	const size_t rlen = spi_nor_otp_region_len(nor);
 	unsigned int region;
+	loff_t rstart;
 	int ret;
 
 	if (from < 0 || (from + len) > spi_nor_otp_size(nor))
@@ -337,7 +367,13 @@ static int spi_nor_mtd_otp_lock(struct mtd_info *mtd, loff_t from, size_t len)
 
 	while (len) {
 		region = spi_nor_otp_offset_to_region(nor, from);
-		ret = ops->lock(nor, region);
+
+		if (is_erase) {
+			rstart = spi_nor_otp_region_start(nor, region);
+			ret = ops->erase(nor, rstart);
+		} else {
+			ret = ops->lock(nor, region);
+		}
 		if (ret)
 			goto out;
 
@@ -351,6 +387,23 @@ static int spi_nor_mtd_otp_lock(struct mtd_info *mtd, loff_t from, size_t len)
 	return ret;
 }
 
+static int spi_nor_mtd_otp_lock(struct mtd_info *mtd, loff_t from, size_t len)
+{
+	return spi_nor_mtd_otp_lock_or_erase(mtd, from, len, false);
+}
+
+static int spi_nor_mtd_otp_erase(struct mtd_info *mtd, loff_t from, size_t len)
+{
+	struct spi_nor *nor = mtd_to_spi_nor(mtd);
+	const struct spi_nor_otp_ops *ops = nor->params->otp.ops;
+
+	/* OTP erase is optional */
+	if (!ops->erase)
+		return -EOPNOTSUPP;
+
+	return spi_nor_mtd_otp_lock_or_erase(mtd, from, len, true);
+}
+
 void spi_nor_otp_init(struct spi_nor *nor)
 {
 	struct mtd_info *mtd = &nor->mtd;
@@ -374,4 +427,5 @@ void spi_nor_otp_init(struct spi_nor *nor)
 	mtd->_read_user_prot_reg = spi_nor_mtd_otp_read;
 	mtd->_write_user_prot_reg = spi_nor_mtd_otp_write;
 	mtd->_lock_user_prot_reg = spi_nor_mtd_otp_lock;
+	mtd->_erase_user_prot_reg = spi_nor_mtd_otp_erase;
 }
diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index 9a81c67a60c6..96573f61caf5 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -139,6 +139,7 @@ static int winbond_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
 static const struct spi_nor_otp_ops winbond_otp_ops = {
 	.read = spi_nor_otp_read_secr,
 	.write = spi_nor_otp_write_secr,
+	.erase = spi_nor_otp_erase_secr,
 	.lock = spi_nor_otp_lock_sr2,
 	.is_locked = spi_nor_otp_is_locked_sr2,
 };
-- 
2.20.1

