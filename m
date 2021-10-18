Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED751431216
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 10:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhJRIZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 04:25:22 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37734 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhJRIZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 04:25:20 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CA5DA21A63;
        Mon, 18 Oct 2021 08:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634545388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n8PkorG0rCUkv4MmnAhqOK1ZEI4Jw++yy8mZkTDdcBY=;
        b=sTlb8kIYeuTgIr34wxMDBzxeP68T2Me3IN0Kqaeb8v1FEM8eSvdeVjOfUal6BmBGWiEYzi
        O5k9TSYNI+B0adYIKhT04yHrSwEjzpPEaMZexUFTxL+94zyfC4XNO0Zs3DqmesiQYcpLZs
        /Pdin1dEmKR/iAR8eBy8LoLB0/U89As=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 60490A3B84;
        Mon, 18 Oct 2021 08:23:08 +0000 (UTC)
Date:   Mon, 18 Oct 2021 10:23:07 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Huangzhaoyang <huangzhaoyang@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: skip current when memcg reclaim
Message-ID: <YW0u67o8wl3CGikP@dhcp22.suse.cz>
References: <1634278529-16983-1-git-send-email-huangzhaoyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1634278529-16983-1-git-send-email-huangzhaoyang@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 15-10-21 14:15:29, Huangzhaoyang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Sibling thread of the same process could refault the reclaimed pages
> in the same time, which would be typical in None global reclaim and
> introduce thrashing.

It is hard to understand what kind of problem you see (ideally along
with some numbers) and how the proposed patch addresses that problem

Also you are missing Signed-off-by tag (please have a look at
Documentation/process/submitting-patches.rst which is much more
comprehensive about the process).

> ---
>  mm/vmscan.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 5199b96..ebbdc37 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2841,6 +2841,11 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>  				sc->memcg_low_skipped = 1;
>  				continue;
>  			}
> +			/*
> +			 * Don't bother current when its memcg is below low
> +			 */
> +			if (get_mem_cgroup_from_mm(current->mm) == memcg)
> +				continue;

This code is executed when none of memcg in the reclaimed hierarchy
could be reclaimed. Low limit is then ignored and this change is
tweaking that behavior without any description of the effect. A very
vague note about trashing would indicate that you have something like
the following

	A (hiting hard limit)
       / \
      B   C

Both B and C low limit protected and current task associated with B. As
none of the two could be reclaimed due to soft protection yuu prefer to
reclaim from C as you do not want to reclaim from the current process as
that could reclaim current's working set. Correct?

I would be really curious about more specifics of the used hierarchy.

Thanks!

>  			memcg_memory_event(memcg, MEMCG_LOW);
>  		}
>  
> -- 
> 1.9.1

-- 
Michal Hocko
SUSE Labs
