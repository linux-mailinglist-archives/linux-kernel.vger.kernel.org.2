Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73FFF45A058
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 11:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235618AbhKWKjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 05:39:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:48204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235564AbhKWKje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 05:39:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8ADA6102A;
        Tue, 23 Nov 2021 10:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637663786;
        bh=fnjpunfMi60kKKSNTEppWkAAlhE50VuTfRoSTjIV8A4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PzThC1Yj3KZQ//cDgphhpcZnWHywlxb+MtgecLuvWXjIGSVQCN0ndEhKkxQNwagLl
         wkqeQEfKmjQEJ7Ci5eXpk4GJaaGpqAT+uTZqvuitMIKEkYI6n40am9zgWj2Glb4I5P
         bmPiAKVq9ru3nZJSe1XCPh4a/hN9tkW0Vnr8UZTfyxqblPbJrSG9xqc0c6Wu0A9hOq
         MC9kum9jl4bbUSbjJUDnI+CAj/+vFV5qTPkPcNTOGCTxJzGq1cWN0o9O9KlFPWx/o4
         NMVKpw2bWLnNO/cQ2ZDKK9ypHQ10KpRoOr5Xpf9gImck8/SGIvFySRcKTHa/GqvB5v
         ie0HiS7Xj4AvQ==
From:   Roger Quadros <rogerq@kernel.org>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     kishon@ti.com, nm@ti.com, tony@atomide.com,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 4/4] mtd: nand: omap2: Add support for NAND Controller on AM64 SoC
Date:   Tue, 23 Nov 2021 12:36:09 +0200
Message-Id: <20211123103609.14063-5-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211123103609.14063-1-rogerq@kernel.org>
References: <20211123103609.14063-1-rogerq@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM64 SoC has an issue which prevents proper 8-bit and 16-bit
reads from GPMC. We are limited to do 32-bit reads only.

Force 32-bit only reads on affected platforms.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/mtd/nand/raw/omap2.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/mtd/nand/raw/omap2.c b/drivers/mtd/nand/raw/omap2.c
index f1fc146e09b9..d952de771b35 100644
--- a/drivers/mtd/nand/raw/omap2.c
+++ b/drivers/mtd/nand/raw/omap2.c
@@ -28,6 +28,7 @@
 
 #include <linux/omap-gpmc.h>
 #include <linux/platform_data/mtd-nand-omap2.h>
+#include <linux/sys_soc.h>
 
 #define	DRIVER_NAME	"omap2-nand"
 #define	OMAP_NAND_TIMEOUT_MS	5000
@@ -181,6 +182,7 @@ struct omap_nand_info {
 	void (*data_out)(struct nand_chip *chip,
 			 const void *buf, unsigned int len,
 			 bool force_8bit);
+	bool force_32bit;
 };
 
 static inline struct omap_nand_info *mtd_to_omap(struct mtd_info *mtd)
@@ -2070,6 +2072,25 @@ static void omap_nand_data_in(struct nand_chip *chip, void *buf,
 	struct omap_nand_info *info = mtd_to_omap(nand_to_mtd(chip));
 	u32 alignment = ((uintptr_t)buf | len) & 3;
 
+	if (info->force_32bit) {
+		u32 val;
+		int left;
+		u8 *ptr;
+
+		ioread32_rep(info->fifo, buf, len >> 2);
+		left = len & 0x3;
+		if (left) {
+			val = ioread32(info->fifo);
+			ptr = (u8 *)(buf + (len - left));
+			while (left--) {
+				*ptr++ = val & 0xff;
+				val >>= 8;
+			}
+		}
+
+		return;
+	}
+
 	if (force_8bit || (alignment & 1))
 		ioread8_rep(info->fifo, buf, len);
 	else if (alignment & 3)
@@ -2169,8 +2190,15 @@ static const struct nand_controller_ops omap_nand_controller_ops = {
 static struct nand_controller omap_gpmc_controller;
 static bool omap_gpmc_controller_initialized;
 
+static const struct of_device_id omap_nand_ids[];
+
 static int omap_nand_probe(struct platform_device *pdev)
 {
+	const struct soc_device_attribute k3_soc_devices[] = {
+		{ .family = "AM64X", .revision = "SR1.0" },
+		{ /* sentinel */ }
+	};
+
 	struct omap_nand_info		*info;
 	struct mtd_info			*mtd;
 	struct nand_chip		*nand_chip;
@@ -2186,6 +2214,12 @@ static int omap_nand_probe(struct platform_device *pdev)
 
 	info->pdev = pdev;
 
+	/* Some SoC's have 32-bit at least, read limitation */
+	if (soc_device_match(k3_soc_devices)) {
+		dev_info(&pdev->dev, "force 32-bit\n");
+		info->force_32bit = true;
+	}
+
 	err = omap_get_dt_info(dev, info);
 	if (err)
 		return err;
@@ -2286,6 +2320,7 @@ static int omap_nand_remove(struct platform_device *pdev)
 
 static const struct of_device_id omap_nand_ids[] = {
 	{ .compatible = "ti,omap2-nand", },
+	{ .compatible = "ti,am64-nand", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, omap_nand_ids);
-- 
2.17.1

