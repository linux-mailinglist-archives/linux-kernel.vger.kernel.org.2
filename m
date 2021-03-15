Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEEE33AD1F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 09:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhCOIMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 04:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbhCOIMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 04:12:41 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4DBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 01:12:41 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id o10so20006501pgg.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 01:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R2DgrG9cCQ/VyW56awRmKaR+vSbaA2HjfGG10SFlQJ8=;
        b=f1AUZBH2EO04x7ODrbKy01jzjCPMEXgrzXxsAEAvbc1X/cXuNUjqPcf/5duQGB5//g
         HI+LT8TD1ggVT3lXRu2NIkKNPyYB+8gZz921R3BviON/WFxCxdBHsb/STb8Pxkum9QRM
         fLdpvu3Ad9y48G32l5DvK80z4UcS4rt+Sgmetx2Hh4+pHIkg5NsV9uxZtapFQNU7rQQ4
         5f1IRJD1bFCZ1NEgqZIAEcVCdTJz+X4r1cCT9vpKYXG8rZ3G0SkeRti9tgNgmlmi0PEj
         jfm/Wu2l+Am9DY59eqg8Q8cZ6jRlCeSty+tT+xvaGKg4zLO7dGXmJQigrC7CEZbBd7we
         Z2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R2DgrG9cCQ/VyW56awRmKaR+vSbaA2HjfGG10SFlQJ8=;
        b=htUEo+BfkytqIRuP6epDlYY/PIZQryuQM3MW8l4/jEFK8XjGpmLjY+mhEK28QhUX+e
         FAmxK0V5VhtWIZ9zJLy6gCvPjzsyZks/1PQ97GSnSejPLxBy0mP1Ds8MOUg0u0f2WJ6P
         goXhuAZJkPO0G48PFR87LAL71BNcDzmYr8YGQz9wfKaoKnHDbmfkbdQfbJGiWX4+GnY3
         7AK4SDJ4nsWZFJH3vp9TqW9UTXiyHGvrRblo0FWRGh++d1O7l7xaC3MhIZLTFWFiYNTq
         EZL4dHR2fLSg55OsruHbGQT4vAJcMcb0P0W9Cjlcy6nQCDqbcKFFY9wHQCjv7Qf3Y+P9
         +e9w==
X-Gm-Message-State: AOAM532tmzEk4Ms+CJXpstdBWx+FsrRFR02ITDKmKRoWfTsp3gQYWtKl
        VTF6mRa9eKaq49xdSNBGafkeZ2mm688=
X-Google-Smtp-Source: ABdhPJxm2AMkqacPwylIlil+tnlWhN57D/cpL5ino0UMZKCtSf2vHXEd0WVc/kTeOrHVw+Hs9LRaDA==
X-Received: by 2002:a62:17c4:0:b029:1f5:7cfe:ebc4 with SMTP id 187-20020a6217c40000b02901f57cfeebc4mr23243360pfx.5.1615795960209;
        Mon, 15 Mar 2021 01:12:40 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:11:546:2cb6:224c:a739])
        by smtp.gmail.com with ESMTPSA id d2sm9909424pjx.42.2021.03.15.01.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 01:12:39 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v5] f2fs: add sysfs nodes to get runtime compression stat
Date:   Mon, 15 Mar 2021 17:12:33 +0900
Message-Id: <20210315081233.3603648-1-daeho43@gmail.com>
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
    related to kernel config
v3: changed sysfs nodes' names and made them runtime stat, not
    persistent on disk
v4: changed sysfs nodes' desctiption
v5: changed not to use atomic values
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 24 ++++++++++++++++
 fs/f2fs/compress.c                      |  1 +
 fs/f2fs/f2fs.h                          | 19 +++++++++++++
 fs/f2fs/sysfs.c                         | 38 +++++++++++++++++++++++++
 4 files changed, 82 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index cbeac1bebe2f..ddd4bd6116fc 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -409,3 +409,27 @@ Description:	Give a way to change checkpoint merge daemon's io priority.
 		I/O priority "3". We can select the class between "rt" and "be",
 		and set the I/O priority within valid range of it. "," delimiter
 		is necessary in between I/O class and priority number.
+
+What:		/sys/fs/f2fs/<disk>/compr_written_block
+Date:		March 2021
+Contact:	"Daeho Jeong" <daehojeong@google.com>
+Description:	Show the block count written after compression since mount. Note
+		that when the compressed blocks are deleted, this count doesn't
+		decrease. If you write "0" here, you can initialize
+		compr_written_block and compr_saved_block to "0".
+
+What:		/sys/fs/f2fs/<disk>/compr_saved_block
+Date:		March 2021
+Contact:	"Daeho Jeong" <daehojeong@google.com>
+Description:	Show the saved block count with compression since mount. Note
+		that when the compressed blocks are deleted, this count doesn't
+		decrease. If you write "0" here, you can initialize
+		compr_written_block and compr_saved_block to "0".
+
+What:		/sys/fs/f2fs/<disk>/compr_new_inode
+Date:		March 2021
+Contact:	"Daeho Jeong" <daehojeong@google.com>
+Description:	Show the count of inode newly enabled for compression since mount.
+		Note that when the compression is disabled for the files, this count
+		doesn't decrease. If you write "0" here, you can initialize
+		compr_new_inode to "0".
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
index e2d302ae3a46..ae7e08aa7d87 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1623,6 +1623,11 @@ struct f2fs_sb_info {
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	struct kmem_cache *page_array_slab;	/* page array entry */
 	unsigned int page_array_slab_size;	/* default page array slab size */
+
+	/* For runtime compression statistics */
+	u64 compr_written_block;
+	u64 compr_saved_block;
+	u32 compr_new_inode;
 #endif
 };
 
@@ -3955,6 +3960,18 @@ int f2fs_init_page_array_cache(struct f2fs_sb_info *sbi);
 void f2fs_destroy_page_array_cache(struct f2fs_sb_info *sbi);
 int __init f2fs_init_compress_cache(void);
 void f2fs_destroy_compress_cache(void);
+#define inc_compr_inode_stat(inode)					\
+	do {								\
+		struct f2fs_sb_info *sbi = F2FS_I_SB(inode);		\
+		sbi->compr_new_inode++;					\
+	} while (0)
+#define add_compr_block_stat(inode, blocks)				\
+	do {								\
+		struct f2fs_sb_info *sbi = F2FS_I_SB(inode);		\
+		int diff = F2FS_I(inode)->i_cluster_size - blocks;	\
+		sbi->compr_written_block += blocks;			\
+		sbi->compr_saved_block += diff;				\
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
 
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index e38a7f6921dd..a166eebbe019 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -12,6 +12,7 @@
 #include <linux/seq_file.h>
 #include <linux/unicode.h>
 #include <linux/ioprio.h>
+#include <linux/sysfs.h>
 
 #include "f2fs.h"
 #include "segment.h"
@@ -282,6 +283,17 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 		return len;
 	}
 
+#ifdef CONFIG_F2FS_FS_COMPRESSION
+	if (!strcmp(a->attr.name, "compr_written_block"))
+		return sysfs_emit(buf, "%llu\n", sbi->compr_written_block);
+
+	if (!strcmp(a->attr.name, "compr_saved_block"))
+		return sysfs_emit(buf, "%llu\n", sbi->compr_saved_block);
+
+	if (!strcmp(a->attr.name, "compr_new_inode"))
+		return sysfs_emit(buf, "%u\n", sbi->compr_new_inode);
+#endif
+
 	ui = (unsigned int *)(ptr + a->offset);
 
 	return sprintf(buf, "%u\n", *ui);
@@ -458,6 +470,24 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+#ifdef CONFIG_F2FS_FS_COMPRESSION
+	if (!strcmp(a->attr.name, "compr_written_block") ||
+		!strcmp(a->attr.name, "compr_saved_block")) {
+		if (t != 0)
+			return -EINVAL;
+		sbi->compr_written_block = 0;
+		sbi->compr_saved_block = 0;
+		return count;
+	}
+
+	if (!strcmp(a->attr.name, "compr_new_inode")) {
+		if (t != 0)
+			return -EINVAL;
+		sbi->compr_new_inode = 0;
+		return count;
+	}
+#endif
+
 	*ui = (unsigned int)t;
 
 	return count;
@@ -668,6 +698,9 @@ F2FS_FEATURE_RO_ATTR(sb_checksum, FEAT_SB_CHECKSUM);
 F2FS_FEATURE_RO_ATTR(casefold, FEAT_CASEFOLD);
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 F2FS_FEATURE_RO_ATTR(compression, FEAT_COMPRESSION);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compr_written_block, compr_written_block);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compr_saved_block, compr_saved_block);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compr_new_inode, compr_new_inode);
 #endif
 
 #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
@@ -730,6 +763,11 @@ static struct attribute *f2fs_attrs[] = {
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

