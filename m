Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B064B3F7C7C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 20:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241125AbhHYS6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 14:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239538AbhHYS6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 14:58:38 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EEDC061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 11:57:52 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id ot2-20020a17090b3b4200b0019127f8ed87so4445178pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 11:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hLij9JXIQFxUcB6cZli9TE9DqsP/Ai0bv78Lg1l5b8k=;
        b=gpjcIr4rozu0rHf/2Q2/UxLfe/Z7pkMwI8LI8Uqg00xoeEiwWwRzLe6Xffurze16Ft
         88BllI6ZS5CFwskyKUfJa73CZCJ0x15Lt+1vEQyx94gJWt7bR9CKS/rlGJkxXGpvN2n9
         vONRYqrcRStyYrm6IRclA68Zh9Y+lSvv8Nns8nOjAHwvA6i/0vqvO7fUXsDBLy5d1xJk
         E16XiNrV8Fly2WPrIuOlDsLUwrBuLNXCYatMuQuLOh6nF9bf9s7BEAsZoZfdybg3Gsas
         daOfYDJpbETLt8LmXKhrOSu+YbukIsvi5A4y4UIY8QOI3M6iz25Wk0Xko9DSCoKNmlFQ
         c2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hLij9JXIQFxUcB6cZli9TE9DqsP/Ai0bv78Lg1l5b8k=;
        b=AjRh/IJ4n2I9DmcWMTeXBZS/QCEO9Jxi377Gvhd0LXVmWTsIYity5rnKot5pR9UmJc
         7n+QhIpi4Q1PKhHfY3rXec0bX3tHWF937Na4euzyQQkMvlx1i1NQ9evjtLvSWFoqzKsq
         DzFS5mkp+KNpLpFXJaKkCbG8jVoTNrxJ8J4ClWRYi3vpNTIq10reZ+XVPNUq0lQdjL6k
         aOiAeEwf8L4rR030ZpqcX55tWg/FU+S5laeHcc7HED32k+AjvqbsEvZ5XTAf0gDmYqCO
         Xkf+5f42Tw7eonZzE4+agtb1dZi+gAO2yK57mUYlyVuXsJNaOSx999JUlQ36szPg/Cxm
         B7gQ==
X-Gm-Message-State: AOAM530bgbZCWql/7pBFXdfItghmDCvzXpjR89NlehEJKmyLRCk6aCaz
        vJcuZDaRIY8ttmoxHYy05LhkrpE3pnw=
X-Google-Smtp-Source: ABdhPJw+6XVGm6rVKeeHB0z1TS5p8E4xhsAubWffKfqLsJ26M4vr5z87ubtO/Q5FurlwHhVLk+dQ6Q==
X-Received: by 2002:a17:902:b717:b029:11a:fae3:ba7c with SMTP id d23-20020a170902b717b029011afae3ba7cmr114796pls.28.1629917871990;
        Wed, 25 Aug 2021 11:57:51 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:211e:7c1e:c467:6ea4])
        by smtp.gmail.com with ESMTPSA id i1sm6449322pjs.31.2021.08.25.11.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 11:57:51 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v2] f2fs: introduce fragment allocation mode mount option
Date:   Wed, 25 Aug 2021 11:57:47 -0700
Message-Id: <20210825185747.1627497-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Added two options into "mode=" mount option to make it possible for
developers to make the filesystem fragmented or simulate filesystem
fragmentation/after-GC situation itself. The developers use these modes
to understand filesystem fragmentation/after-GC condition well,
and eventually get some insights to handle them better.

"fragment:segment": f2fs allocates a new segment in ramdom position.
                    With this, we can simulate the after-GC condition.
"fragment:block"  : We can scatter block allocation with
                    "fragment_chunk_max" and "fragment_hole_max" sysfs
                    nodes. f2fs will allocate 1..<fragment_chunk_max>
                    blocks in a chunk and make a hole in the length of
                    1..<fragment_hole_max> by turns in a newly allocated
                    free segment.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
v2: changed mode name and added sysfs nodes to control the fragmentation
    pattern.
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 18 ++++++++++++++++++
 Documentation/filesystems/f2fs.rst      | 16 ++++++++++++++++
 fs/f2fs/f2fs.h                          | 16 ++++++++++++++++
 fs/f2fs/gc.c                            |  5 ++++-
 fs/f2fs/segment.c                       | 17 +++++++++++++++--
 fs/f2fs/super.c                         | 11 +++++++++++
 fs/f2fs/sysfs.c                         | 20 ++++++++++++++++++++
 7 files changed, 100 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index f627e705e663..dba3997895ef 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -512,3 +512,21 @@ Date:		July 2021
 Contact:	"Daeho Jeong" <daehojeong@google.com>
 Description:	You can	control the multiplier value of	bdi device readahead window size
 		between 2 (default) and 256 for POSIX_FADV_SEQUENTIAL advise option.
+
+What:		/sys/fs/f2fs/<disk>/fragment_chunk_max
+Date:		August 2021
+Contact:	"Daeho Jeong" <daehojeong@google.com>
+Description:	With "mode=fragment:block" mount option, we can scatter block allocation.
+		Using this node, f2fs will allocate 1..<fragment_chunk_max> blocks in a chunk
+		and make a hole in the length of 1..<fragment_hole_max> by turns in a newly
+		allocated free segment. This value can be set between 1..512 and the default
+		value is 4.
+
+What:		/sys/fs/f2fs/<disk>/fragment_hole_max
+Date:		August 2021
+Contact:	"Daeho Jeong" <daehojeong@google.com>
+Description:	With "mode=fragment:block" mount option, we can scatter block allocation.
+		Using this node, f2fs will allocate 1..<fragment_chunk_max> blocks in a chunk
+		and make a hole in the length of 1..<fragment_hole_max> by turns in a newly
+		allocated free segment. This value can be set between 1..512 and the default
+		value is 4.
diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 09de6ebbbdfa..d2ddc1273f67 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -201,6 +201,22 @@ fault_type=%d		 Support configuring fault injection type, should be
 mode=%s			 Control block allocation mode which supports "adaptive"
 			 and "lfs". In "lfs" mode, there should be no random
 			 writes towards main area.
+			 "fragment:segment" and "fragment:block" are newly added here.
+			 These are developer options for experiments to make the filesystem
+			 fragmented or simulate filesystem fragmentation/after-GC situation
+			 itself. The developers use these modes to understand filesystem
+			 fragmentation/after-GC condition well, and eventually get some
+			 insights to handle them better.
+			 In "fragment:segment", f2fs allocates a new segment in ramdom
+			 position. With this, we can simulate the after-GC condition.
+			 In "fragment:block", we can scatter block allocation with
+			 "fragment_chunk_max" and "fragment_hole_max" sysfs nodes. f2fs will
+			 allocate 1..<fragment_chunk_max> blocks in a chunk and make
+			 a hole in the length of 1..<fragment_hole_max> by turns in a newly
+			 allocated free segment. With this, the newly allocated blocks will
+			 be scattered throughout the whole partition. Please, use these
+			 options for your experiments and we strongly recommend to re-format
+			 the filesystem after using these options.
 io_bits=%u		 Set the bit size of write IO requests. It should be set
 			 with "mode=lfs".
 usrquota		 Enable plain user disk quota accounting.
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c24f03e054cb..4e591fc75ee7 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1287,6 +1287,8 @@ enum {
 enum {
 	FS_MODE_ADAPTIVE,	/* use both lfs/ssr allocation */
 	FS_MODE_LFS,		/* use lfs allocation only */
+	FS_MODE_FRAGMENT_SEG,	/* segment fragmentation mode */
+	FS_MODE_FRAGMENT_BLK,	/* block fragmentation mode */
 };
 
 enum {
@@ -1757,6 +1759,10 @@ struct f2fs_sb_info {
 
 	unsigned long seq_file_ra_mul;		/* multiplier for ra_pages of seq. files in fadvise */
 
+	int fragment_chunk_max;		/* the maximum chunk size for fragment:block allocation mode */
+	int fragment_hole_max;		/* the maximum hole size for fragment:block allocation mode */
+	int fragment_remained_chunk;	/* remained size to make a full chunk */
+
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	struct kmem_cache *page_array_slab;	/* page array entry */
 	unsigned int page_array_slab_size;	/* default page array slab size */
@@ -3517,6 +3523,16 @@ unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi,
 unsigned int f2fs_usable_blks_in_seg(struct f2fs_sb_info *sbi,
 			unsigned int segno);
 
+#define DEF_FRAGMENT_SIZE	4
+#define MIN_FRAGMENT_SIZE	1
+#define MAX_FRAGMENT_SIZE	512
+
+static inline bool f2fs_fragment_mode(struct f2fs_sb_info *sbi)
+{
+	return F2FS_OPTION(sbi).fs_mode == FS_MODE_FRAGMENT_SEG ||
+		F2FS_OPTION(sbi).fs_mode == FS_MODE_FRAGMENT_BLK;
+}
+
 /*
  * checkpoint.c
  */
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 2c18443972b6..14046fb19a20 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 #include <linux/freezer.h>
 #include <linux/sched/signal.h>
+#include <linux/random.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -257,7 +258,9 @@ static void select_policy(struct f2fs_sb_info *sbi, int gc_type,
 		p->max_search = sbi->max_victim_search;
 
 	/* let's select beginning hot/small space first in no_heap mode*/
-	if (test_opt(sbi, NOHEAP) &&
+	if (f2fs_fragment_mode(sbi))
+		p->offset = prandom_u32() % (MAIN_SECS(sbi) * sbi->segs_per_sec);
+	else if (test_opt(sbi, NOHEAP) &&
 		(type == CURSEG_HOT_DATA || IS_NODESEG(type)))
 		p->offset = 0;
 	else
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index a135d2247415..0063c8ce18ac 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -15,6 +15,7 @@
 #include <linux/timer.h>
 #include <linux/freezer.h>
 #include <linux/sched/signal.h>
+#include <linux/random.h>
 
 #include "f2fs.h"
 #include "segment.h"
@@ -2630,6 +2631,8 @@ static unsigned int __get_next_segno(struct f2fs_sb_info *sbi, int type)
 	unsigned short seg_type = curseg->seg_type;
 
 	sanity_check_seg_type(sbi, seg_type);
+	if (f2fs_fragment_mode(sbi))
+		return prandom_u32() % (MAIN_SECS(sbi) * sbi->segs_per_sec);
 
 	/* if segs_per_sec is large than 1, we need to keep original policy. */
 	if (__is_large_section(sbi))
@@ -2707,12 +2710,22 @@ static int __next_free_blkoff(struct f2fs_sb_info *sbi,
 static void __refresh_next_blkoff(struct f2fs_sb_info *sbi,
 				struct curseg_info *seg)
 {
-	if (seg->alloc_type == SSR)
+	if (seg->alloc_type == SSR) {
 		seg->next_blkoff =
 			__next_free_blkoff(sbi, seg->segno,
 						seg->next_blkoff + 1);
-	else
+	} else {
 		seg->next_blkoff++;
+		/* To allocate block chunks in different sizes, use random number */
+		if (F2FS_OPTION(sbi).fs_mode == FS_MODE_FRAGMENT_BLK) {
+			if (--sbi->fragment_remained_chunk <= 0) {
+				sbi->fragment_remained_chunk =
+				    prandom_u32() % sbi->fragment_chunk_max + 1;
+				seg->next_blkoff +=
+				    prandom_u32() % sbi->fragment_hole_max + 1;
+			}
+		}
+	}
 }
 
 bool f2fs_segment_has_free_slot(struct f2fs_sb_info *sbi, int segno)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 49e153fd8183..112b50bed186 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -817,6 +817,10 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 				F2FS_OPTION(sbi).fs_mode = FS_MODE_ADAPTIVE;
 			} else if (!strcmp(name, "lfs")) {
 				F2FS_OPTION(sbi).fs_mode = FS_MODE_LFS;
+			} else if (!strcmp(name, "fragment:segment")) {
+				F2FS_OPTION(sbi).fs_mode = FS_MODE_FRAGMENT_SEG;
+			} else if (!strcmp(name, "fragment:block")) {
+				F2FS_OPTION(sbi).fs_mode = FS_MODE_FRAGMENT_BLK;
 			} else {
 				kfree(name);
 				return -EINVAL;
@@ -1897,6 +1901,10 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_puts(seq, "adaptive");
 	else if (F2FS_OPTION(sbi).fs_mode == FS_MODE_LFS)
 		seq_puts(seq, "lfs");
+	else if (F2FS_OPTION(sbi).fs_mode == FS_MODE_FRAGMENT_SEG)
+		seq_puts(seq, "fragment:segment");
+	else if (F2FS_OPTION(sbi).fs_mode == FS_MODE_FRAGMENT_BLK)
+		seq_puts(seq, "fragment:block");
 	seq_printf(seq, ",active_logs=%u", F2FS_OPTION(sbi).active_logs);
 	if (test_opt(sbi, RESERVE_ROOT))
 		seq_printf(seq, ",reserve_root=%u,resuid=%u,resgid=%u",
@@ -3515,6 +3523,9 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 	sbi->max_victim_search = DEF_MAX_VICTIM_SEARCH;
 	sbi->migration_granularity = sbi->segs_per_sec;
 	sbi->seq_file_ra_mul = MIN_RA_MUL;
+	sbi->fragment_chunk_max = DEF_FRAGMENT_SIZE;
+	sbi->fragment_hole_max = DEF_FRAGMENT_SIZE;
+	sbi->fragment_remained_chunk = DEF_FRAGMENT_SIZE;
 
 	sbi->dir_level = DEF_DIR_LEVEL;
 	sbi->interval_time[CP_TIME] = DEF_CP_INTERVAL;
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index a1a3e0f6d658..42c41efd21d3 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -551,6 +551,22 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "fragment_chunk_max")) {
+		if (t >= MIN_FRAGMENT_SIZE && t <= MAX_FRAGMENT_SIZE)
+			sbi->fragment_chunk_max = t;
+		else
+			return -EINVAL;
+		return count;
+	}
+
+	if (!strcmp(a->attr.name, "fragment_hole_max")) {
+		if (t >= MIN_FRAGMENT_SIZE && t <= MAX_FRAGMENT_SIZE)
+			sbi->fragment_hole_max = t;
+		else
+			return -EINVAL;
+		return count;
+	}
+
 	*ui = (unsigned int)t;
 
 	return count;
@@ -781,6 +797,8 @@ F2FS_RW_ATTR(ATGC_INFO, atgc_management, atgc_age_threshold, age_threshold);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, seq_file_ra_mul, seq_file_ra_mul);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_segment_mode, gc_segment_mode);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_reclaimed_segments, gc_reclaimed_segs);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, fragment_chunk_max, fragment_chunk_max);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, fragment_hole_max, fragment_hole_max);
 
 #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
 static struct attribute *f2fs_attrs[] = {
@@ -859,6 +877,8 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(seq_file_ra_mul),
 	ATTR_LIST(gc_segment_mode),
 	ATTR_LIST(gc_reclaimed_segments),
+	ATTR_LIST(fragment_chunk_max),
+	ATTR_LIST(fragment_hole_max),
 	NULL,
 };
 ATTRIBUTE_GROUPS(f2fs);
-- 
2.33.0.259.gc128427fd7-goog

