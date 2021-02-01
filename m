Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F23830A835
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 14:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbhBANC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 08:02:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:52432 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231407AbhBANCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 08:02:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E188EAC45;
        Mon,  1 Feb 2021 13:02:12 +0000 (UTC)
Subject: Re: [PATCH] mm: workingset: clarify eviction order and distance
 calculation
To:     Oscar Salvador <osalvador@suse.de>, akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210201060651.3781-1-osalvador@suse.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <90fd6f25-cefe-34ab-de33-616e8d4dd6f0@suse.cz>
Date:   Mon, 1 Feb 2021 14:02:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210201060651.3781-1-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/21 7:06 AM, Oscar Salvador wrote:
> The premise of the refault distance is that it can be seen as a deficit
> of the inactive list space, so that if the inactive list would have had
> (R - E) more slots, the page would not have been evicted but promoted
> to the active list instead.
> 
> However, the way the code is ordered right now set us to be off by one,
> so the real number of slots would be (R - E) + 1.
> I stumbled upon this when trying to understand the code and it puzzled me
> that the comments did not match what the code did.
> 
> This it not an issue at all since evictions and refaults tend to happen
> in a number large enough that being off-by-one does not have any impact
> - and since the compiler and CPUs are free to rearrange the execution
> sequence anyway.
> But as Johannes says, it is better to re-arrange the code in the proper
> order since otherwise would be misleading to somebody who is actively
> reading and trying to understand the logic of the code - like it
> happened to me.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/workingset.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/workingset.c b/mm/workingset.c
> index 10e96de945b3..0201aa1ff320 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -263,10 +263,10 @@ void *workingset_eviction(struct page *page, struct mem_cgroup *target_memcg)
>  	VM_BUG_ON_PAGE(!PageLocked(page), page);
>  
>  	lruvec = mem_cgroup_lruvec(target_memcg, pgdat);
> -	workingset_age_nonresident(lruvec, thp_nr_pages(page));
>  	/* XXX: target_memcg can be NULL, go through lruvec */
>  	memcgid = mem_cgroup_id(lruvec_memcg(lruvec));
>  	eviction = atomic_long_read(&lruvec->nonresident_age);
> +	workingset_age_nonresident(lruvec, thp_nr_pages(page));
>  	return pack_shadow(memcgid, pgdat, eviction, PageWorkingset(page));
>  }
>  
> 

