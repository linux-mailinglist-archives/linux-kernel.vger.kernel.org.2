Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2D2404023
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 22:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350338AbhIHUSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 16:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349690AbhIHUSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 16:18:11 -0400
Received: from yawp.biot.com (yawp.biot.com [IPv6:2a01:4f8:10a:8e::fce2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F29FC061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 13:17:02 -0700 (PDT)
Received: from debian-spamd by yawp.biot.com with sa-checked (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1mO40B-00CUsB-TM
        for linux-kernel@vger.kernel.org; Wed, 08 Sep 2021 22:17:00 +0200
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on yawp
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.4
Received: from [2a02:578:460c:1:ae1f:6bff:fed1:9ca8] (helo=sumner.biot.com)
        by yawp.biot.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1mO3zg-00CUpr-91; Wed, 08 Sep 2021 22:16:28 +0200
Received: from bert by sumner.biot.com with local (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1mO3zf-000zpp-EB; Wed, 08 Sep 2021 22:16:27 +0200
From:   Bert Vermeulen <bert@biot.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Bert Vermeulen <bert@biot.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Mark Brown <broonie@kernel.org>,
        Alexander Lobakin <alobakin@pm.me>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH v2] mtd: spinand: Add support for Etron EM73D044VCx
Date:   Wed,  8 Sep 2021 22:16:19 +0200
Message-Id: <20210908201624.237634-1-bert@biot.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a new vendor Etron, and support for a 2Gb chip.

The datasheet is available at
https://www.etron.com/cn/products/EM73%5B8%5DC%5BD_E_F%5DVC%20SPI%20NAND%20Flash_Promotion_Rev%201_00A.pdf

Signed-off-by: Bert Vermeulen <bert@biot.com>
---
v2:
- Made ooblayout_free/_ecc depend on chip-specific parameters, instead of
  hardcoded to this 2Gb chip only
- Fixed manufacturer ordering
- Fixed minor formatting issues as reported
- Removed debug comment

 drivers/mtd/nand/spi/Makefile |   2 +-
 drivers/mtd/nand/spi/core.c   |   1 +
 drivers/mtd/nand/spi/etron.c  | 104 ++++++++++++++++++++++++++++++++++
 include/linux/mtd/spinand.h   |   1 +
 4 files changed, 107 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mtd/nand/spi/etron.c

diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
index 9662b9c1d5a9..cc3c4e046ea9 100644
--- a/drivers/mtd/nand/spi/Makefile
+++ b/drivers/mtd/nand/spi/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
-spinand-objs := core.o gigadevice.o macronix.o micron.o paragon.o toshiba.o winbond.o
+spinand-objs := core.o etron.o gigadevice.o macronix.o micron.o paragon.o toshiba.o winbond.o
 obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 446ba8d43fbc..2cbf25b8caa2 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -894,6 +894,7 @@ static const struct nand_ops spinand_ops = {
 };
 
 static const struct spinand_manufacturer *spinand_manufacturers[] = {
+	&etron_spinand_manufacturer,
 	&gigadevice_spinand_manufacturer,
 	&macronix_spinand_manufacturer,
 	&micron_spinand_manufacturer,
diff --git a/drivers/mtd/nand/spi/etron.c b/drivers/mtd/nand/spi/etron.c
new file mode 100644
index 000000000000..1a92b9cf3043
--- /dev/null
+++ b/drivers/mtd/nand/spi/etron.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/mtd/spinand.h>
+
+#define SPINAND_MFR_ETRON			0xd5
+
+static SPINAND_OP_VARIANTS(read_cache_variants,
+		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+
+static SPINAND_OP_VARIANTS(write_cache_variants,
+		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
+		SPINAND_PROG_LOAD(true, 0, NULL, 0));
+
+static SPINAND_OP_VARIANTS(update_cache_variants,
+		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
+		SPINAND_PROG_LOAD(false, 0, NULL, 0));
+
+static int etron_oob_spare(struct mtd_info *mtd)
+{
+	if (mtd->size < 0x10000000)
+		return mtd->oobsize / 2;
+	else
+		return mtd->oobsize / 2 + mtd->oobsize / 16;
+}
+
+static int etron_ooblayout_ecc(struct mtd_info *mtd, int section,
+					struct mtd_oob_region *oobregion)
+{
+	if (section)
+		return -ERANGE;
+
+	oobregion->offset = etron_oob_spare(mtd);
+	oobregion->length = mtd->oobsize - oobregion->offset;
+
+	return 0;
+}
+
+static int etron_ooblayout_free(struct mtd_info *mtd, int section,
+			   struct mtd_oob_region *oobregion)
+{
+	if (section)
+		return -ERANGE;
+
+	oobregion->offset = 2;
+	oobregion->length = etron_oob_spare(mtd) - 2;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops etron_ooblayout = {
+	.ecc = etron_ooblayout_ecc,
+	.free = etron_ooblayout_free,
+};
+
+static int etron_ecc_get_status(struct spinand_device *spinand, u8 status)
+{
+	switch (status & STATUS_ECC_MASK) {
+	case STATUS_ECC_NO_BITFLIPS:
+		return 0;
+
+	case STATUS_ECC_HAS_BITFLIPS:
+		/* Between 1-7 bitflips were corrected */
+		return 7;
+
+	case STATUS_ECC_MASK:
+		/* Maximum bitflips were corrected */
+		return 8;
+
+	case STATUS_ECC_UNCOR_ERROR:
+		return -EBADMSG;
+	}
+
+	return -EINVAL;
+}
+
+static const struct spinand_info etron_spinand_table[] = {
+	SPINAND_INFO("EM73D044VCx",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x1f),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&etron_ooblayout, etron_ecc_get_status)),
+};
+
+static const struct spinand_manufacturer_ops etron_spinand_manuf_ops = {
+};
+
+const struct spinand_manufacturer etron_spinand_manufacturer = {
+	.id = SPINAND_MFR_ETRON,
+	.name = "Etron",
+	.chips = etron_spinand_table,
+	.nchips = ARRAY_SIZE(etron_spinand_table),
+	.ops = &etron_spinand_manuf_ops,
+};
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 6988956b8492..d7c0a0439652 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -260,6 +260,7 @@ struct spinand_manufacturer {
 };
 
 /* SPI NAND manufacturers */
+extern const struct spinand_manufacturer etron_spinand_manufacturer;
 extern const struct spinand_manufacturer gigadevice_spinand_manufacturer;
 extern const struct spinand_manufacturer macronix_spinand_manufacturer;
 extern const struct spinand_manufacturer micron_spinand_manufacturer;
-- 
2.25.1

