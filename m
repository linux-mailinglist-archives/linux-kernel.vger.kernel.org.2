Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67EE73F5402
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 02:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbhHXAM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 20:12:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:41966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231454AbhHXAM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 20:12:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1C4C6124D;
        Tue, 24 Aug 2021 00:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629763903;
        bh=y+M+d16+SOhNga0ZjfIRxu+T5lwMUYmIY0JS7MhlAu4=;
        h=From:To:Cc:Subject:Date:From;
        b=TP961ZmZ2fBtCxsAUnfXGqBKR3CcAL9+OOFFnS2Df8nzxQsNJzar0Ig/tT6dRtaGf
         jktrXSiBjjFYAdXyFljfIEK37xCKM6epuHyyIuIvkcvcT/uFGBjp0G2mjZmUtDCDB2
         E7lahhXVOj1yYBNphBZxuEGHDFDAhPEQ1abGRcdlAtBN/vtmJuiVPhzcTy/MokAtYY
         C7+YyAHCJRzaPlvYJDhH1gQg28YoUi90lTsPXYcI6u0jPQlVIpUfLo9JvrDiCqDcF2
         nf1PwxzGwYzPuXCctAoZ0EGL8ZFxCG7ShGSETFfQexqyvl+zaBE6qYN7mBfr5KuPxG
         2CFCLO33gL/ug==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@linux.dev>,
        Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: adjust unlock order for cleanup
Date:   Tue, 24 Aug 2021 08:11:38 +0800
Message-Id: <20210824001138.12863-1-chao@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adjusts unlock order of .i_mmap_sem and .i_gc_rwsem for
cleanup.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 1323cd0f445a..3330efb41f22 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3496,8 +3496,8 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 		released_blocks += ret;
 	}
 
-	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	up_write(&F2FS_I(inode)->i_mmap_sem);
+	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 out:
 	inode_unlock(inode);
 
@@ -3649,8 +3649,8 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 		reserved_blocks += ret;
 	}
 
-	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	up_write(&F2FS_I(inode)->i_mmap_sem);
+	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 
 	if (ret >= 0) {
 		clear_inode_flag(inode, FI_COMPRESS_RELEASED);
-- 
2.32.0

