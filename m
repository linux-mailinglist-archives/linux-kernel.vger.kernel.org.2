Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2460A3EC20A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 12:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237924AbhHNKhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 06:37:53 -0400
Received: from mail-m17636.qiye.163.com ([59.111.176.36]:36762 "EHLO
        mail-m17636.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237773AbhHNKhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 06:37:35 -0400
Received: from comdg01144022.vivo.xyz (unknown [218.104.188.165])
        by mail-m17636.qiye.163.com (Hmail) with ESMTPA id 394F3C4010B;
        Sat, 14 Aug 2021 18:37:06 +0800 (CST)
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v6] f2fs: introduce /sys/fs/f2fs/<disk>/fsck_stack node
Date:   Sat, 14 Aug 2021 18:37:02 +0800
Message-Id: <20210814103702.52405-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210814103702.52405-1-frank.li@vivo.com>
References: <20210814103702.52405-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUJIGEJWSE9IHUkfGU4YQ0
        tIVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkxVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PAw6Cio6Cz9JSB8#GTQBViM2
        AjYwCQ5VSlVKTUlDQkhMT0lNQ0tNVTMWGhIXVR0JGhUQVRcSOw0SDRRVGBQWRVlXWRILWUFZSUpD
        VUpLT1VKQ0NVSk1OWVdZCAFZQUxITkw3Bg++
X-HM-Tid: 0a7b443c95ccd996kuws394f3c4010b
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SBI_NEED_FSCK is an indicator that fsck.f2fs needs to be triggered,
this flag is set in too many places. For some scenes that are not very
reproducible, adding stack information will help locate the problem.

Let's record all fsck stack history, I added F2FS_FSCK_STACK_TRACE
configuration options and sysfs nodes. After opening the configuration
options and enabling the node, it will start recording. The recorded
stack information will not be clear, and we can get information form
kernel log.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs |  7 ++++
 fs/f2fs/Kconfig                         | 10 ++++++
 fs/f2fs/f2fs.h                          | 45 +++++++++++++++++++++++++
 fs/f2fs/sysfs.c                         | 27 +++++++++++++++
 4 files changed, 89 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index ef4b9218ae1e..047c398093cf 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -493,3 +493,10 @@ Contact:	"Chao Yu" <yuchao0@huawei.com>
 Description:	When ATGC is on, it controls age threshold to bypass GCing young
 		candidates whose age is not beyond the threshold, by default it was
 		initialized as 604800 seconds (equals to 7 days).
+
+What:		/sys/fs/f2fs/<disk>/fsck_stack
+Date:		August 2021
+Contact:	"Yangtao Li" <frank.li@vivo.com>
+Description:	Controls to enable/disable fsck stack trace, you can get stack
+		information from kernel log. Note that the recorded stack information
+		will not be cleared.
diff --git a/fs/f2fs/Kconfig b/fs/f2fs/Kconfig
index 7669de7b49ce..f451e567e4a8 100644
--- a/fs/f2fs/Kconfig
+++ b/fs/f2fs/Kconfig
@@ -135,3 +135,13 @@ config F2FS_FS_LZORLE
 	default y
 	help
 	  Support LZO-RLE compress algorithm, if unsure, say Y.
+
+config F2FS_FSCK_STACK_TRACE
+	bool "F2FS fsck stack information record"
+	depends on F2FS_FS
+	depends on STACKDEPOT
+	default y
+	help
+	 Support printing out fsck stack history. With this, you have to
+	 turn on "fsck_stack" sysfs node. Then you can get information
+	 from kernel log.
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ee8eb33e2c25..b2d1d1a5a3fc 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -24,6 +24,8 @@
 #include <linux/quotaops.h>
 #include <linux/part_stat.h>
 #include <crypto/hash.h>
+#include <linux/stackdepot.h>
+#include <linux/stacktrace.h>
 
 #include <linux/fscrypt.h>
 #include <linux/fsverity.h>
@@ -117,6 +119,8 @@ typedef u32 nid_t;
 
 #define COMPRESS_EXT_NUM		16
 
+#define FSCK_STACK_DEPTH		64
+
 struct f2fs_mount_info {
 	unsigned int opt;
 	int write_io_size_bits;		/* Write IO size bits */
@@ -1748,6 +1752,11 @@ struct f2fs_sb_info {
 	unsigned int compress_watermark;	/* cache page watermark */
 	atomic_t compress_page_hit;		/* cache hit count */
 #endif
+#ifdef CONFIG_F2FS_FSCK_STACK_TRACE
+	depot_stack_handle_t *fsck_stack_history;
+	unsigned int fsck_count;
+	bool fsck_stack;
+#endif
 };
 
 struct f2fs_private_dio {
@@ -1954,6 +1963,38 @@ static inline struct address_space *NODE_MAPPING(struct f2fs_sb_info *sbi)
 	return sbi->node_inode->i_mapping;
 }
 
+#ifdef CONFIG_F2FS_FSCK_STACK_TRACE
+static void fsck_stack_trace(struct f2fs_sb_info *sbi)
+{
+	unsigned long entries[FSCK_STACK_DEPTH];
+	depot_stack_handle_t stack, *new;
+	unsigned int nr_entries;
+	int i;
+
+	if (!sbi->fsck_stack)
+		return;
+
+	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
+	nr_entries = filter_irq_stacks(entries, nr_entries);
+	stack = stack_depot_save(entries, nr_entries, GFP_KERNEL);
+	if (!stack)
+		return;
+
+	/* Try to find an existing entry for this backtrace */
+	for (i = 0; i < sbi->fsck_count; i++)
+		if (sbi->fsck_stack_history[i] == stack)
+			return;
+
+	new = krealloc(sbi->fsck_stack_history, (sbi->fsck_count + 1) *
+		       sizeof(*sbi->fsck_stack_history), GFP_KERNEL);
+	if (!new)
+		return;
+
+	sbi->fsck_stack_history = new;
+	sbi->fsck_stack_history[sbi->fsck_count++] = stack;
+}
+#endif
+
 static inline bool is_sbi_flag_set(struct f2fs_sb_info *sbi, unsigned int type)
 {
 	return test_bit(type, &sbi->s_flag);
@@ -1962,6 +2003,10 @@ static inline bool is_sbi_flag_set(struct f2fs_sb_info *sbi, unsigned int type)
 static inline void set_sbi_flag(struct f2fs_sb_info *sbi, unsigned int type)
 {
 	set_bit(type, &sbi->s_flag);
+#ifdef CONFIG_F2FS_FSCK_STACK_TRACE
+	if (unlikely(type == SBI_NEED_FSCK))
+		fsck_stack_trace(sbi);
+#endif
 }
 
 static inline void clear_sbi_flag(struct f2fs_sb_info *sbi, unsigned int type)
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 204de4c2c818..4e786bb797e7 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -306,6 +306,26 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 	if (!strcmp(a->attr.name, "compr_new_inode"))
 		return sysfs_emit(buf, "%u\n", sbi->compr_new_inode);
 #endif
+#ifdef CONFIG_F2FS_FSCK_STACK_TRACE
+	if (!strcmp(a->attr.name, "fsck_stack")) {
+		unsigned long *entries;
+		unsigned int nr_entries;
+		unsigned int i;
+		int count;
+
+		count = sysfs_emit(buf, "%u\n", sbi->fsck_stack);
+		if (!sbi->fsck_stack)
+			return count;
+
+		for (i = 0; i < sbi->fsck_count; i++) {
+			nr_entries = stack_depot_fetch(sbi->fsck_stack_history[i], &entries);
+			if (!entries)
+				return count;
+			stack_trace_print(entries, nr_entries, 0);
+		}
+		return count;
+	}
+#endif
 
 	ui = (unsigned int *)(ptr + a->offset);
 
@@ -740,6 +760,10 @@ F2FS_RW_ATTR(ATGC_INFO, atgc_management, atgc_candidate_count, max_candidate_cou
 F2FS_RW_ATTR(ATGC_INFO, atgc_management, atgc_age_weight, age_weight);
 F2FS_RW_ATTR(ATGC_INFO, atgc_management, atgc_age_threshold, age_threshold);
 
+#ifdef CONFIG_F2FS_FSCK_STACK_TRACE
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, fsck_stack, fsck_stack);
+#endif
+
 #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
 static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(gc_urgent_sleep_time),
@@ -812,6 +836,9 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(atgc_candidate_count),
 	ATTR_LIST(atgc_age_weight),
 	ATTR_LIST(atgc_age_threshold),
+#ifdef CONFIG_F2FS_FSCK_STACK_TRACE
+	ATTR_LIST(fsck_stack),
+#endif
 	NULL,
 };
 ATTRIBUTE_GROUPS(f2fs);
-- 
2.32.0

