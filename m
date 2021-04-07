Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC6B356C24
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352199AbhDGMcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:32:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:58164 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245181AbhDGMcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:32:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6136CB138;
        Wed,  7 Apr 2021 12:32:04 +0000 (UTC)
Subject: Re: [PATCH v2] mm: page_owner: detect page_owner recursion via
 task_struct
To:     Sergei Trofimovich <slyfox@gentoo.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
References: <20210402125039.671f1f40@sf>
 <20210402115342.1463781-1-slyfox@gentoo.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <ea7e62f1-d8a3-0ece-c373-931b85de7b5d@suse.cz>
Date:   Wed, 7 Apr 2021 14:32:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210402115342.1463781-1-slyfox@gentoo.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/21 1:53 PM, Sergei Trofimovich wrote:
> Before the change page_owner recursion was detected via fetching
> backtrace and inspecting it for current instruction pointer.
> It has a few problems:
> - it is slightly slow as it requires extra backtrace and a linear
>   stack scan of the result
> - it is too late to check if backtrace fetching required memory
>   allocation itself (ia64's unwinder requires it).
> 
> To simplify recursion tracking let's use page_owner recursion flag
> in 'struct task_struct'.
> 
> The change make page_owner=on work on ia64 by avoiding infinite
> recursion in:
>   kmalloc()
>   -> __set_page_owner()
>   -> save_stack()
>   -> unwind() [ia64-specific]
>   -> build_script()
>   -> kmalloc()
>   -> __set_page_owner() [we short-circuit here]
>   -> save_stack()
>   -> unwind() [recursion]
> 
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: Juri Lelli <juri.lelli@redhat.com>
> CC: Vincent Guittot <vincent.guittot@linaro.org>
> CC: Dietmar Eggemann <dietmar.eggemann@arm.com>
> CC: Steven Rostedt <rostedt@goodmis.org>
> CC: Ben Segall <bsegall@google.com>
> CC: Mel Gorman <mgorman@suse.de>
> CC: Daniel Bristot de Oliveira <bristot@redhat.com>
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: linux-mm@kvack.org
> Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>

Much better indeed, thanks.
Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
> Change since v1:
> - use bit from task_struct instead of a new field
> - track only one recursion depth level so far
> 
>  include/linux/sched.h |  4 ++++
>  mm/page_owner.c       | 32 ++++++++++----------------------
>  2 files changed, 14 insertions(+), 22 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index ef00bb22164c..00986450677c 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -841,6 +841,10 @@ struct task_struct {
>  	/* Stalled due to lack of memory */
>  	unsigned			in_memstall:1;
>  #endif
> +#ifdef CONFIG_PAGE_OWNER
> +	/* Used by page_owner=on to detect recursion in page tracking. */
> +	unsigned			in_page_owner:1;
> +#endif
>  
>  	unsigned long			atomic_flags; /* Flags requiring atomic access. */
>  
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index 7147fd34a948..64b2e4c6afb7 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -97,42 +97,30 @@ static inline struct page_owner *get_page_owner(struct page_ext *page_ext)
>  	return (void *)page_ext + page_owner_ops.offset;
>  }
>  
> -static inline bool check_recursive_alloc(unsigned long *entries,
> -					 unsigned int nr_entries,
> -					 unsigned long ip)
> -{
> -	unsigned int i;
> -
> -	for (i = 0; i < nr_entries; i++) {
> -		if (entries[i] == ip)
> -			return true;
> -	}
> -	return false;
> -}
> -
>  static noinline depot_stack_handle_t save_stack(gfp_t flags)
>  {
>  	unsigned long entries[PAGE_OWNER_STACK_DEPTH];
>  	depot_stack_handle_t handle;
>  	unsigned int nr_entries;
>  
> -	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 2);
> -
>  	/*
> -	 * We need to check recursion here because our request to
> -	 * stackdepot could trigger memory allocation to save new
> -	 * entry. New memory allocation would reach here and call
> -	 * stack_depot_save_entries() again if we don't catch it. There is
> -	 * still not enough memory in stackdepot so it would try to
> -	 * allocate memory again and loop forever.
> +	 * Avoid recursion.
> +	 *
> +	 * Sometimes page metadata allocation tracking requires more
> +	 * memory to be allocated:
> +	 * - when new stack trace is saved to stack depot
> +	 * - when backtrace itself is calculated (ia64)
>  	 */
> -	if (check_recursive_alloc(entries, nr_entries, _RET_IP_))
> +	if (current->in_page_owner)
>  		return dummy_handle;
> +	current->in_page_owner = 1;
>  
> +	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 2);
>  	handle = stack_depot_save(entries, nr_entries, flags);
>  	if (!handle)
>  		handle = failure_handle;
>  
> +	current->in_page_owner = 0;
>  	return handle;
>  }
>  
> 

