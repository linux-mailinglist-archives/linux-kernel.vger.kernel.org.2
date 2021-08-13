Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52293EB3DE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 12:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240126AbhHMKOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 06:14:21 -0400
Received: from mail-m17636.qiye.163.com ([59.111.176.36]:43282 "EHLO
        mail-m17636.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239993AbhHMKOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 06:14:14 -0400
Received: from comdg01144022.vivo.xyz (unknown [218.104.188.165])
        by mail-m17636.qiye.163.com (Hmail) with ESMTPA id 37AC1C40221;
        Fri, 13 Aug 2021 18:13:46 +0800 (CST)
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v4 1/2] f2fs: introduce proc/fs/f2fs/<dev>/fsck_stack node
Date:   Fri, 13 Aug 2021 18:13:41 +0800
Message-Id: <20210813101342.442438-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRlJT09WH0tCGEtOTB5DTE
        xIVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OE06FDo6Vj9JNRgQVkI6GjcU
        DjwaCkNVSlVKTUlDQ09CTUlNTENDVTMWGhIXVR0JGhUQVRcSOw0SDRRVGBQWRVlXWRILWUFZSUpD
        VUpLT1VKQ0NVSk1OWVdZCAFZQU9DTUg3Bg++
X-HM-Tid: 0a7b3f00dd04d996kuws37ac1c40221
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SBI_NEED_FSCK is an indicator that fsck.f2fs needs to be triggered,
this flag is set in too many places. For some scenes that are not very
reproducible, adding stack information will help locate the problem.

Let's expose all fsck stack history in procfs.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/f2fs.h  | 33 ++++++++++++++++++++++++++++++++-
 fs/f2fs/sysfs.c | 26 ++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 67faa43cc141..b2662fc56217 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -24,6 +24,7 @@
 #include <linux/quotaops.h>
 #include <linux/part_stat.h>
 #include <crypto/hash.h>
+#include <linux/stackdepot.h>
 
 #include <linux/fscrypt.h>
 #include <linux/fsverity.h>
@@ -119,6 +120,8 @@ typedef u32 nid_t;
 
 #define COMPRESS_EXT_NUM		16
 
+#define FSCK_STACK_DEPTH 64
+
 struct f2fs_mount_info {
 	unsigned int opt;
 	int write_io_size_bits;		/* Write IO size bits */
@@ -1786,6 +1789,8 @@ struct f2fs_sb_info {
 	unsigned int compress_watermark;	/* cache page watermark */
 	atomic_t compress_page_hit;		/* cache hit count */
 #endif
+	depot_stack_handle_t *fsck_stack;
+	unsigned int fsck_count;
 };
 
 struct f2fs_private_dio {
@@ -1997,9 +2002,35 @@ static inline bool is_sbi_flag_set(struct f2fs_sb_info *sbi, unsigned int type)
 	return test_bit(type, &sbi->s_flag);
 }
 
-static inline void set_sbi_flag(struct f2fs_sb_info *sbi, unsigned int type)
+static void set_sbi_flag(struct f2fs_sb_info *sbi, unsigned int type)
 {
 	set_bit(type, &sbi->s_flag);
+
+	if (unlikely(type ==  SBI_NEED_FSCK)) {
+		unsigned long entries[FSCK_STACK_DEPTH];
+		depot_stack_handle_t stack, *new;
+		unsigned int nr_entries;
+		int i;
+
+		nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
+		nr_entries = filter_irq_stacks(entries, nr_entries);
+		stack = stack_depot_save(entries, nr_entries, GFP_KERNEL);
+		if (!stack)
+			return;
+
+		/* Try to find an existing entry for this backtrace */
+		for (i = 0; i < sbi->fsck_count; i++)
+			if (sbi->fsck_stack[i] == stack)
+				return;
+
+		new = krealloc(sbi->fsck_stack, (sbi->fsck_count + 1) *
+			       sizeof(*sbi->fsck_stack), GFP_KERNEL);
+		if (!new)
+			return;
+
+		sbi->fsck_stack = new;
+		sbi->fsck_stack[sbi->fsck_count++] = stack;
+	}
 }
 
 static inline void clear_sbi_flag(struct f2fs_sb_info *sbi, unsigned int type)
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 0954761341d7..c134bbb99c7b 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1171,6 +1171,29 @@ static int __maybe_unused iostat_info_seq_show(struct seq_file *seq,
 	return 0;
 }
 
+static int __maybe_unused fsck_stack_seq_show(struct seq_file *seq,
+						void *offset)
+{
+	struct super_block *sb = seq->private;
+	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	unsigned long *entries;
+	unsigned int nr_entries;
+	unsigned int i, j;
+
+	for (i = 0; i < sbi->fsck_count; i++) {
+		nr_entries = stack_depot_fetch(sbi->fsck_stack[i], &entries);
+		if (!entries)
+			return 0;
+
+		for (j = 0; j < nr_entries; j++)
+			seq_printf(seq, "%pS\n", (void *)entries[j]);
+
+		seq_putc(seq, '\n');
+	}
+
+	return 0;
+}
+
 static int __maybe_unused victim_bits_seq_show(struct seq_file *seq,
 						void *offset)
 {
@@ -1261,6 +1284,8 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
 				iostat_info_seq_show, sb);
 		proc_create_single_data("victim_bits", S_IRUGO, sbi->s_proc,
 				victim_bits_seq_show, sb);
+		proc_create_single_data("fsck_stack", S_IRUGO, sbi->s_proc,
+				fsck_stack_seq_show, sb);
 	}
 	return 0;
 put_feature_list_kobj:
@@ -1282,6 +1307,7 @@ void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi)
 		remove_proc_entry("segment_info", sbi->s_proc);
 		remove_proc_entry("segment_bits", sbi->s_proc);
 		remove_proc_entry("victim_bits", sbi->s_proc);
+		remove_proc_entry("fsck_stack", sbi->s_proc);
 		remove_proc_entry(sbi->sb->s_id, f2fs_proc_root);
 	}
 
-- 
2.32.0

