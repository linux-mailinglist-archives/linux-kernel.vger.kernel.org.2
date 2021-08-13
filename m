Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE243EB595
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 14:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240328AbhHMMdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 08:33:04 -0400
Received: from mail-m17636.qiye.163.com ([59.111.176.36]:51650 "EHLO
        mail-m17636.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240145AbhHMMdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 08:33:01 -0400
Received: from comdg01144022.vivo.xyz (unknown [218.104.188.165])
        by mail-m17636.qiye.163.com (Hmail) with ESMTPA id D9F70C4020F;
        Fri, 13 Aug 2021 20:32:28 +0800 (CST)
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v5 2/2] f2fs: convert S_IRUGO to 0444
Date:   Fri, 13 Aug 2021 20:32:21 +0800
Message-Id: <20210813123221.185591-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210813123221.185591-1-frank.li@vivo.com>
References: <20210813123221.185591-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRoaSUhWSx9JH0xIQkIYQk
        oeVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NxQ6IRw*PD9IFxgfCxYXMSEY
        DRUaChNVSlVKTUlDQ05MQk9CT0xNVTMWGhIXVR0JGhUQVRcSOw0SDRRVGBQWRVlXWRILWUFZSUpD
        VUpLT1VKQ0NVSk1OWVdZCAFZQUlDTUo3Bg++
X-HM-Tid: 0a7b3f7fdb7ad996kuwsd9f70c4020f
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+               proc_create_single_data("fsck_stack", S_IRUGO, sbi->s_proc,

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/debug.c |  2 +-
 fs/f2fs/sysfs.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 473ad04d1891..401e5e34edd6 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -621,7 +621,7 @@ void __init f2fs_create_root_stats(void)
 #ifdef CONFIG_DEBUG_FS
 	f2fs_debugfs_root = debugfs_create_dir("f2fs", NULL);
 
-	debugfs_create_file("status", S_IRUGO, f2fs_debugfs_root, NULL,
+	debugfs_create_file("status", 0444, f2fs_debugfs_root, NULL,
 			    &stat_fops);
 #endif
 }
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index c134bbb99c7b..09bf8c4be2b1 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1276,15 +1276,15 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
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
-		proc_create_single_data("fsck_stack", S_IRUGO, sbi->s_proc,
+		proc_create_single_data("fsck_stack", 0444, sbi->s_proc,
 				fsck_stack_seq_show, sb);
 	}
 	return 0;
-- 
2.32.0

