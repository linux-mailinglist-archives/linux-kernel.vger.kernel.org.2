Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCFAC3C5616
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 12:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351854AbhGLIOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 04:14:32 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46094 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245434AbhGLH2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 03:28:07 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8637E220C2;
        Mon, 12 Jul 2021 07:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626074717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PBvDy4L3seQw19FwrXm13YabUGGme0LRoRLxPiz3JrU=;
        b=PftOOU9p+MK7AedePz5ObIeCy4vn+NDoUQKTThhbK53xJtxP4eR7XPLR69BwM9sSSsZgpL
        VteQ6BbiD+cmVtOtPZ485Anq1f0TDt8g+1uBB+Z8eR+5NXKGgGQST7rKfXqaJ6f+FVvMQ8
        quFtyX0zQWxxmQXJwO41I4nDlyBMJhU=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 55CB6A3CCB;
        Mon, 12 Jul 2021 07:25:17 +0000 (UTC)
Date:   Mon, 12 Jul 2021 09:25:16 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, vbabka@suse.cz,
        axboe@kernel.dk, iamjoonsoo.kim@lge.com, alexs@kernel.org,
        apopple@nvidia.com, willy@infradead.org, minchan@kernel.org,
        david@redhat.com, shli@fb.com, hillf.zj@alibaba-inc.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] mm/vmscan: remove unneeded return value of
 kswapd_run()
Message-ID: <YOvuXDc0LrCE+Xk/@dhcp22.suse.cz>
References: <20210710100329.49174-1-linmiaohe@huawei.com>
 <20210710100329.49174-4-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210710100329.49174-4-linmiaohe@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 10-07-21 18:03:27, Miaohe Lin wrote:
> The return value of kswapd_run() is unused now. Clean it up.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/swap.h | 2 +-
>  mm/vmscan.c          | 7 ++-----
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 6f5a43251593..717e6e500929 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -408,7 +408,7 @@ static inline bool node_reclaim_enabled(void)
>  
>  extern void check_move_unevictable_pages(struct pagevec *pvec);
>  
> -extern int kswapd_run(int nid);
> +extern void kswapd_run(int nid);
>  extern void kswapd_stop(int nid);
>  
>  #ifdef CONFIG_SWAP
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index fbe53e60b248..c580bef6b885 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4284,23 +4284,20 @@ unsigned long shrink_all_memory(unsigned long nr_to_reclaim)
>   * This kswapd start function will be called by init and node-hot-add.
>   * On node-hot-add, kswapd will moved to proper cpus if cpus are hot-added.
>   */
> -int kswapd_run(int nid)
> +void kswapd_run(int nid)
>  {
>  	pg_data_t *pgdat = NODE_DATA(nid);
> -	int ret = 0;
>  
>  	if (pgdat->kswapd)
> -		return 0;
> +		return;
>  
>  	pgdat->kswapd = kthread_run(kswapd, pgdat, "kswapd%d", nid);
>  	if (IS_ERR(pgdat->kswapd)) {
>  		/* failure at boot is fatal */
>  		BUG_ON(system_state < SYSTEM_RUNNING);
>  		pr_err("Failed to start kswapd on node %d\n", nid);
> -		ret = PTR_ERR(pgdat->kswapd);
>  		pgdat->kswapd = NULL;
>  	}
> -	return ret;
>  }
>  
>  /*
> -- 
> 2.23.0

-- 
Michal Hocko
SUSE Labs
