Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61363401F9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 10:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhCRJYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 05:24:35 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:43587 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbhCRJYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 05:24:17 -0400
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 339AF22238;
        Thu, 18 Mar 2021 10:24:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1616059456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x1RzcItq5v/y0wlF/sHuAoN9R5vuwI3duqRdfa+Bo5I=;
        b=GkTTYuNPiFqu+3yTWbWMalhDTlaaU/NgdmM3urU8sm5XjsOXfAd5CfpCYyMMGRQ0GFjsI2
        0vfZWS3FVhJ15v7BQhWSNdsNY+f7aut15e4wlV8xQKbFzErtbSQ+f46yNRUzDCNght5ngs
        Kvbki02Inzo2GAiPxyuMjpPsQp0AcGc=
From:   Michael Walle <michael@walle.cc>
To:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 2/2] mtd: spi-nor: add initial sysfs support
Date:   Thu, 18 Mar 2021 10:24:06 +0100
Message-Id: <20210318092406.5340-3-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210318092406.5340-1-michael@walle.cc>
References: <20210318092406.5340-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to show the name and JEDEC identifier as well as to dump the
SFDP table. Not all flashes list their SFDP table contents in their
datasheet. So having that is useful. It might also be helpful in bug
reports from users.

The idea behind the sysfs module is also to have raw access to the SPI
NOR flash device registers, which can also be useful for debugging.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/Makefile |  2 +-
 drivers/mtd/spi-nor/core.c   |  5 +++
 drivers/mtd/spi-nor/core.h   |  3 ++
 drivers/mtd/spi-nor/sysfs.c  | 86 ++++++++++++++++++++++++++++++++++++
 4 files changed, 95 insertions(+), 1 deletion(-)
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
index 668f22011b1d..dd592f7b62d1 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -488,4 +488,7 @@ static struct spi_nor __maybe_unused *mtd_to_spi_nor(struct mtd_info *mtd)
 	return mtd->priv;
 }
 
+int spi_nor_sysfs_create(struct spi_nor *nor);
+void spi_nor_sysfs_remove(struct spi_nor *nor);
+
 #endif /* __LINUX_MTD_SPI_NOR_INTERNAL_H */
diff --git a/drivers/mtd/spi-nor/sysfs.c b/drivers/mtd/spi-nor/sysfs.c
new file mode 100644
index 000000000000..0de031e246c5
--- /dev/null
+++ b/drivers/mtd/spi-nor/sysfs.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/mtd/spi-nor.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi-mem.h>
+#include <linux/sysfs.h>
+
+#include "core.h"
+
+static ssize_t name_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	struct spi_mem *spimem = spi_get_drvdata(spi);
+	struct spi_nor *nor = spi_mem_get_drvdata(spimem);
+
+	return sprintf(buf, "%s\n", nor->info->name);
+}
+static DEVICE_ATTR_RO(name);
+
+static ssize_t jedec_id_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	struct spi_mem *spimem = spi_get_drvdata(spi);
+	struct spi_nor *nor = spi_mem_get_drvdata(spimem);
+
+	return sprintf(buf, "%*phN\n", nor->info->id_len, nor->info->id);
+}
+static DEVICE_ATTR_RO(jedec_id);
+
+static struct attribute *spi_nor_sysfs_entries[] = {
+	&dev_attr_name.attr,
+	&dev_attr_jedec_id.attr,
+	NULL
+};
+
+static ssize_t sfdp_read(struct file *filp, struct kobject *kobj,
+			 struct bin_attribute *bin_attr, char *buf,
+			 loff_t off, size_t count)
+{
+	struct spi_device *spi = to_spi_device(kobj_to_dev(kobj));
+	struct spi_mem *spimem = spi_get_drvdata(spi);
+	struct spi_nor *nor = spi_mem_get_drvdata(spimem);
+	struct sfdp *sfdp = nor->sfdp;
+	size_t sfdp_size = sfdp->num_dwords * sizeof(*sfdp->dwords);
+
+	return memory_read_from_buffer(buf, count, &off, nor->sfdp->dwords,
+				       sfdp_size);
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
+	if (attr == &bin_attr_sfdp && nor->sfdp)
+		return 0444;
+
+	return 0;
+}
+
+static struct attribute_group spi_nor_sysfs_attr_group = {
+	.name		= NULL,
+	.is_bin_visible	= spi_nor_sysfs_is_bin_visible,
+	.attrs		= spi_nor_sysfs_entries,
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

