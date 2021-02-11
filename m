Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6074F31958D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 23:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhBKWGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 17:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbhBKWFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 17:05:48 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581B0C0613D6;
        Thu, 11 Feb 2021 14:05:08 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id a17so9278506ljq.2;
        Thu, 11 Feb 2021 14:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eO+35/GJdTp493IYWMGw10PHMi3Sa075zN5HnYWgXcs=;
        b=rzcVZpvkM3s+i0owLHv4tvcjd08qg9UK2kXiHjc2blDX9SYagDz5TSNkPIn9VbVmVc
         6Zb3D9tEeuASSekNnVXfaQrg0CCoo+fyiWbbY28xjfkSNdcSmm08Ja3pvdhhalP72v2K
         VeUSde5zCECt6HXOYJWn2YMfXnflUZ0PRuBKs907etrv2q6a733JhmWl0s0grtLK9JYz
         xBWVS8I+r3AlyLmtKpQIqIx1aHh0SfAaCcFai/m4rVrFNhG45J1CmHuiCixwWxuL1kXJ
         kD+r2t+xX7zp9q+n4BdDmnpCT6dk1qE1TdlqkPz12TfeZ7BEsB97mrZrvrToADkVHuKW
         qDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eO+35/GJdTp493IYWMGw10PHMi3Sa075zN5HnYWgXcs=;
        b=cYyJvqfMUqr/TzL1TYCtJtMbKK91XJh1j0UU0XPu5C3HnwGNnRbFn13FbfDt7wvpth
         IZ90IuLgE+w9kR0fw5KI3HswoOr/yx8C+9ihMaSYSNFwPgopbTuE2W02PJMLoDnce5gQ
         /Fnw3iqeL/3UaRjiC7rMqrW7znj+a9kaoLxECOxjwX3JpiyZZaNRhEZVVY+Ostq3+uaI
         82xIjOLZhstmi8QlHvTiq2aJgkJRJ9YZGsqBfod9z9TmUT3nvOm+X5070hUB3cXiH/mT
         3iG+MTFhWf4cPe2PHIpNbHY3+y6ZteqehEKKYZbSAoJITput5JSr6YZGRn4mSXoCKkuI
         /oPA==
X-Gm-Message-State: AOAM53099WrpwrJflxhZ9PIg1/WSvxKPc/XTE8xUClGrEoxlbekonyN7
        f/RKUbEWEEtFoqNBEPVdvsk=
X-Google-Smtp-Source: ABdhPJywoZmeJazkkVlK+/E2zg0SiNAnSvdStwSN1qQGnbKibaSOZjrblPIYdfVGWoIhO28dT67tTQ==
X-Received: by 2002:a2e:9218:: with SMTP id k24mr5994093ljg.195.1613081106773;
        Thu, 11 Feb 2021 14:05:06 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id o14sm1056649ljp.48.2021.02.11.14.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 14:05:06 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH V3 mtd/next 3/3] mtd: parsers: ofpart: support BCM4908 fixed partitions
Date:   Thu, 11 Feb 2021 23:04:27 +0100
Message-Id: <20210211220427.27104-3-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210211220427.27104-1-zajec5@gmail.com>
References: <20210211220427.27104-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

BCM4908 partitioning is based on fixed layout but allows specifying
multiple firmware partitions. It requires detecting which firmware
partition was used for booting current kernel.

To support such cases without duplicating a lot of code (without copying
most of the ofpart.c code) support for post-parsing callback was added.

BCM4908 callback simply reads offset of currently used firmware
partition from the DT. Bootloader specifies it using the "brcm_blparms"
property.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V3: Add #include "bcm4908-partitions.h" to fix:
drivers/mtd/parsers/bcm4908-partitions.c:45:5: warning: no previous prototype for function 'bcm4908_partitions_post_parse' [-Wmissing-prototypes]
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/mtd/parsers/Makefile             |  1 +
 drivers/mtd/parsers/bcm4908-partitions.c | 64 ++++++++++++++++++++++++
 drivers/mtd/parsers/bcm4908-partitions.h |  7 +++
 drivers/mtd/parsers/ofpart.c             | 28 ++++++++++-
 4 files changed, 98 insertions(+), 2 deletions(-)
 create mode 100644 drivers/mtd/parsers/bcm4908-partitions.c
 create mode 100644 drivers/mtd/parsers/bcm4908-partitions.h

diff --git a/drivers/mtd/parsers/Makefile b/drivers/mtd/parsers/Makefile
index 50eb0b0a2210..01972a5edc5c 100644
--- a/drivers/mtd/parsers/Makefile
+++ b/drivers/mtd/parsers/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_MTD_BCM47XX_PARTS)		+= bcm47xxpart.o
 obj-$(CONFIG_MTD_BCM63XX_PARTS)		+= bcm63xxpart.o
 obj-$(CONFIG_MTD_CMDLINE_PARTS)		+= cmdlinepart.o
 obj-$(CONFIG_MTD_OF_PARTS)		+= ofpart.o
+obj-$(CONFIG_MTD_OF_PARTS)		+= bcm4908-partitions.o
 obj-$(CONFIG_MTD_PARSER_IMAGETAG)	+= parser_imagetag.o
 obj-$(CONFIG_MTD_AFS_PARTS)		+= afs.o
 obj-$(CONFIG_MTD_PARSER_TRX)		+= parser_trx.o
diff --git a/drivers/mtd/parsers/bcm4908-partitions.c b/drivers/mtd/parsers/bcm4908-partitions.c
new file mode 100644
index 000000000000..40eb3b3801c3
--- /dev/null
+++ b/drivers/mtd/parsers/bcm4908-partitions.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Rafał Miłecki <rafal@milecki.pl>
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/of.h>
+#include <linux/mtd/mtd.h>
+#include <linux/slab.h>
+#include <linux/mtd/partitions.h>
+
+#include "bcm4908-partitions.h"
+
+#define BLPARAMS_FW_OFFSET		"NAND_RFS_OFS"
+
+static long long bcm4908_partitions_fw_offset(void)
+{
+	struct device_node *root;
+	struct property *prop;
+	const char *s;
+
+	root = of_find_node_by_path("/");
+	if (!root)
+		return -ENOENT;
+
+	of_property_for_each_string(root, "brcm_blparms", prop, s) {
+		size_t len = strlen(BLPARAMS_FW_OFFSET);
+		unsigned long offset;
+		int err;
+
+		if (strncmp(s, BLPARAMS_FW_OFFSET, len) || s[len] != '=')
+			continue;
+
+		err = kstrtoul(s + len + 1, 0, &offset);
+		if (err) {
+			pr_err("failed to parse %s\n", s + len + 1);
+			return err;
+		}
+
+		return offset << 10;
+	}
+
+	return -ENOENT;
+}
+
+int bcm4908_partitions_post_parse(struct mtd_info *mtd, struct mtd_partition *parts, int nr_parts)
+{
+	long long fw_offset;
+	int i;
+
+	fw_offset = bcm4908_partitions_fw_offset();
+
+	for (i = 0; i < nr_parts; i++) {
+		if (of_device_is_compatible(parts[i].of_node, "brcm,bcm4908-firmware")) {
+			if (fw_offset < 0 || parts[i].offset == fw_offset)
+				parts[i].name = "firmware";
+			else
+				parts[i].name = "backup";
+		}
+	}
+
+	return 0;
+}
diff --git a/drivers/mtd/parsers/bcm4908-partitions.h b/drivers/mtd/parsers/bcm4908-partitions.h
new file mode 100644
index 000000000000..df25f0487d0a
--- /dev/null
+++ b/drivers/mtd/parsers/bcm4908-partitions.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __BCM4908_PARTITIONS_H
+#define __BCM4908_PARTITIONS_H
+
+int bcm4908_partitions_post_parse(struct mtd_info *mtd, struct mtd_partition *parts, int nr_parts);
+
+#endif
diff --git a/drivers/mtd/parsers/ofpart.c b/drivers/mtd/parsers/ofpart.c
index daf507c123e6..6b221df8401c 100644
--- a/drivers/mtd/parsers/ofpart.c
+++ b/drivers/mtd/parsers/ofpart.c
@@ -16,6 +16,18 @@
 #include <linux/slab.h>
 #include <linux/mtd/partitions.h>
 
+#include "bcm4908-partitions.h"
+
+struct fixed_partitions_quirks {
+	int (*post_parse)(struct mtd_info *mtd, struct mtd_partition *parts, int nr_parts);
+};
+
+struct fixed_partitions_quirks bcm4908_partitions_quirks = {
+	.post_parse = bcm4908_partitions_post_parse,
+};
+
+static const struct of_device_id parse_ofpart_match_table[];
+
 static bool node_has_compatible(struct device_node *pp)
 {
 	return of_get_property(pp, "compatible", NULL);
@@ -25,6 +37,8 @@ static int parse_fixed_partitions(struct mtd_info *master,
 				  const struct mtd_partition **pparts,
 				  struct mtd_part_parser_data *data)
 {
+	const struct fixed_partitions_quirks *quirks;
+	const struct of_device_id *of_id;
 	struct mtd_partition *parts;
 	struct device_node *mtd_node;
 	struct device_node *ofpart_node;
@@ -33,7 +47,6 @@ static int parse_fixed_partitions(struct mtd_info *master,
 	int nr_parts, i, ret = 0;
 	bool dedicated = true;
 
-
 	/* Pull of_node from the master device node */
 	mtd_node = mtd_get_of_node(master);
 	if (!mtd_node)
@@ -50,11 +63,16 @@ static int parse_fixed_partitions(struct mtd_info *master,
 			 master->name, mtd_node);
 		ofpart_node = mtd_node;
 		dedicated = false;
-	} else if (!of_device_is_compatible(ofpart_node, "fixed-partitions")) {
+	}
+
+	of_id = of_match_node(parse_ofpart_match_table, ofpart_node);
+	if (dedicated && !of_id) {
 		/* The 'partitions' subnode might be used by another parser */
 		return 0;
 	}
 
+	quirks = of_id ? of_id->data : NULL;
+
 	/* First count the subnodes */
 	nr_parts = 0;
 	for_each_child_of_node(ofpart_node,  pp) {
@@ -126,6 +144,9 @@ static int parse_fixed_partitions(struct mtd_info *master,
 	if (!nr_parts)
 		goto ofpart_none;
 
+	if (quirks && quirks->post_parse)
+		quirks->post_parse(master, parts, nr_parts);
+
 	*pparts = parts;
 	return nr_parts;
 
@@ -140,7 +161,10 @@ static int parse_fixed_partitions(struct mtd_info *master,
 }
 
 static const struct of_device_id parse_ofpart_match_table[] = {
+	/* Generic */
 	{ .compatible = "fixed-partitions" },
+	/* Customized */
+	{ .compatible = "brcm,bcm4908-partitions", .data = &bcm4908_partitions_quirks, },
 	{},
 };
 MODULE_DEVICE_TABLE(of, parse_ofpart_match_table);
-- 
2.26.2

