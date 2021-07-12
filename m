Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078483C562A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 12:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355358AbhGLIPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 04:15:44 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33926 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345448AbhGLH3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 03:29:52 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7B9C31FD58;
        Mon, 12 Jul 2021 07:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626074820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mrXLVKgGxcciBhrAVE82pjymkc7+kaj0uY7L/HhEPz4=;
        b=cldL1mRfnI2IiITmu8CUFzpzC6f4N4MUHBTs1zi9gsvVEU5TFyRXEuXg7i2bk7oU0LE7Zi
        kdHKcaYMvt+/CG+AUQxjKgxZuMsOSI0X/yA13/xPU6LGHmtAc0FJteHL2AAwWa1N8DBUfn
        zEn9clHDLGjUT/niCx4bxLw3jCE0Gbo=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4B7C5A4505;
        Mon, 12 Jul 2021 07:27:00 +0000 (UTC)
Date:   Mon, 12 Jul 2021 09:26:59 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, vbabka@suse.cz,
        axboe@kernel.dk, iamjoonsoo.kim@lge.com, alexs@kernel.org,
        apopple@nvidia.com, willy@infradead.org, minchan@kernel.org,
        david@redhat.com, shli@fb.com, hillf.zj@alibaba-inc.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] mm/vmscan: add 'else' to remove check_pending label
Message-ID: <YOvuw6oLGOSm8Yuj@dhcp22.suse.cz>
References: <20210710100329.49174-1-linmiaohe@huawei.com>
 <20210710100329.49174-5-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210710100329.49174-5-linmiaohe@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 10-07-21 18:03:28, Miaohe Lin wrote:
> We could add 'else' to remove the somewhat odd check_pending label to
> make code core succinct.

Yes, this makes the code easier to follow. The two modes of throttling
depending on the fs reclaim mode is more obvious now.

> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/vmscan.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index c580bef6b885..a74760c48bd8 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3428,18 +3428,14 @@ static bool throttle_direct_reclaim(gfp_t gfp_mask, struct zonelist *zonelist,
>  	 * blocked waiting on the same lock. Instead, throttle for up to a
>  	 * second before continuing.
>  	 */
> -	if (!(gfp_mask & __GFP_FS)) {
> +	if (!(gfp_mask & __GFP_FS))
>  		wait_event_interruptible_timeout(pgdat->pfmemalloc_wait,
>  			allow_direct_reclaim(pgdat), HZ);
> +	else
> +		/* Throttle until kswapd wakes the process */
> +		wait_event_killable(zone->zone_pgdat->pfmemalloc_wait,
> +			allow_direct_reclaim(pgdat));
>  
> -		goto check_pending;
> -	}
> -
> -	/* Throttle until kswapd wakes the process */
> -	wait_event_killable(zone->zone_pgdat->pfmemalloc_wait,
> -		allow_direct_reclaim(pgdat));
> -
> -check_pending:
>  	if (fatal_signal_pending(current))
>  		return true;
>  
> -- 
> 2.23.0

-- 
Michal Hocko
SUSE Labs
