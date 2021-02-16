Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B46E31CE0C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 17:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhBPQ3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 11:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbhBPQ3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 11:29:00 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EB6C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 08:28:19 -0800 (PST)
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 8AB1A2224A;
        Tue, 16 Feb 2021 17:28:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1613492894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NMr8+yeSChyfmHM8cnRKw7WYpIv6RKPEGQ18o4d4zLU=;
        b=ovD/UfkJmtaIRGdm3zNNMcOVRO+aS7+JkZHKkAL7ItcVyyIIJm7/+2bkScj41zJn2+RAi1
        MAiDFo8CvgIKDZAFf24A3s+Y8M4ivqx/kHUBAzu4JqT5o9py1CnV6dSeHXXBIbsDT4HRmV
        G/l3H5GFmjyy/R6l3E8nwUuj1OLxytU=
From:   Michael Walle <michael@walle.cc>
To:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v3 1/2] mtd: spi-nor: add OTP support
Date:   Tue, 16 Feb 2021 17:28:06 +0100
Message-Id: <20210216162807.13509-2-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210216162807.13509-1-michael@walle.cc>
References: <20210216162807.13509-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPI flashes sometimes have a special OTP area, which can (and is) used to
store immutable properties like board serial number or vendor assigned
network hardware addresses.

The MTD subsystem already supports accessing such areas and some (non
SPI-NOR) flashes already implement support for it. It differentiates
between user and factory areas. User areas can be written by the user and
factory ones are pre-programmed and locked down by the vendor, usually
containing an "electrical serial number". This patch will only add support
for the user areas.

Lay the foundation and implement the MTD callbacks for the SPI-NOR and add
necessary parameters to the flash_info structure. If a flash supports OTP
it can be added by the convenience macro OTP_INFO(). Sometimes there are
individual regions, which might have individual offsets. Therefore, it is
possible to specify the starting address of the first regions as well as
the distance between two regions (e.g. Winbond devices uses this method).

Additionally, the regions might be locked down. Once locked, no further
write access is possible.

For SPI-NOR flashes the OTP area is accessed like the normal memory, e.g.
by offset addressing; except that you either have to use special read/write
commands (Winbond) or you have to enter (and exit) a specific OTP mode
(Macronix, Micron).

Thus we introduce four operations to which the MTD callbacks will be
mapped: .read(), .write(), .lock() and .is_locked(). The read and the write
ops will be given an address offset to operate on while the locking ops use
regions because locking always affects a whole region. It is up to the
flash driver to implement these ops.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/Makefile |   1 +
 drivers/mtd/spi-nor/core.c   |   8 ++
 drivers/mtd/spi-nor/core.h   |  50 +++++++++++
 drivers/mtd/spi-nor/otp.c    | 157 +++++++++++++++++++++++++++++++++++
 4 files changed, 216 insertions(+)
 create mode 100644 drivers/mtd/spi-nor/otp.c

diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
index 653923896205..2ed2e76ce4f1 100644
--- a/drivers/mtd/spi-nor/Makefile
+++ b/drivers/mtd/spi-nor/Makefile
@@ -12,6 +12,7 @@ spi-nor-objs			+= intel.o
 spi-nor-objs			+= issi.o
 spi-nor-objs			+= macronix.o
 spi-nor-objs			+= micron-st.o
+spi-nor-objs			+= otp.o
 spi-nor-objs			+= spansion.o
 spi-nor-objs			+= sst.o
 spi-nor-objs			+= winbond.o
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 0522304f52fa..af9d7f194f01 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3012,6 +3012,12 @@ static void spi_nor_info_init_params(struct spi_nor *nor)
 	spi_nor_set_erase_type(&map->erase_type[i], info->sector_size,
 			       SPINOR_OP_SE);
 	spi_nor_init_uniform_erase_map(map, erase_mask, params->size);
+
+	/* OTP parameters */
+	nor->params->otp_info.otp_size = info->otp_size;
+	nor->params->otp_info.n_otps = info->n_otps;
+	nor->params->otp_info.otp_start_addr = info->otp_start_addr;
+	nor->params->otp_info.otp_addr_offset = info->otp_addr_offset;
 }
 
 /**
@@ -3502,6 +3508,8 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 		mtd->_is_locked = spi_nor_is_locked;
 	}
 
+	spi_nor_otp_init(nor);
+
 	if (info->flags & USE_FSR)
 		nor->flags |= SNOR_F_USE_FSR;
 	if (info->flags & SPI_NOR_HAS_TB) {
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 4a3f7f150b5d..5fb54ae08c5b 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -175,6 +175,21 @@ struct spi_nor_erase_map {
 	u8				uniform_erase_type;
 };
 
+/**
+ * struct spi_nor_otp_info - Structure to describe the SPI NOR OTP region
+ * @otp_size:		size of one OTP region in bytes.
+ * @n_otps:		number of individual OTP regions.
+ * @otp_start_addr:	start address of the OTP area.
+ * @otp_addr_offset:	offset between consecutive OTP regions if there are
+ *			more than one.
+ */
+struct spi_nor_otp_info {
+	u32 otp_size;
+	int n_otps;
+	u32 otp_start_addr;
+	u32 otp_addr_offset;
+};
+
 /**
  * struct spi_nor_locking_ops - SPI NOR locking methods
  * @lock:	lock a region of the SPI NOR.
@@ -187,6 +202,20 @@ struct spi_nor_locking_ops {
 	int (*is_locked)(struct spi_nor *nor, loff_t ofs, uint64_t len);
 };
 
+/**
+ * struct spi_nor_otp_ops - SPI NOR OTP methods
+ * @read:	read from the SPI NOR OTP area.
+ * @write:	write to the SPI NOR OTP area.
+ * @lock:	lock an OTP region.
+ * @is_locked:	check if an OTP region of the SPI NOR is locked.
+ */
+struct spi_nor_otp_ops {
+	int (*read)(struct spi_nor *nor, loff_t ofs, uint64_t len, u8 *buf);
+	int (*write)(struct spi_nor *nor, loff_t ofs, uint64_t len, u8 *buf);
+	int (*lock)(struct spi_nor *nor, unsigned int region);
+	int (*is_locked)(struct spi_nor *nor, unsigned int region);
+};
+
 /**
  * struct spi_nor_flash_parameter - SPI NOR flash parameters and settings.
  * Includes legacy flash parameters and settings that can be overwritten
@@ -208,6 +237,7 @@ struct spi_nor_locking_ops {
  *                      higher index in the array, the higher priority.
  * @erase_map:		the erase map parsed from the SFDP Sector Map Parameter
  *                      Table.
+ * @otp_info:		describes the OTP regions.
  * @octal_dtr_enable:	enables SPI NOR octal DTR mode.
  * @quad_enable:	enables SPI NOR quad mode.
  * @set_4byte_addr_mode: puts the SPI NOR in 4 byte addressing mode.
@@ -219,6 +249,7 @@ struct spi_nor_locking_ops {
  *                      e.g. different opcodes, specific address calculation,
  *                      page size, etc.
  * @locking_ops:	SPI NOR locking methods.
+ * @otp_ops:		SPI NOR OTP methods.
  */
 struct spi_nor_flash_parameter {
 	u64				size;
@@ -232,6 +263,7 @@ struct spi_nor_flash_parameter {
 	struct spi_nor_pp_command	page_programs[SNOR_CMD_PP_MAX];
 
 	struct spi_nor_erase_map        erase_map;
+	struct spi_nor_otp_info		otp_info;
 
 	int (*octal_dtr_enable)(struct spi_nor *nor, bool enable);
 	int (*quad_enable)(struct spi_nor *nor);
@@ -240,6 +272,7 @@ struct spi_nor_flash_parameter {
 	int (*setup)(struct spi_nor *nor, const struct spi_nor_hwcaps *hwcaps);
 
 	const struct spi_nor_locking_ops *locking_ops;
+	const struct spi_nor_otp_ops *otp_ops;
 };
 
 /**
@@ -341,6 +374,15 @@ struct flash_info {
 
 	/* Part specific fixup hooks. */
 	const struct spi_nor_fixups *fixups;
+
+	/* OTP size in bytes */
+	u16 otp_size;
+	/* Number of OTP banks */
+	u16 n_otps;
+	/* Start address of OTP area */
+	u32 otp_start_addr;
+	/* Offset between consecutive OTP banks if there are more than one */
+	u32 otp_addr_offset;
 };
 
 /* Used when the "_ext_id" is two bytes at most */
@@ -393,6 +435,12 @@ struct flash_info {
 		.addr_width = 3,					\
 		.flags = SPI_NOR_NO_FR | SPI_NOR_XSR_RDY,
 
+#define OTP_INFO(_otp_size, _n_otps, _otp_start_addr, _otp_addr_offset)	\
+		.otp_size = (_otp_size),				\
+		.n_otps = (_n_otps),					\
+		.otp_start_addr = (_otp_start_addr),			\
+		.otp_addr_offset = (_otp_addr_offset),
+
 /**
  * struct spi_nor_manufacturer - SPI NOR manufacturer object
  * @name: manufacturer name
@@ -473,6 +521,8 @@ int spi_nor_post_bfpt_fixups(struct spi_nor *nor,
 			     const struct sfdp_bfpt *bfpt,
 			     struct spi_nor_flash_parameter *params);
 
+void spi_nor_otp_init(struct spi_nor *nor);
+
 static struct spi_nor __maybe_unused *mtd_to_spi_nor(struct mtd_info *mtd)
 {
 	return mtd->priv;
diff --git a/drivers/mtd/spi-nor/otp.c b/drivers/mtd/spi-nor/otp.c
new file mode 100644
index 000000000000..59bd1a3f450d
--- /dev/null
+++ b/drivers/mtd/spi-nor/otp.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * OTP support for SPI-NOR flashes
+ *
+ * Copyright (C) 2021 Michael Walle <michael@walle.cc>
+ */
+
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/spi-nor.h>
+
+#include "core.h"
+
+static loff_t spi_nor_otp_region_start(struct spi_nor *nor, int region)
+{
+	struct spi_nor_otp_info *info = &nor->params->otp_info;
+
+	return info->otp_start_addr + region * info->otp_addr_offset;
+}
+
+static loff_t spi_nor_otp_region_end(struct spi_nor *nor, int region)
+{
+	struct spi_nor_otp_info *info = &nor->params->otp_info;
+
+	return spi_nor_otp_region_start(nor, region) + info->otp_size - 1;
+}
+
+static int spi_nor_mtd_otp_info(struct mtd_info *mtd, size_t len,
+				size_t *retlen, struct otp_info *buf)
+{
+	struct spi_nor *nor = mtd_to_spi_nor(mtd);
+	int n_otps = nor->params->otp_info.n_otps;
+	int locked, i;
+
+	if (len < n_otps * sizeof(*buf))
+		return -ENOSPC;
+
+	for (i = 0; i < n_otps; i++) {
+		buf[i].start = spi_nor_otp_region_start(nor, i);
+		buf[i].length = nor->params->otp_info.otp_size;
+
+		locked = nor->params->otp_ops->is_locked(nor, i);
+		if (locked < 0)
+			return locked;
+
+		buf[i].locked = !!locked;
+	}
+
+	*retlen = n_otps * sizeof(*buf);
+
+	return 0;
+}
+
+static int spi_nor_otp_addr_to_region(struct spi_nor *nor, loff_t addr)
+{
+	int i;
+
+	for (i = 0; i < nor->params->otp_info.n_otps; i++)
+		if (addr >= spi_nor_otp_region_start(nor, i) &&
+		    addr <= spi_nor_otp_region_end(nor, i))
+			return i;
+
+	return -EINVAL;
+}
+
+static int spi_nor_mtd_otp_read_write(struct mtd_info *mtd, loff_t ofs,
+				      size_t len, size_t *retlen, u_char *buf,
+				      bool is_write)
+{
+	struct spi_nor *nor = mtd_to_spi_nor(mtd);
+	int region;
+	int ret;
+
+	*retlen = 0;
+
+	region = spi_nor_otp_addr_to_region(nor, ofs);
+	if (region < 0)
+		return 0;
+
+	if (ofs < spi_nor_otp_region_start(nor, region))
+		return 0;
+
+	if ((ofs + len - 1) > spi_nor_otp_region_end(nor, region))
+		return 0;
+
+	ret = spi_nor_lock_and_prep(nor);
+
+	if (is_write)
+		ret = nor->params->otp_ops->write(nor, ofs, len, buf);
+	else
+		ret = nor->params->otp_ops->read(nor, ofs, len, buf);
+
+	spi_nor_unlock_and_unprep(nor);
+
+	if (ret < 0)
+		return ret;
+
+	*retlen = len;
+	return 0;
+}
+
+static int spi_nor_mtd_otp_read(struct mtd_info *mtd, loff_t from, size_t len,
+				size_t *retlen, u_char *buf)
+{
+	return spi_nor_mtd_otp_read_write(mtd, from, len, retlen, buf, false);
+}
+
+static int spi_nor_mtd_otp_write(struct mtd_info *mtd, loff_t to, size_t len,
+				 size_t *retlen, u_char *buf)
+{
+	return spi_nor_mtd_otp_read_write(mtd, to, len, retlen, buf, true);
+}
+
+static int spi_nor_mtd_otp_lock(struct mtd_info *mtd, loff_t from, size_t len)
+{
+	struct spi_nor *nor = mtd_to_spi_nor(mtd);
+	int region;
+	int ret;
+
+	region = spi_nor_otp_addr_to_region(nor, from);
+	if (region < 0)
+		return -EINVAL;
+
+	if (len != nor->params->otp_info.otp_size)
+		return -EINVAL;
+
+	ret = spi_nor_lock_and_prep(nor);
+	if (ret)
+		return ret;
+
+	ret = nor->params->otp_ops->lock(nor, region);
+
+	spi_nor_unlock_and_unprep(nor);
+
+	return ret;
+}
+
+void spi_nor_otp_init(struct spi_nor *nor)
+{
+	struct mtd_info *mtd = &nor->mtd;
+
+	if (!nor->params->otp_ops)
+		return;
+
+	/*
+	 * We only support user_prot callbacks (yet).
+	 *
+	 * Some SPI-NOR flashes like Macronix ones can be ordered in two
+	 * different variants. One with a factory locked OTP area and one where
+	 * it is left to the user to write to it. The factory locked OTP is
+	 * usually preprogrammed with an "electrical serial number". We don't
+	 * support these for now.
+	 */
+	mtd->_get_user_prot_info = spi_nor_mtd_otp_info;
+	mtd->_read_user_prot_reg = spi_nor_mtd_otp_read;
+	mtd->_write_user_prot_reg = spi_nor_mtd_otp_write;
+	mtd->_lock_user_prot_reg = spi_nor_mtd_otp_lock;
+}
-- 
2.20.1

