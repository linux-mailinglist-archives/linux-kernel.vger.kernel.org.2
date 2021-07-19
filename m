Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A343CD1AC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 12:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236057AbhGSJdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 05:33:44 -0400
Received: from mail-m121143.qiye.163.com ([115.236.121.143]:40752 "EHLO
        mail-m121143.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235416AbhGSJdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 05:33:43 -0400
DKIM-Signature: a=rsa-sha256;
        b=oaHQUK6kNbE9Lu73QmIOI1IL1WejBaZ3qQso0fkH/qz69u4m5c2P2zlqEQOXMz48SH7wR7fjnnpcyr5ukPDo4/+mnHdHNWR+G+wUNjvHlPtKK6M7Lvp29QaI16jKXVtdJ28OPOkNxApipCbaC5GczLMxAyX0Q40EIkbE1o5WwiQ=;
        s=default; c=relaxed/relaxed; d=vivo.com; v=1;
        bh=mXAwOxXrM5xJtuAwJfU7nrm1oj5yDK1drmbP0af1lMo=;
        h=date:mime-version:subject:message-id:from;
Received: from comdg01144022.vivo.xyz (unknown [218.104.188.165])
        by mail-m121143.qiye.163.com (Hmail) with ESMTPA id 95F75540478;
        Mon, 19 Jul 2021 18:14:20 +0800 (CST)
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v2] f2fs: Reduce the scope of setting fsck tag when de->name_len is zero
Date:   Mon, 19 Jul 2021 18:14:19 +0800
Message-Id: <20210719101419.370520-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUJLGRpWGEhLTU9OTE5JGU
        1CVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PQw6LBw4Ez9OEANKLwkZUTZN
        MRUwCS5VSlVKTUlNTUNCTU1KSklOVTMWGhIXVR0JGhUQVRcSOw0SDRRVGBQWRVlXWRILWUFZSUpD
        VUpLT1VKQ0NVSk1OWVdZCAFZQUhNS0g3Bg++
X-HM-Tid: 0a7abe426773b038kuuu95f75540478
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I recently found a case where de->name_len is 0 in f2fs_fill_dentries() easily reproduced,
and finally set the fsck flag.

Thread A					Thread B

f2fs_readdir
	f2fs_read_inline_dir
		ctx->pos = d.max
						f2fs_add_dentry
							f2fs_add_inline_entry
								do_convert_inline_dir
							f2fs_add_regular_entry
f2fs_readdir
	f2fs_fill_dentries
		set_sbi_flag(sbi, SBI_NEED_FSCK)

Process A opens the folder, and has been reading without closing it. During this period,
Process B created a file under the folder (occupying multiple f2fs_dir_entry, exceeding
the d.max of the inline dir). After creation, process A uses the d.max of inline dir to
read it again, and it will read that de->name_len is 0.

And Chao pointed out that w/o inline conversion, the race condition still can happen as below

dir_entry1: A
dir_entry2: B
dir_entry3: C
free slot: _

Before:
AAAABBBB___
         ^
Thread B delete dir_entry2, and create dir_entry3.

After:
AAAACCCCC__
         ^

In these scenarios, the file system is not damaged, and it's hard to avoid it. But we can bypass
tagging FSCK flag if:
a) bit_pos (:= ctx->pos % d->max) is non-zero & b) before bit_pos moves to first
valid dir_entry.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/dir.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 456651682daf..3e2a61a3600c 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -1000,6 +1000,7 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(d->inode);
 	struct blk_plug plug;
 	bool readdir_ra = sbi->readdir_ra == 1;
+	bool find_valid_dentry = false;
 	int err = 0;
 
 	bit_pos = ((unsigned long)ctx->pos % d->max);
@@ -1014,13 +1015,15 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 
 		de = &d->dentry[bit_pos];
 		if (de->name_len == 0) {
+			if (!(ctx->pos % d->max != 0 && find_valid_dentry == false)) {
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
+		find_valid_dentry = true;
 	}
 out:
 	if (readdir_ra)
-- 
2.32.0

