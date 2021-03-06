Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12EA032F718
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 01:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbhCFAGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 19:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhCFAFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 19:05:50 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C75C061762
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 16:05:50 -0800 (PST)
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id C575122256;
        Sat,  6 Mar 2021 01:05:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1614989147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6vYZSKUm8UQgDARDdDwNawTrGlQT/7lLmUbdR2Psfy8=;
        b=X8rjvKeoQBffC90bVuxRXFqjnppIOCXSNcAHkSKorQb+Bueo9FFku+l8GKpR6tJN/puKyP
        u0z/5KFbJBE5fUt/ICZcXtZuh/gFZtp9KM6GAwWqSoLgatTij83Vk/Y4z83k7cjPWaRooq
        tUMA45M/7vC3Hnld7spHywc2sMF0WBs=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v4 4/4] mtd: spi-nor: implement OTP erase for Winbond and similar flashes
Date:   Sat,  6 Mar 2021 01:05:35 +0100
Message-Id: <20210306000535.9890-5-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210306000535.9890-1-michael@walle.cc>
References: <20210306000535.9890-1-michael@walle.cc>
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
 drivers/mtd/spi-nor/core.c    |  4 +-
 drivers/mtd/spi-nor/core.h    |  4 ++
 drivers/mtd/spi-nor/otp.c     | 74 ++++++++++++++++++++++++++++++++++-
 drivers/mtd/spi-nor/winbond.c |  1 +
 4 files changed, 79 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index ef7df26896f1..21a737804576 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -166,8 +166,8 @@ static int spi_nor_controller_ops_read_reg(struct spi_nor *nor, u8 opcode,
 	return nor->controller_ops->read_reg(nor, opcode, buf, len);
 }
 
-static int spi_nor_controller_ops_write_reg(struct spi_nor *nor, u8 opcode,
-					    const u8 *buf, size_t len)
+int spi_nor_controller_ops_write_reg(struct spi_nor *nor, u8 opcode,
+				     const u8 *buf, size_t len)
 {
 	if (spi_nor_protocol_is_dtr(nor->reg_proto))
 		return -EOPNOTSUPP;
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index dfbf6ba42b57..ef62ec4625a1 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -213,6 +213,7 @@ struct spi_nor_otp_ops {
 	int (*read)(struct spi_nor *nor, loff_t addr, size_t len, u8 *buf);
 	int (*write)(struct spi_nor *nor, loff_t addr, size_t len, u8 *buf);
 	int (*lock)(struct spi_nor *nor, unsigned int region);
+	int (*erase)(struct spi_nor *nor, loff_t addr);
 	int (*is_locked)(struct spi_nor *nor, unsigned int region);
 };
 
@@ -481,6 +482,8 @@ extern const struct spi_nor_manufacturer spi_nor_xmc;
 void spi_nor_spimem_setup_op(const struct spi_nor *nor,
 			     struct spi_mem_op *op,
 			     const enum spi_nor_protocol proto);
+int spi_nor_controller_ops_write_reg(struct spi_nor *nor, u8 opcode,
+				     const u8 *buf, size_t len);
 int spi_nor_write_enable(struct spi_nor *nor);
 int spi_nor_write_disable(struct spi_nor *nor);
 int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable);
@@ -506,6 +509,7 @@ ssize_t spi_nor_write_data(struct spi_nor *nor, loff_t to, size_t len,
 
 int spi_nor_otp_read_secr(struct spi_nor *nor, loff_t addr, size_t len, u8 *buf);
 int spi_nor_otp_write_secr(struct spi_nor *nor, loff_t addr, size_t len, u8 *buf);
+int spi_nor_otp_erase_secr(struct spi_nor *nor, loff_t addr);
 int spi_nor_otp_lock_sr2(struct spi_nor *nor, unsigned int region);
 int spi_nor_otp_is_locked_sr2(struct spi_nor *nor, unsigned int region);
 
diff --git a/drivers/mtd/spi-nor/otp.c b/drivers/mtd/spi-nor/otp.c
index 4e8da9108c77..78ec79368c29 100644
--- a/drivers/mtd/spi-nor/otp.c
+++ b/drivers/mtd/spi-nor/otp.c
@@ -8,6 +8,7 @@
 #include <linux/log2.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/spi-nor.h>
+#include <linux/spi/spi-mem.h>
 
 #include "core.h"
 
@@ -111,6 +112,50 @@ int spi_nor_otp_write_secr(struct spi_nor *nor, loff_t addr, size_t len, u8 *buf
 	return ret ?: written;
 }
 
+/**
+ * spi_nor_otp_erase_secr() - erase one OTP region
+ * @nor:        pointer to 'struct spi_nor'
+ * @to:         offset to write to
+ * @len:        number of bytes to write
+ * @buf:        pointer to src buffer
+ *
+ * Erase one OTP region by using the SPINOR_OP_ESECR commands. This method is
+ * used on GigaDevice and Winbond flashes.
+ *
+ * Return: 0 on success, -errno otherwise
+ */
+int spi_nor_otp_erase_secr(struct spi_nor *nor, loff_t addr)
+{
+	int ret;
+
+	ret = spi_nor_write_enable(nor);
+	if (ret)
+		return ret;
+
+	if (nor->spimem) {
+		struct spi_mem_op op =
+			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_ESECR, 0),
+				   SPI_MEM_OP_ADDR(3, addr, 0),
+				   SPI_MEM_OP_NO_DUMMY,
+				   SPI_MEM_OP_NO_DATA);
+
+		spi_nor_spimem_setup_op(nor, &op, nor->write_proto);
+
+		ret = spi_mem_exec_op(nor->spimem, &op);
+	} else {
+		nor->bouncebuf[2] = addr & 0xff;
+		nor->bouncebuf[1] = (addr >> 8) & 0xff;
+		nor->bouncebuf[0] = (addr >> 16) & 0xff;
+
+		ret = spi_nor_controller_ops_write_reg(nor, SPINOR_OP_ESECR,
+						       nor->bouncebuf, 3);
+	}
+	if (ret)
+		return ret;
+
+	return spi_nor_wait_till_ready(nor);
+}
+
 static int spi_nor_otp_lock_bit_cr(unsigned int region)
 {
 	static const int lock_bits[] = { SR2_LB1, SR2_LB2, SR2_LB3 };
@@ -319,11 +364,13 @@ static int spi_nor_mtd_otp_write(struct mtd_info *mtd, loff_t to, size_t len,
 	return spi_nor_mtd_otp_read_write(mtd, to, len, retlen, buf, true);
 }
 
-static int spi_nor_mtd_otp_lock(struct mtd_info *mtd, loff_t from, size_t len)
+static int spi_nor_mtd_otp_lock_erase(struct mtd_info *mtd, loff_t from,
+				      size_t len, bool is_erase)
 {
 	struct spi_nor *nor = mtd_to_spi_nor(mtd);
 	const struct spi_nor_otp_ops *ops = spi_nor_otp_ops(nor);
 	unsigned int region;
+	loff_t start;
 	int ret;
 
 	if (from < 0 || (from + len) > spi_nor_otp_size(nor))
@@ -342,7 +389,12 @@ static int spi_nor_mtd_otp_lock(struct mtd_info *mtd, loff_t from, size_t len)
 
 	while (len) {
 		region = spi_nor_otp_offset_to_region(nor, from);
-		ret = ops->lock(nor, region);
+		start = spi_nor_otp_region_start(nor, region);
+
+		if (is_erase)
+			ret = ops->erase(nor, start);
+		else
+			ret = ops->lock(nor, region);
 		if (ret)
 			goto out;
 
@@ -356,6 +408,23 @@ static int spi_nor_mtd_otp_lock(struct mtd_info *mtd, loff_t from, size_t len)
 	return ret;
 }
 
+static int spi_nor_mtd_otp_lock(struct mtd_info *mtd, loff_t from, size_t len)
+{
+	return spi_nor_mtd_otp_lock_erase(mtd, from, len, false);
+}
+
+static int spi_nor_mtd_otp_erase(struct mtd_info *mtd, loff_t from, size_t len)
+{
+	struct spi_nor *nor = mtd_to_spi_nor(mtd);
+	const struct spi_nor_otp_ops *ops = spi_nor_otp_ops(nor);
+
+	/* OTP erase is optional */
+	if (!ops->erase)
+		return -EOPNOTSUPP;
+
+	return spi_nor_mtd_otp_lock_erase(mtd, from, len, true);
+}
+
 void spi_nor_otp_init(struct spi_nor *nor)
 {
 	struct mtd_info *mtd = &nor->mtd;
@@ -379,4 +448,5 @@ void spi_nor_otp_init(struct spi_nor *nor)
 	mtd->_read_user_prot_reg = spi_nor_mtd_otp_read;
 	mtd->_write_user_prot_reg = spi_nor_mtd_otp_write;
 	mtd->_lock_user_prot_reg = spi_nor_mtd_otp_lock;
+	mtd->_erase_user_prot_reg = spi_nor_mtd_otp_erase;
 }
diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index 9a3f8ff007fd..e04219ac11fd 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -138,6 +138,7 @@ static int winbond_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
 static const struct spi_nor_otp_ops winbond_otp_ops = {
 	.read = spi_nor_otp_read_secr,
 	.write = spi_nor_otp_write_secr,
+	.erase = spi_nor_otp_erase_secr,
 	.lock = spi_nor_otp_lock_sr2,
 	.is_locked = spi_nor_otp_is_locked_sr2,
 };
-- 
2.20.1

