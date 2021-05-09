Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8001E377950
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 01:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhEIXhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 19:37:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229847AbhEIXhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 19:37:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CECBE6101D;
        Sun,  9 May 2021 23:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1620603394;
        bh=J5tl0l1ZOzDBLl5UTcdkIyorm4Fg1VOsMfiBVJvNfMU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WHlknBbHJMsTjvd0Fq90zNyDfnoi03YlgHNvPfujM6TtosG5B8QrEZCdAVfL/kFYW
         2Bx9ceEKkt6/cLdyjfCdXHpFilPxJ+UDu3+IskEN8VStXNh68AsjRtK6rvsKiSKgVp
         algto3pIPDTUD5D9Z+yADE2JgXZOWr2ONnSa73WA=
Date:   Sun, 9 May 2021 16:36:33 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Chi Wu <wuchi.zero@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, tj@kernel.org,
        Howard Cochran <hcochran@kernelspring.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Jens Axboe <axboe@fb.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] mm/page-writeback: Fix performance when BDI's share of
 ratio is 0.
Message-Id: <20210509163633.ced3588cb92984c0d3835fc3@linux-foundation.org>
In-Reply-To: <20210428225046.16301-1-wuchi.zero@gmail.com>
References: <20210428225046.16301-1-wuchi.zero@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Apr 2021 06:50:46 +0800 Chi Wu <wuchi.zero@gmail.com> wrote:

> Fix performance when BDI's share of ratio is 0.
> 
> The issue is similar to commit 74d369443325 ("writeback: Fix
> performance regression in wb_over_bg_thresh()").
> 
> Balance_dirty_pages and the writeback worker will also disagree on
> whether writeback when a BDI uses BDI_CAP_STRICTLIMIT and BDI's share
> of the thresh ratio is zero.
> 
> For example, A thread on cpu0 writes 32 pages and then
> balance_dirty_pages, it will wake up background writeback and pauses
> because wb_dirty > wb->wb_thresh = 0 (share of thresh ratio is zero).
> A thread may runs on cpu0 again because scheduler prefers pre_cpu.
> Then writeback worker may runs on other cpus(1,2..) which causes the
> value of wb_stat(wb, WB_RECLAIMABLE) in wb_over_bg_thresh is 0 and does
> not writeback and returns.
> 
> Thus, balance_dirty_pages keeps looping, sleeping and then waking up the
> worker who will do nothing. It remains stuck in this state until the
> writeback worker hit the right dirty cpu or the dirty pages expire.
> 
> The fix that we should get the wb_stat_sum radically when thresh is low.

(optimistically Cc's various people who might remember how this code works)

> Signed-off-by: Chi Wu <wuchi.zero@gmail.com>

Thanks.  I'll add it for some testing and hopefully someone will find
the time to review this.

> ---
>  mm/page-writeback.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 0062d5c57d41..bd7052295246 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -1945,6 +1945,8 @@ bool wb_over_bg_thresh(struct bdi_writeback *wb)
>  	struct dirty_throttle_control * const gdtc = &gdtc_stor;
>  	struct dirty_throttle_control * const mdtc = mdtc_valid(&mdtc_stor) ?
>  						     &mdtc_stor : NULL;
> +	unsigned long reclaimable;
> +	unsigned long thresh;
>  
>  	/*
>  	 * Similar to balance_dirty_pages() but ignores pages being written
> @@ -1957,8 +1959,13 @@ bool wb_over_bg_thresh(struct bdi_writeback *wb)
>  	if (gdtc->dirty > gdtc->bg_thresh)
>  		return true;
>  
> -	if (wb_stat(wb, WB_RECLAIMABLE) >
> -	    wb_calc_thresh(gdtc->wb, gdtc->bg_thresh))
> +	thresh = wb_calc_thresh(gdtc->wb, gdtc->bg_thresh);
> +	if (thresh < 2 * wb_stat_error())
> +		reclaimable = wb_stat_sum(wb, WB_RECLAIMABLE);
> +	else
> +		reclaimable = wb_stat(wb, WB_RECLAIMABLE);
> +
> +	if (reclaimable > thresh)
>  		return true;
>  
>  	if (mdtc) {
> @@ -1972,8 +1979,13 @@ bool wb_over_bg_thresh(struct bdi_writeback *wb)
>  		if (mdtc->dirty > mdtc->bg_thresh)
>  			return true;
>  
> -		if (wb_stat(wb, WB_RECLAIMABLE) >
> -		    wb_calc_thresh(mdtc->wb, mdtc->bg_thresh))
> +		thresh = wb_calc_thresh(mdtc->wb, mdtc->bg_thresh);
> +		if (thresh < 2 * wb_stat_error())
> +			reclaimable = wb_stat_sum(wb, WB_RECLAIMABLE);
> +		else
> +			reclaimable = wb_stat(wb, WB_RECLAIMABLE);
> +
> +		if (reclaimable > thresh)
>  			return true;
>  	}
>  
> -- 
> 2.17.1
