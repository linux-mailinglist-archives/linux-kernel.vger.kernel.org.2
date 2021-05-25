Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B04E3904A7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 17:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhEYPLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 11:11:43 -0400
Received: from outbound-smtp21.blacknight.com ([81.17.249.41]:55170 "EHLO
        outbound-smtp21.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229898AbhEYPLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 11:11:41 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp21.blacknight.com (Postfix) with ESMTPS id 25778CCB19
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 16:10:10 +0100 (IST)
Received: (qmail 23622 invoked from network); 25 May 2021 15:10:09 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 25 May 2021 15:10:09 -0000
Date:   Tue, 25 May 2021 16:10:08 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [RFC 09/26] mm, slub: move disabling/enabling irqs to
 ___slab_alloc()
Message-ID: <20210525151008.GV30378@techsingularity.net>
References: <20210524233946.20352-1-vbabka@suse.cz>
 <20210524233946.20352-10-vbabka@suse.cz>
 <20210525123536.GR30378@techsingularity.net>
 <f2e9187a-dea8-ef55-b815-9ac295b46919@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <f2e9187a-dea8-ef55-b815-9ac295b46919@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 02:47:10PM +0200, Vlastimil Babka wrote:
> On 5/25/21 2:35 PM, Mel Gorman wrote:
> > On Tue, May 25, 2021 at 01:39:29AM +0200, Vlastimil Babka wrote:
> >> Currently __slab_alloc() disables irqs around the whole ___slab_alloc().  This
> >> includes cases where this is not needed, such as when the allocation ends up in
> >> the page allocator and has to awkwardly enable irqs back based on gfp flags.
> >> Also the whole kmem_cache_alloc_bulk() is executed with irqs disabled even when
> >> it hits the __slab_alloc() slow path, and long periods with disabled interrupts
> >> are undesirable.
> >> 
> >> As a first step towards reducing irq disabled periods, move irq handling into
> >> ___slab_alloc(). Callers will instead prevent the s->cpu_slab percpu pointer
> >> from becoming invalid via migrate_disable(). This does not protect against
> >> access preemption, which is still done by disabled irq for most of
> >> ___slab_alloc(). As the small immediate benefit, slab_out_of_memory() call from
> >> ___slab_alloc() is now done with irqs enabled.
> >> 
> >> kmem_cache_alloc_bulk() disables irqs for its fastpath and then re-enables them
> >> before calling ___slab_alloc(), which then disables them at its discretion. The
> >> whole kmem_cache_alloc_bulk() operation also disables cpu migration.
> >> 
> >> When  ___slab_alloc() calls new_slab() to allocate a new page, re-enable
> >> preemption, because new_slab() will re-enable interrupts in contexts that allow
> >> blocking.
> >> 
> >> The patch itself will thus increase overhead a bit due to disabled migration
> >> and increased disabling/enabling irqs in kmem_cache_alloc_bulk(), but that will
> >> be gradually improved in the following patches.
> >> 
> >> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > 
> > Why did you use migrate_disable instead of preempt_disable? There is a
> > fairly large comment in include/linux/preempt.h on why migrate_disable
> > is undesirable so new users are likely to be put under the microscope
> > once Thomas or Peter notice it.
> 
> I understood it as while undesirable, there's nothing better for now.
> 

I think the "better" option is to reduce preempt_disable sections as
much as possible but you probably have limited options there. It might
be easier to justify if the sections you were protecting need to go to
sleep like what mm/highmem.c needs but that does not appear to be the case.

> > I think you are using it so that an allocation request can be preempted by
> > a higher priority task but given that the code was disabling interrupts,
> > there was already some preemption latency.
> 
> Yes, and the disabled interrupts will get progressively "smaller" in the series.
> 
> > However, migrate_disable
> > is more expensive than preempt_disable (function call versus a simple
> > increment).
> 
> That's true, I think perhaps it could be reimplemented so that on !PREEMPT_RT
> and with no lockdep/preempt/whatnot debugging it could just translate to an
> inline migrate_disable?
> 

It might be a bit too large for that.

> > On that basis, I'd recommend starting with preempt_disable
> > and only using migrate_disable if necessary.
> 
> That's certainly possible and you're right it would be a less disruptive step.
> My thinking was that on !PREEMPT_RT it's actually just preempt_disable (however
> with the call overhead currently), but PREEMPT_RT would welcome the lack of
> preempt disable. I'd be interested to hear RT guys opinion here.
> 

It does more than preempt_disable even on !PREEMPT_RT. It's only on !SMP
that it becomes inline. While it might allow a higher priority task to
preempt, PREEMPT_RT is also not the common case and I think it's better
to use the lighter-weight option for the majority of configurations.

> > Bonus points for adding a comment where ___slab_alloc disables IRQs to
> > clarify what is protected -- I assume it's protecting kmem_cache_cpu
> > from being modified from interrupt context. If so, it's potentially a
> > local_lock candidate.
> 
> Yeah that gets cleared up later :)
> 

I saw that after glancing through the rest of the series. While I didn't
spot anything major, I'd also like to hear from Peter or Thomas on whether
migrate_disable or preempt_disable would be preferred for mm/slub.c. The
preempt-rt tree does not help answer the question given that the slub
changes there are mostly about deferring some work until IRQs are enabled.

-- 
Mel Gorman
SUSE Labs
