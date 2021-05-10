Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0EED378665
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 13:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235938AbhEJLHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 07:07:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:32854 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232821AbhEJKqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:46:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 52563ADCE;
        Mon, 10 May 2021 10:44:54 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F158B1F2C5C; Mon, 10 May 2021 12:44:53 +0200 (CEST)
Date:   Mon, 10 May 2021 12:44:53 +0200
From:   Jan Kara <jack@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Chi Wu <wuchi.zero@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        Howard Cochran <hcochran@kernelspring.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Jens Axboe <axboe@fb.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] mm/page-writeback: Fix performance when BDI's share of
 ratio is 0.
Message-ID: <20210510104453.GE11100@quack2.suse.cz>
References: <20210428225046.16301-1-wuchi.zero@gmail.com>
 <20210509163633.ced3588cb92984c0d3835fc3@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210509163633.ced3588cb92984c0d3835fc3@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 09-05-21 16:36:33, Andrew Morton wrote:
> On Thu, 29 Apr 2021 06:50:46 +0800 Chi Wu <wuchi.zero@gmail.com> wrote:
> 
> > Fix performance when BDI's share of ratio is 0.
> > 
> > The issue is similar to commit 74d369443325 ("writeback: Fix
> > performance regression in wb_over_bg_thresh()").
> > 
> > Balance_dirty_pages and the writeback worker will also disagree on
> > whether writeback when a BDI uses BDI_CAP_STRICTLIMIT and BDI's share
> > of the thresh ratio is zero.
> > 
> > For example, A thread on cpu0 writes 32 pages and then
> > balance_dirty_pages, it will wake up background writeback and pauses
> > because wb_dirty > wb->wb_thresh = 0 (share of thresh ratio is zero).
> > A thread may runs on cpu0 again because scheduler prefers pre_cpu.
> > Then writeback worker may runs on other cpus(1,2..) which causes the
> > value of wb_stat(wb, WB_RECLAIMABLE) in wb_over_bg_thresh is 0 and does
> > not writeback and returns.
> > 
> > Thus, balance_dirty_pages keeps looping, sleeping and then waking up the
> > worker who will do nothing. It remains stuck in this state until the
> > writeback worker hit the right dirty cpu or the dirty pages expire.
> > 
> > The fix that we should get the wb_stat_sum radically when thresh is low.
> 
> (optimistically Cc's various people who might remember how this code works)

Thanks for forwarding Andrew!

> > Signed-off-by: Chi Wu <wuchi.zero@gmail.com>
> 
> Thanks.  I'll add it for some testing and hopefully someone will find
> the time to review this.

Thanks for the patch! It looks good to me, good catch! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> > ---
> >  mm/page-writeback.c | 20 ++++++++++++++++----
> >  1 file changed, 16 insertions(+), 4 deletions(-)
> > 
> > diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> > index 0062d5c57d41..bd7052295246 100644
> > --- a/mm/page-writeback.c
> > +++ b/mm/page-writeback.c
> > @@ -1945,6 +1945,8 @@ bool wb_over_bg_thresh(struct bdi_writeback *wb)
> >  	struct dirty_throttle_control * const gdtc = &gdtc_stor;
> >  	struct dirty_throttle_control * const mdtc = mdtc_valid(&mdtc_stor) ?
> >  						     &mdtc_stor : NULL;
> > +	unsigned long reclaimable;
> > +	unsigned long thresh;
> >  
> >  	/*
> >  	 * Similar to balance_dirty_pages() but ignores pages being written
> > @@ -1957,8 +1959,13 @@ bool wb_over_bg_thresh(struct bdi_writeback *wb)
> >  	if (gdtc->dirty > gdtc->bg_thresh)
> >  		return true;
> >  
> > -	if (wb_stat(wb, WB_RECLAIMABLE) >
> > -	    wb_calc_thresh(gdtc->wb, gdtc->bg_thresh))
> > +	thresh = wb_calc_thresh(gdtc->wb, gdtc->bg_thresh);
> > +	if (thresh < 2 * wb_stat_error())
> > +		reclaimable = wb_stat_sum(wb, WB_RECLAIMABLE);
> > +	else
> > +		reclaimable = wb_stat(wb, WB_RECLAIMABLE);
> > +
> > +	if (reclaimable > thresh)
> >  		return true;
> >  
> >  	if (mdtc) {
> > @@ -1972,8 +1979,13 @@ bool wb_over_bg_thresh(struct bdi_writeback *wb)
> >  		if (mdtc->dirty > mdtc->bg_thresh)
> >  			return true;
> >  
> > -		if (wb_stat(wb, WB_RECLAIMABLE) >
> > -		    wb_calc_thresh(mdtc->wb, mdtc->bg_thresh))
> > +		thresh = wb_calc_thresh(mdtc->wb, mdtc->bg_thresh);
> > +		if (thresh < 2 * wb_stat_error())
> > +			reclaimable = wb_stat_sum(wb, WB_RECLAIMABLE);
> > +		else
> > +			reclaimable = wb_stat(wb, WB_RECLAIMABLE);
> > +
> > +		if (reclaimable > thresh)
> >  			return true;
> >  	}
> >  
> > -- 
> > 2.17.1
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
