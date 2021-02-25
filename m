Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32681323A28
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 11:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbhBXKG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 05:06:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:55612 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234314AbhBXKFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 05:05:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B31DEAE05;
        Wed, 24 Feb 2021 10:05:09 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6EAFE1E14EF; Wed, 24 Feb 2021 11:05:09 +0100 (CET)
Date:   Wed, 24 Feb 2021 11:05:09 +0100
From:   Jan Kara <jack@suse.cz>
To:     Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc:     jack@suse.cz, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+a8b4b0c60155e87e9484@syzkaller.appspotmail.com,
        tytso@mit.edu
Subject: Re: [PATCH v2] fs/ext4: fix integer overflow in s_log_groups_per_flex
Message-ID: <20210224100509.GB20583@quack2.suse.cz>
References: <20210223170118.GD30433@quack2.suse.cz>
 <20210224095800.3350002-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224095800.3350002-1-snovitoll@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 24-02-21 15:58:00, Sabyrzhan Tasbolatov wrote:
> syzbot found UBSAN: shift-out-of-bounds in ext4_mb_init [1], when
> 1 << sbi->s_es->s_log_groups_per_flex is bigger than UINT_MAX,
> where sbi->s_mb_prefetch is unsigned integer type.
> 
> 32 is the maximum allowed power of s_log_groups_per_flex. Following if
> check will also trigger UBSAN shift-out-of-bound:
> 
> if (1 << sbi->s_es->s_log_groups_per_flex >= UINT_MAX) {
> 
> So I'm checking it against the raw number, perhaps there is another way
> to calculate UINT_MAX max power. Also use min_t as to make sure it's
> uint type.
> 
> [1] UBSAN: shift-out-of-bounds in fs/ext4/mballoc.c:2713:24
> shift exponent 60 is too large for 32-bit type 'int'
> Call Trace:
>  __dump_stack lib/dump_stack.c:79 [inline]
>  dump_stack+0x137/0x1be lib/dump_stack.c:120
>  ubsan_epilogue lib/ubsan.c:148 [inline]
>  __ubsan_handle_shift_out_of_bounds+0x432/0x4d0 lib/ubsan.c:395
>  ext4_mb_init_backend fs/ext4/mballoc.c:2713 [inline]
>  ext4_mb_init+0x19bc/0x19f0 fs/ext4/mballoc.c:2898
>  ext4_fill_super+0xc2ec/0xfbe0 fs/ext4/super.c:4983
> 
> Reported-by: syzbot+a8b4b0c60155e87e9484@syzkaller.appspotmail.com
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> v2: updated > 32 condition to >= 32
> 
> > > +		if (sbi->s_es->s_log_groups_per_flex > 32) {
> > 						    ^^ >= 32?
> > 
> > Otherwise the patch looks good.
> > 
> 
> Thanks! Updated to >= 32 condition.
> ---
>  fs/ext4/mballoc.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 99bf091fee10..a02fadf4fc84 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2709,8 +2709,15 @@ static int ext4_mb_init_backend(struct super_block *sb)
>  	}
>  
>  	if (ext4_has_feature_flex_bg(sb)) {
> -		/* a single flex group is supposed to be read by a single IO */
> -		sbi->s_mb_prefetch = min(1 << sbi->s_es->s_log_groups_per_flex,
> +		/* a single flex group is supposed to be read by a single IO.
> +		 * 2 ^ s_log_groups_per_flex != UINT_MAX as s_mb_prefetch is
> +		 * unsigned integer, so the maximum shift is 32.
> +		 */
> +		if (sbi->s_es->s_log_groups_per_flex >= 32) {
> +			ext4_msg(sb, KERN_ERR, "too many log groups per flexible block group");
> +			goto err_freesgi;
> +		}
> +		sbi->s_mb_prefetch = min_t(uint, 1 << sbi->s_es->s_log_groups_per_flex,
>  			BLK_MAX_SEGMENT_SIZE >> (sb->s_blocksize_bits - 9));
>  		sbi->s_mb_prefetch *= 8; /* 8 prefetch IOs in flight at most */
>  	} else {
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
