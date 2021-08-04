Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1802B3DFA03
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 05:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbhHDDaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 23:30:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:59022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229571AbhHDDaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 23:30:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 01ACA61037;
        Wed,  4 Aug 2021 03:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628047791;
        bh=1iL1o2YZoGnWri3qeq+tQMAVLFgEuBeM6zTEgcD8x/0=;
        h=From:To:Cc:Subject:Date:From;
        b=BD4cCTnKHQ733Bo8SGheKl2MDcYfKXSpnoyI0seWn8Alagwcn3g+96Iz2Y28enleF
         NLlbvBJuabETpj8/cc2wf0aCJsYpE9g9UcUQX1ZrGcnSZXoLsRp31qcG7AaAQeNks+
         p1s4Gr4xqJnXWVb83WiAh4TDmGPjG+zkNL1JsNRXl1wQ402czpwtQKo/cjb2egTikC
         7hZsylN0GyKHbhLMeA67WL/GoO53ZUdpIK9nIcXx1UfbAsCPJUzXvNBdG/hgvsRZOp
         5AUAq0VjIzypOyD5oR0Zrl7yQMGXHB2ceZ94TH+FVRNw64pPM3w79PAfJInFf7p313
         Lkobbreq8o45g==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@linux.dev>,
        Yangtao Li <frank.li@vivo.com>, Chao Yu <chao@kernel.org>
Subject: [PATCH v4] f2fs: reduce the scope of setting fsck tag when de->name_len is zero
Date:   Wed,  4 Aug 2021 11:29:46 +0800
Message-Id: <20210804032946.1416807-1-chao@kernel.org>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <frank.li@vivo.com>

I recently found a case where de->name_len is 0 in f2fs_fill_dentries()
easily reproduced, and finally set the fsck flag.

Thread A			Thread B
- f2fs_readdir
 - f2fs_read_inline_dir
  - ctx->pos = d.max
				- f2fs_add_dentry
				 - f2fs_add_inline_entry
				  - do_convert_inline_dir
				 - f2fs_add_regular_entry
- f2fs_readdir
 - f2fs_fill_dentries
  - set_sbi_flag(sbi, SBI_NEED_FSCK)

Process A opens the folder, and has been reading without closing it.
During this period, Process B created a file under the folder (occupying
multiple f2fs_dir_entry, exceeding the d.max of the inline dir). After
creation, process A uses the d.max of inline dir to read it again, and
it will read that de->name_len is 0.

And Chao pointed out that w/o inline conversion, the race condition still
can happen as below:

dir_entry1: A
dir_entry2: B
dir_entry3: C
free slot: _
ctx->pos: ^

Thread A is traversing directory,
ctx-pos moves to below position after readdir() by thread A:
AAAABBBB___
        ^

Then thread B delete dir_entry2, and create dir_entry3.

Thread A calls readdir() to lookup dirents starting from middle
of new dirent slots as below:
AAAACCCCCC_
        ^
In these scenarios, the file system is not damaged, and it's hard to
avoid it. But we can bypass tagging FSCK flag if:
a) bit_pos (:= ctx->pos % d->max) is non-zero and
b) before bit_pos moves to first valid dir_entry.

Fixes: ddf06b753a85 ("f2fs: fix to trigger fsck if dirent.name_len is zero")
Signed-off-by: Yangtao Li <frank.li@vivo.com>
[Chao: clean up description]
Reviewed-by: Chao Yu <chao@kernel.org>
---
v4:
- clean up description a bit
- fix code style issue
 fs/f2fs/dir.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-) 
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 456651682daf..c250bf46ef5e 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -1000,6 +1000,7 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(d->inode);
 	struct blk_plug plug;
 	bool readdir_ra = sbi->readdir_ra == 1;
+	bool found_valid_dirent = false;
 	int err = 0;
 
 	bit_pos = ((unsigned long)ctx->pos % d->max);
@@ -1014,13 +1015,15 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 
 		de = &d->dentry[bit_pos];
 		if (de->name_len == 0) {
+			if (found_valid_dirent || !bit_pos) {
+				printk_ratelimited(
+					"%sF2FS-fs (%s): invalid namelen(0), ino:%u, run fsck to fix.",
+					KERN_WARNING, sbi->sb->s_id,
+					le32_to_cpu(de->ino));
+				set_sbi_flag(sbi, SBI_NEED_FSCK);
+			}
 			bit_pos++;
 			ctx->pos = start_pos + bit_pos;
-			printk_ratelimited(
-				"%sF2FS-fs (%s): invalid namelen(0), ino:%u, run fsck to fix.",
-				KERN_WARNING, sbi->sb->s_id,
-				le32_to_cpu(de->ino));
-			set_sbi_flag(sbi, SBI_NEED_FSCK);
 			continue;
 		}
 
@@ -1063,6 +1066,7 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 			f2fs_ra_node_page(sbi, le32_to_cpu(de->ino));
 
 		ctx->pos = start_pos + bit_pos;
+		found_valid_dirent = true;
 	}
 out:
 	if (readdir_ra)
-- 
2.22.1

