Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46B730BE30
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 13:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbhBBM3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 07:29:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:58126 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231366AbhBBM3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 07:29:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C65A4AC45;
        Tue,  2 Feb 2021 12:28:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2E3A41E14C3; Tue,  2 Feb 2021 13:28:36 +0100 (CET)
Date:   Tue, 2 Feb 2021 13:28:36 +0100
From:   Jan Kara <jack@suse.cz>
To:     Lin Feng <linf@wangsu.com>
Cc:     axboe@kernel.dk, paolo.valente@linaro.org, jack@suse.cz,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] Revert "bfq: Fix computation of shallow depth"
Message-ID: <20210202122836.GC17147@quack2.suse.cz>
References: <20210129111808.45796-1-linf@wangsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129111808.45796-1-linf@wangsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri 29-01-21 19:18:08, Lin Feng wrote:
> This reverts commit 6d4d273588378c65915acaf7b2ee74e9dd9c130a.
> 
> bfq.limit_depth passes word_depths[] as shallow_depth down to sbitmap core
> sbitmap_get_shallow, which uses just the number to limit the scan depth of
> each bitmap word, formula:
> scan_percentage_for_each_word = shallow_depth / (1 << sbimap->shift) * 100%

Looking at sbitmap_get_shallow() again more carefully, I agree that I
misunderstood how shallow_depth argument gets used and the original code
was correct and I broke it. Thanks for spotting this!

What I didn't notice is that shallow_depth indeed gets used for each bitmap
word separately and not for bitmap as a whole. I'd say this could use some
more documentation but that's unrelated to your revert. So feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

to your patch. Thanks.

								Honza

> 
> That means the comments's percentiles 50%, 75%, 18%, 37% of bfq are correct.
> But after commit patch 'bfq: Fix computation of shallow depth', we use
> sbitmap.depth instead, as a example in following case:
> 
> sbitmap.depth = 256, map_nr = 4, shift = 6; sbitmap_word.depth = 64.
> The resulsts of computed bfqd->word_depths[] are {128, 192, 48, 96}, and
> three of the numbers exceed core dirver's 'sbitmap_word.depth=64' limit
> nothing. Do we really don't want limit depth for such workloads, or we
> just want to bump up the percentiles to 100%?
> 
> Please correct me if I miss something, thanks.
> 
> Signed-off-by: Lin Feng <linf@wangsu.com>
> ---
>  block/bfq-iosched.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 9e4eb0fc1c16..9e81d1052091 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -6332,13 +6332,13 @@ static unsigned int bfq_update_depths(struct bfq_data *bfqd,
>  	 * limit 'something'.
>  	 */
>  	/* no more than 50% of tags for async I/O */
> -	bfqd->word_depths[0][0] = max(bt->sb.depth >> 1, 1U);
> +	bfqd->word_depths[0][0] = max((1U << bt->sb.shift) >> 1, 1U);
>  	/*
>  	 * no more than 75% of tags for sync writes (25% extra tags
>  	 * w.r.t. async I/O, to prevent async I/O from starving sync
>  	 * writes)
>  	 */
> -	bfqd->word_depths[0][1] = max((bt->sb.depth * 3) >> 2, 1U);
> +	bfqd->word_depths[0][1] = max(((1U << bt->sb.shift) * 3) >> 2, 1U);
>  
>  	/*
>  	 * In-word depths in case some bfq_queue is being weight-
> @@ -6348,9 +6348,9 @@ static unsigned int bfq_update_depths(struct bfq_data *bfqd,
>  	 * shortage.
>  	 */
>  	/* no more than ~18% of tags for async I/O */
> -	bfqd->word_depths[1][0] = max((bt->sb.depth * 3) >> 4, 1U);
> +	bfqd->word_depths[1][0] = max(((1U << bt->sb.shift) * 3) >> 4, 1U);
>  	/* no more than ~37% of tags for sync writes (~20% extra tags) */
> -	bfqd->word_depths[1][1] = max((bt->sb.depth * 6) >> 4, 1U);
> +	bfqd->word_depths[1][1] = max(((1U << bt->sb.shift) * 6) >> 4, 1U);
>  
>  	for (i = 0; i < 2; i++)
>  		for (j = 0; j < 2; j++)
> -- 
> 2.25.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
