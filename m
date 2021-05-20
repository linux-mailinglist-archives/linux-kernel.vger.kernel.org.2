Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2985338AE6B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235512AbhETMhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbhETMhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:37:09 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97013C03463C
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 04:49:02 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id u4-20020a05600c00c4b02901774b80945cso5227342wmm.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 04:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QPaYVrSRdLkmionAM++uY77FvCctt4j++gqXCg4Vy6U=;
        b=nGFmcYTSBurIZOqyQ2L5oGSwhqx8v9yvTrfoLO7TWlBNbQ/pu327A36Pl6xBdMzb6X
         BrC7JbeDLQgrmlSevT6ocOXBBRnMWF5rUjCbGSscWm/XppFvH2SbF0vo04FB9AuDB4Rl
         vDX0Rlvojrhx1A9uFV6MAzbf4kot+xjvD1k9jnR29/UgKCeMuOdRcj9wdH0ScdZ2/GUy
         APnY9mTVS6axoEVD0rV3HLeVeNm2y0dDITs8lHPCH8FAcVpA3hCn6j+rpn6Sw4mQPzc1
         Tkf7hA6GfceIJp6KyK0bHIdaxTWEITWtm7Skl80WDG22xxOwUit5UfL+pSmfYul5Mwa1
         4rRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QPaYVrSRdLkmionAM++uY77FvCctt4j++gqXCg4Vy6U=;
        b=NQoDtc+RqqUcTXMm1U9wuoYTqWXNRYRCTb7mpSVrTO0Q4bjQZjyS7sS2MznosRqJiQ
         4koSHg22gCHTy18uNSaUlxoi+NQWjotpu920AMEV17NrB1A0WCaXkTXH2b4wRO7tJdbR
         9XY6H5TtZDjc0aen1HJgVCMhdLblbxWlA+abdlIYoxMK3BN8OYPmXSeZryvRe9jetMmM
         FjA3qi9wz+YHsSEa8bDdCa6TcWjliw7LcCMZFQAcfG+gO73bG9Jp3HrNNdIWF4X/cxJR
         IKJRhA4fFW/+DoLVBuuDD7rHwHV01kZxBciVTrIa5SKH7YGKr7EmBWG1U/cPIEO1nmQJ
         BYRg==
X-Gm-Message-State: AOAM5316sqoUVHRIsL5IeO3UCXj7DcK/vHmSWN3JFaolYS4JRgK5a73l
        MDmkSQtFhuJoHFmql3qPnEQy4Q==
X-Google-Smtp-Source: ABdhPJwi5TsXq9K487aycr86sXUt1qrwH5W0QT/pDOXjaR2fPO1nHdLIq2/BT2K1BJ2a6jeVHH9WwA==
X-Received: by 2002:a7b:cf15:: with SMTP id l21mr3291063wmg.30.1621511341154;
        Thu, 20 May 2021 04:49:01 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id s83sm2478886wms.16.2021.05.20.04.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 04:49:00 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     boris.brezillon@bootlin.com, linus.walleij@linaro.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 2/2] mtd: partitions: redboot: fix style issues
Date:   Thu, 20 May 2021 11:48:51 +0000
Message-Id: <20210520114851.1274609-2-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210520114851.1274609-1-clabbe@baylibre.com>
References: <20210520114851.1274609-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes easy checkpatch issues.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/mtd/parsers/redboot.c | 69 +++++++++++++++++------------------
 1 file changed, 34 insertions(+), 35 deletions(-)

diff --git a/drivers/mtd/parsers/redboot.c b/drivers/mtd/parsers/redboot.c
index 3ccd6363ee8c..feb44a573d44 100644
--- a/drivers/mtd/parsers/redboot.c
+++ b/drivers/mtd/parsers/redboot.c
@@ -17,15 +17,15 @@
 #include <linux/module.h>
 
 struct fis_image_desc {
-    unsigned char name[16];      // Null terminated name
-    uint32_t	  flash_base;    // Address within FLASH of image
-    uint32_t	  mem_base;      // Address in memory where it executes
-    uint32_t	  size;          // Length of image
-    uint32_t	  entry_point;   // Execution entry point
-    uint32_t	  data_length;   // Length of actual data
-    unsigned char _pad[256-(16+7*sizeof(uint32_t))];
-    uint32_t	  desc_cksum;    // Checksum over image descriptor
-    uint32_t	  file_cksum;    // Checksum over image data
+	unsigned char name[16];      // Null terminated name
+	u32	  flash_base;    // Address within FLASH of image
+	u32	  mem_base;      // Address in memory where it executes
+	u32	  size;          // Length of image
+	u32	  entry_point;   // Execution entry point
+	u32	  data_length;   // Length of actual data
+	unsigned char _pad[256 - (16 + 7 * sizeof(u32))];
+	u32	  desc_cksum;    // Checksum over image descriptor
+	u32	  file_cksum;    // Checksum over image data
 };
 
 struct fis_list {
@@ -90,12 +90,12 @@ static int parse_redboot_partitions(struct mtd_info *master,
 
 	parse_redboot_of(master);
 
-	if ( directory < 0 ) {
+	if (directory < 0) {
 		offset = master->size + directory * master->erasesize;
 		while (mtd_block_isbad(master, offset)) {
 			if (!offset) {
-			nogood:
-				printk(KERN_NOTICE "Failed to find a non-bad block to check for RedBoot partition table\n");
+nogood:
+				pr_notice("Failed to find a non-bad block to check for RedBoot partition table\n");
 				return -EIO;
 			}
 			offset -= master->erasesize;
@@ -113,8 +113,8 @@ static int parse_redboot_partitions(struct mtd_info *master,
 	if (!buf)
 		return -ENOMEM;
 
-	printk(KERN_NOTICE "Searching for RedBoot partition table in %s at offset 0x%lx\n",
-	       master->name, offset);
+	pr_notice("Searching for RedBoot partition table in %s at offset 0x%lx\n",
+		  master->name, offset);
 
 	ret = mtd_read(master, offset, master->erasesize, &retlen,
 		       (void *)buf);
@@ -150,14 +150,13 @@ static int parse_redboot_partitions(struct mtd_info *master,
 			     && swab32(buf[i].size) < master->erasesize)) {
 				int j;
 				/* Update numslots based on actual FIS directory size */
-				numslots = swab32(buf[i].size) / sizeof (struct fis_image_desc);
+				numslots = swab32(buf[i].size) / sizeof(struct fis_image_desc);
 				for (j = 0; j < numslots; ++j) {
-
 					/* A single 0xff denotes a deleted entry.
 					 * Two of them in a row is the end of the table.
 					 */
 					if (buf[j].name[0] == 0xff) {
-				  		if (buf[j].name[1] == 0xff) {
+						if (buf[j].name[1] == 0xff) {
 							break;
 						} else {
 							continue;
@@ -184,8 +183,8 @@ static int parse_redboot_partitions(struct mtd_info *master,
 	}
 	if (i == numslots) {
 		/* Didn't find it */
-		printk(KERN_NOTICE "No RedBoot partition table detected in %s\n",
-		       master->name);
+		pr_notice("No RedBoot partition table detected in %s\n",
+			  master->name);
 		ret = 0;
 		goto out;
 	}
@@ -204,7 +203,7 @@ static int parse_redboot_partitions(struct mtd_info *master,
 			break;
 
 		new_fl = kmalloc(sizeof(struct fis_list), GFP_KERNEL);
-		namelen += strlen(buf[i].name)+1;
+		namelen += strlen(buf[i].name) + 1;
 		if (!new_fl) {
 			ret = -ENOMEM;
 			goto out;
@@ -213,13 +212,13 @@ static int parse_redboot_partitions(struct mtd_info *master,
 		if (data && data->origin)
 			buf[i].flash_base -= data->origin;
 		else
-			buf[i].flash_base &= master->size-1;
+			buf[i].flash_base &= master->size - 1;
 
 		/* I'm sure the JFFS2 code has done me permanent damage.
 		 * I now think the following is _normal_
 		 */
 		prev = &fl;
-		while(*prev && (*prev)->img->flash_base < new_fl->img->flash_base)
+		while (*prev && (*prev)->img->flash_base < new_fl->img->flash_base)
 			prev = &(*prev)->next;
 		new_fl->next = *prev;
 		*prev = new_fl;
@@ -239,7 +238,7 @@ static int parse_redboot_partitions(struct mtd_info *master,
 		}
 	}
 #endif
-	parts = kzalloc(sizeof(*parts)*nrparts + nulllen + namelen, GFP_KERNEL);
+	parts = kzalloc(sizeof(*parts) * nrparts + nulllen + namelen, GFP_KERNEL);
 
 	if (!parts) {
 		ret = -ENOMEM;
@@ -248,23 +247,22 @@ static int parse_redboot_partitions(struct mtd_info *master,
 
 	nullname = (char *)&parts[nrparts];
 #ifdef CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED
-	if (nulllen > 0) {
+	if (nulllen > 0)
 		strcpy(nullname, nullstring);
-	}
 #endif
 	names = nullname + nulllen;
 
-	i=0;
+	i = 0;
 
 #ifdef CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED
 	if (fl->img->flash_base) {
-	       parts[0].name = nullname;
-	       parts[0].size = fl->img->flash_base;
-	       parts[0].offset = 0;
+		parts[0].name = nullname;
+		parts[0].size = fl->img->flash_base;
+		parts[0].offset = 0;
 		i++;
 	}
 #endif
-	for ( ; i<nrparts; i++) {
+	for ( ; i < nrparts; i++) {
 		parts[i].size = fl->img->size;
 		parts[i].offset = fl->img->flash_base;
 		parts[i].name = names;
@@ -272,17 +270,17 @@ static int parse_redboot_partitions(struct mtd_info *master,
 		strcpy(names, fl->img->name);
 #ifdef CONFIG_MTD_REDBOOT_PARTS_READONLY
 		if (!memcmp(names, "RedBoot", 8) ||
-				!memcmp(names, "RedBoot config", 15) ||
-				!memcmp(names, "FIS directory", 14)) {
+		    !memcmp(names, "RedBoot config", 15) ||
+		    !memcmp(names, "FIS directory", 14)) {
 			parts[i].mask_flags = MTD_WRITEABLE;
 		}
 #endif
-		names += strlen(names)+1;
+		names += strlen(names) + 1;
 
 #ifdef CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED
-		if(fl->next && fl->img->flash_base + fl->img->size + master->erasesize <= fl->next->img->flash_base) {
+		if (fl->next && fl->img->flash_base + fl->img->size + master->erasesize <= fl->next->img->flash_base) {
 			i++;
-			parts[i].offset = parts[i-1].size + parts[i-1].offset;
+			parts[i].offset = parts[i - 1].size + parts[i - 1].offset;
 			parts[i].size = fl->next->img->flash_base - parts[i].offset;
 			parts[i].name = nullname;
 		}
@@ -296,6 +294,7 @@ static int parse_redboot_partitions(struct mtd_info *master,
  out:
 	while (fl) {
 		struct fis_list *old = fl;
+
 		fl = fl->next;
 		kfree(old);
 	}
-- 
2.26.3

