Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 977913E4C76
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 20:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235900AbhHISzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 14:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235728AbhHISzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 14:55:18 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DE0C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 11:54:57 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id lw7-20020a17090b1807b029017881cc80b7so352640pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 11:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JFDH27KaX6Bplb2L7zfn1uM94mEXFuq9PmXIqO+M6UA=;
        b=nH2TlYoyJUgJy+JqjE6y9+n4UUrV8cMI0ihfDwkJCmFkrZkprgA7WYAQwM888kf38k
         Eaqpe5gVdqGTMSOabpHBXDSp39LzAEkeoYJ6qkDCUV0TZYG+1zMlhQdwmOqE+EK9gVB+
         62iOR5Qn3VtVXBL80xPmXlSqD6iKxQkaN9QzYKUm1jXco4UDYd1sOh1CAnTCwCDIlJ7e
         iYuEMNHhTQd1KKLOj++2ujqjQ09e+9HAcTOmx1BqZQm1MROJnAxqzKF907SBhM3q6ONA
         zFTO33l+LZgWwMP4gc6+PXut5JG3nkvcNg7gcvxzeq/nLlssoNYRwK7ZVkIjVkUln/0U
         l5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JFDH27KaX6Bplb2L7zfn1uM94mEXFuq9PmXIqO+M6UA=;
        b=UbdA63Z9dEeXZkaosXXBzNxaKykBS8RuUxcfw1rYZCIfle7Rr057Zw5Q14beVUZesM
         LcnotPoREDW4KCf1oMCIaC58PMJUtHBBe3FUE9imdsz/9ivVC2DkMjsPvK6B8Sv9mk/G
         EODqznKUWqxfZnUhruDxhfNQMAzghxpeX37/WYO3nTnD5QWxeX/s+ofYSXZNLuzo+eO0
         6EN++/UTspMSDkyUlosnh3Fnn6AAr6B04bQpGhHK2K2ct33nK0hSPxpxW5VA54ZQLClZ
         iu6mdCBQfG3Q5/B14yI+19juWxySrj3kMJckjnEMYe766JVKNHhCXWOZy5od4tIK1yDR
         DJVg==
X-Gm-Message-State: AOAM532zf62xO9CMksxWvuSwjSut/cPyfXHNEgku6jmbJ+mL9uQpONi7
        5p58N1er5N5u9pOuOJKS30YTyWqAx+k=
X-Google-Smtp-Source: ABdhPJw6wo9UfsueK7zwUEdBiXyulhloHoo7tJOOi5G/w3ZOB2vQO6EzIikD7FHEdW9/vLMUElFGhQ==
X-Received: by 2002:a17:90a:2a8e:: with SMTP id j14mr567651pjd.208.1628535296794;
        Mon, 09 Aug 2021 11:54:56 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:b4fb:63af:3274:9f8d])
        by smtp.gmail.com with ESMTPSA id 81sm21575374pfv.185.2021.08.09.11.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 11:54:55 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v2] f2fs: introduce blk_alloc_mode mount option
Date:   Mon,  9 Aug 2021 11:54:49 -0700
Message-Id: <20210809185449.2565768-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Added a mount option to control block allocation mode for filesystem
developer to simulate filesystem fragmentation and after-GC situation
for experimental reasons to understand the filesystem behaviors well
under the severe condition. This supports "normal", "seg_random" and
"blk_random:<num>" options.

"normal" (default): f2fs allocates blocks in the normal way.
"seg_random": f2fs allocates a new segment in ramdom position.
              With this, we can simulate the after-GC condition.
"blk_random:<num>": We can make f2fs allocate only 1..<num> blocks
                    in a row and forcibly change the segment randomly.
                    With this, the newly allocated blocks will be scatter
                    throughout the whole partition and we can simulate
                    filesystem fragmentation condition.

Signed-off-by: Daeho Jeong <daehojeong@google.com>

---
v2: changed the <num> initialization way.
---
 Documentation/filesystems/f2fs.rst | 16 ++++++++++
 fs/f2fs/f2fs.h                     | 20 +++++++++++++
 fs/f2fs/gc.c                       |  5 +++-
 fs/f2fs/segment.c                  | 12 ++++++++
 fs/f2fs/super.c                    | 47 ++++++++++++++++++++++++++++++
 5 files changed, 99 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index ff9e7cc97c65..a0ca963fda20 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -312,6 +312,22 @@ inlinecrypt		 When possible, encrypt/decrypt the contents of encrypted
 			 Documentation/block/inline-encryption.rst.
 atgc			 Enable age-threshold garbage collection, it provides high
 			 effectiveness and efficiency on background GC.
+blk_alloc_mode=%s	 Control block allocation mode. This is a developer option
+			 for experiments to simulate filesystem fragmentation and
+			 after-GC situation. The developers use this mode to understand
+			 filesystem fragmentation and after-GC condition well, and
+			 eventually get the insight to handle them better.
+			 This supports "normal", "seg_random" and "blk_random:<num>" modes.
+			 In "normal" mode (default), f2fs allocates blocks in the normal way.
+			 In "seg_random", f2fs allocates a new segment in ramdom position.
+			 With this, we can simulate the after-GC condition.
+			 In "blk_random:<num>", we can make f2fs allocate only 1..<num>
+			 blocks in a row and forcibly change the segment randomly.
+			 You can set the <num> within 1 .. 512 number.
+			 With this, the newly allocated blocks will be scatter throughout
+			 the whole partition and we can simulate filesystem fragmentation
+			 condition. Please, use this option for your experiments and we
+			 strongly recommand a filesystem format after using this option.
 ======================== ============================================================
 
 Debugfs Entries
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index fccee18ab776..aed09e8c0fce 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -155,6 +155,9 @@ struct f2fs_mount_info {
 	int compress_mode;			/* compression mode */
 	unsigned char extensions[COMPRESS_EXT_NUM][F2FS_EXTENSION_LEN];	/* extensions */
 	unsigned char noextensions[COMPRESS_EXT_NUM][F2FS_EXTENSION_LEN]; /* extensions */
+
+	int blk_alloc_mode;		/* block allocation mode */
+	int blk_alloc_random_max;	/* the maximum chunk size for block random allocation mode */
 };
 
 #define F2FS_FEATURE_ENCRYPT		0x0001
@@ -1740,6 +1743,8 @@ struct f2fs_sb_info {
 
 	unsigned long seq_file_ra_mul;		/* multiplier for ra_pages of seq. files in fadvise */
 
+	int blk_alloc_remained;			/* remained block count for this block allocation period */
+
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	struct kmem_cache *page_array_slab;	/* page array entry */
 	unsigned int page_array_slab_size;	/* default page array slab size */
@@ -3619,6 +3624,21 @@ unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi,
 unsigned int f2fs_usable_blks_in_seg(struct f2fs_sb_info *sbi,
 			unsigned int segno);
 
+#define MIN_BLK_ALLOC_RANDOM	1
+#define MAX_BLK_ALLOC_RANDOM	512
+
+enum {
+	BLK_ALLOC_MODE_NORMAL,		/* normal block allocation mode */
+	BLK_ALLOC_MODE_SEG_RANDOM,	/* make segment allocation random */
+	BLK_ALLOC_MODE_BLK_RANDOM,	/* make block allocation random */
+};
+
+static inline bool f2fs_need_seg_random(struct f2fs_sb_info *sbi)
+{
+	return F2FS_OPTION(sbi).blk_alloc_mode == BLK_ALLOC_MODE_SEG_RANDOM ||
+		F2FS_OPTION(sbi).blk_alloc_mode == BLK_ALLOC_MODE_BLK_RANDOM;
+}
+
 /*
  * checkpoint.c
  */
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 9dce44619069..571b50322e6e 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 #include <linux/freezer.h>
 #include <linux/sched/signal.h>
+#include <linux/random.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -256,7 +257,9 @@ static void select_policy(struct f2fs_sb_info *sbi, int gc_type,
 		p->max_search = sbi->max_victim_search;
 
 	/* let's select beginning hot/small space first in no_heap mode*/
-	if (test_opt(sbi, NOHEAP) &&
+	if (f2fs_need_seg_random(sbi))
+		p->offset = prandom_u32() % (MAIN_SECS(sbi) * sbi->segs_per_sec);
+	else if (test_opt(sbi, NOHEAP) &&
 		(type == CURSEG_HOT_DATA || IS_NODESEG(type)))
 		p->offset = 0;
 	else
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index f9b7fb785e1d..6dff2d36ad6b 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -15,6 +15,7 @@
 #include <linux/timer.h>
 #include <linux/freezer.h>
 #include <linux/sched/signal.h>
+#include <linux/random.h>
 
 #include "f2fs.h"
 #include "segment.h"
@@ -2587,6 +2588,8 @@ static unsigned int __get_next_segno(struct f2fs_sb_info *sbi, int type)
 	unsigned short seg_type = curseg->seg_type;
 
 	sanity_check_seg_type(sbi, seg_type);
+	if (f2fs_need_seg_random(sbi))
+		return prandom_u32() % (MAIN_SECS(sbi) * sbi->segs_per_sec);
 
 	/* if segs_per_sec is large than 1, we need to keep original policy. */
 	if (__is_large_section(sbi))
@@ -3150,6 +3153,15 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 static bool __has_curseg_space(struct f2fs_sb_info *sbi,
 					struct curseg_info *curseg)
 {
+	/* To allocate block chunks in different sizes, use random number */
+	if (F2FS_OPTION(sbi).blk_alloc_mode == BLK_ALLOC_MODE_BLK_RANDOM) {
+		if (--sbi->blk_alloc_remained < 0) {
+			sbi->blk_alloc_remained = prandom_u32() %
+				F2FS_OPTION(sbi).blk_alloc_random_max;
+			return false;
+		}
+	}
+
 	return curseg->next_blkoff < f2fs_usable_blks_in_seg(sbi,
 							curseg->segno);
 }
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9ead6d2e703b..ef14f3e8b29a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -155,6 +155,7 @@ enum {
 	Opt_atgc,
 	Opt_gc_merge,
 	Opt_nogc_merge,
+	Opt_blk_alloc_mode,
 	Opt_err,
 };
 
@@ -231,6 +232,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_atgc, "atgc"},
 	{Opt_gc_merge, "gc_merge"},
 	{Opt_nogc_merge, "nogc_merge"},
+	{Opt_blk_alloc_mode, "blk_alloc_mode=%s"},
 	{Opt_err, NULL},
 };
 
@@ -1173,6 +1175,40 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 		case Opt_nogc_merge:
 			clear_opt(sbi, GC_MERGE);
 			break;
+		case Opt_blk_alloc_mode:
+			name = match_strdup(&args[0]);
+			if (!name)
+				return -ENOMEM;
+			if (!strcmp(name, "normal")) {
+				F2FS_OPTION(sbi).blk_alloc_mode =
+					BLK_ALLOC_MODE_NORMAL;
+			} else if (!strcmp(name, "seg_random")) {
+				F2FS_OPTION(sbi).blk_alloc_mode =
+					BLK_ALLOC_MODE_SEG_RANDOM;
+			} else if (!strncmp(name, "blk_random:", 11)) {
+				const char *num = name + 11;
+				long size;
+
+				ret = kstrtol(num, 10, &size);
+				if (ret) {
+					kfree(name);
+					return ret;
+				}
+				if (size < MIN_BLK_ALLOC_RANDOM)
+					size = MIN_BLK_ALLOC_RANDOM;
+				else if (size > MAX_BLK_ALLOC_RANDOM)
+					size = MAX_BLK_ALLOC_RANDOM;
+
+				F2FS_OPTION(sbi).blk_alloc_mode =
+					BLK_ALLOC_MODE_BLK_RANDOM;
+				F2FS_OPTION(sbi).blk_alloc_random_max =	size;
+				sbi->blk_alloc_remained = size;
+			} else {
+				kfree(name);
+				return -EINVAL;
+			}
+			kfree(name);
+			break;
 		default:
 			f2fs_err(sbi, "Unrecognized mount option \"%s\" or missing value",
 				 p);
@@ -1919,6 +1955,14 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 	else if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_NOBARRIER)
 		seq_printf(seq, ",fsync_mode=%s", "nobarrier");
 
+	if (F2FS_OPTION(sbi).blk_alloc_mode == BLK_ALLOC_MODE_NORMAL)
+		seq_printf(seq, ",blk_alloc_mode=%s", "normal");
+	else if (F2FS_OPTION(sbi).blk_alloc_mode == BLK_ALLOC_MODE_SEG_RANDOM)
+		seq_printf(seq, ",blk_alloc_mode=%s", "seg_random");
+	else if (F2FS_OPTION(sbi).blk_alloc_mode == BLK_ALLOC_MODE_BLK_RANDOM)
+		seq_printf(seq, ",blk_alloc_mode=%s:%d", "blk_random",
+				F2FS_OPTION(sbi).blk_alloc_random_max);
+
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	f2fs_show_compress_options(seq, sbi->sb);
 #endif
@@ -1947,6 +1991,9 @@ static void default_options(struct f2fs_sb_info *sbi)
 	F2FS_OPTION(sbi).compress_ext_cnt = 0;
 	F2FS_OPTION(sbi).compress_mode = COMPR_MODE_FS;
 	F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_ON;
+	F2FS_OPTION(sbi).blk_alloc_mode = BLK_ALLOC_MODE_NORMAL;
+	F2FS_OPTION(sbi).blk_alloc_random_max = MAX_BLK_ALLOC_RANDOM;
+	sbi->blk_alloc_remained = MAX_BLK_ALLOC_RANDOM;
 
 	sbi->sb->s_flags &= ~SB_INLINECRYPT;
 
-- 
2.32.0.605.g8dce9f2422-goog

