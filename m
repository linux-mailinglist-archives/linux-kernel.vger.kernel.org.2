Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A77A336A2A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 03:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhCKCdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 21:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhCKCck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 21:32:40 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6696C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 18:32:40 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id w34so11634553pga.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 18:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0jrg7iGa4RYXjLu/MmTA0frccpTTlqL/JYx7MpARQsw=;
        b=WpIdNjy03bODwTsVi/A+dU+4qUsEVxGf9rjzjeinPO3Ni8bkV4czPV49xDnccfbdyW
         R2JwvcFw/HXJLlYv7MYiRHWvDgC670ECsZr9fYJIpwfoFFUOINilnLsZYhUpspWML+Rv
         kcO+Wx2YO6laPxJelGBuM7J7Qzdlc0pK3UwX2g9eH5x9uCcDQsV0rRWhg4pYBk548umK
         tvZDi99R+nyzW/h6IDqRocG6MVwTYoQo3wDIaDYYVTakaRoSTAQMftHxMh8F27kxkH+m
         3nTYDD9HwiUEgWFuQDRkJ1+Y9wn9LeHBPGFJiHEy1xGrEdnM17FluPlygrq8vH76cVnK
         Pe4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0jrg7iGa4RYXjLu/MmTA0frccpTTlqL/JYx7MpARQsw=;
        b=X5aapxOoIiw+DS59EV+RrSLv4nXW/1o4JAuLpE89Dkq7zSwtNh4gnWiHNYd2/FMGl4
         bhtQsMze9OWKaEwefvZrQYqveYJAVG3mN5Guz3XqI7XhtCYnHiBmToorBHzLTIbmjdxu
         WjvJimGQLiP+kxNChaPObZW6CoeVCXOcImIs2FgBWGh6ThfgX2OziX2liChnj303bJgn
         AQz2hixgcOtjy9M0gDtH8O9QvS+Yd1WrPPCjsQiRuQsI1p19gkkE6GvTcd+sCmBw9wvX
         g0U48ijL5eI9DmC5rHW6qEb87R6xV/DGrAvQQk7Au0DFhFg2MIodrZ8HarraySeMXJ2y
         tKFg==
X-Gm-Message-State: AOAM531xMYHNqCnWpC1rxj/f0SdQzRr9oIP8ddq0gir8WDjfxUtqUy72
        fmSWYwX7GBiVJTf4Vk71buJTVum2E0w=
X-Google-Smtp-Source: ABdhPJweREoe8X4n+1x3kaG+RcB41z/5PTyfnjTIc2tT+3Eqas7s0HRh+etRJHjygHRvdb+jkWEPMQ==
X-Received: by 2002:a65:46c9:: with SMTP id n9mr5179633pgr.116.1615429959792;
        Wed, 10 Mar 2021 18:32:39 -0800 (PST)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:11:addc:c0e1:9aed:6202])
        by smtp.gmail.com with ESMTPSA id t13sm712715pfe.161.2021.03.10.18.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 18:32:39 -0800 (PST)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v3] f2fs: add sysfs nodes to get runtime compression stat
Date:   Thu, 11 Mar 2021 11:32:33 +0900
Message-Id: <20210311023233.1034946-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

I've added new sysfs nodes to show runtime compression stat since mount.
compr_written_block - show the block count written after compression
compr_saved_block - show the saved block count with compression
compr_new_inode - show the count of inode newly enabled for compression

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
v2: thanks to kernel test robot <lkp@intel.com>, fixed compile issue
    related to kernel config.
v3: changed sysfs nodes' names and made them runtime stat, not
    persistent on disk
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 20 +++++++++
 fs/f2fs/compress.c                      |  1 +
 fs/f2fs/f2fs.h                          | 19 ++++++++
 fs/f2fs/super.c                         |  7 +++
 fs/f2fs/sysfs.c                         | 58 +++++++++++++++++++++++++
 5 files changed, 105 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index cbeac1bebe2f..f2981eb319cb 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -409,3 +409,23 @@ Description:	Give a way to change checkpoint merge daemon's io priority.
 		I/O priority "3". We can select the class between "rt" and "be",
 		and set the I/O priority within valid range of it. "," delimiter
 		is necessary in between I/O class and priority number.
+
+What:		/sys/fs/f2fs/<disk>/compr_written_block
+Date:		March 2021
+Contact:	"Daeho Jeong" <daehojeong@google.com>
+Description:	Show the block count written after compression since mount.
+		If you write "0" here, you can initialize compr_written_block and
+		compr_saved_block to "0".
+
+What:		/sys/fs/f2fs/<disk>/compr_saved_block
+Date:		March 2021
+Contact:	"Daeho Jeong" <daehojeong@google.com>
+Description:	Show the saved block count with compression since mount.
+		If you write "0" here, you can initialize compr_written_block and
+		compr_saved_block to "0".
+
+What:		/sys/fs/f2fs/<disk>/compr_new_inode
+Date:		March 2021
+Contact:	"Daeho Jeong" <daehojeong@google.com>
+Description:	Show the count of inode newly enabled for compression since mount.
+		If you write "0" here, you can initialize compr_new_inode to "0".
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 77fa342de38f..3c9d797dbdd6 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1353,6 +1353,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 	if (fio.compr_blocks)
 		f2fs_i_compr_blocks_update(inode, fio.compr_blocks - 1, false);
 	f2fs_i_compr_blocks_update(inode, cc->nr_cpages, true);
+	add_compr_block_stat(inode, cc->nr_cpages);
 
 	set_inode_flag(cc->inode, FI_APPEND_WRITE);
 	if (cc->cluster_idx == 0)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e2d302ae3a46..2c989f8caf05 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1623,6 +1623,11 @@ struct f2fs_sb_info {
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	struct kmem_cache *page_array_slab;	/* page array entry */
 	unsigned int page_array_slab_size;	/* default page array slab size */
+
+	/* For runtime compression statistics */
+	atomic64_t compr_written_block;
+	atomic64_t compr_saved_block;
+	atomic_t compr_new_inode;
 #endif
 };
 
@@ -3955,6 +3960,18 @@ int f2fs_init_page_array_cache(struct f2fs_sb_info *sbi);
 void f2fs_destroy_page_array_cache(struct f2fs_sb_info *sbi);
 int __init f2fs_init_compress_cache(void);
 void f2fs_destroy_compress_cache(void);
+#define inc_compr_inode_stat(inode)					\
+	do {								\
+		struct f2fs_sb_info *sbi = F2FS_I_SB(inode);		\
+		atomic_inc(&sbi->compr_new_inode);			\
+	} while (0)
+#define add_compr_block_stat(inode, blocks)				\
+	do {								\
+		struct f2fs_sb_info *sbi = F2FS_I_SB(inode);		\
+		int diff = F2FS_I(inode)->i_cluster_size - blocks;	\
+		atomic64_add(blocks, &sbi->compr_written_block);	\
+		atomic64_add(diff, &sbi->compr_saved_block);		\
+	} while (0)
 #else
 static inline bool f2fs_is_compressed_page(struct page *page) { return false; }
 static inline bool f2fs_is_compress_backend_ready(struct inode *inode)
@@ -3983,6 +4000,7 @@ static inline int f2fs_init_page_array_cache(struct f2fs_sb_info *sbi) { return
 static inline void f2fs_destroy_page_array_cache(struct f2fs_sb_info *sbi) { }
 static inline int __init f2fs_init_compress_cache(void) { return 0; }
 static inline void f2fs_destroy_compress_cache(void) { }
+#define inc_compr_inode_stat(inode)		do { } while (0)
 #endif
 
 static inline void set_compress_context(struct inode *inode)
@@ -4006,6 +4024,7 @@ static inline void set_compress_context(struct inode *inode)
 	F2FS_I(inode)->i_flags |= F2FS_COMPR_FL;
 	set_inode_flag(inode, FI_COMPRESSED_FILE);
 	stat_inc_compr_inode(inode);
+	inc_compr_inode_stat(inode);
 	f2fs_mark_inode_dirty_sync(inode, true);
 }
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 7069793752f1..88d9ecdee8d3 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3260,6 +3260,13 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 
 	init_rwsem(&sbi->sb_lock);
 	init_rwsem(&sbi->pin_sem);
+
+#ifdef CONFIG_F2FS_FS_COMPRESSION
+	/* For runtime compression statistics */
+	atomic64_set(&sbi->compr_written_block, 0);
+	atomic64_set(&sbi->compr_saved_block, 0);
+	atomic_set(&sbi->compr_new_inode, 0);
+#endif
 }
 
 static int init_percpu_info(struct f2fs_sb_info *sbi)
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index e38a7f6921dd..2b6e5e6e1286 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -282,6 +282,38 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 		return len;
 	}
 
+#ifdef CONFIG_F2FS_FS_COMPRESSION
+	if (!strcmp(a->attr.name, "compr_written_block")) {
+		u64 bcount;
+		int len;
+
+		bcount = atomic64_read(&sbi->compr_written_block);
+
+		len = scnprintf(buf, PAGE_SIZE, "%llu\n", bcount);
+		return len;
+	}
+
+	if (!strcmp(a->attr.name, "compr_saved_block")) {
+		u64 bcount;
+		int len;
+
+		bcount = atomic64_read(&sbi->compr_saved_block);
+
+		len = scnprintf(buf, PAGE_SIZE, "%llu\n", bcount);
+		return len;
+	}
+
+	if (!strcmp(a->attr.name, "compr_new_inode")) {
+		u32 icount;
+		int len;
+
+		icount = atomic_read(&sbi->compr_new_inode);
+
+		len = scnprintf(buf, PAGE_SIZE, "%u\n", icount);
+		return len;
+	}
+#endif
+
 	ui = (unsigned int *)(ptr + a->offset);
 
 	return sprintf(buf, "%u\n", *ui);
@@ -458,6 +490,24 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+#ifdef CONFIG_F2FS_FS_COMPRESSION
+	if (!strcmp(a->attr.name, "compr_written_block") ||
+		!strcmp(a->attr.name, "compr_saved_block")) {
+		if (t != 0)
+			return -EINVAL;
+		atomic64_set(&sbi->compr_written_block, 0);
+		atomic64_set(&sbi->compr_saved_block, 0);
+		return count;
+	}
+
+	if (!strcmp(a->attr.name, "compr_new_inode")) {
+		if (t != 0)
+			return -EINVAL;
+		atomic_set(&sbi->compr_new_inode, 0);
+		return count;
+	}
+#endif
+
 	*ui = (unsigned int)t;
 
 	return count;
@@ -668,6 +718,9 @@ F2FS_FEATURE_RO_ATTR(sb_checksum, FEAT_SB_CHECKSUM);
 F2FS_FEATURE_RO_ATTR(casefold, FEAT_CASEFOLD);
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 F2FS_FEATURE_RO_ATTR(compression, FEAT_COMPRESSION);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compr_written_block, compr_written_block);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compr_saved_block, compr_saved_block);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compr_new_inode, compr_new_inode);
 #endif
 
 #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
@@ -730,6 +783,11 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(moved_blocks_foreground),
 	ATTR_LIST(moved_blocks_background),
 	ATTR_LIST(avg_vblocks),
+#endif
+#ifdef CONFIG_F2FS_FS_COMPRESSION
+	ATTR_LIST(compr_written_block),
+	ATTR_LIST(compr_saved_block),
+	ATTR_LIST(compr_new_inode),
 #endif
 	NULL,
 };
-- 
2.31.0.rc2.261.g7f71774620-goog

