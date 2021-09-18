Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C3C4104AF
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 09:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236629AbhIRHY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 03:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbhIRHY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 03:24:26 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFF2C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 00:23:03 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d18so7645047pll.11
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 00:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3/DBi7RwM1M3KB0MW8LaNgi4t6NDHut6TlL12sSGe3I=;
        b=ee4W6IXi42isoeIZ0wephrXbvBx4HHDA254kQiLwvCc6GiGEzIIV5369o3RPPk5p9z
         wwn/pFJ7gXHA7JDHoULYnmmBTWeS7t6qekNjjx5bSmoujWlpXvsGpDLVaxups4Gigetw
         p7AgFhLyHig56IQMPpXtTsJ5VtzdgZIdOOnDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3/DBi7RwM1M3KB0MW8LaNgi4t6NDHut6TlL12sSGe3I=;
        b=e6GPM+QqofKBKby/wcjVaqtu30YwGStcfL2dJEDKB7SAwo3at4Dv+FGpaAdr0qsM4I
         Mx83hpw2Y6Pf9VcLPA66KI6fbVi7Tzodj0sLnuudGv6WWtngEAsJJGq62L8o5Ego6vih
         aeKUD4P2pjxvfnzxPTiYA2gH8K5Qdsa9Sy4+zlR+jEZ4vguPQySc92u2Z+Kwa7W3HdkP
         qZYZSl6MoVNKLTf3juiNPyh6U6YtEtMJAukDAUvFrlqrBOro8CrsdQ/JvlgGh2K3T3tb
         b8MMS9T63yNgNnBzeTL1sm85NbgSlAiyVAX5dusNm+nW74jRvjrQ3S6QRHxKOvresONL
         6cDg==
X-Gm-Message-State: AOAM533MfLRYc/jbpx1PiorDY4O6wFD0pLdz3FLFgrkibNdYjuL5hRAh
        qGx6uFM15z0SAYGkZe9Cl2DKeQ==
X-Google-Smtp-Source: ABdhPJxYHdiYIx+50COYvEYU/ZRBpmNm7i5m7K/Gj8ydbBTNU4S0LYI1x8J2scs4T700kMM1ysSJ1g==
X-Received: by 2002:a17:902:7103:b0:13d:9a6f:d158 with SMTP id a3-20020a170902710300b0013d9a6fd158mr2562644pll.49.1631949783096;
        Sat, 18 Sep 2021 00:23:03 -0700 (PDT)
Received: from shiro.work (p864106-ipngn200510sizuokaden.shizuoka.ocn.ne.jp. [180.9.58.106])
        by smtp.googlemail.com with ESMTPSA id b7sm8746411pgs.64.2021.09.18.00.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 00:23:02 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-mtd@lists.infradead.org, tudor.ambarus@microchip.com
Cc:     michael@walle.cc, p.yadav@ti.com, linux-kernel@vger.kernel.org,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH] mtd: spi-nor: Add support for ZB25VQ128
Date:   Sat, 18 Sep 2021 16:22:56 +0900
Message-Id: <20210918072256.3505379-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the ZBIT ZB25VQ128 128MBit SPI NOR
flash.

Link: http://www.cipatelje.eu/pdf/ZB25VQ128.pdf
Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 drivers/mtd/spi-nor/Makefile |  1 +
 drivers/mtd/spi-nor/core.c   |  1 +
 drivers/mtd/spi-nor/core.h   |  1 +
 drivers/mtd/spi-nor/zbit.c   | 21 +++++++++++++++++++++
 4 files changed, 24 insertions(+)
 create mode 100644 drivers/mtd/spi-nor/zbit.c

diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
index 6b904e439372..a6f3646824cb 100644
--- a/drivers/mtd/spi-nor/Makefile
+++ b/drivers/mtd/spi-nor/Makefile
@@ -17,6 +17,7 @@ spi-nor-objs			+= sst.o
 spi-nor-objs			+= winbond.o
 spi-nor-objs			+= xilinx.o
 spi-nor-objs			+= xmc.o
+spi-nor-objs			+= zbit.o
 obj-$(CONFIG_MTD_SPI_NOR)	+= spi-nor.o
 
 obj-$(CONFIG_MTD_SPI_NOR)	+= controllers/
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index cc08bd707378..75f6ac9485b9 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1846,6 +1846,7 @@ static const struct spi_nor_manufacturer *manufacturers[] = {
 	&spi_nor_winbond,
 	&spi_nor_xilinx,
 	&spi_nor_xmc,
+	&spi_nor_zbit,
 };
 
 static const struct flash_info *
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 3348e1dd1445..ad3b34a3b80f 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -489,6 +489,7 @@ extern const struct spi_nor_manufacturer spi_nor_sst;
 extern const struct spi_nor_manufacturer spi_nor_winbond;
 extern const struct spi_nor_manufacturer spi_nor_xilinx;
 extern const struct spi_nor_manufacturer spi_nor_xmc;
+extern const struct spi_nor_manufacturer spi_nor_zbit;
 
 extern const struct attribute_group *spi_nor_sysfs_groups[];
 
diff --git a/drivers/mtd/spi-nor/zbit.c b/drivers/mtd/spi-nor/zbit.c
new file mode 100644
index 000000000000..d240dd65d249
--- /dev/null
+++ b/drivers/mtd/spi-nor/zbit.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021, Daniel Palmer<daniel@thingy.jp>
+ */
+
+#include <linux/mtd/spi-nor.h>
+
+#include "core.h"
+
+static const struct flash_info zbit_parts[] = {
+	/* zbit */
+	{ "zb25vq128", INFO(0x5e4018, 0, 64 * 1024, 256,
+			    SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			    SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
+};
+
+const struct spi_nor_manufacturer spi_nor_zbit = {
+	.name = "zbit",
+	.parts = zbit_parts,
+	.nparts = ARRAY_SIZE(zbit_parts),
+};
-- 
2.33.0

