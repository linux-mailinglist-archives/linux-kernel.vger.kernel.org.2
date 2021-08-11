Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11CE3E8C71
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 10:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236260AbhHKIv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 04:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhHKIvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 04:51:55 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87088C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 01:51:32 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id t3so1748487plg.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 01:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7vn1eldgbv11PV6+xbV5jWseW1R8cuS20m4woT+uMpA=;
        b=bImmEc8rUsnx7O3YDjx4SMdyB5LjrzuWSVS+d19JS4Bvuh0I0MDJddl9RWl//ljE9p
         /AjgyOczhJH57r6h5AwBOE3gCVpUCzyNlsnRniuMBvc1PDSJBJbgceE6FSgRkhc2yqYR
         R+ukyzrGl1vPmXgYzoM8z8qXeuH2ZdoPeh7OA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7vn1eldgbv11PV6+xbV5jWseW1R8cuS20m4woT+uMpA=;
        b=ZVaO1GenCWpHAcIkQY8FlBlhXQ+4TLL8e5DRLAmSxk0u1Fx3DgQ+GYd2dw4uEp2Z/i
         hQf5IHWmXvGAmcwCeOZjGu53KiRprF2lgCKukMpxjcswo7BXMuWHkOfOgqmuLMdfj8/w
         Au15VUVr+nyniH3n9hfhAQm7EGZrge+X1SGFBSyZ8SKDRVUaiiuD2fQuiJL1k28QlnWq
         W1ik0KUg9+2nO0UOi65WJql+sGfZbetxc6ZXWp5ZRc3veUQzE/o7owHrovdSI58+qWzP
         G/EEvXIL20r+ArhrTctBIhDKZ6TL0h4evFFKeRVcAnybwWWNOZNDislLpIpV37hsh1P2
         gF4Q==
X-Gm-Message-State: AOAM532BpYSdxzRX6OE0OvIccLsyUYAHbhTtFAG317xNz1pUadz41f51
        8mbdIkhO3IQu/3C+O8OmJHOyZQ==
X-Google-Smtp-Source: ABdhPJzyyofg68LqLd3IEv7hF5/lLSnYCz8QJZvRcSjm+UlCxruIjcZ/S6MIAYlbUozesqOU9TG4qA==
X-Received: by 2002:a17:90b:3007:: with SMTP id hg7mr9524316pjb.66.1628671892015;
        Wed, 11 Aug 2021 01:51:32 -0700 (PDT)
Received: from shiro.work (p866038-ipngn200510sizuokaden.shizuoka.ocn.ne.jp. [180.9.60.38])
        by smtp.googlemail.com with ESMTPSA id ga8sm5704348pjb.4.2021.08.11.01.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 01:51:31 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-mtd@lists.infradead.org, miquel.raynal@bootlin.com,
        richard@nod.at
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v3] mtd: spinand: add support for Foresee FS35ND0*G parts
Date:   Wed, 11 Aug 2021 17:49:24 +0900
Message-Id: <20210811084924.52293-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the various Foresee FS35ND0*G parts manufactured by Longsys.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>

Link: https://datasheet.lcsc.com/szlcsc/2008121142_FORESEE-FS35ND01G-S1Y2QWFI000_C719495.pdf
---
 Changes since v2:
 - Originally I only had the 1Gbit version of this chip, now I have the 2Gbit and 4Gbit
   variations so I've added support for those too. There is no datasheet for the bigger
   chips but they are documented in a flashing tool from an SoC vendor so I took the parameters
   from there.
 - Previous versions of this patch only had single io read cache variants. My SPI flash driver
   now supports dual and quad io for reading so I added and tested those modes too.
   My driver/hardware only supports single io for writing so those are still left out.
 - Implemented proper logic for checking the ECC status.
 - Combined with the previous patch for 1-filling the OOB in the page buffer before writing
   I have been using this for a few months now without anything getting broken.
 
 drivers/mtd/nand/spi/Makefile  |   2 +-
 drivers/mtd/nand/spi/core.c    |   1 +
 drivers/mtd/nand/spi/longsys.c | 134 +++++++++++++++++++++++++++++++++
 include/linux/mtd/spinand.h    |   1 +
 4 files changed, 137 insertions(+), 1 deletion(-)
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
index 446ba8d43fbc..48f635d5c1ff 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -895,6 +895,7 @@ static const struct nand_ops spinand_ops = {
 
 static const struct spinand_manufacturer *spinand_manufacturers[] = {
 	&gigadevice_spinand_manufacturer,
+	&longsys_spinand_manufacturer,
 	&macronix_spinand_manufacturer,
 	&micron_spinand_manufacturer,
 	&paragon_spinand_manufacturer,
diff --git a/drivers/mtd/nand/spi/longsys.c b/drivers/mtd/nand/spi/longsys.c
new file mode 100644
index 000000000000..ee38f8728262
--- /dev/null
+++ b/drivers/mtd/nand/spi/longsys.c
@@ -0,0 +1,134 @@
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
+#define SPINAND_MFR_LONGSYS			0xCD
+#define FS35ND01G_S1Y2_STATUS_ECC_0_3_BITFLIPS	(0 << 4)
+#define FS35ND01G_S1Y2_STATUS_ECC_4_BITFLIPS	(1 << 4)
+#define FS35ND01G_S1Y2_STATUS_ECC_UNCORRECTABLE	(2 << 4)
+
+static SPINAND_OP_VARIANTS(read_cache_variants,
+		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
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
+static int fs35nd01g_s1y2_ecc_get_status(struct spinand_device *spinand,
+					u8 status)
+{
+	switch (status & STATUS_ECC_MASK) {
+	case FS35ND01G_S1Y2_STATUS_ECC_0_3_BITFLIPS:
+		return 3;
+	/*
+	 * The datasheet says *successful* with 4 bits flipped.
+	 * nandbiterrs always complains that the read reported
+	 * successful but the data is incorrect.
+	 */
+	case FS35ND01G_S1Y2_STATUS_ECC_4_BITFLIPS:
+		return 4;
+	case FS35ND01G_S1Y2_STATUS_ECC_UNCORRECTABLE:
+		return -EBADMSG;
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
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
+				     fs35nd01g_s1y2_ecc_get_status)),
+	SPINAND_INFO("FS35ND02G-S3Y2",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xEB, 0x11),
+		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&fs35nd01g_s1y2_ooblayout,
+				     fs35nd01g_s1y2_ecc_get_status)),
+	SPINAND_INFO("FS35ND04G-S2Y2",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xEC, 0x11),
+		     NAND_MEMORG(1, 2048, 64, 64, 4096, 40, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&fs35nd01g_s1y2_ooblayout,
+				     fs35nd01g_s1y2_ecc_get_status)),
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
index 6988956b8492..f6c38528bb03 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -261,6 +261,7 @@ struct spinand_manufacturer {
 
 /* SPI NAND manufacturers */
 extern const struct spinand_manufacturer gigadevice_spinand_manufacturer;
+extern const struct spinand_manufacturer longsys_spinand_manufacturer;
 extern const struct spinand_manufacturer macronix_spinand_manufacturer;
 extern const struct spinand_manufacturer micron_spinand_manufacturer;
 extern const struct spinand_manufacturer paragon_spinand_manufacturer;
-- 
2.32.0

