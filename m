Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A2835B215
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 09:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234681AbhDKHCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 03:02:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229792AbhDKHCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 03:02:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8887361206;
        Sun, 11 Apr 2021 07:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618124522;
        bh=dbu10ZxNnwrVX7m/W1f40w6BRJpvnEEL0J+cWh2TzEw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MOi4YddZxzel+f1kOe/jTUfurJJUkG4JJgL4ANjNLKO2ombxnCbx4OA1ss+RIIJLE
         lIWura2Dt16fX8OreA1ubTOWXqymnKRE5/kPwDYUZdv6LouSg15IqqSd0l+VCgEW2w
         vZZBbJ/j2tlhqfXjPfUPXtwzpxM/lEbbi1HMGR2wQ2lAleEbO/iCeuhYc0hFbS3ega
         bFhetItvW5bhnRCL67otyz6ZuCcJEnF7IR27uiWFJvpTObe17AAQHAKgj00FWeQsyF
         2FV20a7REI4NHlW9dJyOrGf8qLbtPLWpu61xEpWzYrOHldYLNLLHQ1H7JJjUYGHvBl
         9Qv3geCSO/sfQ==
Subject: Re: [PATCH v2] f2fs: fix to avoid touching checkpointed data in
 get_victim()
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20210324031828.67133-1-yuchao0@huawei.com>
 <YFvQGxLbpmDjxEzR@google.com>
 <2dfb085b-80ce-050b-5650-986675a07488@huawei.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <66e0a225-7f52-a33e-ccd6-e7bfa1067ed1@kernel.org>
Date:   Sun, 11 Apr 2021 15:01:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <2dfb085b-80ce-050b-5650-986675a07488@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaegeuk,

Could you please help to merge below cleanup diff into original patch?
or merge this separately if it is too late since it is near rc7.

 From 5a342a8f332a1b3281ec0e2b4d41b5287689c8ed Mon Sep 17 00:00:00 2001
From: Chao Yu <yuchao0@huawei.com>
Date: Sun, 11 Apr 2021 14:29:34 +0800
Subject: [PATCH] f2fs: avoid duplicated codes for cleanup

f2fs_segment_has_free_slot() was copied from __next_free_blkoff(),
the main implementation of them is almost the same, clean up them to
reuse common code as much as possible.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
  fs/f2fs/segment.c | 32 ++++++++++----------------------
  1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b33273aa5c22..bd9056165d62 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2627,22 +2627,20 @@ static void new_curseg(struct f2fs_sb_info *sbi, int type, bool new_sec)
  	curseg->alloc_type = LFS;
  }

-static void __next_free_blkoff(struct f2fs_sb_info *sbi,
-			struct curseg_info *seg, block_t start)
+static int __next_free_blkoff(struct f2fs_sb_info *sbi,
+					int segno, block_t start)
  {
-	struct seg_entry *se = get_seg_entry(sbi, seg->segno);
+	struct seg_entry *se = get_seg_entry(sbi, segno);
  	int entries = SIT_VBLOCK_MAP_SIZE / sizeof(unsigned long);
  	unsigned long *target_map = SIT_I(sbi)->tmp_map;
  	unsigned long *ckpt_map = (unsigned long *)se->ckpt_valid_map;
  	unsigned long *cur_map = (unsigned long *)se->cur_valid_map;
-	int i, pos;
+	int i;

  	for (i = 0; i < entries; i++)
  		target_map[i] = ckpt_map[i] | cur_map[i];

-	pos = __find_rev_next_zero_bit(target_map, sbi->blocks_per_seg, start);
-
-	seg->next_blkoff = pos;
+	return __find_rev_next_zero_bit(target_map, sbi->blocks_per_seg, start);
  }

  /*
@@ -2654,26 +2652,16 @@ static void __refresh_next_blkoff(struct f2fs_sb_info *sbi,
  				struct curseg_info *seg)
  {
  	if (seg->alloc_type == SSR)
-		__next_free_blkoff(sbi, seg, seg->next_blkoff + 1);
+		seg->next_blkoff =
+			__next_free_blkoff(sbi, seg->segno,
+						seg->next_blkoff + 1);
  	else
  		seg->next_blkoff++;
  }

  bool f2fs_segment_has_free_slot(struct f2fs_sb_info *sbi, int segno)
  {
-	struct seg_entry *se = get_seg_entry(sbi, segno);
-	int entries = SIT_VBLOCK_MAP_SIZE / sizeof(unsigned long);
-	unsigned long *target_map = SIT_I(sbi)->tmp_map;
-	unsigned long *ckpt_map = (unsigned long *)se->ckpt_valid_map;
-	unsigned long *cur_map = (unsigned long *)se->cur_valid_map;
-	int i, pos;
-
-	for (i = 0; i < entries; i++)
-		target_map[i] = ckpt_map[i] | cur_map[i];
-
-	pos = __find_rev_next_zero_bit(target_map, sbi->blocks_per_seg, 0);
-
-	return pos < sbi->blocks_per_seg;
+	return __next_free_blkoff(sbi, segno, 0) < sbi->blocks_per_seg;
  }

  /*
@@ -2701,7 +2689,7 @@ static void change_curseg(struct f2fs_sb_info *sbi, int type, bool flush)

  	reset_curseg(sbi, type, 1);
  	curseg->alloc_type = SSR;
-	__next_free_blkoff(sbi, curseg, 0);
+	__next_free_blkoff(sbi, curseg->segno, 0);

  	sum_page = f2fs_get_sum_page(sbi, new_segno);
  	if (IS_ERR(sum_page)) {
-- 
2.22.1

