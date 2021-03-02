Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D223032A341
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378767AbhCBIyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 03:54:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:50750 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1377938AbhCBIpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 03:45:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614674683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZBnLGSe1gH0StLLOp+vkB66rJ3ZeBVTb8pfylvStG8Y=;
        b=U21HVWtfzGlmYBEkQ0M5CXhpoSfBCOeIsn4zdzi9ieIOlJ9hKZ5AO1iKjkv/dnGoCWGINE
        XLpR/Y8WhZ/iYDJiP71+kEkLhgUNyj8gUcUM0gt9Czm/kdQV4JZiq0zixQN4u5in+R8K3i
        KcX0zMsZU/tSkbxoKBwLeDuBQyR9RiQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 65777ABF4;
        Tue,  2 Mar 2021 08:44:43 +0000 (UTC)
Date:   Tue, 2 Mar 2021 09:44:42 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     guro@fb.com, hannes@cmpxchg.org, akpm@linux-foundation.org,
        shakeelb@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: memcontrol: fix kernel stack account
Message-ID: <YD36+i1PZX/CH1jf@dhcp22.suse.cz>
References: <20210302073733.8928-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302073733.8928-1-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 02-03-21 15:37:33, Muchun Song wrote:
> The alloc_thread_stack_node() cannot guarantee that allocated stack pages
> are in the same node when CONFIG_VMAP_STACK. Because we do not specify
> __GFP_THISNODE to __vmalloc_node_range(). Fix it by caling
> mod_lruvec_page_state() for each page one by one.

What is the actual problem you are trying to address by this patch?
991e7673859e has deliberately dropped the per page accounting. Can you
explain why that was incorrect? There surely is some imprecision
involved but does it matter and is it even observable?

> Fixes: 991e7673859e ("mm: memcontrol: account kernel stack per node")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
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
