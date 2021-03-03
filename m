Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2C232BCEF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447626AbhCCPEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 10:04:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:51954 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1843086AbhCCKZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:25:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614767113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0sFDgqNuAGBwdZtFGlQ6KMAz588jj5D84lNaxniNvRs=;
        b=hg77FMOHpvTO3oWdodqeuN17jinSq0WZyJsnSiMukBFGgmEK7hHBZqWuv0rjv6UJj0r3X5
        RPBO9w8QzYZxYezbpPOICA/n2UKAGOkEbqaqiwC1p/ffIyeEIGGHmBjhqjC3YcGsBDkmjB
        XGi6yay6liJiYsq/B6ejf0CVxdjxTkw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 08813AD87;
        Wed,  3 Mar 2021 10:25:13 +0000 (UTC)
Date:   Wed, 3 Mar 2021 11:25:12 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     guro@fb.com, hannes@cmpxchg.org, akpm@linux-foundation.org,
        shakeelb@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: memcontrol: fix kernel stack account
Message-ID: <YD9kCLlckn9evWuw@dhcp22.suse.cz>
References: <20210303093956.72318-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303093956.72318-1-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 03-03-21 17:39:56, Muchun Song wrote:
> For simplification 991e7673859e ("mm: memcontrol: account kernel stack
> per node") has changed the per zone vmalloc backed stack pages
> accounting to per node. By doing that we have lost a certain precision
> because those pages might live in different NUMA nodes. In the end
> NR_KERNEL_STACK_KB exported to the userspace might be over estimated on
> some nodes while underestimated on others.
> 
> This doesn't impose any real problem to correctnes of the kernel
> behavior as the counter is not used for any internal processing but it
> can cause some confusion to the userspace.

You have skipped over one part of the changelog I have proposed and that
is to provide an actual data.

> Address the problem by accounting each vmalloc backing page to its own
> node.
> 
> Fixes: 991e7673859e ("mm: memcontrol: account kernel stack per node")

Fixes tag might make somebody assume this is worth backporting but I
highly doubt so.

> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

Anyway
Acked-by: Michal Hocko <mhocko@suse.com>

as the patch is correct with one comment below

> ---
> Changelog in v2:
>  - Rework commit log suggested by Michal.
> 
>  Thanks to Michal and Shakeel for review.
> 
>  kernel/fork.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index d66cd1014211..6e2201feb524 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -379,14 +379,19 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
>  	void *stack = task_stack_page(tsk);
>  	struct vm_struct *vm = task_stack_vm_area(tsk);
>  
> +	if (vm) {
> +		int i;
>  
> -	/* All stack pages are in the same node. */
> -	if (vm)
> -		mod_lruvec_page_state(vm->pages[0], NR_KERNEL_STACK_KB,
> -				      account * (THREAD_SIZE / 1024));
> -	else
> +		BUG_ON(vm->nr_pages != THREAD_SIZE / PAGE_SIZE);

I do not think we need this BUG_ON. What kind of purpose does it serve?

> +
> +		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++)
> +			mod_lruvec_page_state(vm->pages[i], NR_KERNEL_STACK_KB,
> +					      account * (PAGE_SIZE / 1024));
> +	} else {
> +		/* All stack pages are in the same node. */
>  		mod_lruvec_kmem_state(stack, NR_KERNEL_STACK_KB,
>  				      account * (THREAD_SIZE / 1024));
> +	}
>  }
>  
>  static int memcg_charge_kernel_stack(struct task_struct *tsk)
> -- 
> 2.11.0

-- 
Michal Hocko
SUSE Labs
