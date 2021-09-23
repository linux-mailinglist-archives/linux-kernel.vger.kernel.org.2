Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74045415547
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 03:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238854AbhIWBye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 21:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238177AbhIWByd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 21:54:33 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7342C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 18:53:02 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id k23so3404918pji.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 18:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w0m5pdek4/Gq1QH2qsR623RAqp8S4w0CIYDU8k0g4bU=;
        b=BUoFK1r5RSCFV/uRZjVqL+dHE46j0i1MvEN7pDEkDjJXk0g4IGvc1IHE/KzleL/nVJ
         AlpmCUjD0ft9fxxjplyJEknzk/ccTQ9+skhxE+tzkYsDrvxwxCfyVvPxFLlZkGgT3Zzf
         ZEPon+UzG6IMtYqCkE7By0iyZUMHlj/Xi2HpX5cXyuOTzu9Ddqst2Wzditgko+9AxFaH
         zn13CU7+dADFILWLUkxLGWfuJP+XEZBm+ACC5DP5tRMxitPLMB8GKwtX0qFMJXco3Nby
         tVjfNBVN7OtUJiIcaY7cX+x5Wg40a8V2BFuszlhxVlQUrupZppZ0b5gEyleIovw0kdCf
         Ixww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w0m5pdek4/Gq1QH2qsR623RAqp8S4w0CIYDU8k0g4bU=;
        b=hAXacxEyR0dQSkBWjR08nkZg+IF+71eW7vqArGWbmbTDepnNt/DbeP3f5wQ0IFrDxn
         PM1Bkp8L7xt998imf6fy+rTHu3bOiJL9bFfCZ8r+yL4BPkduUdOngvcnkTjOllYLe5+X
         GHfAo9P5YLRfrym0DP3oAJt5a2Y3iB8Ts6aBChmCmQfXc7F8ejGVWylOZg5QbcibaCHs
         V9imh3bH2K7YrRJfqyFnAdWJBLMzQa+jlT6AyZXJgvppAsPwCifyHOFPupxIqe/sTKGD
         s3wizZNl6r3/Ct2/zeFi8qSx98Uqnuqph3GL9IhQZFK83NW5dPHww9ncGsVwemZofqo1
         uYTw==
X-Gm-Message-State: AOAM533fliF7Uym93zWPuGxK0rvTm/B13KzDJaPHeW20Sy/P4DwoBN0X
        vF9awVMiQIWSaAKFcvwUBvk=
X-Google-Smtp-Source: ABdhPJxs6u80+faOKJAOnx9x4qwGGUXf1Yvy5bBQt7Ev51KiqgzuezEAQHTFxl9kXvANOo+hDI2ihw==
X-Received: by 2002:a17:90b:4f82:: with SMTP id qe2mr15018514pjb.131.1632361982158;
        Wed, 22 Sep 2021 18:53:02 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id g13sm3654396pfi.176.2021.09.22.18.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 18:53:01 -0700 (PDT)
From:   CGEL <cgel.zte@gmail.com>
X-Google-Original-From: CGEL <ren.xiaohui@zte.com.cn>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Alexander Lobakin <alobakin@pm.me>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Ren Xiaohui <ren.xiaohui@zte.com.cn>
Subject: [PATCH] mtd: spinand: add merge-two-spinand function
Date:   Thu, 23 Sep 2021 01:52:41 +0000
Message-Id: <20210923015241.248910-1-ren.xiaohui@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ren Xiaohui <ren.xiaohui@zte.com.cn>

Combine the two SPI NAND flash in the MTD layer

Signed-off-by: Ren Xiaohui <ren.xiaohui@zte.com.cn>
---
 drivers/mtd/nand/spi/Kconfig          |   8 +
 drivers/mtd/nand/spi/Makefile         |   2 +-
 drivers/mtd/nand/spi/core.c           |  36 +++-
 drivers/mtd/nand/spi/spi_nand_merge.c | 350 ++++++++++++++++++++++++++++++++++
 include/linux/mtd/spinand.h           |  14 +-
 5 files changed, 400 insertions(+), 10 deletions(-)
 create mode 100644 drivers/mtd/nand/spi/spi_nand_merge.c

diff --git a/drivers/mtd/nand/spi/Kconfig b/drivers/mtd/nand/spi/Kconfig
index 3d7649a..6aec3ef 100644
--- a/drivers/mtd/nand/spi/Kconfig
+++ b/drivers/mtd/nand/spi/Kconfig
@@ -7,3 +7,11 @@ menuconfig MTD_SPI_NAND
 	select SPI_MEM
 	help
 	  This is the framework for the SPI NAND device drivers.
+
+menuconfig MTD_SPI_NAND_MERGE
+	tristate "Two SPI NAND merge a mtd device"
+	select MTD_NAND_CORE
+	depends on MTD_SPI_NAND
+	select SPI_MEM
+	help
+	  This is the framework for Two SPI NAND merge a mtd device.
diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
index 9662b9c..5d6475d 100644
--- a/drivers/mtd/nand/spi/Makefile
+++ b/drivers/mtd/nand/spi/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
-spinand-objs := core.o gigadevice.o macronix.o micron.o paragon.o toshiba.o winbond.o
+spinand-objs := core.o gigadevice.o macronix.o micron.o paragon.o spi_nand_merge.o toshiba.o winbond.o
 obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 2c8685f..ee5e653 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -624,7 +624,7 @@ static int spinand_write_page(struct spinand_device *spinand,
 	return nand_ecc_finish_io_req(nand, (struct nand_page_io_req *)req);
 }
 
-static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
+int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 			    struct mtd_oob_ops *ops)
 {
 	struct spinand_device *spinand = mtd_to_spinand(mtd);
@@ -669,8 +669,9 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 
 	return ret ? ret : max_bitflips;
 }
+EXPORT_SYMBOL(spinand_mtd_read);
 
-static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
+int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
 			     struct mtd_oob_ops *ops)
 {
 	struct spinand_device *spinand = mtd_to_spinand(mtd);
@@ -704,6 +705,7 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
 
 	return ret;
 }
+EXPORT_SYMBOL(spinand_mtd_write);
 
 static bool spinand_isbad(struct nand_device *nand, const struct nand_pos *pos)
 {
@@ -725,7 +727,7 @@ static bool spinand_isbad(struct nand_device *nand, const struct nand_pos *pos)
 	return false;
 }
 
-static int spinand_mtd_block_isbad(struct mtd_info *mtd, loff_t offs)
+int spinand_mtd_block_isbad(struct mtd_info *mtd, loff_t offs)
 {
 	struct nand_device *nand = mtd_to_nanddev(mtd);
 	struct spinand_device *spinand = nand_to_spinand(nand);
@@ -739,6 +741,7 @@ static int spinand_mtd_block_isbad(struct mtd_info *mtd, loff_t offs)
 
 	return ret;
 }
+EXPORT_SYMBOL(spinand_mtd_block_isbad);
 
 static int spinand_markbad(struct nand_device *nand, const struct nand_pos *pos)
 {
@@ -764,7 +767,7 @@ static int spinand_markbad(struct nand_device *nand, const struct nand_pos *pos)
 	return spinand_write_page(spinand, &req);
 }
 
-static int spinand_mtd_block_markbad(struct mtd_info *mtd, loff_t offs)
+int spinand_mtd_block_markbad(struct mtd_info *mtd, loff_t offs)
 {
 	struct nand_device *nand = mtd_to_nanddev(mtd);
 	struct spinand_device *spinand = nand_to_spinand(nand);
@@ -778,6 +781,7 @@ static int spinand_mtd_block_markbad(struct mtd_info *mtd, loff_t offs)
 
 	return ret;
 }
+EXPORT_SYMBOL(spinand_mtd_block_markbad);
 
 static int spinand_erase(struct nand_device *nand, const struct nand_pos *pos)
 {
@@ -808,8 +812,7 @@ static int spinand_erase(struct nand_device *nand, const struct nand_pos *pos)
 	return ret;
 }
 
-static int spinand_mtd_erase(struct mtd_info *mtd,
-			     struct erase_info *einfo)
+int spinand_mtd_erase(struct mtd_info *mtd, struct erase_info *einfo)
 {
 	struct spinand_device *spinand = mtd_to_spinand(mtd);
 	int ret;
@@ -820,8 +823,9 @@ static int spinand_mtd_erase(struct mtd_info *mtd,
 
 	return ret;
 }
+EXPORT_SYMBOL(spinand_mtd_erase);
 
-static int spinand_mtd_block_isreserved(struct mtd_info *mtd, loff_t offs)
+int spinand_mtd_block_isreserved(struct mtd_info *mtd, loff_t offs)
 {
 	struct spinand_device *spinand = mtd_to_spinand(mtd);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
@@ -835,6 +839,7 @@ static int spinand_mtd_block_isreserved(struct mtd_info *mtd, loff_t offs)
 
 	return ret;
 }
+EXPORT_SYMBOL(spinand_mtd_block_isreserved);
 
 static int spinand_create_dirmap(struct spinand_device *spinand,
 				 unsigned int plane)
@@ -1017,7 +1022,8 @@ spinand_select_op_variant(struct spinand_device *spinand,
  * @table_size: size of the device description table
  * @rdid_method: read id method to match
  *
- * Match between a device ID retrieved through the READ_ID command and an
+ * Should be used by SPI NAND manufacturer drivers when they want to find a
+ * match between a device ID retrieved through the READ_ID command and an
  * entry in the SPI NAND description table. If a match is found, the spinand
  * object will be initialized with information provided by the matching
  * spinand_info entry.
@@ -1295,6 +1301,10 @@ static int spinand_probe(struct spi_mem *mem)
 	mtd = spinand_to_mtd(spinand);
 	mtd->dev.parent = &mem->spi->dev;
 
+#ifdef CONFIG_MTD_SPI_NAND_MERGE
+	merge_mtd_register(mtd);
+#endif
+
 	ret = spinand_init(spinand);
 	if (ret)
 		return ret;
@@ -1320,10 +1330,20 @@ static int spinand_remove(struct spi_mem *mem)
 	spinand = spi_mem_get_drvdata(mem);
 	mtd = spinand_to_mtd(spinand);
 
+#ifdef CONFIG_MTD_SPI_NAND_MERGE
+	if (mtd == get_merge_mtd(0) || mtd == get_merge_mtd(1)) {
+		pr_warn("this mtd device is merging, It is illegal.");
+		return 0;
+	}
 	ret = mtd_device_unregister(mtd);
 	if (ret)
 		return ret;
+	spinand_cleanup(spinand);
+#endif
 
+	ret = mtd_device_unregister(mtd);
+	if (ret)
+		return ret;
 	spinand_cleanup(spinand);
 
 	return 0;
diff --git a/drivers/mtd/nand/spi/spi_nand_merge.c b/drivers/mtd/nand/spi/spi_nand_merge.c
new file mode 100644
index 0000000..fde1810
--- /dev/null
+++ b/drivers/mtd/nand/spi/spi_nand_merge.c
@@ -0,0 +1,350 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Merge Nand Chips driver
+ *
+ * Copyright 2021 - 2099 ZTE, Inc
+ *
+ * Author:
+ * Ren Xiaohui <ren.xiaohui@zte.com.cn>
+ */
+#include <linux/string.h>
+#include <linux/device.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/mtd/spinand.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi-mem.h>
+
+struct merge_mtd_info {
+	struct mtd_info *merge_spinand_mtd[2];
+	int merge_mtd_count;
+};
+static struct merge_mtd_info merge_mtd = {0};
+
+struct mtd_info *merge_mtd_register(struct mtd_info *mtd)
+{
+	if (merge_mtd.merge_mtd_count < 2)
+		merge_mtd.merge_spinand_mtd[merge_mtd.merge_mtd_count++] = mtd;
+
+	return 0;
+}
+EXPORT_SYMBOL(merge_mtd_register);
+
+struct mtd_info *get_merge_mtd(int index)
+{
+	return merge_mtd.merge_spinand_mtd[index];
+}
+EXPORT_SYMBOL(get_merge_mtd);
+
+static inline loff_t second_chip_addr(loff_t from)
+{
+	return from - merge_mtd.merge_spinand_mtd[0]->size;
+}
+
+static inline int select_chip(loff_t from, size_t len)
+{
+	int chip;
+	loff_t size = merge_mtd.merge_spinand_mtd[0]->size;
+
+	if ((from + len) <= size)
+		chip = 0;
+	else if (from >= size)
+		chip = 1;
+	else
+		chip = 2;
+
+	return chip;
+}
+
+static int merge_nand_erase(struct mtd_info *mtd, struct erase_info *instr)
+{
+	int ret, chip;
+	struct erase_info *erase_idx = NULL;
+
+	erase_idx = instr;
+	erase_idx->fail_addr = 0;
+
+	chip = select_chip(erase_idx->addr, erase_idx->len);
+	if (chip == 0) {
+		ret = spinand_mtd_erase(merge_mtd.merge_spinand_mtd[chip], erase_idx);
+	} else if (chip == 1) {
+
+		/* second chip */
+		instr->addr = second_chip_addr(erase_idx->addr);
+		instr->len = erase_idx->len;
+		ret =
+			spinand_mtd_erase(merge_mtd.merge_spinand_mtd[chip], erase_idx);
+	} else {
+		size_t len;
+		/* cross boundary */
+		len = erase_idx->len;
+		erase_idx->len =
+			merge_mtd.merge_spinand_mtd[0]->size - erase_idx->addr;
+		ret = spinand_mtd_erase(merge_mtd.merge_spinand_mtd[0], erase_idx);
+		if (ret)
+			goto bail_out;
+		erase_idx->addr = 0;
+		erase_idx->len = len - erase_idx->len;
+		ret = spinand_mtd_erase(merge_mtd.merge_spinand_mtd[1], erase_idx);
+	}
+
+bail_out:
+	return ret;
+}
+
+static int merge_spinand_read_oob(struct mtd_info *mtd, loff_t from,
+			 struct mtd_oob_ops *ops)
+{
+	int ret, chip;
+	size_t len = 0;
+
+	if (ops->datbuf)
+		len = ops->len;
+	else {
+		pr_warn("This ops->datbuf is NULL!\n");
+		return 0;
+	}
+
+	chip = select_chip(from, len);
+	if (chip == 0) {
+		ret = spinand_mtd_read(merge_mtd.merge_spinand_mtd[chip], from, ops);
+	} else if (chip == 1) {
+		/* second chip */
+		ret = spinand_mtd_read(merge_mtd.merge_spinand_mtd[chip],
+					second_chip_addr(from), ops);
+	} else {
+		loff_t _from[2];
+		size_t orig_len = ops->len;
+		uint8_t	*orig_datbuf = ops->datbuf;
+		size_t	retlen[2];
+		size_t	oobretlen[2];
+
+		/* cross boundary */
+		WARN_ON(ops->datbuf == NULL);
+		_from[0] = from;
+		ops->len = merge_mtd.merge_spinand_mtd[0]->size - from;
+		ret = spinand_mtd_read(merge_mtd.merge_spinand_mtd[0], _from[0], ops);
+		retlen[0] = ops->retlen;
+		oobretlen[0] = ops->oobretlen;
+		if (ret) {
+			ops->len = orig_len;
+			pr_warn("first chip read oob %llu err %d, abort read second chip\n",
+						_from[0], ret);
+			goto bail_out;
+		}
+
+		_from[1] = 0;
+		ops->len = orig_len - ops->len;
+		ops->datbuf += (merge_mtd.merge_spinand_mtd[1]->size - from);
+		ret = spinand_mtd_read(merge_mtd.merge_spinand_mtd[1], _from[1], ops);
+		retlen[1] = ops->retlen;
+		oobretlen[1] = ops->oobretlen;
+		ops->len = orig_len;
+		ops->datbuf = orig_datbuf;
+		ops->retlen = retlen[0] + retlen[1];
+		ops->oobretlen = oobretlen[0] + oobretlen[1];
+	}
+bail_out:
+	return ret;
+}
+
+static int merge_spinand_write_oob(struct mtd_info *mtd, loff_t to,
+			 struct mtd_oob_ops *ops)
+{
+	int ret, chip;
+	size_t len = 0;
+
+	if (ops->datbuf)
+		len = ops->len;
+	else {
+		pr_warn("This ops->datbuf is NULL!\n");
+		return 0;
+	}
+
+	chip = select_chip(to, len);
+	if (chip == 0) {
+		ret =
+				spinand_mtd_write(merge_mtd.merge_spinand_mtd[chip], to, ops);
+	} else if (chip == 1) {
+		/* second chip */
+		ret = spinand_mtd_write(merge_mtd.merge_spinand_mtd[chip],
+					second_chip_addr(to), ops);
+	} else {
+		loff_t _to[2];
+		size_t orig_len = ops->len;
+		uint8_t	*orig_datbuf = ops->datbuf;
+		size_t	retlen[2];
+		size_t	oobretlen[2];
+
+		/* cross boundary */
+		WARN_ON(ops->datbuf == NULL);
+		_to[0] = to;
+		ops->len = merge_mtd.merge_spinand_mtd[0]->size - to;
+		ret = spinand_mtd_write(merge_mtd.merge_spinand_mtd[0], _to[0], ops);
+		retlen[0] = ops->retlen;
+		oobretlen[0] = ops->oobretlen;
+		if (ret) {
+			ops->len = orig_len;
+			pr_warn("first chip write oob %llu err %d, abort write second chip\n",
+						_to[0], ret);
+			goto bail_out;
+		}
+
+		_to[1] = 0;
+		ops->len = orig_len - ops->len;
+		ops->datbuf += (merge_mtd.merge_spinand_mtd[0]->size - to);
+		ret = spinand_mtd_write(merge_mtd.merge_spinand_mtd[1], _to[1], ops);
+		retlen[1] = ops->retlen;
+		oobretlen[1] = ops->oobretlen;
+		ops->len = orig_len;
+		ops->datbuf = orig_datbuf;
+		ops->retlen = retlen[0] + retlen[1];
+		ops->oobretlen = oobretlen[0] + oobretlen[1];
+	}
+bail_out:
+	return ret;
+}
+
+static int merge_spinand_block_isreserved(struct mtd_info *mtd, loff_t ofs)
+{
+	int chip = select_chip(ofs, 0);
+
+	if (chip == 0)
+		return spinand_mtd_block_isreserved(merge_mtd.merge_spinand_mtd[0], ofs);
+	else
+		return spinand_mtd_block_isreserved(merge_mtd.merge_spinand_mtd[1],
+					second_chip_addr(ofs));
+}
+
+static int merge_spinand_block_isbad(struct mtd_info *mtd, loff_t ofs)
+{
+	int chip = select_chip(ofs, 0);
+
+	if (chip == 0)
+		return spinand_mtd_block_isbad(merge_mtd.merge_spinand_mtd[0],
+						ofs);
+	else
+		return spinand_mtd_block_isbad(merge_mtd.merge_spinand_mtd[1],
+					second_chip_addr(ofs));
+}
+
+static int merge_spinand_block_markbad(struct mtd_info *mtd, loff_t ofs)
+{
+	int chip = select_chip(ofs, 0);
+
+	if (chip == 0)
+		return spinand_mtd_block_markbad(merge_mtd.merge_spinand_mtd[0], ofs);
+	else
+		return spinand_mtd_block_markbad(merge_mtd.merge_spinand_mtd[1],
+					second_chip_addr(ofs));
+}
+
+static int merge_nanddev_mtd_max_bad_blocks(struct mtd_info *mtd,
+					loff_t offs, size_t len)
+{
+	int chip = select_chip(offs, len);
+
+	if (chip == 0)
+		return nanddev_mtd_max_bad_blocks(merge_mtd.merge_spinand_mtd[0],
+						offs, len);
+	else
+		return nanddev_mtd_max_bad_blocks(merge_mtd.merge_spinand_mtd[1],
+					second_chip_addr(offs), len);
+}
+
+static int merge_mtds(void)
+{
+	int ret = 0;
+	struct mtd_info *merge_dev = NULL;
+
+	merge_dev = kzalloc(sizeof(struct mtd_info), GFP_KERNEL);
+	if (!merge_dev) {
+		pr_warn("The reason of merge failure\n");
+		ret = -ENOMEM;
+		return ret;
+	}
+
+	merge_dev->name = "merge_mtd";
+	merge_dev->size =
+		merge_mtd.merge_spinand_mtd[0]->size + merge_mtd.merge_spinand_mtd[1]->size;
+
+	if (merge_mtd.merge_spinand_mtd[0]->erasesize ==
+				merge_mtd.merge_spinand_mtd[1]->erasesize)
+		merge_dev->erasesize = merge_mtd.merge_spinand_mtd[0]->erasesize;
+	else {
+		pr_warn("error: These two spinands have different erasesize!\n");
+		return -1;
+	}
+
+	if (merge_mtd.merge_spinand_mtd[0]->writesize ==
+				merge_mtd.merge_spinand_mtd[1]->writesize)
+		merge_dev->writesize = merge_mtd.merge_spinand_mtd[0]->writesize;
+	else {
+		pr_warn("error: These two spinands have different writesize!\n");
+		return -1;
+	}
+	merge_dev->writebufsize = merge_mtd.merge_spinand_mtd[0]->writebufsize;
+	merge_dev->type = MTD_NANDFLASH;
+	merge_dev->flags = MTD_CAP_NANDFLASH;
+	merge_dev->_read_oob = merge_spinand_read_oob;
+	merge_dev->_write_oob = merge_spinand_write_oob;
+	merge_dev->_block_isbad = merge_spinand_block_isbad;
+	merge_dev->_block_markbad = merge_spinand_block_markbad;
+	merge_dev->_block_isreserved = merge_spinand_block_isreserved;
+	merge_dev->_erase = merge_nand_erase;
+	merge_dev->_max_bad_blocks = merge_nanddev_mtd_max_bad_blocks;
+
+	mtd_device_register(merge_dev, NULL, 0);
+	pr_notice("mtd%d: [%s] erase_size = %dKiB [%d], total_size = %lldKiB [%lld] ",
+				merge_dev->index,
+				merge_dev->name + strlen("merge_mtd: "),
+				merge_dev->erasesize >> 10, merge_dev->erasesize,
+				merge_dev->size >> 10, merge_dev->size);
+
+	return 0;
+}
+
+static int __init merge_mtd_init(void)
+{
+	int ret = 0;
+
+	pr_notice("merge starting...\n");
+
+	if (merge_mtd.merge_spinand_mtd[0] == NULL ||
+				merge_mtd.merge_spinand_mtd[1] == NULL) {
+		pr_warn("whoo...can not get any mtd device\n");
+		return -1;
+	}
+
+	if (merge_mtd.merge_spinand_mtd[0]->name == NULL ||
+		merge_mtd.merge_spinand_mtd[1]->name == NULL) {
+		pr_warn("error:Can not get mtd device name.");
+		pr_warn("the first spinand name:%s, second spinand name:%s.\n",
+			merge_mtd.merge_spinand_mtd[0]->name, merge_mtd.merge_spinand_mtd[1]->name);
+		return -1;
+	}
+	pr_notice("merge_spinand_mtd[0]->name = %s, merge_mtd.merge_spinand_mtd[1]->name = %s\n",
+		merge_mtd.merge_spinand_mtd[0]->name, merge_mtd.merge_spinand_mtd[1]->name);
+
+
+	ret = merge_mtds();
+
+	return ret;
+}
+
+
+static void merge_mtd_exit(void)
+{
+	pr_notice("exit ");
+	mtd_device_unregister(merge_mtd.merge_spinand_mtd[0]);
+	mtd_device_unregister(merge_mtd.merge_spinand_mtd[1]);
+}
+
+late_initcall(merge_mtd_init);
+module_exit(merge_mtd_exit);
+
+MODULE_DESCRIPTION("Merge two spi nand chips under one mtd device");
+MODULE_AUTHOR("renxiaohui <ren.xiaohui@zte.com.cn>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 6988956..9c5fb0f 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -504,12 +504,24 @@ static inline void spinand_set_of_node(struct spinand_device *spinand,
 	nanddev_set_of_node(&spinand->base, np);
 }
 
-int spinand_match_and_init(struct spinand_device *spinand,
+
+struct mtd_info *merge_mtd_register(struct mtd_info *mtd);
+struct mtd_info *get_merge_mtd(int index);
+
+int spinand_match_and_init(struct spinand_device *dev,
 			   const struct spinand_info *table,
 			   unsigned int table_size,
 			   enum spinand_readid_method rdid_method);
 
 int spinand_upd_cfg(struct spinand_device *spinand, u8 mask, u8 val);
 int spinand_select_target(struct spinand_device *spinand, unsigned int target);
+int spinand_mtd_erase(struct mtd_info *mtd, struct erase_info *einfo);
+int spinand_mtd_block_isreserved(struct mtd_info *mtd, loff_t offs);
+int spinand_mtd_block_markbad(struct mtd_info *mtd, loff_t offs);
+int spinand_mtd_block_isbad(struct mtd_info *mtd, loff_t offs);
+int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
+			     struct mtd_oob_ops *ops);
+int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
+			    struct mtd_oob_ops *ops);
 
 #endif /* __LINUX_MTD_SPINAND_H */
-- 
2.15.2


