Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E8C3FC214
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 07:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbhHaFLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 01:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhHaFLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 01:11:37 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06420C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 22:10:43 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id d3-20020a17090ae28300b0019629c96f25so1522976pjz.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 22:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=POzeuDN2B/dZOqWRi1SomAxzYwAHr9xeqPjl4S2qOqk=;
        b=TqkwkuCWoWDcjeLLKrRqrjhBCfGtADJe+6JVrzYnPHnte9KDyGG215/ZDGlkdkwuxK
         5MugjJoqvnrs5zY8bqJ5WamD6A2yikjTyDgQR5tjbRNP1V7imPk0w7qT+vFQyd+5/1yE
         0eR/oR3mp21Xfo+ZtC7n7u7TlOuhO+q6LNRyT3aeElJt1bdZTaEtOMMLXPDrj64x1XIO
         h5zpslsMkdQ7BHlEFVsEdcLAouJCfkt/WZ104qdPD3ouYqsbqsoV6cP6VmXUhC2byH6t
         e4QDXWoM8t1XDi8hr9q19PXN8iX5JJWpBY14hVS9KE3fuLJ7EVSfXHN9PUfW3kCjHMzA
         JGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=POzeuDN2B/dZOqWRi1SomAxzYwAHr9xeqPjl4S2qOqk=;
        b=Xs1eqa81hGBLY6H59JZAhuBN0zUkfJ/AizNK9akQdNqbhgxb5qpke9fiC350t9Md4m
         MYaGUGaHNsYRMLso0xwSvYWmbYAmGTfdse1H2UqA0b9PEp4xzz5iRkGygrfkWeU78PlF
         Njo8VFcoWAKhbxVs1PS913JCTHLwiijFQc6W6b1023MS2A9iYv8LWoDDrtEr5G0Bym8Q
         h/KBLfGCb3D62e8ZjC5X8cUa3f/xxXi7HNdLINUqifZdcjbXQyekBUCk3CKBTItfQa+v
         mKw8PoJPXcP4g8IvGYtY9+U+8zm4Kz+iKBSYCHzVzg8M3MaYEICNBxcGXp0l3Gtj8kvj
         6bJA==
X-Gm-Message-State: AOAM530+qqSi6bH77SxXLp6VNBvsYWgOr2Y+sgIE2LSLHs9FSpF7yK61
        Nr/4uySDS1dIQ+WRBjnN+kWkATskK8s=
X-Google-Smtp-Source: ABdhPJxiaYUmmjWr0AahcY9vVp+y5FkqZtzNfcmCv4A8SIG8CMnrCLBRU8Y4IkY4a+7J8ndjRxH+dw==
X-Received: by 2002:a17:90a:14c4:: with SMTP id k62mr3148521pja.126.1630386642106;
        Mon, 30 Aug 2021 22:10:42 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:4e37:37d1:bd97:eada])
        by smtp.gmail.com with ESMTPSA id a10sm15883469pfo.75.2021.08.30.22.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 22:10:41 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v3] f2fs: introduce fragment allocation mode mount option
Date:   Mon, 30 Aug 2021 22:10:37 -0700
Message-Id: <20210831051037.3108944-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Added three options into "mode=" mount option to make it possible for
developers to make the filesystem fragmented or simulate filesystem
fragmentation/after-GC situation itself. The developers use these modes
to understand filesystem fragmentation/after-GC condition well,
and eventually get some insights to handle them better.

"fragment:segment": f2fs allocates a new segment in ramdom position.
		With this, we can simulate the after-GC condition.
"fragment:fixed_block" : We can scatter block allocation with
		"fragment_chunk_size" and "fragment_hole_size" sysfs
		nodes. f2fs will allocate <fragment_chunk_size> blocks
		in a chunk and make a hole in the length of
		<fragment_hole_size> by turns in a newly allocated free
		segment.
"fragment:rand_block" : Working like "fragment:fixed_block" mode, but
		added some randomness to both chunk and hole size. So,
		f2fs will allocate 1..<fragment_chunk_size> blocks in a
		chunk and make a hole in the nodes. f2fs will allocate
		1..<fragment_chunk_size> blocks in a chunk and make a
		hole in the length of 1..<fragment_hole_size> by turns
		in a newly allocated free segment.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
v3: divided "fragment:block" mode and fixed a race condition related to
    making chunks.
v2: changed mode name and added sysfs nodes to control the fragmentation
    pattern.
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 24 ++++++++++++++++++++
 Documentation/filesystems/f2fs.rst      | 20 +++++++++++++++++
 fs/f2fs/f2fs.h                          | 21 ++++++++++++++++--
 fs/f2fs/gc.c                            |  5 ++++-
 fs/f2fs/segment.c                       | 29 +++++++++++++++++++++++--
 fs/f2fs/segment.h                       |  1 +
 fs/f2fs/super.c                         | 14 ++++++++++++
 fs/f2fs/sysfs.c                         | 20 +++++++++++++++++
 8 files changed, 129 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index f627e705e663..d56ecfd16abf 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -512,3 +512,27 @@ Date:		July 2021
 Contact:	"Daeho Jeong" <daehojeong@google.com>
 Description:	You can	control the multiplier value of	bdi device readahead window size
 		between 2 (default) and 256 for POSIX_FADV_SEQUENTIAL advise option.
+
+What:		/sys/fs/f2fs/<disk>/fragment_chunk_size
+Date:		August 2021
+Contact:	"Daeho Jeong" <daehojeong@google.com>
+Description:	With "mode=fragment:fixed_block" and "mode=fragment:rand_block" mount options,
+		we can scatter block allocation. Using this node, in "fragment:fixed_block"
+		mode, f2fs will allocate <fragment_chunk_size> blocks in a chunk and make
+		a hole in the length of	<fragment_hole_size> by turns in a newly allocated
+		free segment. Plus, in "fragment:rand_block" mode, f2fs will allocate
+		1..<fragment_chunk_size> blocks in a chunk and make a hole in the length of
+		1..<fragment_hole_size> by turns. This value can be set between 1..512 and
+		the default value is 4.
+
+What:		/sys/fs/f2fs/<disk>/fragment_hole_size
+Date:		August 2021
+Contact:	"Daeho Jeong" <daehojeong@google.com>
+Description:	With "mode=fragment:fixed_block" and "mode=fragment:rand_block" mount options,
+		we can scatter block allocation. Using this node, in "fragment:fixed_block"
+		mode, f2fs will allocate <fragment_chunk_size> blocks in a chunk and make
+		a hole in the length of	<fragment_hole_size> by turns in a newly allocated
+		free segment. Plus, in "fragment:rand_block" mode, f2fs will allocate
+		1..<fragment_chunk_size> blocks in a chunk and make a hole in the length of
+		1..<fragment_hole_size> by turns. This value can be set between 1..512 and
+		the default value is 4.
diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 09de6ebbbdfa..c58d300d2f41 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -201,6 +201,26 @@ fault_type=%d		 Support configuring fault injection type, should be
 mode=%s			 Control block allocation mode which supports "adaptive"
 			 and "lfs". In "lfs" mode, there should be no random
 			 writes towards main area.
+			 "fragment:segment", "fragment:fixed_block" and "fragment:rand_block"
+			 are newly added here. These are developer options for experiments
+			 to make the filesystem fragmented or simulate filesystem
+			 fragmentation/after-GC situation itself. The developers use these
+			 modes to understand filesystem fragmentation/after-GC condition well,
+			 and eventually get some insights to handle them better.
+			 In "fragment:segment", f2fs allocates a new segment in ramdom
+			 position. With this, we can simulate the after-GC condition.
+			 In "fragment:fixed_block" and "fragment:rand_block", we can scatter
+			 block allocation with "fragment_chunk_size" and "fragment_hole_size"
+			 sysfs nodes. In "fragment:fixed_block" mode, f2fs will allocate
+			 <fragment_chunk_size> blocks in a chunk and make a hole in the length
+			 of <fragment_hole_size> by turns in a newly allocated free segment.
+			 But, in "fragment:rand_block" mode, f2fs adds some randomness to
+			 both chunk and hole size. So, f2fs will allocate
+			 1..<fragment_chunk_size> blocks in a chunk and make a hole in the
+			 length of 1..<fragment_hole_size> by turns. With these, the newly
+			 allocated blocks will be scattered throughout the whole partition.
+			 Please, use these options for your experiments and we strongly
+			 recommend to re-format the filesystem after using these options.
 io_bits=%u		 Set the bit size of write IO requests. It should be set
 			 with "mode=lfs".
 usrquota		 Enable plain user disk quota accounting.
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c24f03e054cb..9f9368405ab1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1285,8 +1285,11 @@ enum {
 };
 
 enum {
-	FS_MODE_ADAPTIVE,	/* use both lfs/ssr allocation */
-	FS_MODE_LFS,		/* use lfs allocation only */
+	FS_MODE_ADAPTIVE,		/* use both lfs/ssr allocation */
+	FS_MODE_LFS,			/* use lfs allocation only */
+	FS_MODE_FRAGMENT_SEG,		/* segment fragmentation mode */
+	FS_MODE_FRAGMENT_FIXED_BLK,	/* fixed block fragmentation mode */
+	FS_MODE_FRAGMENT_RAND_BLK,	/* randomized block fragmentation mode */
 };
 
 enum {
@@ -1757,6 +1760,9 @@ struct f2fs_sb_info {
 
 	unsigned long seq_file_ra_mul;		/* multiplier for ra_pages of seq. files in fadvise */
 
+	int fragment_chunk_size;		/* the chunk size for block fragmentation mode */
+	int fragment_hole_size;			/* the hole size for block fragmentation mode */
+
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	struct kmem_cache *page_array_slab;	/* page array entry */
 	unsigned int page_array_slab_size;	/* default page array slab size */
@@ -3517,6 +3523,17 @@ unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi,
 unsigned int f2fs_usable_blks_in_seg(struct f2fs_sb_info *sbi,
 			unsigned int segno);
 
+#define DEF_FRAGMENT_SIZE	4
+#define MIN_FRAGMENT_SIZE	1
+#define MAX_FRAGMENT_SIZE	512
+
+static inline bool f2fs_fragment_mode(struct f2fs_sb_info *sbi)
+{
+	return F2FS_OPTION(sbi).fs_mode == FS_MODE_FRAGMENT_SEG ||
+		F2FS_OPTION(sbi).fs_mode == FS_MODE_FRAGMENT_FIXED_BLK ||
+		F2FS_OPTION(sbi).fs_mode == FS_MODE_FRAGMENT_RAND_BLK;
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
index a135d2247415..f064e439f2e0 100644
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
@@ -2681,6 +2684,11 @@ static void new_curseg(struct f2fs_sb_info *sbi, int type, bool new_sec)
 	curseg->next_segno = segno;
 	reset_curseg(sbi, type, 1);
 	curseg->alloc_type = LFS;
+	if (F2FS_OPTION(sbi).fs_mode == FS_MODE_FRAGMENT_FIXED_BLK)
+		curseg->fragment_remained_chunk = sbi->fragment_chunk_size;
+	else if (F2FS_OPTION(sbi).fs_mode == FS_MODE_FRAGMENT_RAND_BLK)
+		curseg->fragment_remained_chunk =
+				prandom_u32() % sbi->fragment_chunk_size + 1;
 }
 
 static int __next_free_blkoff(struct f2fs_sb_info *sbi,
@@ -2707,12 +2715,29 @@ static int __next_free_blkoff(struct f2fs_sb_info *sbi,
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
+		if (F2FS_OPTION(sbi).fs_mode == FS_MODE_FRAGMENT_FIXED_BLK) {
+			if (--seg->fragment_remained_chunk <= 0) {
+				seg->fragment_remained_chunk =
+				   sbi->fragment_chunk_size;
+				seg->next_blkoff +=
+				   sbi->fragment_hole_size;
+			}
+		} else if (F2FS_OPTION(sbi).fs_mode == FS_MODE_FRAGMENT_RAND_BLK) {
+			/* To allocate block chunks in different sizes, use random number */
+			if (--seg->fragment_remained_chunk <= 0) {
+				seg->fragment_remained_chunk =
+				   prandom_u32() % sbi->fragment_chunk_size + 1;
+				seg->next_blkoff +=
+				   prandom_u32() % sbi->fragment_hole_size + 1;
+			}
+		}
+	}
 }
 
 bool f2fs_segment_has_free_slot(struct f2fs_sb_info *sbi, int segno)
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 89fff258727d..46fde9f3f28e 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -314,6 +314,7 @@ struct curseg_info {
 	unsigned short next_blkoff;		/* next block offset to write */
 	unsigned int zone;			/* current zone number */
 	unsigned int next_segno;		/* preallocated segment */
+	int fragment_remained_chunk;		/* remained block size in a chunk for block fragmentation mode */
 	bool inited;				/* indicate inmem log is inited */
 };
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 49e153fd8183..60067b6d9fea 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -817,6 +817,12 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 				F2FS_OPTION(sbi).fs_mode = FS_MODE_ADAPTIVE;
 			} else if (!strcmp(name, "lfs")) {
 				F2FS_OPTION(sbi).fs_mode = FS_MODE_LFS;
+			} else if (!strcmp(name, "fragment:segment")) {
+				F2FS_OPTION(sbi).fs_mode = FS_MODE_FRAGMENT_SEG;
+			} else if (!strcmp(name, "fragment:fixed_block")) {
+				F2FS_OPTION(sbi).fs_mode = FS_MODE_FRAGMENT_FIXED_BLK;
+			} else if (!strcmp(name, "fragment:rand_block")) {
+				F2FS_OPTION(sbi).fs_mode = FS_MODE_FRAGMENT_RAND_BLK;
 			} else {
 				kfree(name);
 				return -EINVAL;
@@ -1897,6 +1903,12 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_puts(seq, "adaptive");
 	else if (F2FS_OPTION(sbi).fs_mode == FS_MODE_LFS)
 		seq_puts(seq, "lfs");
+	else if (F2FS_OPTION(sbi).fs_mode == FS_MODE_FRAGMENT_SEG)
+		seq_puts(seq, "fragment:segment");
+	else if (F2FS_OPTION(sbi).fs_mode == FS_MODE_FRAGMENT_FIXED_BLK)
+		seq_puts(seq, "fragment:fixed_block");
+	else if (F2FS_OPTION(sbi).fs_mode == FS_MODE_FRAGMENT_RAND_BLK)
+		seq_puts(seq, "fragment:rand_block");
 	seq_printf(seq, ",active_logs=%u", F2FS_OPTION(sbi).active_logs);
 	if (test_opt(sbi, RESERVE_ROOT))
 		seq_printf(seq, ",reserve_root=%u,resuid=%u,resgid=%u",
@@ -3515,6 +3527,8 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 	sbi->max_victim_search = DEF_MAX_VICTIM_SEARCH;
 	sbi->migration_granularity = sbi->segs_per_sec;
 	sbi->seq_file_ra_mul = MIN_RA_MUL;
+	sbi->fragment_chunk_size = DEF_FRAGMENT_SIZE;
+	sbi->fragment_hole_size = DEF_FRAGMENT_SIZE;
 
 	sbi->dir_level = DEF_DIR_LEVEL;
 	sbi->interval_time[CP_TIME] = DEF_CP_INTERVAL;
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index a1a3e0f6d658..ab34b3c2e09d 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -551,6 +551,22 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "fragment_chunk_size")) {
+		if (t >= MIN_FRAGMENT_SIZE && t <= MAX_FRAGMENT_SIZE)
+			sbi->fragment_chunk_size = t;
+		else
+			return -EINVAL;
+		return count;
+	}
+
+	if (!strcmp(a->attr.name, "fragment_hole_size")) {
+		if (t >= MIN_FRAGMENT_SIZE && t <= MAX_FRAGMENT_SIZE)
+			sbi->fragment_hole_size = t;
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
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, fragment_chunk_size, fragment_chunk_size);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, fragment_hole_size, fragment_hole_size);
 
 #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
 static struct attribute *f2fs_attrs[] = {
@@ -859,6 +877,8 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(seq_file_ra_mul),
 	ATTR_LIST(gc_segment_mode),
 	ATTR_LIST(gc_reclaimed_segments),
+	ATTR_LIST(fragment_chunk_size),
+	ATTR_LIST(fragment_hole_size),
 	NULL,
 };
 ATTRIBUTE_GROUPS(f2fs);
-- 
2.33.0.259.gc128427fd7-goog

