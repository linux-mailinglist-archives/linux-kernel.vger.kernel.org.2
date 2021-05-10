Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD563790D5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbhEJObp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:31:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:38494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243495AbhEJO3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:29:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B2091611F0;
        Mon, 10 May 2021 14:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620656890;
        bh=5Qx2wMQY09P/jiz+QyXoXliDQV06oKwVi44Sr9uGsVA=;
        h=From:To:Cc:Subject:Date:From;
        b=n7DQ+ePe8MZ/W7CimYXZFPNzOE2FndNoWEPR8x0U22UVREFxJqX/XHbh1VJDAfNkg
         3DqJom5OmACR5RAparxHCl1akePyOJy5N+T2ywJeG83VMXW6c4KLpe8H3KXCG3DbNP
         NRVLHKM+Vavik1dfRoR5AfBZrZQT/P64EfFpunNiZh4oXoNkfNizJsdI9kbPfAmW9r
         krRxiPrxLc+AYkGspZm9ZjIrRQ1C80XqDOvTD+hsYIpKct/KYFOLvM5+98t1zllQq4
         LcmVGOUCyoXQinz2z2EpF7Be5pbOuizu1JpEoIiYNTYvugS1KgPq13oHI2j5rqSp2l
         DRFddyGFb2SUQ==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: avoid null pointer access when handling IPU error
Date:   Mon, 10 May 2021 07:28:04 -0700
Message-Id: <20210510142804.511265-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Unable to handle kernel NULL pointer dereference at virtual address 000000000000001a
 pc : f2fs_inplace_write_data+0x144/0x208
 lr : f2fs_inplace_write_data+0x134/0x208
 Call trace:
  f2fs_inplace_write_data+0x144/0x208
  f2fs_do_write_data_page+0x270/0x770
  f2fs_write_single_data_page+0x47c/0x830
  __f2fs_write_data_pages+0x444/0x98c
  f2fs_write_data_pages.llvm.16514453770497736882+0x2c/0x38
  do_writepages+0x58/0x118
  __writeback_single_inode+0x44/0x300
  writeback_sb_inodes+0x4b8/0x9c8
  wb_writeback+0x148/0x42c
  wb_do_writeback+0xc8/0x390
  wb_workfn+0xb0/0x2f4
  process_one_work+0x1fc/0x444
  worker_thread+0x268/0x4b4
  kthread+0x13c/0x158
  ret_from_fork+0x10/0x18

Fixes: 955772787667 ("f2fs: drop inplace IO if fs status is abnormal")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index c605415840b5..ae875557d693 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3577,9 +3577,11 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
 	if (fio->bio) {
 		struct bio *bio = *(fio->bio);
 
-		bio->bi_status = BLK_STS_IOERR;
-		bio_endio(bio);
-		fio->bio = NULL;
+		if (bio) {
+			bio->bi_status = BLK_STS_IOERR;
+			bio_endio(bio);
+			fio->bio = NULL;
+		}
 	}
 	return err;
 }
-- 
2.31.1.607.g51e8a6a459-goog

