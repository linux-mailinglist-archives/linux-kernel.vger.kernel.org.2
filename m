Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF20B35243D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 02:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236026AbhDBAFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 20:05:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233677AbhDBAFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 20:05:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2F4F60FED;
        Fri,  2 Apr 2021 00:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1617321920;
        bh=6DTceYIxopB6FCcqzfOkPPslBYRaOV3hFwQSWjZGRzg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pN/xBbiuAx3DN06+F4R7VfLgYVMi6hoHcURfdtJSqHT1c4Fl3nRJhPAW4cV7BNcq2
         H7iJf/vOIKAUGLliWJI0CPFbUqtrdhx6L+LIJ/mTyPbUXAvNnthFpADKeqDQBtGzeo
         fkats2jlgZJGMrM0al1pxjEaop2kEV1rxPeTWNtY=
Date:   Thu, 1 Apr 2021 17:05:19 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sergei Trofimovich <slyfox@gentoo.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH] mm: page_owner: detect page_owner recursion via
 task_struct
Message-Id: <20210401170519.00824fbdf8ab60b720609422@linux-foundation.org>
In-Reply-To: <20210401223010.3580480-1-slyfox@gentoo.org>
References: <20210401223010.3580480-1-slyfox@gentoo.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  1 Apr 2021 23:30:10 +0100 Sergei Trofimovich <slyfox@gentoo.org> wrote:

> Before the change page_owner recursion was detected via fetching
> backtrace and inspecting it for current instruction pointer.
> It has a few problems:
> - it is slightly slow as it requires extra backtrace and a linear
>   stack scan of the result
> - it is too late to check if backtrace fetching required memory
>   allocation itself (ia64's unwinder requires it).
> 
> To simplify recursion tracking let's use page_owner recursion depth
> as a counter in 'struct task_struct'.

Seems like a better approach.

> The change make page_owner=on work on ia64 bu avoiding infinite
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
> ...
>
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1371,6 +1371,15 @@ struct task_struct {
>  	struct llist_head               kretprobe_instances;
>  #endif
>  
> +#ifdef CONFIG_PAGE_OWNER
> +	/*
> +	 * Used by page_owner=on to detect recursion in page tracking.
> +	 * Is it fine to have non-atomic ops here if we ever access
> +	 * this variable via current->page_owner_depth?

Yes, it is fine.  This part of the comment can be removed.

> +	 */
> +	unsigned int page_owner_depth;
> +#endif

Adding to the task_struct has a cost.  But I don't expect that
PAGE_OWNER is commonly used in prodction builds (correct?).

> --- a/init/init_task.c
> +++ b/init/init_task.c
> @@ -213,6 +213,9 @@ struct task_struct init_task
>  #ifdef CONFIG_SECCOMP
>  	.seccomp	= { .filter_count = ATOMIC_INIT(0) },
>  #endif
> +#ifdef CONFIG_PAGE_OWNER
> +	.page_owner_depth	= 0,
> +#endif
>  };
>  EXPORT_SYMBOL(init_task);

It will be initialized to zero by the compiler.  We can omit this hunk
entirely.

> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -20,6 +20,16 @@
>   */
>  #define PAGE_OWNER_STACK_DEPTH (16)
>  
> +/*
> + * How many reenters we allow to page_owner.
> + *
> + * Sometimes metadata allocation tracking requires more memory to be allocated:
> + * - when new stack trace is saved to stack depot
> + * - when backtrace itself is calculated (ia64)
> + * Instead of falling to infinite recursion give it a chance to recover.
> + */
> +#define PAGE_OWNER_MAX_RECURSION_DEPTH (1)

So this is presently a boolean.  Is there any expectation that
PAGE_OWNER_MAX_RECURSION_DEPTH will ever be greater than 1?  If not, we
could use a single bit in the task_struct.  Add it to the
"Unserialized, strictly 'current'" bitfields.  Could make it a 2-bit field if we want
to permit PAGE_OWNER_MAX_RECURSION_DEPTH=larger.


