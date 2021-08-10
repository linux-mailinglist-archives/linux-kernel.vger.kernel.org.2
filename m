Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF77B3DE507
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 06:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhHCEXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 00:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhHCEXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 00:23:00 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC73C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 21:22:50 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id e21so22163984pla.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 21:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tXJO3DS43dJeTykYAE8toCIr8am72kynw84HwxXNATU=;
        b=TBOO+fZ+ARJfZzumGvwQm67UCaUMczInFrrCTUMYJcn/2QrCuL+/a8+1+6GvbjX2lw
         2I2XoWu5o79zJzUN/cvdSaYcRSoHJ3RFYZGVRoJYmFVk0F87iI/b1WYoOzpTu3U3sDZv
         yqpqB40rdfD+7gpEWJtEfaxk7wEpJiE15ZVgBA5W4VtDmvVH9m3nK3CgKE7Ki+lW6MHN
         pIxlcnoLnCa4OpqKyvUjQcMDK0EQVAabVJA/TIjcn+9lG0gN5VBj6zOvVecyutHr6YeS
         EdiTA/HC6XEWBEpEVvOGPIheUzQmT0nRgksRI0XB994iMV4RCfAasJkc3qjr8KYQbwVn
         Wynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tXJO3DS43dJeTykYAE8toCIr8am72kynw84HwxXNATU=;
        b=j1jvFnrQrKw+7KL7hR+Gy7jP3TSJC78zuFijPumFsCdJWE+10F6rs5tBPWTCkzL3uw
         VVmcfu8IUhvmm7VyB9XjvxnSg/ukf4P9/mI6p1OmQg32fXPe/1ROAgUSKQ6MQ9DNCmIF
         a17A7giuWl1GfjX0B+71KxHSoNEiDjQHsX9D+r/1+fG0FbdNBl2W3ftfWuc9iNfmhozh
         OpZ4j2klVmMqLFQiJMnXf26zHKYXTMKklLo6+7Fxn1/mzTUauk6PMRFUQB8RbKJub7Yh
         5gDVXhbaRT/NNAewVznRPK5jG36cguiP5BiTtQedKgjRWvGp/pSnjcbhoBNhE2KSsSEF
         Ohww==
X-Gm-Message-State: AOAM532AubNuWkHTHwoBO5MnYHH9obFaR69B6VhcyJSgsB8X1s7nylYO
        7lC53aFguhaGsVo1rx1fUopNccx/VOQ=
X-Google-Smtp-Source: ABdhPJzydDBjUMimjSQFmMbmcPhvgXqryrfwelng2TXuMHLYroPLN8pTg5DYlr5idMxgecsMJUoBcw==
X-Received: by 2002:a05:6a00:23cf:b029:2d5:302e:dc77 with SMTP id g15-20020a056a0023cfb02902d5302edc77mr20805513pfc.63.1627964569738;
        Mon, 02 Aug 2021 21:22:49 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:415b:68b1:20fb:3589])
        by smtp.gmail.com with ESMTPSA id b17sm9538385pgl.61.2021.08.02.21.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 21:22:49 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH v3] f2fs: add sysfs node to control ra_pages for fadvise seq file
Date:   Mon,  2 Aug 2021 21:22:45 -0700
Message-Id: <20210803042245.2297259-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

fadvise() allows the user to expand the readahead window to double with
POSIX_FADV_SEQUENTIAL, now. But, in some use cases, it is not that
sufficient and we need to meet the need in a restricted way. We can
control the multiplier value of bdi device readahead between 2 (default)
and 256 for POSIX_FADV_SEQUENTIAL advise option.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

---
v3: changed a meaningless value to defined value
v2: fix minor style issues
---
 Documentation/ABI/testing/sysfs-fs-f2fs |  6 +++++
 fs/f2fs/f2fs.h                          |  5 +++++
 fs/f2fs/file.c                          | 30 +++++++++++++++++++++++++
 fs/f2fs/super.c                         |  1 +
 fs/f2fs/sysfs.c                         | 10 +++++++++
 5 files changed, 52 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 845c4be535b0..73211f77d11e 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -507,3 +507,9 @@ Date:		July 2021
 Contact:	"Daeho Jeong" <daehojeong@google.com>
 Description:	You can control for which gc mode the "gc_reclaimed_segments" node shows.
 		Refer to the description of the modes in "gc_reclaimed_segments".
+
+What:		/sys/fs/f2fs/<disk>/seq_file_ra_mul
+Date:		July 2021
+Contact:	"Daeho Jeong" <daehojeong@google.com>
+Description:	You can	control the multiplier value of	bdi device readahead window size
+		between 2 (default) and 256 for POSIX_FADV_SEQUENTIAL advise option.
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8459b6d5a2f8..10a94ed839b1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1738,6 +1738,8 @@ struct f2fs_sb_info {
 	unsigned int gc_segment_mode;		/* GC state for reclaimed segments */
 	unsigned int gc_reclaimed_segs[MAX_GC_MODE];	/* Reclaimed segs for each mode */
 
+	unsigned long seq_file_ra_mul;		/* multiplier for ra_pages of seq. files in fadvise */
+
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	struct kmem_cache *page_array_slab;	/* page array entry */
 	unsigned int page_array_slab_size;	/* default page array slab size */
@@ -3992,6 +3994,9 @@ void f2fs_destroy_extent_cache(void);
 /*
  * sysfs.c
  */
+#define MIN_RA_MUL	2
+#define MAX_RA_MUL	256
+
 int __init f2fs_init_sysfs(void);
 void f2fs_exit_sysfs(void);
 int f2fs_register_sysfs(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index b1cb5b50faac..1a631e6d3e9b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -23,6 +23,7 @@
 #include <linux/nls.h>
 #include <linux/sched/signal.h>
 #include <linux/fileattr.h>
+#include <linux/fadvise.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -4332,6 +4333,34 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	return ret;
 }
 
+static int f2fs_file_fadvise(struct file *filp, loff_t offset, loff_t len,
+		int advice)
+{
+	struct inode *inode;
+	struct address_space *mapping;
+	struct backing_dev_info *bdi;
+
+	if (advice == POSIX_FADV_SEQUENTIAL) {
+		inode = file_inode(filp);
+		if (S_ISFIFO(inode->i_mode))
+			return -ESPIPE;
+
+		mapping = filp->f_mapping;
+		if (!mapping || len < 0)
+			return -EINVAL;
+
+		bdi = inode_to_bdi(mapping->host);
+		filp->f_ra.ra_pages = bdi->ra_pages *
+			F2FS_I_SB(inode)->seq_file_ra_mul;
+		spin_lock(&filp->f_lock);
+		filp->f_mode &= ~FMODE_RANDOM;
+		spin_unlock(&filp->f_lock);
+		return 0;
+	}
+
+	return generic_fadvise(filp, offset, len, advice);
+}
+
 #ifdef CONFIG_COMPAT
 struct compat_f2fs_gc_range {
 	u32 sync;
@@ -4460,4 +4489,5 @@ const struct file_operations f2fs_file_operations = {
 #endif
 	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
+	.fadvise	= f2fs_file_fadvise,
 };
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 72eb9d70969f..04aeb7c0df7d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3422,6 +3422,7 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 	sbi->next_victim_seg[FG_GC] = NULL_SEGNO;
 	sbi->max_victim_search = DEF_MAX_VICTIM_SEARCH;
 	sbi->migration_granularity = sbi->segs_per_sec;
+	sbi->seq_file_ra_mul = MIN_RA_MUL;
 
 	sbi->dir_level = DEF_DIR_LEVEL;
 	sbi->interval_time[CP_TIME] = DEF_CP_INTERVAL;
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index b1725620c07d..f3a3aecbe111 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -538,6 +538,14 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "seq_file_ra_mul")) {
+		if (t >= MIN_RA_MUL && t <= MAX_RA_MUL)
+			sbi->seq_file_ra_mul = t;
+		else
+			return -EINVAL;
+		return count;
+	}
+
 	*ui = (unsigned int)t;
 
 	return count;
@@ -763,6 +771,7 @@ F2FS_RW_ATTR(ATGC_INFO, atgc_management, atgc_candidate_count, max_candidate_cou
 F2FS_RW_ATTR(ATGC_INFO, atgc_management, atgc_age_weight, age_weight);
 F2FS_RW_ATTR(ATGC_INFO, atgc_management, atgc_age_threshold, age_threshold);
 
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, seq_file_ra_mul, seq_file_ra_mul);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_segment_mode, gc_segment_mode);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_reclaimed_segments, gc_reclaimed_segs);
 
@@ -838,6 +847,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(atgc_candidate_count),
 	ATTR_LIST(atgc_age_weight),
 	ATTR_LIST(atgc_age_threshold),
+	ATTR_LIST(seq_file_ra_mul),
 	ATTR_LIST(gc_segment_mode),
 	ATTR_LIST(gc_reclaimed_segments),
 	NULL,
-- 
2.32.0.554.ge1b32706d8-goog

