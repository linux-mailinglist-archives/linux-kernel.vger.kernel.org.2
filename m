Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9483531CC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 02:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235523AbhDCAov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 20:44:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:39458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234488AbhDCAot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 20:44:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AAE4B610D0;
        Sat,  3 Apr 2021 00:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1617410687;
        bh=1Q7F1ojdeMzO59hw12eAM9A/b0MF0hsRE/tvKSlwQ4Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uqsMJJGTVvznaZh8ne4y3j21MwL5iis0hsMjX4dlPmuWPHJnQqCNlL7uFoASBRbqn
         QlFagg+S1ZA+z0o5z9SZOSagE5/8nA17EkIMqBouPf012Grth7shpsFhS5NZAjVfVP
         f1LI3TDtCqhfgslHbqPAL6lFL3gOlPrn8rLvYxPo=
Date:   Fri, 2 Apr 2021 17:44:47 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stillinux <stillinux@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        liuzhengyuan@kylinos.cn, liuyun01@kylinos.cn,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [RFC PATCH] mm/swap: fix system stuck due to infinite loop
Message-Id: <20210402174447.2abccc77cdca5cad67756d55@linux-foundation.org>
In-Reply-To: <CAKN5gChSwSs1Zy1r7iXHw7ZSKy7Nkr3NqcqJSn7z9yZPr3J2AA@mail.gmail.com>
References: <CAKN5gChSwSs1Zy1r7iXHw7ZSKy7Nkr3NqcqJSn7z9yZPr3J2AA@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Apr 2021 15:03:37 +0800 Stillinux <stillinux@gmail.com> wrote:

> In the case of high system memory and load pressure, we ran ltp test
> and found that the system was stuck, the direct memory reclaim was
> all stuck in io_schedule, the waiting request was stuck in the blk_plug
> flow of one process, and this process fell into an infinite loop.
> not do the action of brushing out the request.
> 
> The call flow of this process is swap_cluster_readahead.
> Use blk_start/finish_plug for blk_plug operation,
> flow swap_cluster_readahead->__read_swap_cache_async->swapcache_prepare.
> When swapcache_prepare return -EEXIST, it will fall into an infinite loop,
> even if cond_resched is called, but according to the schedule,
> sched_submit_work will be based on tsk->state, and will not flash out
> the blk_plug request, so will hang io, causing the overall system  hang.
> 
> For the first time involving the swap part, there is no good way to fix
> the problem from the fundamental problem. In order to solve the
> engineering situation, we chose to make swap_cluster_readahead aware of
> the memory pressure situation as soon as possible, and do io_schedule to
> flush out the blk_plug request, thereby changing the allocation flag in
> swap_readpage to GFP_NOIO , No longer do the memory reclaim of flush io.
> Although system operating normally, but not the most fundamental way.
> 

Thanks.

I'm not understanding why swapcache_prepare() repeatedly returns
-EEXIST in this situation?

And how does the switch to GFP_NOIO fix this?  Simply by avoiding
direct reclaim altogether?

> ---
>  mm/page_io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_io.c b/mm/page_io.c
> index c493ce9ebcf5..87392ffabb12 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -403,7 +403,7 @@ int swap_readpage(struct page *page, bool synchronous)
>  	}
> 
>  	ret = 0;
> -	bio = bio_alloc(GFP_KERNEL, 1);
> +	bio = bio_alloc(GFP_NOIO, 1);
>  	bio_set_dev(bio, sis->bdev);
>  	bio->bi_opf = REQ_OP_READ;
>  	bio->bi_iter.bi_sector = swap_page_sector(page);

