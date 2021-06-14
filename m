Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49ADD3A689D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 16:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbhFNODp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 10:03:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54976 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbhFNODn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 10:03:43 -0400
Date:   Mon, 14 Jun 2021 16:01:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623679299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3DT1R4sMY2Bm8waC43/W6qp1g1k6z/nnrssefIHXpts=;
        b=l/jgwy4bBanobhax+edKgJIdrMspIYO3LBw1gsyL6zm2wUjsZNdilic6SMXWTOTkeVhhDe
        u6y4/SmiHs+wQ+iHphLvqeHbzQGdY/UflX7yvxrCbEVt4E+E2gJTCmAYIXVE+dSUZFsEOk
        J38+zl9sgDY9gdqsBftWhpnMVk7J0UoOqBytPCHmorcPyFm0DD2oCBpnWa5ibMsK9k01Vv
        kjBMFtbizppkoDq20i29KNwKLG8y/fyNfgj9MVAVXIdLqsbwRF0EQYpydqwxXnt6UpCkwU
        TyV089RJon43uKDL52oCLS9pgQ8yhqrybokTn59OqmRWJK21kVL43vBRA4z0HA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623679299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3DT1R4sMY2Bm8waC43/W6qp1g1k6z/nnrssefIHXpts=;
        b=7DRKZukesw9FZsY7e3oUrBpBBFHFgoTIzeQsVbdN0CTO4DMYe8m1pG4PtXvix6ifMRiejR
        T/E6tm3gRegIWeBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [RFC v2 33/34] mm, slub: use migrate_disable() on PREEMPT_RT
Message-ID: <20210614140138.urxtrsk3jddnv57r@linutronix.de>
References: <20210609113903.1421-1-vbabka@suse.cz>
 <20210609113903.1421-34-vbabka@suse.cz>
 <c553c26f-1f9c-e5ab-b71b-b2b5eeb59ad2@suse.cz>
 <20210614111619.l3ral7tt2wasvlb4@linutronix.de>
 <390fc59e-17ed-47eb-48ff-8dae93c9a718@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <390fc59e-17ed-47eb-48ff-8dae93c9a718@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-14 13:33:43 [+0200], Vlastimil Babka wrote:
> On 6/14/21 1:16 PM, Sebastian Andrzej Siewior wrote:
> > I haven't looked at the series and I have just this tiny question: why
> > did migrate_disable() crash for Mel on !RT and why do you expect that it
> > does not happen on PREEMPT_RT?
> 
> Right, so it's because __slab_alloc() has this optimization to avoid re-reading
> 'c' in case there is no preemption enabled at all (or it's just voluntary).
> 
> #ifdef CONFIG_PREEMPTION
>         /*
>          * We may have been preempted and rescheduled on a different
>          * cpu before disabling preemption. Need to reload cpu area
>          * pointer.
>          */
>         c = slub_get_cpu_ptr(s->cpu_slab);
> #endif
> 
> Mel's config has CONFIG_PREEMPT_VOLUNTARY, which means CONFIG_PREEMPTION is not
> enabled.
> 
> But then later in ___slab_alloc() we have
> 
>         slub_put_cpu_ptr(s->cpu_slab);
>         page = new_slab(s, gfpflags, node);
>         c = slub_get_cpu_ptr(s->cpu_slab);
> 
> And this is not hidden under CONFIG_PREEMPTION, so with the #ifdef bug the
> slub_put_cpu_ptr did a migrate_enable() with Mel's config, without prior
> migrate_disable().

Ach, right. The update to this field is done with cmpxchg-double (if I
remember correctly) but I don't remember if this is also re-entry safe. 

> If there wasn't the #ifdef PREEMPT_RT bug:
> - this slub_put_cpu_ptr() would translate to put_cpu_ptr() thus
> preempt_enable(), which on this config is just a barrier(), so it doesn't matter
> that there was no matching preempt_disable() before.
> - with PREEMPT_RT the CONFIG_PREEMPTION would be enabled, so the
> slub_get_cpu_ptr() would do a migrate_disable() and there's no imbalance.
> 
> But now that I dig into this in detail, I can see there might be another
> instance of this imbalance bug, if CONFIG_PREEMPTION is disabled, but
> CONFIG_PREEMPT_COUNT is enabled, which seems to be possible in some debug
> scenarios. Because then preempt_disable()/preempt_enable() still manipulate the
> preempt counter and compiling them out in __slab_alloc() will cause imbalance.
> 
> So I think the guards in __slab_alloc() should be using CONFIG_PREEMPT_COUNT
> instead of CONFIG_PREEMPT to be correct on all configs. I dare not remove them
> completely :)

:)

Sebastian
