Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666973CC0E5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 05:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhGQEAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 00:00:40 -0400
Received: from mail-m121143.qiye.163.com ([115.236.121.143]:50014 "EHLO
        mail-m121143.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhGQEAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 00:00:39 -0400
X-Greylist: delayed 466 seconds by postgrey-1.27 at vger.kernel.org; Sat, 17 Jul 2021 00:00:39 EDT
DKIM-Signature: a=rsa-sha256;
        b=iH/OZ3HHXC/mBIn+vvby/MRMx0JtGS6/KxC+ikd63TTmeMUlCAoufXG7cuFZSrhFlQg7dHrWEzXYkBm/2FHl7smn7PvBC1vOgTrKhIrhpGZYp2ZD3m14U4wHj8JYe5PuO2x4fScHnrN+7ZOr8b0nJAWws74qTM8+qsL4kr6zZmE=;
        s=default; c=relaxed/relaxed; d=vivo.com; v=1;
        bh=upSSh/KOwILS29K5sdGT0T+g8OnbUotq6IY7mSmY6H4=;
        h=date:mime-version:subject:message-id:from;
Received: from comdg01144022.vivo.xyz (unknown [218.104.188.165])
        by mail-m121143.qiye.163.com (Hmail) with ESMTPA id 7B1F2540208;
        Sat, 17 Jul 2021 11:49:56 +0800 (CST)
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] f2fs: fix ctx->pos in f2fs_read_inline_dir()
Date:   Sat, 17 Jul 2021 11:49:55 +0800
Message-Id: <20210717034955.344408-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRlNGhpWS04fGkJJTU4YSE
        0fVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6KxQ6FTo6FT8CFA4zSRIhE0JN
        DRoKFB5VSlVKTUlNT0JITEJNQk5OVTMWGhIXVR0JGhUQVRcSOw0SDRRVGBQWRVlXWRILWUFZSUpD
        VUpLT1VKQ0NVSk1OWVdZCAFZQUlOTUg3Bg++
X-HM-Tid: 0a7ab295c12ab038kuuu7b1f2540208
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

And returning early in f2fs_read_inline_dir will cause the process to be unable to see
the changes before reopening the file.

So don't return early and remove the modification of ctx->pos in f2fs_read_inline_dir().

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/inline.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 56a20d5c15da..fc6551139a3d 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -729,9 +729,6 @@ int f2fs_read_inline_dir(struct file *file, struct dir_context *ctx,
 
 	make_dentry_ptr_inline(inode, &d, inline_dentry);
 
-	if (ctx->pos == d.max)
-		return 0;
-
 	ipage = f2fs_get_node_page(F2FS_I_SB(inode), inode->i_ino);
 	if (IS_ERR(ipage))
 		return PTR_ERR(ipage);
@@ -747,8 +744,6 @@ int f2fs_read_inline_dir(struct file *file, struct dir_context *ctx,
 	make_dentry_ptr_inline(inode, &d, inline_dentry);
 
 	err = f2fs_fill_dentries(ctx, &d, 0, fstr);
-	if (!err)
-		ctx->pos = d.max;
 
 	f2fs_put_page(ipage, 0);
 	return err < 0 ? err : 0;
-- 
2.32.0

