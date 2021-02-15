Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D072831B691
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 10:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhBOJjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 04:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbhBOJii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 04:38:38 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B600AC061574;
        Mon, 15 Feb 2021 01:37:57 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id v6so6920733ljh.9;
        Mon, 15 Feb 2021 01:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j3ckuPrqHhj+a9wM1FpqARhpl+yXkW6M1ONJjD4HIFU=;
        b=MTsSPieEeX4km2tagPGx8RvLv5f+XB7O2V2K2REq8f/x+EqJW31CA0aYINGF49Di6E
         xylN3jtjbn18pW9Tzfn5iJiAeSRFJTPFJQ+Tj45xqZ7+eOneojyqhsAkhEfINWf6PFUU
         Ug71oVnaT5McTA+cPrYVX2RFwZhW9Jw5XrN+A7qFWOHdRp8oUAYbfCGO3t4NJHRmPUY9
         10vRn/BLgwPDfzL9hzmM7q18UXNJLbb7APR4BLzNoGTeNnL8uI16wFeWRUrfLAnKIUmQ
         XEja8KcjWSKkllNC/k0bteEQfldN54ZdOy3nWKZZg1nzHl5PbxExI4ykabdN0akIbch1
         h9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j3ckuPrqHhj+a9wM1FpqARhpl+yXkW6M1ONJjD4HIFU=;
        b=FfAur0gdCvN98QvlHSuGi5fVaa+0nTWbFR430UvawIjpJ7a7IoyvnzY1anldnPgsBT
         rIaTG693UVUmuQVDH9y4/FmT+G/HN9qwZTcaboCgeLjzQihY6qk6h1/dMMuN4Y5MNmOz
         3t9tJzzHPK8r6EhtGSl7NogdWtxu0+7R8EInVXfBuNnWqtU7U9L2uJmwCK177NiCze5q
         UYkgzMcAqqvSiIYA3coOfihQlyc9XxpLtynJKZjwIhkxq9lUq7ljStmRLuQVCYNnorPg
         /YcpDM3VKSvQOn9ypCtFnOHjS/j1OXpzXB/PCnsFh+g5VhvMwD74B5a5NMri53CKpdWB
         IaSA==
X-Gm-Message-State: AOAM533NbIRBjU/b6sl2G0dqETk6qqQsXFmPPY5uJNPwYP3tP0tAt8ej
        +7nBmIeeYNXXTVnfymISgRA=
X-Google-Smtp-Source: ABdhPJyrlMXsFhRD4Hwqt37Q625ONHuhehs+5US0UQ2P7CRdqld15xiv38CJ1dOSAsR9o9VVkkCOWQ==
X-Received: by 2002:a2e:730f:: with SMTP id o15mr9360582ljc.145.1613381876281;
        Mon, 15 Feb 2021 01:37:56 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id i21sm2733258lfe.102.2021.02.15.01.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 01:37:55 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] mtd: parsers: add MTD_OF_PARTS_BCM4908 config option
Date:   Mon, 15 Feb 2021 10:37:40 +0100
Message-Id: <20210215093740.20080-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

Right now ofpart parser gets always compiled with the BCM4908 support.
It's not a big issue at this point as BCM4908 partitioning support comes
at close-to-zero cost. It may differ for possible further ofpart quirks
though.

Make BCM4908 support selectable to set a clean pattern for adding further
quirks.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
This is NOT urgent and is NOT intended for the 5.12. Please review this
change in a free moment, probably after merge window closes.
---
 drivers/mtd/parsers/Kconfig                              | 9 +++++++++
 drivers/mtd/parsers/Makefile                             | 3 ++-
 .../parsers/{bcm4908-partitions.c => ofpart_bcm4908.c}   | 2 +-
 .../parsers/{bcm4908-partitions.h => ofpart_bcm4908.h}   | 8 ++++++++
 drivers/mtd/parsers/{ofpart.c => ofpart_core.c}          | 2 +-
 5 files changed, 21 insertions(+), 3 deletions(-)
 rename drivers/mtd/parsers/{bcm4908-partitions.c => ofpart_bcm4908.c} (97%)
 rename drivers/mtd/parsers/{bcm4908-partitions.h => ofpart_bcm4908.h} (52%)
 rename drivers/mtd/parsers/{ofpart.c => ofpart_core.c} (99%)

diff --git a/drivers/mtd/parsers/Kconfig b/drivers/mtd/parsers/Kconfig
index d90c30229052..05b6a24cedd8 100644
--- a/drivers/mtd/parsers/Kconfig
+++ b/drivers/mtd/parsers/Kconfig
@@ -67,6 +67,15 @@ config MTD_OF_PARTS
 	  flash memory node, as described in
 	  Documentation/devicetree/bindings/mtd/partition.txt.
 
+config MTD_OF_PARTS_BCM4908
+	bool "BCM4908 partitioning support"
+	depends on MTD_OF_PARTS && (ARCH_BCM4908 || COMPILE_TEST)
+	default ARCH_BCM4908
+	help
+	  This provides partitions parser for BCM4908 family devices
+	  that can have multiple "firmware" partitions. It takes care of
+	  finding currently used one and backup ones.
+
 config MTD_PARSER_IMAGETAG
 	tristate "Parser for BCM963XX Image Tag format partitions"
 	depends on BCM63XX || BMIPS_GENERIC || COMPILE_TEST
diff --git a/drivers/mtd/parsers/Makefile b/drivers/mtd/parsers/Makefile
index bf58a5221730..2dfe9fb602de 100644
--- a/drivers/mtd/parsers/Makefile
+++ b/drivers/mtd/parsers/Makefile
@@ -4,7 +4,8 @@ obj-$(CONFIG_MTD_BCM47XX_PARTS)		+= bcm47xxpart.o
 obj-$(CONFIG_MTD_BCM63XX_PARTS)		+= bcm63xxpart.o
 obj-$(CONFIG_MTD_CMDLINE_PARTS)		+= cmdlinepart.o
 obj-$(CONFIG_MTD_OF_PARTS)		+= ofpart.o
-ofpart-objs				:= bcm4908-partitions.o
+ofpart-y				+= ofpart_core.o
+ofpart-$(CONFIG_MTD_OF_PARTS_BCM4908)	+= ofpart_bcm4908.o
 obj-$(CONFIG_MTD_PARSER_IMAGETAG)	+= parser_imagetag.o
 obj-$(CONFIG_MTD_AFS_PARTS)		+= afs.o
 obj-$(CONFIG_MTD_PARSER_TRX)		+= parser_trx.o
diff --git a/drivers/mtd/parsers/bcm4908-partitions.c b/drivers/mtd/parsers/ofpart_bcm4908.c
similarity index 97%
rename from drivers/mtd/parsers/bcm4908-partitions.c
rename to drivers/mtd/parsers/ofpart_bcm4908.c
index ac69a2169763..3cfa4f4ec562 100644
--- a/drivers/mtd/parsers/bcm4908-partitions.c
+++ b/drivers/mtd/parsers/ofpart_bcm4908.c
@@ -10,7 +10,7 @@
 #include <linux/slab.h>
 #include <linux/mtd/partitions.h>
 
-#include "bcm4908-partitions.h"
+#include "ofpart_bcm4908.h"
 
 #define BLPARAMS_FW_OFFSET		"NAND_RFS_OFS"
 
diff --git a/drivers/mtd/parsers/bcm4908-partitions.h b/drivers/mtd/parsers/ofpart_bcm4908.h
similarity index 52%
rename from drivers/mtd/parsers/bcm4908-partitions.h
rename to drivers/mtd/parsers/ofpart_bcm4908.h
index df25f0487d0a..80f8c086641f 100644
--- a/drivers/mtd/parsers/bcm4908-partitions.h
+++ b/drivers/mtd/parsers/ofpart_bcm4908.h
@@ -2,6 +2,14 @@
 #ifndef __BCM4908_PARTITIONS_H
 #define __BCM4908_PARTITIONS_H
 
+#ifdef CONFIG_MTD_OF_PARTS_BCM4908
 int bcm4908_partitions_post_parse(struct mtd_info *mtd, struct mtd_partition *parts, int nr_parts);
+#else
+static inline int bcm4908_partitions_post_parse(struct mtd_info *mtd, struct mtd_partition *parts,
+						int nr_parts)
+{
+	return -EOPNOTSUPP;
+}
+#endif
 
 #endif
diff --git a/drivers/mtd/parsers/ofpart.c b/drivers/mtd/parsers/ofpart_core.c
similarity index 99%
rename from drivers/mtd/parsers/ofpart.c
rename to drivers/mtd/parsers/ofpart_core.c
index 6b221df8401c..258c06a42283 100644
--- a/drivers/mtd/parsers/ofpart.c
+++ b/drivers/mtd/parsers/ofpart_core.c
@@ -16,7 +16,7 @@
 #include <linux/slab.h>
 #include <linux/mtd/partitions.h>
 
-#include "bcm4908-partitions.h"
+#include "ofpart_bcm4908.h"
 
 struct fixed_partitions_quirks {
 	int (*post_parse)(struct mtd_info *mtd, struct mtd_partition *parts, int nr_parts);
-- 
2.26.2

