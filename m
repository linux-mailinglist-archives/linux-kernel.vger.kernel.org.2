Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3583F5404
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 02:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbhHXANB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 20:13:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:42076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233305AbhHXAM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 20:12:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1953861052;
        Tue, 24 Aug 2021 00:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629763934;
        bh=R4PBDrabhdLVRyrQpEgZnIix3ZrqUr8Ms4laA+oA8EQ=;
        h=From:To:Cc:Subject:Date:From;
        b=LGxBHpxzUweIm67VnnU/0/cNRLceaxgKyVefuc759RoE60i1Rg604nLPSVQUNaSut
         gX+JnTi8V/l+f4s9zhRpY/u65/8bsSCYVFLHadiPgaiPhWKPbyChV8YtFgw6CJReCG
         O6CIa6lFLMUv+fERyZ4GpYW2ubUGU+elyGxVLph1fxfFhE3i0zBEOG8RSozt3oFHcm
         4EigZjIjKxehVcfrOSkXf7t3b1iSssJpUiSWEzLZvgPI4mCyvmEsQFI7a0AkbhyZLY
         Mfh7/uZ3poq3ZXAmYeab6mOqbeUBxdqOuyPv/TP+YNWOcswP1m8lI0bRdMivkV9/sI
         KYj3ib4LobZIQ==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@linux.dev>,
        Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to account missing .skipped_gc_rwsem
Date:   Tue, 24 Aug 2021 08:12:08 +0800
Message-Id: <20210824001208.12942-1-chao@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a missing place we forgot to account .skipped_gc_rwsem, fix it.

Fixes: 6f8d4455060d ("f2fs: avoid fi->i_gc_rwsem[WRITE] lock in f2fs_gc")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/gc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 2c18443972b6..77391e3b7d68 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1500,8 +1500,10 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 			int err;
 
 			if (S_ISREG(inode->i_mode)) {
-				if (!down_write_trylock(&fi->i_gc_rwsem[READ]))
+				if (!down_write_trylock(&fi->i_gc_rwsem[READ])) {
+					sbi->skipped_gc_rwsem++;
 					continue;
+				}
 				if (!down_write_trylock(
 						&fi->i_gc_rwsem[WRITE])) {
 					sbi->skipped_gc_rwsem++;
-- 
2.32.0

