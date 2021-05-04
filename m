Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4496B3725C2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 08:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhEDGWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 02:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbhEDGWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 02:22:02 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436B3C061574
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 23:21:08 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id t22so5857414pgu.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 23:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=XvLhmui0DLBspUsebj9ZhiFb3OL3QLLsT0XxkJts9GM=;
        b=n/88DwrSGVg+p/UJg/8TjC8QfENWmOxZ6mzWRtpaudIol2IiY6LubibGpSjCe8jyRR
         YJ8ePUA7cuM0EQkGk6ICv8QHtMulLmSmdkt9Q6mi2UtIoTNDtc55Bpt8DsGZi9+19wLM
         Iwh0Ek6NFBAEYNd1w7Y8El+1S0fyAqhJgLIl6xU4Hh8yAoaEm0Gcs4l+dY8NwQSD7PL1
         7ulR4nnbZ20H40iC1pilyG7iVcdsTviWgeLt8BZEYDBvRRa1EUWHHBg0SVHC0sQZtOHl
         gQdMyySawyX/6C7vx7edLj4Ql58f5Rw5BdByHahcR9SfUWf5nha7LGo+xIimGbJBsoiz
         KTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=XvLhmui0DLBspUsebj9ZhiFb3OL3QLLsT0XxkJts9GM=;
        b=TVbnx17+kL5MHOI91+FL0OIgA7SDjMLs5lBhEiNJUol5E8Ls0FSwRCLw4bPs5quW4z
         eusSwYdjfUH+F60VR2oNO7PiNqm1Evb/jg8yewE2dEzb03hgFShb/9P+7VhSUF6prRyW
         PCh03YQA80jWT137jKgl2WBpPCYi5cctYveJiZvqLu7PlZwBHWlqnqhkUG7WPiKDFJCw
         A+P3odAgmzEqw5foF7mYsEkBAmBQtu/NBr+Q4Ase/JLF6PvU/aDdYMRxyakPnXa1PHmx
         Qx3D2zlmsALHhA3sImviDd66k+eLDUCb70D6M84WIEjtBE7yzzagYGNlDsqLHHLov0hI
         AS5g==
X-Gm-Message-State: AOAM5312luHNG+WINUCklLVjE6RZ6h+K0Y0Crqu8Y7yS6yhEqP8HE+FD
        i5UePhr3GMg/dEiV/Td4uYA=
X-Google-Smtp-Source: ABdhPJwM0ko0KU5LpvTsmPaxv7/zz1yELmz+Zx7cOP30kAu9E5UbKS6PJIW4RsTjk9twkCjRsGylXA==
X-Received: by 2002:a17:90b:2393:: with SMTP id mr19mr3055929pjb.24.1620109267641;
        Mon, 03 May 2021 23:21:07 -0700 (PDT)
Received: from localhost ([157.45.118.142])
        by smtp.gmail.com with ESMTPSA id t1sm11403542pjo.33.2021.05.03.23.21.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 May 2021 23:21:07 -0700 (PDT)
Date:   Tue, 4 May 2021 11:50:59 +0530
From:   Shubhankar Kuranagatti <shubhankarvk@gmail.com>
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: mtd: sm_ftl.c: Fix alignment of block comment
Message-ID: <20210504062059.mywqzwveyjfawreg@kewl-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A star has been added to subsequent line of block comment
The closing */ has been shifted to new line
This is done to maintain code uniformity

Signed-off-by: Shubhankar Kuranagatti <shubhankarvk@gmail.com>
---
 drivers/mtd/sm_ftl.c | 51 +++++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 19 deletions(-)

diff --git a/drivers/mtd/sm_ftl.c b/drivers/mtd/sm_ftl.c
index 4d1ae25507ab..0cff2cda1b5a 100644
--- a/drivers/mtd/sm_ftl.c
+++ b/drivers/mtd/sm_ftl.c
@@ -265,7 +265,8 @@ static int sm_read_sector(struct sm_ftl *ftl,
 again:
 	if (try++) {
 		/* Avoid infinite recursion on CIS reads, sm_recheck_media
-			won't help anyway */
+		 * won't help anyway
+		 */
 		if (zone == 0 && block == ftl->cis_block && boffset ==
 			ftl->cis_boffset)
 			return ret;
@@ -276,7 +277,8 @@ static int sm_read_sector(struct sm_ftl *ftl,
 	}
 
 	/* Unfortunately, oob read will _always_ succeed,
-		despite card removal..... */
+	 * despite card removal.....
+	 */
 	ret = mtd_read_oob(mtd, sm_mkoffset(ftl, zone, block, boffset), &ops);
 
 	/* Test for unknown errors */
@@ -411,9 +413,10 @@ static int sm_write_block(struct sm_ftl *ftl, uint8_t *buf,
 
 			/* If write fails. try to erase the block */
 			/* This is safe, because we never write in blocks
-				that contain valuable data.
-			This is intended to repair block that are marked
-			as erased, but that isn't fully erased*/
+			 * that contain valuable data.
+			 * This is intended to repair block that are marked
+			 * as erased, but that isn't fully erased
+			 */
 
 			if (sm_erase_block(ftl, zone, block, 0))
 				return -EIO;
@@ -448,7 +451,8 @@ static void sm_mark_block_bad(struct sm_ftl *ftl, int zone, int block)
 
 	/* We aren't checking the return value, because we don't care */
 	/* This also fails on fake xD cards, but I guess these won't expose
-		any bad blocks till fail completely */
+	 * any bad blocks till fail completely
+	 */
 	for (boffset = 0; boffset < ftl->block_size; boffset += SM_SECTOR_SIZE)
 		sm_write_sector(ftl, zone, block, boffset, NULL, &oob);
 }
@@ -505,7 +509,8 @@ static int sm_check_block(struct sm_ftl *ftl, int zone, int block)
 
 	/* First just check that block doesn't look fishy */
 	/* Only blocks that are valid or are sliced in two parts, are
-		accepted */
+	 * accepted
+	 */
 	for (boffset = 0; boffset < ftl->block_size;
 					boffset += SM_SECTOR_SIZE) {
 
@@ -554,7 +559,8 @@ static const uint8_t cis_signature[] = {
 	0x01, 0x03, 0xD9, 0x01, 0xFF, 0x18, 0x02, 0xDF, 0x01, 0x20
 };
 /* Find out media parameters.
- * This ideally has to be based on nand id, but for now device size is enough */
+ * This ideally has to be based on nand id, but for now device size is enough
+ */
 static int sm_get_media_info(struct sm_ftl *ftl, struct mtd_info *mtd)
 {
 	int i;
@@ -607,7 +613,8 @@ static int sm_get_media_info(struct sm_ftl *ftl, struct mtd_info *mtd)
 	}
 
 	/* Minimum xD size is 16MiB. Also, all xD cards have standard zone
-	   sizes. SmartMedia cards exist up to 128 MiB and have same layout*/
+	 * sizes. SmartMedia cards exist up to 128 MiB and have same layout
+	 */
 	if (size_in_megs >= 16) {
 		ftl->zone_count = size_in_megs / 16;
 		ftl->zone_size = 1024;
@@ -782,7 +789,8 @@ static int sm_init_zone(struct sm_ftl *ftl, int zone_num)
 		}
 
 		/* Test to see if block is erased. It is enough to test
-			first sector, because erase happens in one shot */
+		 * first sector, because erase happens in one shot
+		 */
 		if (sm_block_erased(&oob)) {
 			kfifo_in(&zone->free_sectors,
 				(unsigned char *)&block, 2);
@@ -792,7 +800,8 @@ static int sm_init_zone(struct sm_ftl *ftl, int zone_num)
 		/* If block is marked as bad, skip it */
 		/* This assumes we can trust first sector*/
 		/* However the way the block valid status is defined, ensures
-			very low probability of failure here */
+		 * very low probability of failure here
+		 */
 		if (!sm_block_valid(&oob)) {
 			dbg("PH %04d <-> <marked bad>", block);
 			continue;
@@ -803,7 +812,8 @@ static int sm_init_zone(struct sm_ftl *ftl, int zone_num)
 
 		/* Invalid LBA means that block is damaged. */
 		/* We can try to erase it, or mark it as bad, but
-			lets leave that to recovery application */
+		 * lets leave that to recovery application
+		 */
 		if (lba == -2 || lba >= ftl->max_lba) {
 			dbg("PH %04d <-> LBA %04d(bad)", block, lba);
 			continue;
@@ -811,7 +821,8 @@ static int sm_init_zone(struct sm_ftl *ftl, int zone_num)
 
 
 		/* If there is no collision,
-			just put the sector in the FTL table */
+		 * just put the sector in the FTL table
+		 */
 		if (zone->lba_to_phys_table[lba] < 0) {
 			dbg_verbose("PH %04d <-> LBA %04d", block, lba);
 			zone->lba_to_phys_table[lba] = block;
@@ -834,9 +845,9 @@ static int sm_init_zone(struct sm_ftl *ftl, int zone_num)
 		}
 
 		/* If both blocks are valid and share same LBA, it means that
-			they hold different versions of same data. It not
-			known which is more recent, thus just erase one of them
-		*/
+		 * they hold different versions of same data. It not
+		 * known which is more recent, thus just erase one of them
+		 */
 		sm_printk("both blocks are valid, erasing the later");
 		sm_erase_block(ftl, zone_num, block, 1);
 	}
@@ -845,7 +856,8 @@ static int sm_init_zone(struct sm_ftl *ftl, int zone_num)
 	zone->initialized = 1;
 
 	/* No free sectors, means that the zone is heavily damaged, write won't
-		work, but it can still can be (partially) read */
+	 * work, but it can still can be (partially) read
+	 */
 	if (!kfifo_len(&zone->free_sectors)) {
 		sm_printk("no free blocks in zone %d", zone_num);
 		return 0;
@@ -952,8 +964,9 @@ static int sm_cache_flush(struct sm_ftl *ftl)
 
 	/* If there are no spare blocks, */
 	/* we could still continue by erasing/writing the current block,
-		but for such worn out media it doesn't worth the trouble,
-			and the dangers */
+	 * but for such worn out media it doesn't worth the trouble,
+	 * and the dangers
+	 */
 	if (kfifo_out(&zone->free_sectors,
 				(unsigned char *)&write_sector, 2) != 2) {
 		dbg("no free sectors for write!");
-- 
2.17.1

