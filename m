Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA563ED3EF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 14:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhHPM2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 08:28:45 -0400
Received: from mail-m17636.qiye.163.com ([59.111.176.36]:63824 "EHLO
        mail-m17636.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbhHPM2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 08:28:43 -0400
Received: from comdg01144022.vivo.xyz (unknown [218.104.188.165])
        by mail-m17636.qiye.163.com (Hmail) with ESMTPA id 936B6C400B1;
        Mon, 16 Aug 2021 20:28:08 +0800 (CST)
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] f2fs: change value of recovery to bool
Date:   Mon, 16 Aug 2021 20:28:07 +0800
Message-Id: <20210816122807.71400-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUNPS0xWHU0ZTB4fHkxCQx
        hMVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NEk6Pyo4ET8CTBwMPBk0HTUB
        EyMwFBdVSlVKTUlCSkpNQ0NCSUxNVTMWGhIXVR0JGhUQVRcSOw0SDRRVGBQWRVlXWRILWUFZSUpD
        VUpLT1VKQ0NVSk1OWVdZCAFZQUlOS083Bg++
X-HM-Tid: 0a7b4eeef6b0d996kuws936b6c400b1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recovery has only two values, 0 and 1, let's change it to bool type.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/super.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8fecd3050ccd..98727e04d271 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3541,7 +3541,7 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
  */
 static int read_raw_super_block(struct f2fs_sb_info *sbi,
 			struct f2fs_super_block **raw_super,
-			int *valid_super_block, int *recovery)
+			int *valid_super_block, bool *recovery)
 {
 	struct super_block *sb = sbi->sb;
 	int block;
@@ -3559,7 +3559,7 @@ static int read_raw_super_block(struct f2fs_sb_info *sbi,
 			f2fs_err(sbi, "Unable to read %dth superblock",
 				 block + 1);
 			err = -EIO;
-			*recovery = 1;
+			*recovery = true;
 			continue;
 		}
 
@@ -3569,7 +3569,7 @@ static int read_raw_super_block(struct f2fs_sb_info *sbi,
 			f2fs_err(sbi, "Can't find valid F2FS filesystem in %dth superblock",
 				 block + 1);
 			brelse(bh);
-			*recovery = 1;
+			*recovery = true;
 			continue;
 		}
 
@@ -3784,15 +3784,16 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	int err;
 	bool skip_recovery = false, need_fsck = false;
 	char *options = NULL;
-	int recovery, i, valid_super_block;
+	int i, valid_super_block;
 	struct curseg_info *seg_i;
 	int retry_cnt = 1;
+	bool recovery;
 
 try_onemore:
 	err = -EINVAL;
 	raw_super = NULL;
 	valid_super_block = -1;
-	recovery = 0;
+	recovery = false;
 
 	/* allocate memory for f2fs-specific super block info */
 	sbi = kzalloc(sizeof(struct f2fs_sb_info), GFP_KERNEL);
-- 
2.32.0

