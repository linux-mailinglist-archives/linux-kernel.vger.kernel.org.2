Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C17327054
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 06:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhB1FKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 00:10:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:58178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229454AbhB1FKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 00:10:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 532E964DE5;
        Sun, 28 Feb 2021 05:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614489006;
        bh=pbH0DKm6LsNqRGRaN/F4XVCG+yk9JeMauppGOKDCpXc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c4dqyBJyyC6nBR4E4m6ZzRbDZJ8iStONpQgBFczSuFDF1i2uh5TMhGeFGI9hwNkVX
         sZyQ8iUedHkYG3thuesTKi+8oh2+2QLIo2/XEIowkqtGu0f+Qxk4JQpN97AyHueVjN
         Tb7LE8d8I9g8YonNI/gUanGOwAvCaMaJ/k7IaHH4J89OkRMnCr78avxHTGxs9lSr+d
         kBYINX8pvAhOe32+93qOfprY5GKXbZhr4K3Sogg7RS6IQFp46cQdDM2xBCQRjM4rm2
         ag+SpuTlOdE4E+2TA0b7SmP2BPtaD3Ul865W108kWCmbmyr60LrJWfDlNlO02SMU1q
         PHB4yxOcqU/Pg==
Date:   Sat, 27 Feb 2021 21:10:05 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] f2fs: fix to avoid selecting full segment w/
 {AT,}SSR allocator
Message-ID: <YDslrV/qw0DyVc8o@google.com>
References: <20210220094052.64905-1-yuchao0@huawei.com>
 <ad627dde-23f9-cbbc-ce58-7c799161f290@kernel.org>
 <2b96b5e5-abc0-615f-0220-5d46b8e2c329@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b96b5e5-abc0-615f-0220-5d46b8e2c329@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/23, Chao Yu wrote:
> Jaegeuk,
> 
> Could you please help to review this patch? since I doubt that this
> issue can happen in real world... :(

Let me take a look as soon as I have some time. Sorry for the delay.

> 
> Thanks,
> 
> On 2021/2/22 21:43, Chao Yu wrote:
> > Ping,
> > 
> > On 2021/2/20 17:40, Chao Yu wrote:
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
> > >    fs/f2fs/f2fs.h    |  1 +
> > >    fs/f2fs/gc.c      | 17 +++++++++++++----
> > >    fs/f2fs/segment.c | 20 ++++++++++++++++++++
> > >    3 files changed, 34 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > > index ed7807103c8e..9c753eff0814 100644
> > > --- a/fs/f2fs/f2fs.h
> > > +++ b/fs/f2fs/f2fs.h
> > > @@ -3376,6 +3376,7 @@ block_t f2fs_get_unusable_blocks(struct f2fs_sb_info *sbi);
> > >    int f2fs_disable_cp_again(struct f2fs_sb_info *sbi, block_t unusable);
> > >    void f2fs_release_discard_addrs(struct f2fs_sb_info *sbi);
> > >    int f2fs_npages_for_summary_flush(struct f2fs_sb_info *sbi, bool for_ra);
> > > +bool segment_has_free_slot(struct f2fs_sb_info *sbi, int segno);
> > >    void f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi);
> > >    void f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi);
> > >    void f2fs_restore_inmem_curseg(struct f2fs_sb_info *sbi);
> > > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > > index 86ba8ed0b8a7..a1d8062cdace 100644
> > > --- a/fs/f2fs/gc.c
> > > +++ b/fs/f2fs/gc.c
> > > @@ -392,10 +392,6 @@ static void add_victim_entry(struct f2fs_sb_info *sbi,
> > >    		if (p->gc_mode == GC_AT &&
> > >    			get_valid_blocks(sbi, segno, true) == 0)
> > >    			return;
> > > -
> > > -		if (p->alloc_mode == AT_SSR &&
> > > -			get_seg_entry(sbi, segno)->ckpt_valid_blocks == 0)
> > > -			return;
> > >    	}
> > >    	for (i = 0; i < sbi->segs_per_sec; i++)
> > > @@ -736,6 +732,19 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
> > >    		if (gc_type == BG_GC && test_bit(secno, dirty_i->victim_secmap))
> > >    			goto next;
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
> > > +			}
> > > +		}
> > > +
> > >    		if (is_atgc) {
> > >    			add_victim_entry(sbi, &p, segno);
> > >    			goto next;
> > > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > > index 2d5a82c4ca15..deaf57e13125 100644
> > > --- a/fs/f2fs/segment.c
> > > +++ b/fs/f2fs/segment.c
> > > @@ -2650,6 +2650,26 @@ static void __refresh_next_blkoff(struct f2fs_sb_info *sbi,
> > >    		seg->next_blkoff++;
> > >    }
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
> > >    /*
> > >     * This function always allocates a used segment(from dirty seglist) by SSR
> > >     * manner, so it should recover the existing segment information of valid blocks
> > > 
> > .
> > 
