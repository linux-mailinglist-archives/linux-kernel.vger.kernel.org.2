Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED2B3B0EA2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 22:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhFVUYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 16:24:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:53222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230151AbhFVUYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 16:24:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EFCE260724;
        Tue, 22 Jun 2021 20:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624393339;
        bh=YiAxCf6fiPnI8bJy6wNlmJjhebzXdmJijGBXG3hEx18=;
        h=From:To:Cc:Subject:Date:From;
        b=VJPJNCa91bYO3PAPUjo+cmmgiNiUJDqIm/6/Nmu2Q1QEsR/BFZncuFlhEu83yyRsY
         SDuIiSiqiIbDM1Qz6PDf+fTWq19Dpz/cNr23wQRstLowvNuwyfhgBcGWvBEmnMorPh
         gW4uEjj/QUr/oadnOrhGTCY0Nz1ZBVICmqL88+QNipdx4FtiHuOZ0MK814hNxhQvIq
         kT31lJTh9YamuD2X23XVe9Wfd4sBSrEAtaKfeosoj29LjMiWOYvyWRqg1CcOzyWw/d
         ZCFiIUElBPjYWPvonRAxvA3UkVS/nK2D6aDk+4TvMlUQV13Q5epIzG1gPnB7eNK5+R
         z7lIMUi/LFRFw==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: remove false alarm on iget failure during GC
Date:   Tue, 22 Jun 2021 13:22:17 -0700
Message-Id: <20210622202217.3864743-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes setting SBI_NEED_FSCK when GC gets an error on f2fs_iget,
since f2fs_iget can give ENOMEM and others by race condition.
If we set this critical fsck flag, we'll get EIO during fsync via the below
code path.

In f2fs_inplace_write_data(),

	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK) || f2fs_cp_error(sbi)) {
		err = -EIO;
		goto drop_bio;
	}

Fixes: 9557727876674 ("f2fs: drop inplace IO if fs status is abnormal")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index da5947b30142..0e42ee5f7770 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1451,10 +1451,8 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 
 		if (phase == 3) {
 			inode = f2fs_iget(sb, dni.ino);
-			if (IS_ERR(inode) || is_bad_inode(inode)) {
-				set_sbi_flag(sbi, SBI_NEED_FSCK);
+			if (IS_ERR(inode) || is_bad_inode(inode))
 				continue;
-			}
 
 			if (!down_write_trylock(
 				&F2FS_I(inode)->i_gc_rwsem[WRITE])) {
-- 
2.32.0.288.g62a8d224e6-goog

