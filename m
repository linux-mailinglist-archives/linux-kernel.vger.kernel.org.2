Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9610C33F854
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 19:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbhCQSqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 14:46:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:45084 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232777AbhCQSpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 14:45:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B81EAABD7;
        Wed, 17 Mar 2021 18:45:50 +0000 (UTC)
To:     Xunlei Pang <xlpang@linux.alibaba.com>,
        Christoph Lameter <cl@linux.com>,
        Christoph Lameter <cl@gentwo.de>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shu Ming <sming56@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Wen Yang <wenyang@linux.alibaba.com>,
        James Wang <jnwang@linux.alibaba.com>
References: <1615967692-80524-1-git-send-email-xlpang@linux.alibaba.com>
 <1615967692-80524-2-git-send-email-xlpang@linux.alibaba.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4 1/3] mm/slub: Introduce two counters for partial
 objects
Message-ID: <322e2b18-e529-3004-c19a-8c4a3b97c532@suse.cz>
Date:   Wed, 17 Mar 2021 19:45:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <1615967692-80524-2-git-send-email-xlpang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/21 8:54 AM, Xunlei Pang wrote:
> The node list_lock in count_partial() spends long time iterating
> in case of large amount of partial page lists, which can cause
> thunder herd effect to the list_lock contention.
> 
> We have HSF RT(High-speed Service Framework Response-Time) monitors,
> the RT figures fluctuated randomly, then we deployed a tool detecting
> "irq off" and "preempt off" to dump the culprit's calltrace, capturing
> the list_lock cost nearly 100ms with irq off issued by "ss", this also
> caused network timeouts.
> 
> This patch introduces two counters to maintain the actual number
> of partial objects dynamically instead of iterating the partial
> page lists with list_lock held.
> 
> New counters of kmem_cache_node: partial_free_objs, partial_total_objs.
> The main operations are under list_lock in slow path, its performance
> impact is expected to be minimal except the __slab_free() path.
> 
> The only concern of introducing partial counter is that partial_free_objs
> may cause cacheline contention and false sharing issues in case of same
> SLUB concurrent __slab_free(), so define it to be a percpu counter and
> places it carefully.

Hm I wonder, is it possible that this will eventually overflow/underflow the
counter on some CPU? (I guess practially only on 32bit). Maybe the operations
that are already done under n->list_lock should flush the percpu counter to a
shared counter?

...

> @@ -3039,6 +3066,13 @@ static void __slab_free(struct kmem_cache *s, struct page *page,
>  		head, new.counters,
>  		"__slab_free"));
>  
> +	if (!was_frozen && prior) {
> +		if (n)
> +			__update_partial_free(n, cnt);
> +		else
> +			__update_partial_free(get_node(s, page_to_nid(page)), cnt);
> +	}

I would guess this is the part that makes your measurements notice that
(although tiny) difference. We didn't need to obtain the node pointer before and
now we do. And that is really done just for the per-node breakdown in "objects"
and "objects_partial" files under /sys/kernel/slab - distinguishing nodes is not
needed for /proc/slabinfo. So that kinda justifies putting this under a new
CONFIG as you did. Although perhaps somebody interested in these kind of stats
would enable CONFIG_SLUB_STATS anyway, so that's still an option to use instead
of introducing a new oddly specific CONFIG? At least until somebody comes up and
presents an use case where they want the per-node breakdowns in /sys but cannot
afford CONFIG_SLUB_STATS.

But I'm also still thinking about simply counting all free objects (for the
purposes of accurate <active_objs> in /proc/slabinfo) as a percpu variable in
struct kmem_cache itself. That would basically put this_cpu_add() in all the
fast paths, but AFAICS thanks to the segment register it doesn't mean disabling
interrupts nor a LOCK operation, so maybe it wouldn't be that bad? And it
shouldn't need to deal with these node pointers. So maybe that would be
acceptable for CONFIG_SLUB_DEBUG? Guess I'll have to try...

