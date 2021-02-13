Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9932F31AAB0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 11:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbhBMKAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 05:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhBMKAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 05:00:03 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60F5C061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 01:59:17 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id b145so1134066pfb.4
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 01:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EPmH+KTYm0sc7J3KXd8oTGxPlEtQqqPszkJhsyp7hKY=;
        b=hFTDclujnvaXkydcUpKIBczF/l/tx9w0xGamyo22UcWS5PXDzPjORQlt9qfq53D7Om
         Zzot57l261/X5D6IDlKO7CipTXRRsPdvQGbNyuR9AaYQE+sgu1S+G5R9pScuOg4AD4xP
         ZUEYApfOkJBEC+hgZ/QVKcj3MQlSga6YPYS1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EPmH+KTYm0sc7J3KXd8oTGxPlEtQqqPszkJhsyp7hKY=;
        b=VGoWXzUEMoIstRYFlF8Zj97S+Hw52o89WMxdqAIk1aFj5R6YSaECoacLFO/Z14OoCF
         Tzm1VzCZUeyJkQBTzBGJZpOPkIHpJbeKF/ObFWSlQdeSGnGn/nDqwUaIj8vA0F9czQLN
         lVwXeT62gK2H+cktzJiH/baEd3AGAxMkQOAohiCG3BzqNZGcCQTuagyfbdSTRuz7WlnK
         g4uE4K/fIXUgmRbkv/xHF700KOZDirx313VA30NZ/1RlIvLtDIP/0L/6biGu94HLfuyI
         rR7vwixGMc6gp2qE4bMIrKSkR6/LH407myPa12Updo7fUavBezo/ZwxTXSrA+gs9mJU2
         03WQ==
X-Gm-Message-State: AOAM530Xc3ftL1/jgSdMKN7NQxBC2gZwk/EM8CZBjTv80tA5KA4SOEOi
        8aJKSxELxmuecTQSk7Bwz0H8oC4tuJ2v7w==
X-Google-Smtp-Source: ABdhPJzi01cVzGvcwYU6U/bZN6+OXlJR5MSbs7pUlQWFX8M0tMas6R6SHHXYsyb6cNvqKz4n6+upoQ==
X-Received: by 2002:aa7:96cc:0:b029:1e7:c46b:2954 with SMTP id h12-20020aa796cc0000b02901e7c46b2954mr6828539pfq.68.1613210357198;
        Sat, 13 Feb 2021 01:59:17 -0800 (PST)
Received: from shiro.work (p345188-ipngn200408sizuokaden.shizuoka.ocn.ne.jp. [124.98.97.188])
        by smtp.googlemail.com with ESMTPSA id k24sm11556089pfg.40.2021.02.13.01.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 01:59:16 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-mtd@lists.infradead.org, miquel.raynal@bootlin.com
Cc:     linux-kernel@vger.kernel.org, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2] mtd: spinand: add support for Foresee FS35ND01G-S1Y2
Date:   Sat, 13 Feb 2021 18:57:24 +0900
Message-Id: <20210213095724.3411058-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.30.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Foresee FS35ND01G-S1Y2 manufactured by Longsys.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>

Link: https://datasheet.lcsc.com/szlcsc/2008121142_FORESEE-FS35ND01G-S1Y2QWFI000_C719495.pdf
---
 drivers/mtd/nand/spi/Makefile  |  2 +-
 drivers/mtd/nand/spi/core.c    |  1 +
 drivers/mtd/nand/spi/longsys.c | 86 ++++++++++++++++++++++++++++++++++
 include/linux/mtd/spinand.h    |  1 +
 4 files changed, 89 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mtd/nand/spi/longsys.c

diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
index 9662b9c1d5a9..1d6819022e43 100644
--- a/drivers/mtd/nand/spi/Makefile
+++ b/drivers/mtd/nand/spi/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
-spinand-objs := core.o gigadevice.o macronix.o micron.o paragon.o toshiba.o winbond.o
+spinand-objs := core.o gigadevice.o longsys.o macronix.o micron.o paragon.o toshiba.o winbond.o
 obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 61d932c1b718..8c36f0f6b1c9 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -864,6 +864,7 @@ static const struct nand_ops spinand_ops = {
 
 static const struct spinand_manufacturer *spinand_manufacturers[] = {
 	&gigadevice_spinand_manufacturer,
+	&longsys_spinand_manufacturer,
 	&macronix_spinand_manufacturer,
 	&micron_spinand_manufacturer,
 	&paragon_spinand_manufacturer,
diff --git a/drivers/mtd/nand/spi/longsys.c b/drivers/mtd/nand/spi/longsys.c
new file mode 100644
index 000000000000..418bd5a1f20d
--- /dev/null
+++ b/drivers/mtd/nand/spi/longsys.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 Daniel Palmer <daniel@thingy.jp>
+ *
+ */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/mtd/spinand.h>
+
+#define SPINAND_MFR_LONGSYS		0xCD
+
+static SPINAND_OP_VARIANTS(read_cache_variants,
+		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+
+static SPINAND_OP_VARIANTS(write_cache_variants,
+		SPINAND_PROG_LOAD(true, 0, NULL, 0));
+
+static SPINAND_OP_VARIANTS(update_cache_variants,
+		SPINAND_PROG_LOAD(false, 0, NULL, 0));
+
+static int fs35nd01g_s1y2_ooblayout_ecc(struct mtd_info *mtd, int section,
+					struct mtd_oob_region *region)
+{
+	if (section > 3)
+		return -ERANGE;
+
+	/* ECC is not user accessible */
+	region->offset = 0;
+	region->length = 0;
+
+	return 0;
+}
+
+static int fs35nd01g_s1y2_ooblayout_free(struct mtd_info *mtd, int section,
+				    struct mtd_oob_region *region)
+{
+	if (section > 3)
+		return -ERANGE;
+
+	/*
+	 * No ECC data is stored in the accessible OOB so the full 16 bytes
+	 * of each spare region is available to the user. Apparently also
+	 * covered by the internal ECC.
+	 */
+	if (section) {
+		region->offset = 16 * section;
+		region->length = 16;
+	} else {
+		/* First byte in spare0 area is used for bad block marker */
+		region->offset = 1;
+		region->length = 15;
+	}
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops fs35nd01g_s1y2_ooblayout = {
+	.ecc = fs35nd01g_s1y2_ooblayout_ecc,
+	.free = fs35nd01g_s1y2_ooblayout_free,
+};
+
+static const struct spinand_info longsys_spinand_table[] = {
+	SPINAND_INFO("FS35ND01G-S1Y2",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xEA, 0x11),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&fs35nd01g_s1y2_ooblayout,
+				     NULL)),
+};
+
+static const struct spinand_manufacturer_ops longsys_spinand_manuf_ops = {
+};
+
+const struct spinand_manufacturer longsys_spinand_manufacturer = {
+	.id = SPINAND_MFR_LONGSYS,
+	.name = "Longsys",
+	.chips = longsys_spinand_table,
+	.nchips = ARRAY_SIZE(longsys_spinand_table),
+	.ops = &longsys_spinand_manuf_ops,
+};
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 6bb92f26833e..8651e63a2f8a 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -239,6 +239,7 @@ struct spinand_manufacturer {
 
 /* SPI NAND manufacturers */
 extern const struct spinand_manufacturer gigadevice_spinand_manufacturer;
+extern const struct spinand_manufacturer longsys_spinand_manufacturer;
 extern const struct spinand_manufacturer macronix_spinand_manufacturer;
 extern const struct spinand_manufacturer micron_spinand_manufacturer;
 extern const struct spinand_manufacturer paragon_spinand_manufacturer;
-- 
2.30.0.rc2

