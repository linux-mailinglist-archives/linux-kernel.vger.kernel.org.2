Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E44A33D212
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 11:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236864AbhCPKoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 06:44:11 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:35174 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236775AbhCPKmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 06:42:42 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0US9MFIf_1615891358;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0US9MFIf_1615891358)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Mar 2021 18:42:39 +0800
Reply-To: xlpang@linux.alibaba.com
Subject: Re: [PATCH v3 0/4] mm/slub: Fix count_partial() problem
To:     Vlastimil Babka <vbabka@suse.cz>,
        Xunlei Pang <xlpang@linux.alibaba.com>,
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
 <793c884a-9d60-baaf-fab8-3e5f4a024124@suse.cz>
From:   Xunlei Pang <xlpang@linux.alibaba.com>
Message-ID: <1b4f7296-cd26-7177-873b-a35f5504ccfb@linux.alibaba.com>
Date:   Tue, 16 Mar 2021 18:42:38 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <793c884a-9d60-baaf-fab8-3e5f4a024124@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/21 2:49 AM, Vlastimil Babka wrote:
> On 3/9/21 4:25 PM, Xunlei Pang wrote:
>> count_partial() can hold n->list_lock spinlock for quite long, which
>> makes much trouble to the system. This series eliminate this problem.
> 
> Before I check the details, I have two high-level comments:
> 
> - patch 1 introduces some counting scheme that patch 4 then changes, could we do
> this in one step to avoid the churn?
> 
> - the series addresses the concern that spinlock is being held, but doesn't
> address the fact that counting partial per-node slabs is not nearly enough if we
> want accurate <active_objs> in /proc/slabinfo because there are also percpu
> slabs and per-cpu partial slabs, where we don't track the free objects at all.
> So after this series while the readers of /proc/slabinfo won't block the
> spinlock, they will get the same garbage data as before. So Christoph is not
> wrong to say that we can just report active_objs == num_objs and it won't
> actually break any ABI.

If maintainers don't mind this inaccuracy which I also doubt its
importance, then it becomes easy. For fear that some people who really
cares, introducing an extra config(default-off) for it would be a good
option.

> At the same time somebody might actually want accurate object statistics at the
> expense of peak performance, and it would be nice to give them such option in
> SLUB. Right now we don't provide this accuracy even with CONFIG_SLUB_STATS,
> although that option provides many additional tuning stats, with additional
> overhead.
> So my proposal would be a new config for "accurate active objects" (or just tie
> it to CONFIG_SLUB_DEBUG?) that would extend the approach of percpu counters in
> patch 4 to all alloc/free, so that it includes percpu slabs. Without this config
> enabled, let's just report active_objs == num_objs.
For percpu slabs, the numbers can be retrieved from the existing
slub_percpu_partial()->pobjects, looks no need extra work.

> 
> Vlastimil
> 
>> v1->v2:
>> - Improved changelog and variable naming for PATCH 1~2.
>> - PATCH3 adds per-cpu counter to avoid performance regression
>>   in concurrent __slab_free().
>>
>> v2->v3:
>> - Changed "page->inuse" to the safe "new.inuse", etc.
>> - Used CONFIG_SLUB_DEBUG and CONFIG_SYSFS condition for new counters.
>> - atomic_long_t -> unsigned long
>>
>> [Testing]
>> There seems might be a little performance impact under extreme
>> __slab_free() concurrent calls according to my tests.
>>
>> On my 32-cpu 2-socket physical machine:
>> Intel(R) Xeon(R) CPU E5-2650 v2 @ 2.60GHz
>>
>> 1) perf stat --null --repeat 10 -- hackbench 20 thread 20000
>>
>> == original, no patched
>> Performance counter stats for 'hackbench 20 thread 20000' (10 runs):
>>
>>       24.536050899 seconds time elapsed                                          ( +-  0.24% )
>>
>>
>> Performance counter stats for 'hackbench 20 thread 20000' (10 runs):
>>
>>       24.588049142 seconds time elapsed                                          ( +-  0.35% )
>>
>>
>> == patched with patch1~4
>> Performance counter stats for 'hackbench 20 thread 20000' (10 runs):
>>
>>       24.670892273 seconds time elapsed                                          ( +-  0.29% )
>>
>>
>> Performance counter stats for 'hackbench 20 thread 20000' (10 runs):
>>
>>       24.746755689 seconds time elapsed                                          ( +-  0.21% )
>>
>>
>> 2) perf stat --null --repeat 10 -- hackbench 32 thread 20000
>>
>> == original, no patched
>>  Performance counter stats for 'hackbench 32 thread 20000' (10 runs):
>>
>>       39.784911855 seconds time elapsed                                          ( +-  0.14% )
>>
>>  Performance counter stats for 'hackbench 32 thread 20000' (10 runs):
>>
>>       39.868687608 seconds time elapsed                                          ( +-  0.19% )
>>
>> == patched with patch1~4
>>  Performance counter stats for 'hackbench 32 thread 20000' (10 runs):
>>
>>       39.681273015 seconds time elapsed                                          ( +-  0.21% )
>>
>>  Performance counter stats for 'hackbench 32 thread 20000' (10 runs):
>>
>>       39.681238459 seconds time elapsed                                          ( +-  0.09% )
>>
>>
>> Xunlei Pang (4):
>>   mm/slub: Introduce two counters for partial objects
>>   mm/slub: Get rid of count_partial()
>>   percpu: Export per_cpu_sum()
>>   mm/slub: Use percpu partial free counter
>>
>>  include/linux/percpu-defs.h   |  10 ++++
>>  kernel/locking/percpu-rwsem.c |  10 ----
>>  mm/slab.h                     |   4 ++
>>  mm/slub.c                     | 120 +++++++++++++++++++++++++++++-------------
>>  4 files changed, 97 insertions(+), 47 deletions(-)
>>
