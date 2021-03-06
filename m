Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7B932F719
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 01:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhCFAGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 19:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhCFAFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 19:05:50 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4BAC06175F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 16:05:50 -0800 (PST)
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 8CF3C2222E;
        Sat,  6 Mar 2021 01:05:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1614989146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C0ECYTqaEql0XiF/OzySNt5ic5wu2HjTkZ/OgOov9ss=;
        b=KnPnWMB304aZZHJJ5AzJXRX9bHoVEqVCl+XZRZV3E7iV8xFOMZGId3U7CbDDg5CoK9HsvR
        OtWOdgfUrngnnFATUklQQr0AQB9TFmpBQ5PduUtEQfBLIDkirIH2S3Dmkwtck2knGIRT1D
        mfYXJQiNxh72KdFYqSopU4tQl5bsKAs=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v4 1/4] mtd: spi-nor: add OTP support
Date:   Sat,  6 Mar 2021 01:05:32 +0100
Message-Id: <20210306000535.9890-2-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210306000535.9890-1-michael@walle.cc>
References: <20210306000535.9890-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPI flashes sometimes have a special OTP area, which can (and is) used to
store immutable properties like board serial number or vendor assigned
network hardware addresses.

The MTD subsystem already supports accessing such areas and some (non
SPI NOR) flashes already implement support for it. It differentiates
between user and factory areas. User areas can be written by the user and
factory ones are pre-programmed and locked down by the vendor, usually
containing an "electrical serial number". This patch will only add support
for the user areas.

Lay the foundation and implement the MTD callbacks for the SPI NOR and add
necessary parameters to the flash_info structure. If a flash supports OTP
it can be added by the convenience macro OTP_INFO(). Sometimes there are
individual regions, which might have individual offsets. Therefore, it is
possible to specify the starting address of the first regions as well as
the distance between two regions (e.g. Winbond devices uses this method).

Additionally, the regions might be locked down. Once locked, no further
write access is possible.

For SPI NOR flashes the OTP area is accessed like the normal memory, e.g.
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
 drivers/mtd/spi-nor/core.c   |   5 +
 drivers/mtd/spi-nor/core.h   |  54 +++++++++
 drivers/mtd/spi-nor/otp.c    | 218 +++++++++++++++++++++++++++++++++++
 4 files changed, 278 insertions(+)
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
index 4a315cb1c4db..0c5c757fa95b 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3009,6 +3009,8 @@ static void spi_nor_info_init_params(struct spi_nor *nor)
 	spi_nor_set_erase_type(&map->erase_type[i], info->sector_size,
 			       SPINOR_OP_SE);
 	spi_nor_init_uniform_erase_map(map, erase_mask, params->size);
+
+	nor->params->otp.org = &info->otp_org;
 }
 
 /**
@@ -3550,6 +3552,9 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 	if (ret)
 		return ret;
 
+	/* Configure OTP parameters and ops */
+	spi_nor_otp_init(nor);
+
 	/* Send all the required SPI flash commands to initialize device */
 	ret = spi_nor_init(nor);
 	if (ret)
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 4a3f7f150b5d..ec8da1243846 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -187,6 +187,45 @@ struct spi_nor_locking_ops {
 	int (*is_locked)(struct spi_nor *nor, loff_t ofs, uint64_t len);
 };
 
+/**
+ * struct spi_nor_otp_organization - Structure to describe the SPI NOR OTP regions
+ * @len:	size of one OTP region in bytes.
+ * @base:	start address of the OTP area.
+ * @offset:	offset between consecutive OTP regions if there are more
+ *              than one.
+ * @n_regions:	number of individual OTP regions.
+ */
+struct spi_nor_otp_organization {
+	size_t len;
+	loff_t base;
+	loff_t offset;
+	unsigned int n_regions;
+};
+
+/**
+ * struct spi_nor_otp_ops - SPI NOR OTP methods
+ * @read:	read from the SPI NOR OTP area.
+ * @write:	write to the SPI NOR OTP area.
+ * @lock:	lock an OTP region.
+ * @is_locked:	check if an OTP region of the SPI NOR is locked.
+ */
+struct spi_nor_otp_ops {
+	int (*read)(struct spi_nor *nor, loff_t addr, size_t len, u8 *buf);
+	int (*write)(struct spi_nor *nor, loff_t addr, size_t len, u8 *buf);
+	int (*lock)(struct spi_nor *nor, unsigned int region);
+	int (*is_locked)(struct spi_nor *nor, unsigned int region);
+};
+
+/**
+ * struct spi_nor_otp - SPI NOR OTP grouping structure
+ * @org:	OTP region organization
+ * @ops:	OTP access ops
+ */
+struct spi_nor_otp {
+	const struct spi_nor_otp_organization *org;
+	const struct spi_nor_otp_ops *ops;
+};
+
 /**
  * struct spi_nor_flash_parameter - SPI NOR flash parameters and settings.
  * Includes legacy flash parameters and settings that can be overwritten
@@ -208,6 +247,7 @@ struct spi_nor_locking_ops {
  *                      higher index in the array, the higher priority.
  * @erase_map:		the erase map parsed from the SFDP Sector Map Parameter
  *                      Table.
+ * @otp_info:		describes the OTP regions.
  * @octal_dtr_enable:	enables SPI NOR octal DTR mode.
  * @quad_enable:	enables SPI NOR quad mode.
  * @set_4byte_addr_mode: puts the SPI NOR in 4 byte addressing mode.
@@ -219,6 +259,7 @@ struct spi_nor_locking_ops {
  *                      e.g. different opcodes, specific address calculation,
  *                      page size, etc.
  * @locking_ops:	SPI NOR locking methods.
+ * @otp:		SPI NOR OTP methods.
  */
 struct spi_nor_flash_parameter {
 	u64				size;
@@ -232,6 +273,7 @@ struct spi_nor_flash_parameter {
 	struct spi_nor_pp_command	page_programs[SNOR_CMD_PP_MAX];
 
 	struct spi_nor_erase_map        erase_map;
+	struct spi_nor_otp		otp;
 
 	int (*octal_dtr_enable)(struct spi_nor *nor, bool enable);
 	int (*quad_enable)(struct spi_nor *nor);
@@ -341,6 +383,8 @@ struct flash_info {
 
 	/* Part specific fixup hooks. */
 	const struct spi_nor_fixups *fixups;
+
+	const struct spi_nor_otp_organization otp_org;
 };
 
 /* Used when the "_ext_id" is two bytes at most */
@@ -393,6 +437,14 @@ struct flash_info {
 		.addr_width = 3,					\
 		.flags = SPI_NOR_NO_FR | SPI_NOR_XSR_RDY,
 
+#define OTP_INFO(_len, _n_regions, _base, _offset)			\
+		.otp_org = {						\
+			.len = (_len),					\
+			.base = (_base),				\
+			.offset = (_offset),				\
+			.n_regions = (_n_regions),			\
+		},
+
 /**
  * struct spi_nor_manufacturer - SPI NOR manufacturer object
  * @name: manufacturer name
@@ -473,6 +525,8 @@ int spi_nor_post_bfpt_fixups(struct spi_nor *nor,
 			     const struct sfdp_bfpt *bfpt,
 			     struct spi_nor_flash_parameter *params);
 
+void spi_nor_otp_init(struct spi_nor *nor);
+
 static struct spi_nor __maybe_unused *mtd_to_spi_nor(struct mtd_info *mtd)
 {
 	return mtd->priv;
diff --git a/drivers/mtd/spi-nor/otp.c b/drivers/mtd/spi-nor/otp.c
new file mode 100644
index 000000000000..4e301fd5156b
--- /dev/null
+++ b/drivers/mtd/spi-nor/otp.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * OTP support for SPI NOR flashes
+ *
+ * Copyright (C) 2021 Michael Walle <michael@walle.cc>
+ */
+
+#include <linux/log2.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/spi-nor.h>
+
+#include "core.h"
+
+#define spi_nor_otp_ops(nor) ((nor)->params->otp.ops)
+#define spi_nor_otp_region_len(nor) ((nor)->params->otp.org->len)
+#define spi_nor_otp_n_regions(nor) ((nor)->params->otp.org->n_regions)
+
+static loff_t spi_nor_otp_region_start(const struct spi_nor *nor, int region)
+{
+	const struct spi_nor_otp_organization *org = nor->params->otp.org;
+
+	return org->base + region * org->offset;
+}
+
+static size_t spi_nor_otp_size(struct spi_nor *nor)
+{
+	return spi_nor_otp_n_regions(nor) * spi_nor_otp_region_len(nor);
+}
+
+/*
+ * Translate the file offsets from and to OTP regions. See also
+ * spi_nor_mtd_otp_do_op().
+ */
+static loff_t spi_nor_otp_region_to_offset(struct spi_nor *nor, unsigned int region)
+{
+	return region * spi_nor_otp_region_len(nor);
+}
+
+static unsigned int spi_nor_otp_offset_to_region(struct spi_nor *nor, loff_t ofs)
+{
+	return ofs / spi_nor_otp_region_len(nor);
+}
+
+static int spi_nor_mtd_otp_info(struct mtd_info *mtd, size_t len,
+				size_t *retlen, struct otp_info *buf)
+{
+	struct spi_nor *nor = mtd_to_spi_nor(mtd);
+	const struct spi_nor_otp_ops *ops = spi_nor_otp_ops(nor);
+	unsigned int n_regions = spi_nor_otp_n_regions(nor);
+	unsigned int region;
+	int ret, locked;
+
+	if (len < n_regions * sizeof(*buf))
+		return -ENOSPC;
+
+	ret = spi_nor_lock_and_prep(nor);
+	if (ret)
+		return ret;
+
+	for (region = 0; region < spi_nor_otp_n_regions(nor); region++) {
+		buf->start = spi_nor_otp_region_to_offset(nor, region);
+		buf->length = spi_nor_otp_region_len(nor);
+
+		locked = ops->is_locked(nor, region);
+		if (locked < 0) {
+			ret = locked;
+			goto out;
+		}
+
+		buf->locked = !!locked;
+		buf++;
+	}
+
+	*retlen = n_regions * sizeof(*buf);
+
+out:
+	spi_nor_unlock_and_unprep(nor);
+
+	return ret;
+}
+
+static int spi_nor_mtd_otp_read_write(struct mtd_info *mtd, loff_t ofs,
+				      size_t total_len, size_t *retlen,
+				      u_char *buf, bool is_write)
+{
+	struct spi_nor *nor = mtd_to_spi_nor(mtd);
+	const struct spi_nor_otp_ops *ops = spi_nor_otp_ops(nor);
+	const size_t rlen = spi_nor_otp_region_len(nor);
+	loff_t rstart, rofs;
+	unsigned int region;
+	size_t len;
+	int ret;
+
+	if (ofs < 0 || ofs >= spi_nor_otp_size(nor))
+		return 0;
+
+	ret = spi_nor_lock_and_prep(nor);
+	if (ret)
+		return ret;
+
+	/* don't access beyond the end */
+	total_len = min_t(size_t, total_len, spi_nor_otp_size(nor) - ofs);
+
+	*retlen = 0;
+	while (total_len) {
+		/*
+		 * The OTP regions are mapped into a contiguous area starting
+		 * at 0 as expected by the MTD layer. This will map the MTD
+		 * file offsets to the address of an OTP region as used in the
+		 * actual SPI commands.
+		 */
+		region = spi_nor_otp_offset_to_region(nor, ofs);
+		rstart = spi_nor_otp_region_start(nor, region);
+
+		/*
+		 * The size of a OTP region is expected to be a power of two,
+		 * thus we can just mask the lower bits and get the offset into
+		 * a region.
+		 */
+		rofs = ofs & (rlen - 1);
+
+		/* don't access beyond one OTP region */
+		len = min_t(size_t, total_len, rlen - rofs);
+
+		if (is_write)
+			ret = ops->write(nor, rstart + rofs, len, buf);
+		else
+			ret = ops->read(nor, rstart + rofs, len, buf);
+		if (ret == 0)
+			ret = -EIO;
+		if (ret < 0)
+			goto out;
+
+		*retlen += ret;
+		ofs += ret;
+		buf += ret;
+		total_len -= ret;
+	}
+	ret = 0;
+
+out:
+	spi_nor_unlock_and_unprep(nor);
+	return ret;
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
+	const struct spi_nor_otp_ops *ops = spi_nor_otp_ops(nor);
+	unsigned int region;
+	int ret;
+
+	if (from < 0 || (from + len) > spi_nor_otp_size(nor))
+		return -EINVAL;
+
+	/* the user has to explicitly ask for whole regions */
+	if (len % spi_nor_otp_region_len(nor))
+		return -EINVAL;
+
+	if (from % spi_nor_otp_region_len(nor))
+		return -EINVAL;
+
+	ret = spi_nor_lock_and_prep(nor);
+	if (ret)
+		return ret;
+
+	while (len) {
+		region = spi_nor_otp_offset_to_region(nor, from);
+		ret = ops->lock(nor, region);
+		if (ret)
+			goto out;
+
+		len -= spi_nor_otp_region_len(nor);
+		from += spi_nor_otp_region_len(nor);
+	}
+
+out:
+	spi_nor_unlock_and_unprep(nor);
+
+	return ret;
+}
+
+void spi_nor_otp_init(struct spi_nor *nor)
+{
+	struct mtd_info *mtd = &nor->mtd;
+
+	if (!nor->params->otp.ops)
+		return;
+
+	if (WARN_ON(!is_power_of_2(spi_nor_otp_region_len(nor))))
+		return;
+
+	/*
+	 * We only support user_prot callbacks (yet).
+	 *
+	 * Some SPI NOR flashes like Macronix ones can be ordered in two
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

