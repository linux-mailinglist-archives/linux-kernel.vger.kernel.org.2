Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D19F390144
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 14:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbhEYMsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 08:48:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:56872 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231907AbhEYMsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 08:48:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621946831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ow7nAyPcGdke18qJEo6av0sYcdwU6XcTU/DgEkAn7yM=;
        b=FxL6ZlDtF8Wy2BqyYb/3eJSiSp6XCFeSeDaVDIVooNyPTiOzyDH4+pa/YteL8e1dl/y1vR
        kA7Ml6AJ5FUJi1O38ppB+jzJgRKzq64rKlaaBEiZOCkb/MIntldHQDji6r5jskgrbya4fN
        o/UHqWJgwQ5QofOl5M/nXlaD3fo4SMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621946831;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ow7nAyPcGdke18qJEo6av0sYcdwU6XcTU/DgEkAn7yM=;
        b=qebmyN+O+iU2R107ggiYlMVKFtXlAATSYJ60aSRZl5H8i0OUyxfI37srJ1LjZXQ3pfIi8g
        Vy4Cp9Ldag/KVIAw==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4FB68AB71;
        Tue, 25 May 2021 12:47:11 +0000 (UTC)
To:     Mel Gorman <mgorman@techsingularity.net>
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
References: <20210524233946.20352-1-vbabka@suse.cz>
 <20210524233946.20352-10-vbabka@suse.cz>
 <20210525123536.GR30378@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC 09/26] mm, slub: move disabling/enabling irqs to
 ___slab_alloc()
Message-ID: <f2e9187a-dea8-ef55-b815-9ac295b46919@suse.cz>
Date:   Tue, 25 May 2021 14:47:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210525123536.GR30378@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/21 2:35 PM, Mel Gorman wrote:
> On Tue, May 25, 2021 at 01:39:29AM +0200, Vlastimil Babka wrote:
>> Currently __slab_alloc() disables irqs around the whole ___slab_alloc().  This
>> includes cases where this is not needed, such as when the allocation ends up in
>> the page allocator and has to awkwardly enable irqs back based on gfp flags.
>> Also the whole kmem_cache_alloc_bulk() is executed with irqs disabled even when
>> it hits the __slab_alloc() slow path, and long periods with disabled interrupts
>> are undesirable.
>> 
>> As a first step towards reducing irq disabled periods, move irq handling into
>> ___slab_alloc(). Callers will instead prevent the s->cpu_slab percpu pointer
>> from becoming invalid via migrate_disable(). This does not protect against
>> access preemption, which is still done by disabled irq for most of
>> ___slab_alloc(). As the small immediate benefit, slab_out_of_memory() call from
>> ___slab_alloc() is now done with irqs enabled.
>> 
>> kmem_cache_alloc_bulk() disables irqs for its fastpath and then re-enables them
>> before calling ___slab_alloc(), which then disables them at its discretion. The
>> whole kmem_cache_alloc_bulk() operation also disables cpu migration.
>> 
>> When  ___slab_alloc() calls new_slab() to allocate a new page, re-enable
>> preemption, because new_slab() will re-enable interrupts in contexts that allow
>> blocking.
>> 
>> The patch itself will thus increase overhead a bit due to disabled migration
>> and increased disabling/enabling irqs in kmem_cache_alloc_bulk(), but that will
>> be gradually improved in the following patches.
>> 
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Why did you use migrate_disable instead of preempt_disable? There is a
> fairly large comment in include/linux/preempt.h on why migrate_disable
> is undesirable so new users are likely to be put under the microscope
> once Thomas or Peter notice it.

I understood it as while undesirable, there's nothing better for now.

> I think you are using it so that an allocation request can be preempted by
> a higher priority task but given that the code was disabling interrupts,
> there was already some preemption latency.

Yes, and the disabled interrupts will get progressively "smaller" in the series.

> However, migrate_disable
> is more expensive than preempt_disable (function call versus a simple
> increment).

That's true, I think perhaps it could be reimplemented so that on !PREEMPT_RT
and with no lockdep/preempt/whatnot debugging it could just translate to an
inline migrate_disable?

> On that basis, I'd recommend starting with preempt_disable
> and only using migrate_disable if necessary.

That's certainly possible and you're right it would be a less disruptive step.
My thinking was that on !PREEMPT_RT it's actually just preempt_disable (however
with the call overhead currently), but PREEMPT_RT would welcome the lack of
preempt disable. I'd be interested to hear RT guys opinion here.

> Bonus points for adding a comment where ___slab_alloc disables IRQs to
> clarify what is protected -- I assume it's protecting kmem_cache_cpu
> from being modified from interrupt context. If so, it's potentially a
> local_lock candidate.

Yeah that gets cleared up later :)

