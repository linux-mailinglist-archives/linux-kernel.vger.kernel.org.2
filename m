Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED063124AB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 15:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhBGOY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 09:24:58 -0500
Received: from mail.figgyc.uk ([204.13.154.60]:52860 "EHLO mail.figgyc.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229751AbhBGOXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 09:23:13 -0500
X-Greylist: delayed 1842 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Feb 2021 09:23:12 EST
DKIM-Signature: a=rsa-sha256; bh=+W9jqtvjB4TFcPdtNzGomMX3JEdWSo19rZS32GgHeps=;
 c=relaxed/relaxed; d=figgyc.uk;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:Message-Id:Message-Id:References:Autocrypt:Openpgp;
 i=@figgyc.uk; s=default; t=1612702155; v=1; x=1613134155;
 b=kUPbvntvILEmdDvbWOg/nngyACr6u3Y1nQQiV8y7bVYhpVSciUFHaUZm7gTIu01aXbeIrhuF
 TuJNeyzk5Po2h++uIUbyzfk7uLWixa19pNjHZgLrfHKEqaPKPgisaaJgrKA9+/M3FiCrLIv1TsD
 G8W0mmgbABCD6gZRj4+419574XDqdTHoWgiAgS82Wf+fFHII51KUyXv7Jh+rKhVOWyfcuTlXimJ
 mqJriIkgMcsTvVsEnFl+1y1G2vQIx2QHoPb8kpn80ZTuF/6+kS7zvmr1ivXcTewIW5xDasCCXYN
 3I9DiUU9FuDKb3N7wUpzq4bkBq7rytWuEQn/sQnW4l5dQ==
Received: by mail.figgyc.uk (envelope-sender <figgyc@figgyc.uk>) with ESMTPS
 id 90dc45c2; Sun, 07 Feb 2021 07:49:15 -0500
From:   George Brooke <figgyc@figgyc.uk>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     George Brooke <figgyc@figgyc.uk>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH] mtd: spi-nor: boya: add support for boya by25q128as
Date:   Sun,  7 Feb 2021 12:30:34 +0000
Message-Id: <20210207123032.516207-1-figgyc@figgyc.uk>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for the Boya Microelectronics BY25Q128AS 128 Mbit flash.
I tested this on the Creality WB-01 embedded device which uses this,
although that was with OpenWrt which is still using 5.4 so I had to
do a bit of porting work. Don't see how that would make much of a
difference though.

Signed-off-by: George Brooke <figgyc@figgyc.uk>
---
 drivers/mtd/spi-nor/Makefile |  1 +
 drivers/mtd/spi-nor/boya.c   | 23 +++++++++++++++++++++++
 drivers/mtd/spi-nor/core.c   |  1 +
 drivers/mtd/spi-nor/core.h   |  1 +
 4 files changed, 26 insertions(+)
 create mode 100644 drivers/mtd/spi-nor/boya.c

diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
index 653923896205..7d1551fbfbaa 100644
--- a/drivers/mtd/spi-nor/Makefile
+++ b/drivers/mtd/spi-nor/Makefile
@@ -2,6 +2,7 @@
 
 spi-nor-objs			:= core.o sfdp.o
 spi-nor-objs			+= atmel.o
+spi-nor-objs			+= boya.o
 spi-nor-objs			+= catalyst.o
 spi-nor-objs			+= eon.o
 spi-nor-objs			+= esmt.o
diff --git a/drivers/mtd/spi-nor/boya.c b/drivers/mtd/spi-nor/boya.c
new file mode 100644
index 000000000000..014b0087048a
--- /dev/null
+++ b/drivers/mtd/spi-nor/boya.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2005, Intec Automation Inc.
+ * Copyright (C) 2014, Freescale Semiconductor, Inc.
+ */
+
+#include <linux/mtd/spi-nor.h>
+
+#include "core.h"
+
+static const struct flash_info boya_parts[] = {
+	/* Boya */
+	{ "by25q128as", INFO(0x684018, 0, 64 * 1024, 256,
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
+	},
+};
+
+const struct spi_nor_manufacturer spi_nor_boya = {
+	.name = "boya",
+	.parts = boya_parts,
+	.nparts = ARRAY_SIZE(boya_parts),
+};
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 20df44b753da..4d0d003e9c3f 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2160,6 +2160,7 @@ int spi_nor_sr2_bit7_quad_enable(struct spi_nor *nor)
 
 static const struct spi_nor_manufacturer *manufacturers[] = {
 	&spi_nor_atmel,
+	&spi_nor_boya,
 	&spi_nor_catalyst,
 	&spi_nor_eon,
 	&spi_nor_esmt,
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index d631ee299de3..d5ed5217228b 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -409,6 +409,7 @@ struct spi_nor_manufacturer {
 
 /* Manufacturer drivers. */
 extern const struct spi_nor_manufacturer spi_nor_atmel;
+extern const struct spi_nor_manufacturer spi_nor_boya;
 extern const struct spi_nor_manufacturer spi_nor_catalyst;
 extern const struct spi_nor_manufacturer spi_nor_eon;
 extern const struct spi_nor_manufacturer spi_nor_esmt;
-- 
2.30.0

