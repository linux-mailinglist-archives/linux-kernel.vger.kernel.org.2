Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E778339717
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 20:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbhCLTGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 14:06:34 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:44189 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbhCLTGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 14:06:06 -0500
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 1A94F2224F;
        Fri, 12 Mar 2021 20:06:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1615575965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=54WT5odVgY6G1Iibvufmnv/spHyjf85yc0gFnkvJHTs=;
        b=kfTeiVrDdViU1Arw0rzLvj6wrF5QynbJpS5rxIguvGAUHrXtMocNsXGfyKmfGFCfJo1V7Q
        svVGpLsksXSFnpuDwTdxgpDtUOghII5mWKK21IunUgoQR635FfOlXUMoW7l7aS+C6RjTeE
        FyTI8Uxh7MrS7/BXdQhwLOIhBR9FN5s=
From:   Michael Walle <michael@walle.cc>
To:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Walle <michael@walle.cc>
Subject: [RFC PATCH 3/3] mtd: spi-nor: add sysfs and SFDP support
Date:   Fri, 12 Mar 2021 20:05:48 +0100
Message-Id: <20210312190548.6954-4-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210312190548.6954-1-michael@walle.cc>
References: <20210312190548.6954-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to dump the SFDP table. Not all flashes list their SFDP
table contents in their datasheet. So having that is useful. It might
also be helpful in bug reports from users.

The idea behind the sysfs module is also to have raw access to the SPI
NOR flash device registers, which can also be useful for debugging.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/Makefile |  2 +-
 drivers/mtd/spi-nor/core.c   |  5 +++
 drivers/mtd/spi-nor/core.h   |  3 ++
 drivers/mtd/spi-nor/sfdp.c   |  4 +-
 drivers/mtd/spi-nor/sfdp.h   |  2 +
 drivers/mtd/spi-nor/sysfs.c  | 73 ++++++++++++++++++++++++++++++++++++
 6 files changed, 86 insertions(+), 3 deletions(-)
 create mode 100644 drivers/mtd/spi-nor/sysfs.c

diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
index 653923896205..aff308f75987 100644
--- a/drivers/mtd/spi-nor/Makefile
+++ b/drivers/mtd/spi-nor/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-spi-nor-objs			:= core.o sfdp.o
+spi-nor-objs			:= core.o sfdp.o sysfs.o
 spi-nor-objs			+= atmel.o
 spi-nor-objs			+= catalyst.o
 spi-nor-objs			+= eon.o
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 4a315cb1c4db..2eaf4ba8c0f3 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3707,6 +3707,10 @@ static int spi_nor_probe(struct spi_mem *spimem)
 	if (ret)
 		return ret;
 
+	ret = spi_nor_sysfs_create(nor);
+	if (ret)
+		return ret;
+
 	return mtd_device_register(&nor->mtd, data ? data->parts : NULL,
 				   data ? data->nr_parts : 0);
 }
@@ -3716,6 +3720,7 @@ static int spi_nor_remove(struct spi_mem *spimem)
 	struct spi_nor *nor = spi_mem_get_drvdata(spimem);
 
 	spi_nor_restore(nor);
+	spi_nor_sysfs_remove(nor);
 
 	/* Clean up MTD stuff. */
 	return mtd_device_unregister(&nor->mtd);
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 4a3f7f150b5d..43c0d6eaf679 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -478,4 +478,7 @@ static struct spi_nor __maybe_unused *mtd_to_spi_nor(struct mtd_info *mtd)
 	return mtd->priv;
 }
 
+int spi_nor_sysfs_create(struct spi_nor *nor);
+void spi_nor_sysfs_remove(struct spi_nor *nor);
+
 #endif /* __LINUX_MTD_SPI_NOR_INTERNAL_H */
diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index 47634ec9b899..62e58f14c197 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -219,8 +219,8 @@ static int spi_nor_read_sfdp(struct spi_nor *nor, u32 addr,
  * Return: -ENOMEM if kmalloc() fails, the return code of spi_nor_read_sfdp()
  *          otherwise.
  */
-static int spi_nor_read_sfdp_dma_unsafe(struct spi_nor *nor, u32 addr,
-					size_t len, void *buf)
+int spi_nor_read_sfdp_dma_unsafe(struct spi_nor *nor, u32 addr,
+				 size_t len, void *buf)
 {
 	void *dma_safe_buf;
 	int ret;
diff --git a/drivers/mtd/spi-nor/sfdp.h b/drivers/mtd/spi-nor/sfdp.h
index 89152ae1cf3e..11ce208e0cd7 100644
--- a/drivers/mtd/spi-nor/sfdp.h
+++ b/drivers/mtd/spi-nor/sfdp.h
@@ -109,5 +109,7 @@ struct sfdp_parameter_header {
 
 int spi_nor_parse_sfdp(struct spi_nor *nor,
 		       struct spi_nor_flash_parameter *params);
+int spi_nor_read_sfdp_dma_unsafe(struct spi_nor *nor, u32 addr,
+				 size_t len, void *buf);
 
 #endif /* __LINUX_MTD_SFDP_H */
diff --git a/drivers/mtd/spi-nor/sysfs.c b/drivers/mtd/spi-nor/sysfs.c
new file mode 100644
index 000000000000..53641f964a2c
--- /dev/null
+++ b/drivers/mtd/spi-nor/sysfs.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/mtd/spi-nor.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi-mem.h>
+#include <linux/sysfs.h>
+
+#include "core.h"
+
+static ssize_t sfdp_read(struct file *filp, struct kobject *kobj,
+			 struct bin_attribute *bin_attr, char *buf,
+			 loff_t off, size_t count)
+{
+	struct spi_device *spi = to_spi_device(kobj_to_dev(kobj));
+	struct spi_mem *spimem = spi_get_drvdata(spi);
+	struct spi_nor *nor = spi_mem_get_drvdata(spimem);
+	int ret;
+
+	ret = spi_nor_lock_and_prep(nor);
+	if (ret)
+		return ret;
+
+	if (off >= nor->sfdp_size) {
+		ret = 0;
+	} else {
+		if (off + count > nor->sfdp_size)
+			count = nor->sfdp_size - off;
+
+		ret = spi_nor_read_sfdp_dma_unsafe(nor, off, count, buf);
+		if (ret < 0)
+			ret = -EIO;
+		else
+			ret = count;
+	}
+
+	spi_nor_unlock_and_unprep(nor);
+	return ret;
+}
+static BIN_ATTR_RO(sfdp, PAGE_SIZE);
+
+static struct bin_attribute *spi_nor_sysfs_bin_entries[] = {
+	&bin_attr_sfdp,
+	NULL
+};
+
+static umode_t spi_nor_sysfs_is_bin_visible(struct kobject *kobj,
+					    struct bin_attribute *attr, int n)
+{
+	struct spi_device *spi = to_spi_device(kobj_to_dev(kobj));
+	struct spi_mem *spimem = spi_get_drvdata(spi);
+	struct spi_nor *nor = spi_mem_get_drvdata(spimem);
+
+	if (attr == &bin_attr_sfdp && !nor->sfdp_size)
+		return 0;
+
+	return 0400;
+}
+
+static struct attribute_group spi_nor_sysfs_attr_group = {
+	.name		= NULL,
+	.is_bin_visible	= spi_nor_sysfs_is_bin_visible,
+	.bin_attrs	= spi_nor_sysfs_bin_entries,
+};
+
+int spi_nor_sysfs_create(struct spi_nor *nor)
+{
+	return sysfs_create_group(&nor->dev->kobj, &spi_nor_sysfs_attr_group);
+}
+
+void spi_nor_sysfs_remove(struct spi_nor *nor)
+{
+	sysfs_remove_group(&nor->dev->kobj, &spi_nor_sysfs_attr_group);
+}
-- 
2.20.1

