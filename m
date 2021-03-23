Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F09346DA8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 00:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbhCWXA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 19:00:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:47582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233782AbhCWW7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 18:59:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B883619D9;
        Tue, 23 Mar 2021 22:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616540380;
        bh=8pvmxfe6Fus9YwEnpI++2Qy2NL6+4k5fZBCD7awngFI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FM5Bg24zzDgHRftBa0WHC+xbB+vNkL+HgWYCuPwW7cMxEmoAsc0tWcPYUeK06UsLe
         FZ4isI7VYM+Ln1WBQSEUsSGdML8CAGgk5dLWZST/2FR0JUi5NPVvf6qxLmR0/4o/Kl
         pDjxB/1mGj2vq2XnQuAdMe2Q3YHxbhB5lk791pSzELfSEYTtLvcABDTvX2SOuWRM58
         Ieefat7N+uWctng3AoSBREDtyVpcZyZ1eghjdgHp/fCeiPqsDzr0nf5Tgan4U0YdMa
         /HQcZ3Dy6PjmCU5oZ/QV7OZvU7jm4P2xAEq6CfBLWCgRpSylSXl/A8qLdSQeq4xGLA
         1AXP5HK67QGCg==
Date:   Tue, 23 Mar 2021 15:59:39 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH RFC] f2fs: fix to avoid selecting full segment w/
 {AT,}SSR allocator
Message-ID: <YFpy26JZRpZASB7R@google.com>
References: <20210220094052.64905-1-yuchao0@huawei.com>
 <YFOLNGo+/8sKQ7si@google.com>
 <ec5cda53-d3f4-450c-7567-7bfc68e224f9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec5cda53-d3f4-450c-7567-7bfc68e224f9@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/19, Chao Yu wrote:
> On 2021/3/19 1:17, Jaegeuk Kim wrote:
> > On 02/20, Chao Yu wrote:
> > > In cp disabling mode, there could be a condition
> > > - target segment has 128 ckpt valid blocks
> > > - GC migrates 128 valid blocks to other segment (segment is still in
> > > dirty list)
> > > - GC migrates 384 blocks to target segment (segment has 128 cp_vblocks
> > > and 384 vblocks)
> > > - If GC selects target segment via {AT,}SSR allocator, however there is
> > > no free space in targe segment.
> > > 
> > > Fixes: 4354994f097d ("f2fs: checkpoint disabling")
> > > Fixes: 093749e296e2 ("f2fs: support age threshold based garbage collection")
> > > Signed-off-by: Chao Yu <yuchao0@huawei.com>
> > > ---
> > >   fs/f2fs/f2fs.h    |  1 +
> > >   fs/f2fs/gc.c      | 17 +++++++++++++----
> > >   fs/f2fs/segment.c | 20 ++++++++++++++++++++
> > >   3 files changed, 34 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > > index ed7807103c8e..9c753eff0814 100644
> > > --- a/fs/f2fs/f2fs.h
> > > +++ b/fs/f2fs/f2fs.h
> > > @@ -3376,6 +3376,7 @@ block_t f2fs_get_unusable_blocks(struct f2fs_sb_info *sbi);
> > >   int f2fs_disable_cp_again(struct f2fs_sb_info *sbi, block_t unusable);
> > >   void f2fs_release_discard_addrs(struct f2fs_sb_info *sbi);
> > >   int f2fs_npages_for_summary_flush(struct f2fs_sb_info *sbi, bool for_ra);
> > > +bool segment_has_free_slot(struct f2fs_sb_info *sbi, int segno);
> > >   void f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi);
> > >   void f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi);
> > >   void f2fs_restore_inmem_curseg(struct f2fs_sb_info *sbi);
> > > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > > index 86ba8ed0b8a7..a1d8062cdace 100644
> > > --- a/fs/f2fs/gc.c
> > > +++ b/fs/f2fs/gc.c
> > > @@ -392,10 +392,6 @@ static void add_victim_entry(struct f2fs_sb_info *sbi,
> > >   		if (p->gc_mode == GC_AT &&
> > >   			get_valid_blocks(sbi, segno, true) == 0)
> > >   			return;
> > > -
> > > -		if (p->alloc_mode == AT_SSR &&
> > > -			get_seg_entry(sbi, segno)->ckpt_valid_blocks == 0)
> > > -			return;
> > >   	}
> > >   	for (i = 0; i < sbi->segs_per_sec; i++)
> > > @@ -736,6 +732,19 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
> > >   		if (gc_type == BG_GC && test_bit(secno, dirty_i->victim_secmap))
> > >   			goto next;
> > > +		if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
> > > +			/*
> > > +			 * to avoid selecting candidate which has below valid
> > > +			 * block distribution:
> > > +			 * partial blocks are valid and all left ones are valid
> > > +			 * in previous checkpoint.
> > > +			 */
> > > +			if (p.alloc_mode == SSR || p.alloc_mode == AT_SSR) {
> > > +				if (!segment_has_free_slot(sbi, segno))
> > > +					goto next;
> > 
> > Do we need to change this to check free_slot instead of get_ckpt_valid_blocks()?
> 
> Jaegeuk,
> 
> LFS was assigned only for GC case, in this case we are trying to select source
> section, rather than target segment for SSR/AT_SSR case, so we don't need to
> check free_slot.
> 
> - f2fs_gc
>  - __get_victim
>   - get_victim(sbi, victim, gc_type, NO_CHECK_TYPE, LFS, 0);
> 
> > 
> >   732                 if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED) &&
> >   733                                         get_ckpt_valid_blocks(sbi, segno) &&
> >   734                                         p.alloc_mode == LFS))
> 
> BTW, in LFS mode, GC wants to find source section rather than segment, so we
> should change to check valid ckpt blocks in every segment of targe section here?

Alright. I refactored a bit on this patch with new one. Could you please take a look?

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=00152bd7cabd69b4615ebead823ff23887b0e0f7

Thanks,

> 
> Thanks,
> 
> > 
> > 
> > > +			}
> > > +		}
> > > +
> > >   		if (is_atgc) {
> > >   			add_victim_entry(sbi, &p, segno);
> > >   			goto next;
> > > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > > index 2d5a82c4ca15..deaf57e13125 100644
> > > --- a/fs/f2fs/segment.c
> > > +++ b/fs/f2fs/segment.c
> > > @@ -2650,6 +2650,26 @@ static void __refresh_next_blkoff(struct f2fs_sb_info *sbi,
> > >   		seg->next_blkoff++;
> > >   }
> > > +bool segment_has_free_slot(struct f2fs_sb_info *sbi, int segno)
> > > +{
> > > +	struct sit_info *sit = SIT_I(sbi);
> > > +	struct seg_entry *se = get_seg_entry(sbi, segno);
> > > +	int entries = SIT_VBLOCK_MAP_SIZE / sizeof(unsigned long);
> > > +	unsigned long *target_map = SIT_I(sbi)->tmp_map;
> > > +	unsigned long *ckpt_map = (unsigned long *)se->ckpt_valid_map;
> > > +	unsigned long *cur_map = (unsigned long *)se->cur_valid_map;
> > > +	int i, pos;
> > > +
> > > +	down_write(&sit->sentry_lock);
> > > +	for (i = 0; i < entries; i++)
> > > +		target_map[i] = ckpt_map[i] | cur_map[i];
> > > +
> > > +	pos = __find_rev_next_zero_bit(target_map, sbi->blocks_per_seg, 0);
> > > +	up_write(&sit->sentry_lock);
> > > +
> > > +	return pos < sbi->blocks_per_seg;
> > > +}
> > > +
> > >   /*
> > >    * This function always allocates a used segment(from dirty seglist) by SSR
> > >    * manner, so it should recover the existing segment information of valid blocks
> > > -- 
> > > 2.29.2
> > .
> > 
