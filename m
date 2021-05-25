Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8C8390110
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 14:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbhEYMhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 08:37:11 -0400
Received: from outbound-smtp07.blacknight.com ([46.22.139.12]:49515 "EHLO
        outbound-smtp07.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232353AbhEYMhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 08:37:10 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp07.blacknight.com (Postfix) with ESMTPS id 36CB41C3DA2
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 13:35:39 +0100 (IST)
Received: (qmail 9730 invoked from network); 25 May 2021 12:35:38 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 25 May 2021 12:35:38 -0000
Date:   Tue, 25 May 2021 13:35:36 +0100
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
Message-ID: <20210525123536.GR30378@techsingularity.net>
References: <20210524233946.20352-1-vbabka@suse.cz>
 <20210524233946.20352-10-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210524233946.20352-10-vbabka@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 01:39:29AM +0200, Vlastimil Babka wrote:
> Currently __slab_alloc() disables irqs around the whole ___slab_alloc().  This
> includes cases where this is not needed, such as when the allocation ends up in
> the page allocator and has to awkwardly enable irqs back based on gfp flags.
> Also the whole kmem_cache_alloc_bulk() is executed with irqs disabled even when
> it hits the __slab_alloc() slow path, and long periods with disabled interrupts
> are undesirable.
> 
> As a first step towards reducing irq disabled periods, move irq handling into
> ___slab_alloc(). Callers will instead prevent the s->cpu_slab percpu pointer
> from becoming invalid via migrate_disable(). This does not protect against
> access preemption, which is still done by disabled irq for most of
> ___slab_alloc(). As the small immediate benefit, slab_out_of_memory() call from
> ___slab_alloc() is now done with irqs enabled.
> 
> kmem_cache_alloc_bulk() disables irqs for its fastpath and then re-enables them
> before calling ___slab_alloc(), which then disables them at its discretion. The
> whole kmem_cache_alloc_bulk() operation also disables cpu migration.
> 
> When  ___slab_alloc() calls new_slab() to allocate a new page, re-enable
> preemption, because new_slab() will re-enable interrupts in contexts that allow
> blocking.
> 
> The patch itself will thus increase overhead a bit due to disabled migration
> and increased disabling/enabling irqs in kmem_cache_alloc_bulk(), but that will
> be gradually improved in the following patches.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Why did you use migrate_disable instead of preempt_disable? There is a
fairly large comment in include/linux/preempt.h on why migrate_disable
is undesirable so new users are likely to be put under the microscope
once Thomas or Peter notice it.

I think you are using it so that an allocation request can be preempted by
a higher priority task but given that the code was disabling interrupts,
there was already some preemption latency. However, migrate_disable
is more expensive than preempt_disable (function call versus a simple
increment). On that basis, I'd recommend starting with preempt_disable
and only using migrate_disable if necessary.

Bonus points for adding a comment where ___slab_alloc disables IRQs to
clarify what is protected -- I assume it's protecting kmem_cache_cpu
from being modified from interrupt context. If so, it's potentially a
local_lock candidate.

-- 
Mel Gorman
SUSE Labs
