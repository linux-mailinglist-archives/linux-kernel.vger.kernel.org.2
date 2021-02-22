Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE75321A0D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 15:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbhBVORq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 09:17:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:41086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230008AbhBVNoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 08:44:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 965E464DD0;
        Mon, 22 Feb 2021 13:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614001412;
        bh=Bf/NcxIpzK9yRb/+rvFnNaliEbQA1RDoY0uXTNr/qZs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nAipNCVxTEd6U6LBtKFH3B3Xcu5OcRHp+V4e8FxfyDWugzlsfSi5x+fcbI/x+2CIQ
         K5lxHmePufQUP6Qxe3Egsuj+HOcNKNaQpu6zSc3glKXrtf14EEjVkRT6isTOdQm8Fk
         UaY/5S3UK4sOSuwGevvz0GvimmBtsEQQjYcstHndowkORQe8A3QxZOyf31aglcjsDi
         2Dy/tUN8HItsmd5QrRP5sivyNBPi/YvH7jX4YvnREXBl2Wqc2JQPIaWbtJSnwsVWA8
         K4ZCDFx2WtObP5rXEnSADOGJNC1nw+7kSdknOXFuMD+oae6n+uwOXbbWmeWgE52Hes
         C4x2kbRjGLyuQ==
Subject: Re: [PATCH RFC] f2fs: fix to avoid selecting full segment w/ {AT,}SSR
 allocator
To:     Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20210220094052.64905-1-yuchao0@huawei.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <ad627dde-23f9-cbbc-ce58-7c799161f290@kernel.org>
Date:   Mon, 22 Feb 2021 21:43:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210220094052.64905-1-yuchao0@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping,

On 2021/2/20 17:40, Chao Yu wrote:
> In cp disabling mode, there could be a condition
> - target segment has 128 ckpt valid blocks
> - GC migrates 128 valid blocks to other segment (segment is still in
> dirty list)
> - GC migrates 384 blocks to target segment (segment has 128 cp_vblocks
> and 384 vblocks)
> - If GC selects target segment via {AT,}SSR allocator, however there is
> no free space in targe segment.
> 
> Fixes: 4354994f097d ("f2fs: checkpoint disabling")
> Fixes: 093749e296e2 ("f2fs: support age threshold based garbage collection")
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>   fs/f2fs/f2fs.h    |  1 +
>   fs/f2fs/gc.c      | 17 +++++++++++++----
>   fs/f2fs/segment.c | 20 ++++++++++++++++++++
>   3 files changed, 34 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index ed7807103c8e..9c753eff0814 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3376,6 +3376,7 @@ block_t f2fs_get_unusable_blocks(struct f2fs_sb_info *sbi);
>   int f2fs_disable_cp_again(struct f2fs_sb_info *sbi, block_t unusable);
>   void f2fs_release_discard_addrs(struct f2fs_sb_info *sbi);
>   int f2fs_npages_for_summary_flush(struct f2fs_sb_info *sbi, bool for_ra);
> +bool segment_has_free_slot(struct f2fs_sb_info *sbi, int segno);
>   void f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi);
>   void f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi);
>   void f2fs_restore_inmem_curseg(struct f2fs_sb_info *sbi);
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 86ba8ed0b8a7..a1d8062cdace 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -392,10 +392,6 @@ static void add_victim_entry(struct f2fs_sb_info *sbi,
>   		if (p->gc_mode == GC_AT &&
>   			get_valid_blocks(sbi, segno, true) == 0)
>   			return;
> -
> -		if (p->alloc_mode == AT_SSR &&
> -			get_seg_entry(sbi, segno)->ckpt_valid_blocks == 0)
> -			return;
>   	}
>   
>   	for (i = 0; i < sbi->segs_per_sec; i++)
> @@ -736,6 +732,19 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
>   		if (gc_type == BG_GC && test_bit(secno, dirty_i->victim_secmap))
>   			goto next;
>   
> +		if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
> +			/*
> +			 * to avoid selecting candidate which has below valid
> +			 * block distribution:
> +			 * partial blocks are valid and all left ones are valid
> +			 * in previous checkpoint.
> +			 */
> +			if (p.alloc_mode == SSR || p.alloc_mode == AT_SSR) {
> +				if (!segment_has_free_slot(sbi, segno))
> +					goto next;
> +			}
> +		}
> +
>   		if (is_atgc) {
>   			add_victim_entry(sbi, &p, segno);
>   			goto next;
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 2d5a82c4ca15..deaf57e13125 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2650,6 +2650,26 @@ static void __refresh_next_blkoff(struct f2fs_sb_info *sbi,
>   		seg->next_blkoff++;
>   }
>   
> +bool segment_has_free_slot(struct f2fs_sb_info *sbi, int segno)
> +{
> +	struct sit_info *sit = SIT_I(sbi);
> +	struct seg_entry *se = get_seg_entry(sbi, segno);
> +	int entries = SIT_VBLOCK_MAP_SIZE / sizeof(unsigned long);
> +	unsigned long *target_map = SIT_I(sbi)->tmp_map;
> +	unsigned long *ckpt_map = (unsigned long *)se->ckpt_valid_map;
> +	unsigned long *cur_map = (unsigned long *)se->cur_valid_map;
> +	int i, pos;
> +
> +	down_write(&sit->sentry_lock);
> +	for (i = 0; i < entries; i++)
> +		target_map[i] = ckpt_map[i] | cur_map[i];
> +
> +	pos = __find_rev_next_zero_bit(target_map, sbi->blocks_per_seg, 0);
> +	up_write(&sit->sentry_lock);
> +
> +	return pos < sbi->blocks_per_seg;
> +}
> +
>   /*
>    * This function always allocates a used segment(from dirty seglist) by SSR
>    * manner, so it should recover the existing segment information of valid blocks
> 
