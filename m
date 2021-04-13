Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0A335D584
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 05:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241976AbhDMC7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 22:59:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:44374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237380AbhDMC7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 22:59:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACD2E613A9;
        Tue, 13 Apr 2021 02:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618282773;
        bh=hbfFBZpQIOqrYUqshL/7tI8UK0GjZzppnidBVQmHG+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EOaCFXUcH7W7w2L9tPvbl5yB4zma5CtKI1Tg51BTxPdqinL76ZtmZVYru/ftN7Nvp
         EEj3j4MdJxRZ7aXa94C1l5y+iUThkU5z1tP8ZEu+O8lk5J4wVbN8I/FKPfYym+6f18
         8GpaKKpL3EyYZP85+0se1vPpI0aO0uwBU1n/r/xgY+PO8fu8k+8gxsKvHLE0u1jbnG
         eNp960PLerluXeSYOPsXKu0TVzSORqXSH6XvayAskdR3xlIP06XwP6efrPX/OvdbM1
         w0dgbVCd/t1ufpbiwYL2krAOpjWV4Yfo/Ijv0WuoRisuS+oPQ/Z6X4dQVOtqPT5Y7g
         xyW/RKIsNNybw==
Date:   Mon, 12 Apr 2021 19:59:32 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: fix to avoid touching checkpointed data in
 get_victim()
Message-ID: <YHUJFElliMOWMbWN@google.com>
References: <20210324031828.67133-1-yuchao0@huawei.com>
 <YFvQGxLbpmDjxEzR@google.com>
 <2dfb085b-80ce-050b-5650-986675a07488@huawei.com>
 <66e0a225-7f52-a33e-ccd6-e7bfa1067ed1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66e0a225-7f52-a33e-ccd6-e7bfa1067ed1@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11, Chao Yu wrote:
> Hi Jaegeuk,
> 
> Could you please help to merge below cleanup diff into original patch?
> or merge this separately if it is too late since it is near rc7.

I didn't review this tho, this gives an error in xfstests/083.

> 
> From 5a342a8f332a1b3281ec0e2b4d41b5287689c8ed Mon Sep 17 00:00:00 2001
> From: Chao Yu <yuchao0@huawei.com>
> Date: Sun, 11 Apr 2021 14:29:34 +0800
> Subject: [PATCH] f2fs: avoid duplicated codes for cleanup
> 
> f2fs_segment_has_free_slot() was copied from __next_free_blkoff(),
> the main implementation of them is almost the same, clean up them to
> reuse common code as much as possible.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/segment.c | 32 ++++++++++----------------------
>  1 file changed, 10 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index b33273aa5c22..bd9056165d62 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2627,22 +2627,20 @@ static void new_curseg(struct f2fs_sb_info *sbi, int type, bool new_sec)
>  	curseg->alloc_type = LFS;
>  }
> 
> -static void __next_free_blkoff(struct f2fs_sb_info *sbi,
> -			struct curseg_info *seg, block_t start)
> +static int __next_free_blkoff(struct f2fs_sb_info *sbi,
> +					int segno, block_t start)
>  {
> -	struct seg_entry *se = get_seg_entry(sbi, seg->segno);
> +	struct seg_entry *se = get_seg_entry(sbi, segno);
>  	int entries = SIT_VBLOCK_MAP_SIZE / sizeof(unsigned long);
>  	unsigned long *target_map = SIT_I(sbi)->tmp_map;
>  	unsigned long *ckpt_map = (unsigned long *)se->ckpt_valid_map;
>  	unsigned long *cur_map = (unsigned long *)se->cur_valid_map;
> -	int i, pos;
> +	int i;
> 
>  	for (i = 0; i < entries; i++)
>  		target_map[i] = ckpt_map[i] | cur_map[i];
> 
> -	pos = __find_rev_next_zero_bit(target_map, sbi->blocks_per_seg, start);
> -
> -	seg->next_blkoff = pos;
> +	return __find_rev_next_zero_bit(target_map, sbi->blocks_per_seg, start);
>  }
> 
>  /*
> @@ -2654,26 +2652,16 @@ static void __refresh_next_blkoff(struct f2fs_sb_info *sbi,
>  				struct curseg_info *seg)
>  {
>  	if (seg->alloc_type == SSR)
> -		__next_free_blkoff(sbi, seg, seg->next_blkoff + 1);
> +		seg->next_blkoff =
> +			__next_free_blkoff(sbi, seg->segno,
> +						seg->next_blkoff + 1);
>  	else
>  		seg->next_blkoff++;
>  }
> 
>  bool f2fs_segment_has_free_slot(struct f2fs_sb_info *sbi, int segno)
>  {
> -	struct seg_entry *se = get_seg_entry(sbi, segno);
> -	int entries = SIT_VBLOCK_MAP_SIZE / sizeof(unsigned long);
> -	unsigned long *target_map = SIT_I(sbi)->tmp_map;
> -	unsigned long *ckpt_map = (unsigned long *)se->ckpt_valid_map;
> -	unsigned long *cur_map = (unsigned long *)se->cur_valid_map;
> -	int i, pos;
> -
> -	for (i = 0; i < entries; i++)
> -		target_map[i] = ckpt_map[i] | cur_map[i];
> -
> -	pos = __find_rev_next_zero_bit(target_map, sbi->blocks_per_seg, 0);
> -
> -	return pos < sbi->blocks_per_seg;
> +	return __next_free_blkoff(sbi, segno, 0) < sbi->blocks_per_seg;
>  }
> 
>  /*
> @@ -2701,7 +2689,7 @@ static void change_curseg(struct f2fs_sb_info *sbi, int type, bool flush)
> 
>  	reset_curseg(sbi, type, 1);
>  	curseg->alloc_type = SSR;
> -	__next_free_blkoff(sbi, curseg, 0);
> +	__next_free_blkoff(sbi, curseg->segno, 0);
> 
>  	sum_page = f2fs_get_sum_page(sbi, new_segno);
>  	if (IS_ERR(sum_page)) {
> -- 
> 2.22.1
