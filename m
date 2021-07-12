Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9480F3C54DC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 12:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355088AbhGLIF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 04:05:56 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46034 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245523AbhGLH1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 03:27:15 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9F9A7220B5;
        Mon, 12 Jul 2021 07:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626074666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ga96rYfOhZ936qPkgzzgegVhNigCT8utIq+5j8Vq0uM=;
        b=rUG+yRDPioETsxv4p88tf/AJBNhWDsw/mVnSAL0wTJkn/MFg6jb7XMaoN37r7qyswt4hnl
        kJGyBuq83F2YapHXXsdtHnatJhlLv8DGqC/CkEYuU3Uc7jnJzNu/e5ehL6GIQscwh5jK5A
        wRhbKUybFMyxnavjV54qn15ncM11g0I=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1D507A52B1;
        Mon, 12 Jul 2021 07:24:26 +0000 (UTC)
Date:   Mon, 12 Jul 2021 09:24:25 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, vbabka@suse.cz,
        axboe@kernel.dk, iamjoonsoo.kim@lge.com, alexs@kernel.org,
        apopple@nvidia.com, willy@infradead.org, minchan@kernel.org,
        david@redhat.com, shli@fb.com, hillf.zj@alibaba-inc.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] mm/vmscan: remove misleading setting to sc->priority
Message-ID: <YOvuKZ4kZ/1BJ5VC@dhcp22.suse.cz>
References: <20210710100329.49174-1-linmiaohe@huawei.com>
 <20210710100329.49174-3-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210710100329.49174-3-linmiaohe@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 10-07-21 18:03:26, Miaohe Lin wrote:
> The priority field of sc is used to control how many pages we should scan
> at once while we always traverse the list to shrink the pages in these
> functions. So these settings are unneeded and misleading.

I dunno. I agree that priority is not really used as these operate on
page lists but I am not sure this is worth touching.

> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/vmscan.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 6483fe0e2065..fbe53e60b248 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1702,7 +1702,6 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
>  {
>  	struct scan_control sc = {
>  		.gfp_mask = GFP_KERNEL,
> -		.priority = DEF_PRIORITY,
>  		.may_unmap = 1,
>  	};
>  	struct reclaim_stat stat;
> @@ -2327,7 +2326,6 @@ unsigned long reclaim_pages(struct list_head *page_list)
>  	unsigned int noreclaim_flag;
>  	struct scan_control sc = {
>  		.gfp_mask = GFP_KERNEL,
> -		.priority = DEF_PRIORITY,
>  		.may_writepage = 1,
>  		.may_unmap = 1,
>  		.may_swap = 1,
> -- 
> 2.23.0

-- 
Michal Hocko
SUSE Labs
