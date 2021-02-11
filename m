Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE333190E3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 18:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhBKRVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 12:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbhBKQVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 11:21:12 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28D9C061788;
        Thu, 11 Feb 2021 08:20:30 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id b16so8005400lji.13;
        Thu, 11 Feb 2021 08:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ypo3wj7J3pF2Yz8E+y5ps2m5DtA6PNEJkEl7d6YQRY=;
        b=QZMSbH+ttQB5qa33fjxlBu+2fHDGXvxwCtufn6iodc5U5ZxyD9UMwdYLmpxcOd/DOz
         aOAd5/0fq2q9j91/njYxzrbdx0G6XQgmHL2kMh8HwxgscVcZfDt+6BJ811FDBlGMR9U3
         h3yhoMcw6AHeCdezr4qm85Uxq9634J0JWrJykUljT+XEn/F7NprQN9BkrE1yzy7QZH17
         qwGZPSsuxXa0dTOeg7X9l6I7Un6YSkz94j6q3ZWigAESZ9qAEYIb8rr3UKlyJaM82ONI
         CRrXUqpOJ1nXD0JRa85LeeCWmWr1v51wf3GDfOG2eIIpL4EBRxYixDWan7/4smnsqxa8
         SeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ypo3wj7J3pF2Yz8E+y5ps2m5DtA6PNEJkEl7d6YQRY=;
        b=AJ6IqaiK14amTk2gZeVhNDdCMscxJIkm3ckRcVQHCYJDqvAXimhr26BCnA/joC+Dnd
         phmCcL0ZZKj8ad5oWsQquBDBRKjQR0j9TjTf27wDkFNChhPsgTAYYseHiiKx4DIDd0Eo
         GGqYQNbOVgFd9N9+AqrUDHML4zIWCWHIRkOG7cPiQKpOFOcnbdCUqbs9goh0FzZixidp
         wERB6KLoSkca6X3gGw6sDi7wZdO5bwO5gKddWFu7o9HM1yBiDJpwII9p63GIEIpv4KhB
         j13AvsKkxXedi9Q2xD0tL8Yw/JPNLm1whVPdPphH8b7IUgj2tKlNmUTiiA3ruRZv1KTe
         ZTBQ==
X-Gm-Message-State: AOAM531ejA7CjL30bKoiKW90AjN/YGdMbEsuBGiN3TohDVowfKRJVemi
        Gzed5AjKqoNotGz+RPzfYRg=
X-Google-Smtp-Source: ABdhPJxlyl1pYqoM9NleY1jv+/fLEqPbr1QDZyb4le0/nwxxulN5aU9vYoTiUFC74g4SqpsCp6CeCQ==
X-Received: by 2002:a2e:7815:: with SMTP id t21mr5604805ljc.94.1613060429413;
        Thu, 11 Feb 2021 08:20:29 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id b5sm685941lfi.3.2021.02.11.08.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 08:20:29 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 mtd/next 3/3] mtd: parsers: ofpart: support BCM4908 fixed partitions
Date:   Thu, 11 Feb 2021 17:20:12 +0100
Message-Id: <20210211162012.27417-3-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210211162012.27417-1-zajec5@gmail.com>
References: <20210211162012.27417-1-zajec5@gmail.com>
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
 drivers/mtd/parsers/Makefile             |  1 +
 drivers/mtd/parsers/bcm4908-partitions.c | 62 ++++++++++++++++++++++++
 drivers/mtd/parsers/bcm4908-partitions.h |  7 +++
 drivers/mtd/parsers/ofpart.c             | 28 ++++++++++-
 4 files changed, 96 insertions(+), 2 deletions(-)
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
index 000000000000..032a4b1b8a5f
--- /dev/null
+++ b/drivers/mtd/parsers/bcm4908-partitions.c
@@ -0,0 +1,62 @@
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

