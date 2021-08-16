Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745F93ED77A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 15:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240727AbhHPNdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 09:33:37 -0400
Received: from mail-m17636.qiye.163.com ([59.111.176.36]:46412 "EHLO
        mail-m17636.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240410AbhHPNXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 09:23:22 -0400
Received: from comdg01144022.vivo.xyz (unknown [218.104.188.165])
        by mail-m17636.qiye.163.com (Hmail) with ESMTPA id 491E5C40261;
        Mon, 16 Aug 2021 21:22:49 +0800 (CST)
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] f2fs: always call f2fs_issue_checkpoint() in f2fs_sync_fs()
Date:   Mon, 16 Aug 2021 21:22:48 +0800
Message-Id: <20210816132248.276865-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUJKGkNWHU9NGE0ZGElKSE
        geVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MjY6PSo6Mz9JNRwzLBkSF08N
        SRMaCypVSlVKTUlCSklLSk1CQ05PVTMWGhIXVR0JGhUQVRcSOw0SDRRVGBQWRVlXWRILWUFZSUpD
        VUpLT1VKQ0NVSk1OWVdZCAFZQUpNQ0k3Bg++
X-HM-Tid: 0a7b4f2105efd996kuws491e5c40261
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sync is always 1, so delete the check of the value.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/super.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 98727e04d271..b823c7e3f303 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1553,7 +1553,6 @@ static void f2fs_put_super(struct super_block *sb)
 int f2fs_sync_fs(struct super_block *sb, int sync)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
-	int err = 0;
 
 	if (unlikely(f2fs_cp_error(sbi)))
 		return 0;
@@ -1565,10 +1564,7 @@ int f2fs_sync_fs(struct super_block *sb, int sync)
 	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
 		return -EAGAIN;
 
-	if (sync)
-		err = f2fs_issue_checkpoint(sbi);
-
-	return err;
+	return f2fs_issue_checkpoint(sbi);
 }
 
 static int f2fs_freeze(struct super_block *sb)
-- 
2.32.0

