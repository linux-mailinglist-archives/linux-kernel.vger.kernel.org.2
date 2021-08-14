Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7CB83EC207
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 12:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237861AbhHNKhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 06:37:37 -0400
Received: from mail-m17636.qiye.163.com ([59.111.176.36]:36744 "EHLO
        mail-m17636.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237637AbhHNKhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 06:37:34 -0400
Received: from comdg01144022.vivo.xyz (unknown [218.104.188.165])
        by mail-m17636.qiye.163.com (Hmail) with ESMTPA id F1812C400E5;
        Sat, 14 Aug 2021 18:37:04 +0800 (CST)
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] f2fs: convert S_IRUGO to 0444
Date:   Sat, 14 Aug 2021 18:37:01 +0800
Message-Id: <20210814103702.52405-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUIaHk1WTU0fThkaQh0eSE
        4YVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkxVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mgw6KSo4Ij9OFx84GTQ#Vi4y
        DU5PFE5VSlVKTUlDQkhMT0lOTkhNVTMWGhIXVR0JGhUQVRcSOw0SDRRVGBQWRVlXWRILWUFZSUpD
        VUpLT1VKQ0NVSk1OWVdZCAFZQUlPSk43Bg++
X-HM-Tid: 0a7b443c90efd996kuwsf1812c400e5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To fix:
WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/debug.c | 2 +-
 fs/f2fs/sysfs.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 833325038ef3..542c20e9ea0c 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -611,7 +611,7 @@ void __init f2fs_create_root_stats(void)
 #ifdef CONFIG_DEBUG_FS
 	f2fs_debugfs_root = debugfs_create_dir("f2fs", NULL);
 
-	debugfs_create_file("status", S_IRUGO, f2fs_debugfs_root, NULL,
+	debugfs_create_file("status", 0444, f2fs_debugfs_root, NULL,
 			    &stat_fops);
 #endif
 }
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 6642246206bd..204de4c2c818 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1213,13 +1213,13 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
 		sbi->s_proc = proc_mkdir(sb->s_id, f2fs_proc_root);
 
 	if (sbi->s_proc) {
-		proc_create_single_data("segment_info", S_IRUGO, sbi->s_proc,
+		proc_create_single_data("segment_info", 0444, sbi->s_proc,
 				segment_info_seq_show, sb);
-		proc_create_single_data("segment_bits", S_IRUGO, sbi->s_proc,
+		proc_create_single_data("segment_bits", 0444, sbi->s_proc,
 				segment_bits_seq_show, sb);
-		proc_create_single_data("iostat_info", S_IRUGO, sbi->s_proc,
+		proc_create_single_data("iostat_info", 0444, sbi->s_proc,
 				iostat_info_seq_show, sb);
-		proc_create_single_data("victim_bits", S_IRUGO, sbi->s_proc,
+		proc_create_single_data("victim_bits", 0444, sbi->s_proc,
 				victim_bits_seq_show, sb);
 	}
 	return 0;
-- 
2.32.0

