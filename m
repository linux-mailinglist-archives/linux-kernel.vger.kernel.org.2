Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67649356C04
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbhDGMZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:25:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:55706 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234902AbhDGMZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:25:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DC5F1B135;
        Wed,  7 Apr 2021 12:25:41 +0000 (UTC)
Subject: Re: [PATCH] mm: page_owner: detect page_owner recursion via
 task_struct
To:     Sergei Trofimovich <slyfox@gentoo.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
References: <20210401223010.3580480-1-slyfox@gentoo.org>
 <20210401170519.00824fbdf8ab60b720609422@linux-foundation.org>
 <20210402125039.671f1f40@sf>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <876f8349-5b64-6be5-6a97-4cf17d7abfb1@suse.cz>
Date:   Wed, 7 Apr 2021 14:25:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210402125039.671f1f40@sf>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/21 1:50 PM, Sergei Trofimovich wrote:
> On Thu, 1 Apr 2021 17:05:19 -0700
> Andrew Morton <akpm@linux-foundation.org> wrote:
> 
>> On Thu,  1 Apr 2021 23:30:10 +0100 Sergei Trofimovich <slyfox@gentoo.org> wrote:
>> 
>> > Before the change page_owner recursion was detected via fetching
>> > backtrace and inspecting it for current instruction pointer.
>> > It has a few problems:
>> > - it is slightly slow as it requires extra backtrace and a linear
>> >   stack scan of the result
>> > - it is too late to check if backtrace fetching required memory
>> >   allocation itself (ia64's unwinder requires it).
>> > 
>> > To simplify recursion tracking let's use page_owner recursion depth
>> > as a counter in 'struct task_struct'.  
>> 
>> Seems like a better approach.
>> 
>> > The change make page_owner=on work on ia64 bu avoiding infinite
>> > recursion in:
>> >   kmalloc()  
>> >   -> __set_page_owner()
>> >   -> save_stack()
>> >   -> unwind() [ia64-specific]
>> >   -> build_script()
>> >   -> kmalloc()
>> >   -> __set_page_owner() [we short-circuit here]
>> >   -> save_stack()
>> >   -> unwind() [recursion]  
>> > 
>> > ...
>> >
>> > --- a/include/linux/sched.h
>> > +++ b/include/linux/sched.h
>> > @@ -1371,6 +1371,15 @@ struct task_struct {
>> >  	struct llist_head               kretprobe_instances;
>> >  #endif
>> >  
>> > +#ifdef CONFIG_PAGE_OWNER
>> > +	/*
>> > +	 * Used by page_owner=on to detect recursion in page tracking.
>> > +	 * Is it fine to have non-atomic ops here if we ever access
>> > +	 * this variable via current->page_owner_depth?  
>> 
>> Yes, it is fine.  This part of the comment can be removed.
> 
> Cool! Will do.
> 
>> > +	 */
>> > +	unsigned int page_owner_depth;
>> > +#endif  
>> 
>> Adding to the task_struct has a cost.  But I don't expect that
>> PAGE_OWNER is commonly used in prodction builds (correct?).
> 
> Yeah, PAGE_OWNER should not be enabled for production kernels.

Note that it was converted to use a static key exactly so that it can be always
built in production kernels, and simply enabled on boot when needed. Our kernels
have it enabled.

> Not having extra memory overhead (or layout disruption) is a nice
> benefit though. I'll switch to "Unserialized, strictly 'current'" bitfield.
> 
>> > --- a/init/init_task.c
>> > +++ b/init/init_task.c
>> > @@ -213,6 +213,9 @@ struct task_struct init_task
>> >  #ifdef CONFIG_SECCOMP
>> >  	.seccomp	= { .filter_count = ATOMIC_INIT(0) },
>> >  #endif
>> > +#ifdef CONFIG_PAGE_OWNER
>> > +	.page_owner_depth	= 0,
>> > +#endif
>> >  };
>> >  EXPORT_SYMBOL(init_task);  
>> 
>> It will be initialized to zero by the compiler.  We can omit this hunk
>> entirely.
>> 
>> > --- a/mm/page_owner.c
>> > +++ b/mm/page_owner.c
>> > @@ -20,6 +20,16 @@
>> >   */
>> >  #define PAGE_OWNER_STACK_DEPTH (16)
>> >  
>> > +/*
>> > + * How many reenters we allow to page_owner.
>> > + *
>> > + * Sometimes metadata allocation tracking requires more memory to be allocated:
>> > + * - when new stack trace is saved to stack depot
>> > + * - when backtrace itself is calculated (ia64)
>> > + * Instead of falling to infinite recursion give it a chance to recover.
>> > + */
>> > +#define PAGE_OWNER_MAX_RECURSION_DEPTH (1)  
>> 
>> So this is presently a boolean.  Is there any expectation that
>> PAGE_OWNER_MAX_RECURSION_DEPTH will ever be greater than 1?  If not, we
>> could use a single bit in the task_struct.  Add it to the
>> "Unserialized, strictly 'current'" bitfields.  Could make it a 2-bit field if we want
>> to permit PAGE_OWNER_MAX_RECURSION_DEPTH=larger.
> 
> Let's settle on depth=1. depth>1 is not trivial for other reasons I don't
> completely understand.

That's fine, I don't think depth>1 would bring us much benefit anyway.

> Follow-up patch incoming.
> 

