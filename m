Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90E333C621
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 19:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbhCOSuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 14:50:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:45802 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232256AbhCOSt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 14:49:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7FD47AE8F;
        Mon, 15 Mar 2021 18:49:58 +0000 (UTC)
To:     Xunlei Pang <xlpang@linux.alibaba.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shu Ming <sming56@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Wen Yang <wenyang@linux.alibaba.com>,
        James Wang <jnwang@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1615303512-35058-1-git-send-email-xlpang@linux.alibaba.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v3 0/4] mm/slub: Fix count_partial() problem
Message-ID: <793c884a-9d60-baaf-fab8-3e5f4a024124@suse.cz>
Date:   Mon, 15 Mar 2021 19:49:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <1615303512-35058-1-git-send-email-xlpang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/21 4:25 PM, Xunlei Pang wrote:
> count_partial() can hold n->list_lock spinlock for quite long, which
> makes much trouble to the system. This series eliminate this problem.

Before I check the details, I have two high-level comments:

- patch 1 introduces some counting scheme that patch 4 then changes, could we do
this in one step to avoid the churn?

- the series addresses the concern that spinlock is being held, but doesn't
address the fact that counting partial per-node slabs is not nearly enough if we
want accurate <active_objs> in /proc/slabinfo because there are also percpu
slabs and per-cpu partial slabs, where we don't track the free objects at all.
So after this series while the readers of /proc/slabinfo won't block the
spinlock, they will get the same garbage data as before. So Christoph is not
wrong to say that we can just report active_objs == num_objs and it won't
actually break any ABI.
At the same time somebody might actually want accurate object statistics at the
expense of peak performance, and it would be nice to give them such option in
SLUB. Right now we don't provide this accuracy even with CONFIG_SLUB_STATS,
although that option provides many additional tuning stats, with additional
overhead.
So my proposal would be a new config for "accurate active objects" (or just tie
it to CONFIG_SLUB_DEBUG?) that would extend the approach of percpu counters in
patch 4 to all alloc/free, so that it includes percpu slabs. Without this config
enabled, let's just report active_objs == num_objs.

Vlastimil

> v1->v2:
> - Improved changelog and variable naming for PATCH 1~2.
> - PATCH3 adds per-cpu counter to avoid performance regression
>   in concurrent __slab_free().
> 
> v2->v3:
> - Changed "page->inuse" to the safe "new.inuse", etc.
> - Used CONFIG_SLUB_DEBUG and CONFIG_SYSFS condition for new counters.
> - atomic_long_t -> unsigned long
> 
> [Testing]
> There seems might be a little performance impact under extreme
> __slab_free() concurrent calls according to my tests.
> 
> On my 32-cpu 2-socket physical machine:
> Intel(R) Xeon(R) CPU E5-2650 v2 @ 2.60GHz
> 
> 1) perf stat --null --repeat 10 -- hackbench 20 thread 20000
> 
> == original, no patched
> Performance counter stats for 'hackbench 20 thread 20000' (10 runs):
> 
>       24.536050899 seconds time elapsed                                          ( +-  0.24% )
> 
> 
> Performance counter stats for 'hackbench 20 thread 20000' (10 runs):
> 
>       24.588049142 seconds time elapsed                                          ( +-  0.35% )
> 
> 
> == patched with patch1~4
> Performance counter stats for 'hackbench 20 thread 20000' (10 runs):
> 
>       24.670892273 seconds time elapsed                                          ( +-  0.29% )
> 
> 
> Performance counter stats for 'hackbench 20 thread 20000' (10 runs):
> 
>       24.746755689 seconds time elapsed                                          ( +-  0.21% )
> 
> 
> 2) perf stat --null --repeat 10 -- hackbench 32 thread 20000
> 
> == original, no patched
>  Performance counter stats for 'hackbench 32 thread 20000' (10 runs):
> 
>       39.784911855 seconds time elapsed                                          ( +-  0.14% )
> 
>  Performance counter stats for 'hackbench 32 thread 20000' (10 runs):
> 
>       39.868687608 seconds time elapsed                                          ( +-  0.19% )
> 
> == patched with patch1~4
>  Performance counter stats for 'hackbench 32 thread 20000' (10 runs):
> 
>       39.681273015 seconds time elapsed                                          ( +-  0.21% )
> 
>  Performance counter stats for 'hackbench 32 thread 20000' (10 runs):
> 
>       39.681238459 seconds time elapsed                                          ( +-  0.09% )
> 
> 
> Xunlei Pang (4):
>   mm/slub: Introduce two counters for partial objects
>   mm/slub: Get rid of count_partial()
>   percpu: Export per_cpu_sum()
>   mm/slub: Use percpu partial free counter
> 
>  include/linux/percpu-defs.h   |  10 ++++
>  kernel/locking/percpu-rwsem.c |  10 ----
>  mm/slab.h                     |   4 ++
>  mm/slub.c                     | 120 +++++++++++++++++++++++++++++-------------
>  4 files changed, 97 insertions(+), 47 deletions(-)
> 

