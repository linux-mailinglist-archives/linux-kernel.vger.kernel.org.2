Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7EC31B5A2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 08:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhBOHa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 02:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhBOHaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 02:30:21 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22084C061756;
        Sun, 14 Feb 2021 23:29:41 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id r23so6613225ljh.1;
        Sun, 14 Feb 2021 23:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=79lwX7opGlCl6k5/gtvtF+EDAPSlvhge501UOjBBscg=;
        b=eiC5KUj7w3Xi5LydiaVaeY2pU7nAWZNFMzNtonYi6Gj9FCa9r7bZDFBNu3uEJ24nlb
         IVnQB2kazqrFhJP0/poOWprW7rVU1GUyivC4/Y8akCTl6KU86N656ztrv2DqH5akeVNN
         NcnjnPlePYIiSXaABijTi0xyxWt4owXTLMGOOnPeDhVU5MSYTS1ej+I2Qasy0aTvdWgn
         7hqpEf/Wsm7vtE1rN11JvJg3WW60iXn7w3U5Xt4+J+35Aa4Q83jxWP0frOMJxnG+evOi
         TWJ6wY3wJQ8/bwffoOm4lz3Ir3V1EITAxmWZ/HcntwicFbVnmq/Ra/7fZknfRgPrSqJP
         +XUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=79lwX7opGlCl6k5/gtvtF+EDAPSlvhge501UOjBBscg=;
        b=kh6jsEoBelmbuHTsJQmqRzknO3lUFoxB0lcuY+TprRSz8QRcm8lCGYXv+XfjA0qSe4
         81Ndr1xf7TPnxBFaiBpU8CIIEK/FmRrZN1A4S2UR9XMPRvx2i5vJJ3XyivLCQqDSFO+B
         bvbgITknjYDACvZiwRNYLY+YPTl5RKWNyAll1MPw0bRxpfNTawKbSBIZro7uxhiF+ZAr
         pH4pfQZQvZBxi5L4r2VzL6MxKSbP8OfP1pj3ORsi7PFY87kY26cds/MbPtzZgASiHn6u
         yMdv8U0jFoKCz2BkHNI27EFqo1ZdfwycTeEMBicZCcFVQ9eYyTb6LjnOEQzFcpSff0t1
         fNuQ==
X-Gm-Message-State: AOAM530wrW1Xs7w4zjiYwG0LFmeoPny5XR8p2iyduJz9tEZ/IgyGRpdu
        tH79uhQ01oBvCMEIgZpdUtI=
X-Google-Smtp-Source: ABdhPJxXhZkTpdE72XrqXK28hqtTTDaRS+c9UywWe9x23DTns/PHAPvrg65zYVKRvGljJ5UDmJGQ2Q==
X-Received: by 2002:a2e:730c:: with SMTP id o12mr3645460ljc.27.1613374179617;
        Sun, 14 Feb 2021 23:29:39 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id l19sm3538642lji.53.2021.02.14.23.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 23:29:39 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] mtd: parsers: ofpart: fix building as module
Date:   Mon, 15 Feb 2021 08:28:44 +0100
Message-Id: <20210215072844.16136-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

This fixes:
ERROR: modpost: missing MODULE_LICENSE() in drivers/mtd/parsers/bcm4908-partitions.o
ERROR: modpost: "bcm4908_partitions_post_parse" [drivers/mtd/parsers/ofpart.ko] undefined!

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 09cf6ee6d21c ("mtd: parsers: ofpart: support BCM4908 fixed partitions")
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/mtd/parsers/Makefile             | 2 +-
 drivers/mtd/parsers/bcm4908-partitions.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/parsers/Makefile b/drivers/mtd/parsers/Makefile
index 01972a5edc5c..bf58a5221730 100644
--- a/drivers/mtd/parsers/Makefile
+++ b/drivers/mtd/parsers/Makefile
@@ -4,7 +4,7 @@ obj-$(CONFIG_MTD_BCM47XX_PARTS)		+= bcm47xxpart.o
 obj-$(CONFIG_MTD_BCM63XX_PARTS)		+= bcm63xxpart.o
 obj-$(CONFIG_MTD_CMDLINE_PARTS)		+= cmdlinepart.o
 obj-$(CONFIG_MTD_OF_PARTS)		+= ofpart.o
-obj-$(CONFIG_MTD_OF_PARTS)		+= bcm4908-partitions.o
+ofpart-objs				:= bcm4908-partitions.o
 obj-$(CONFIG_MTD_PARSER_IMAGETAG)	+= parser_imagetag.o
 obj-$(CONFIG_MTD_AFS_PARTS)		+= afs.o
 obj-$(CONFIG_MTD_PARSER_TRX)		+= parser_trx.o
diff --git a/drivers/mtd/parsers/bcm4908-partitions.c b/drivers/mtd/parsers/bcm4908-partitions.c
index 40eb3b3801c3..ac69a2169763 100644
--- a/drivers/mtd/parsers/bcm4908-partitions.c
+++ b/drivers/mtd/parsers/bcm4908-partitions.c
@@ -62,3 +62,5 @@ int bcm4908_partitions_post_parse(struct mtd_info *mtd, struct mtd_partition *pa
 
 	return 0;
 }
+
+MODULE_LICENSE("GPL");
-- 
2.26.2

