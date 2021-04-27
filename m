Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B52136C070
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 09:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbhD0HyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 03:54:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:42528 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230062AbhD0HyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 03:54:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619510019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KnRuIjNauYv+n59UfyiM6hQaRIw+vg7KJ4k1CdGuSNU=;
        b=UeG9qa8Rh09mqzLVtdctEr1ik4OVKl5f4APZ9prRrftYqWyQe/MoeKd0kV3eJpox00XdQ9
        bBWkoUg2ERcSc8yampmR1B/2WbZoDwqO4/0MsNF0OLIsm6dYHLVmIafN8HVtFDulJiTvz5
        NM6heP8S4mO7xp95kWEhVGngoLwObZA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4A8FEAFF8;
        Tue, 27 Apr 2021 07:53:39 +0000 (UTC)
Date:   Tue, 27 Apr 2021 09:53:38 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Alexander Sosna <alexander@sosna.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM casualties by enforcing memcg limits
Message-ID: <YIfDAvcjm9FKDAWP@dhcp22.suse.cz>
References: <ea6db5cc-f862-7c4b-d872-acb29c2d8193@sosna.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea6db5cc-f862-7c4b-d872-acb29c2d8193@sosna.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 26-04-21 22:04:56, Alexander Sosna wrote:
> Before this commit memory cgroup limits were not enforced during
> allocation.  If a process within a cgroup tries to allocates more
> memory than allowed, the kernel will not prevent the allocation even if
> OVERCOMMIT_NEVER is set.  Than the OOM killer is activated to kill
> processes in the corresponding cgroup.  This behavior is not to be expected
> when setting OVERCOMMIT_NEVER (vm.overcommit_memory = 2) and it is a huge
> problem for applications assuming that the kernel will deny an allocation
> if not enough memory is available, like PostgreSQL.

Memory cgroup controller is by design accounting physically allocated
memory while overcommit policy is a global control of the virtual memory
allocation. Memcg is not aware of the virtual memory commitment so it
cannot really evaluate OVERCOMMIT_NEVER heuristic.

> To prevent this a
> check is implemented to not allow a process to allocate more memory than
> limited by it's cgroup.  This means a process will not be killed while
> accessing pages but will receive errors on memory allocation as
> appropriate.  This gives programs a chance to handle memory allocation
> failures gracefully instead of being reaped.

I am afraid I have to nak this patch. It is changing a long term
semantic of a user interface which can break many existing applications.
So you would need to create a new overcommit mode which would be
explicitly memcg aware.

As mentioned above memcg would need to have some awareness of the
virtual memory committed for the memcg. Without that
OVERCOMMIT_NEVER_MEMCG would effectively turn into OVERCOMMIT_GUESS.
 
> Signed-off-by: Alexander Sosna <alexander@sosna.de>

Nacked-by: Michal Hocko <mhocko@suse.com>

> diff --git a/mm/util.c b/mm/util.c
> index a8bf17f18a81..c84b83c532c6 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -853,6 +853,7 @@ EXPORT_SYMBOL_GPL(vm_memory_committed);
>   *
>   * Strict overcommit modes added 2002 Feb 26 by Alan Cox.
>   * Additional code 2002 Jul 20 by Robert Love.
> + * Code to enforce memory cgroup limits added 2021 by Alexander Sosna.
>   *
>   * cap_sys_admin is 1 if the process has admin privileges, 0 otherwise.
>   *
> @@ -891,6 +892,34 @@ int __vm_enough_memory(struct mm_struct *mm, long
> pages, int cap_sys_admin)
>  		long reserve = sysctl_user_reserve_kbytes >> (PAGE_SHIFT - 10);
> 
>  		allowed -= min_t(long, mm->total_vm / 32, reserve);
> +
> +#ifdef CONFIG_MEMCG
> +		/*
> +		 * If we are in a memory cgroup we also evaluate if the cgroup
> +		 * has enough memory to allocate a new virtual mapping.
> +		 * This is how we can keep processes from exceeding their
> +		 * limits and also prevent that the OOM killer must be
> +		 * awakened.  This gives programs a chance to handle memory
> +		 * allocation failures gracefully and not being reaped.
> +		 * In the current version mem_cgroup_get_max() is used which
> +		 * allows the processes to exceeded their memory limits if
> +		 * enough SWAP is available.  If this is not intended we could
> +		 * use READ_ONCE(memcg->memory.max) instead.
> +		 *
> +		 * This code is only reached if sysctl_overcommit_memory equals
> +		 * OVERCOMMIT_NEVER, both other options are handled above.
> +		 */
> +		{
> +			struct mem_cgroup *memcg = get_mem_cgroup_from_mm(mm);
> +
> +			if (memcg) {
> +				long available = mem_cgroup_get_max(memcg)
> +						- mem_cgroup_size(memcg);
> +
> +				allowed = min_t(long, available, allowed);
> +			}
> +		}
> +#endif
>  	}
> 
>  	if (percpu_counter_read_positive(&vm_committed_as) < allowed)

-- 
Michal Hocko
SUSE Labs
