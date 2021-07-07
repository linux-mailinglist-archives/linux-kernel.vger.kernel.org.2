Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80CF03BE14A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 05:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhGGDM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 23:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbhGGDMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 23:12:54 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F93CC061574
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 20:10:15 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y2so273119plc.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 20:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=p4IMlRkU0d9zAu6JAs/50Bj1mvwAUYLzkHODMBHeZeA=;
        b=txj8Ka5IB4OCqCVbhkb0lfgEuEHvlqL9svPMHI2s21Qld1AxRGUIMN9RUBsK+NFaSk
         3eNyYbMtWSrNtzAH5YG0Zt+lBCp3bRqloAoKYIDvx88q1EpsTTgf4Zi1Fg/wxoD484m5
         PWkcg7ooVQ1dJdYjYQ5yMkxgfz4NYwpxbJj741cbxWCfbm1bips49f4plk1ICXUZv5y4
         hHBEQijL6XsOhHFhItRLmGxwbwe6qHJ1WjYosxcNdGYmDIBQN3u7OP0Nwq07guJXu5gk
         a1DwrD3C+9C/f9fBJ6ja0Qb1UtAzypjq4nTDHIvCizHZ4AhJ3w18UJ5opY1wxtv0qc4+
         GtIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=p4IMlRkU0d9zAu6JAs/50Bj1mvwAUYLzkHODMBHeZeA=;
        b=llOVS0BZgMk/nm/qAAYYIbT7PeSoY0c0tLqDzWSN0Nhv9dKlaF0atsC6J0ccmF2cf5
         eOSS49mN1yFB03M7+6T7BVHFCl/HkEPxZQR5OsAK7zp06OtfaQFXLh8ZzeaY+WMBud43
         RrNdEowfjIK2wro2hFAMV4Y/D+69W9EyhxHnAeeXivMzbJGYFwbfFGco3W5wskBWwKiV
         EVAP9iSa8WnPeJStdbKX8CQ4oBvkxPSpJdjVYHm59cWxX21y4FlvJ98aWR2jUaGHglTj
         Z7eWMQuDlM31H34+hqRBxcZ5TLdY2hQbcwwFyYt05IurChSmU5RQ7DCdT3J4EQJ8I3pb
         u8Xw==
X-Gm-Message-State: AOAM533nFtuYcJiAu5kEF5ilevdgQS06PzWsD+SzbEFIYdAZWNIj3m3t
        3MCVmDuJlK9h451Uq8TrLUvu7w==
X-Google-Smtp-Source: ABdhPJzOEm9/Ch/nnGnnwof7AQm+yYDZIccJoPrSOEmCeUG24JCjxDslHvIRBqIeEFAALkHzgvVLPg==
X-Received: by 2002:a17:902:c408:b029:129:3680:32f1 with SMTP id k8-20020a170902c408b0290129368032f1mr19420584plk.81.1625627414364;
        Tue, 06 Jul 2021 20:10:14 -0700 (PDT)
Received: from [10.87.61.221] ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id y8sm3906354pff.29.2021.07.06.20.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 20:10:13 -0700 (PDT)
Subject: Re: [PATCH] kretprobe scalability improvement
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mingo@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, mattwu@163.com,
        Steven Rostedt <rostedt@goodmis.org>
References: <20210703102818.20766-1-wuqiang.matt@bytedance.com>
 <20210705155948.d00db849150308b2ff662edc@kernel.org>
 <7785805e-8dd1-bc98-feb4-b722433fdea0@bytedance.com>
 <20210707012526.5b72acfac983ff13183f13cc@kernel.org>
From:   Matt Wu <wuqiang.matt@bytedance.com>
Message-ID: <fa0265aa-a1b4-e693-f270-1f9aef463b34@bytedance.com>
Date:   Wed, 7 Jul 2021 11:10:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210707012526.5b72acfac983ff13183f13cc@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/7 AM12:25, Masami Hiramatsu wrote:
> On Tue, 6 Jul 2021 09:21:00 +0800
> Matt Wu <wuqiang.matt@bytedance.com> wrote:
> 
>> On 2021/7/5 PM2:59, Masami Hiramatsu wrote:
>>> Hi,
>>>
>>> On Sat,  3 Jul 2021 18:28:18 +0800
>>> "wuqiang" <wuqiang.matt@bytedance.com> wrote:
>>>
>>>> From: wuqiang <wuqiang.matt@bytedance.com>
>>>>
>>>> The original freelist is a LIFO queue based on singly linked list, which lacks
>>>> of scalability, and thus becomes bottleneck under high workloads. freelist was
>>>> introduced by Masami Hiramatsu's work of removing kretprobe hash lock:
>>>> url: https://lkml.org/lkml/2020/8/29/209.
>>>>
>>>> Here an array-based MPMC lockless queue is proposed. The solution of bounded
>>>> array can nicely avoid ABA issue, while freelist or circular queue etc. have
>>>> to perform 2 CAS loops. The other advantage is that order and fairness can be
>>>> ignored, the only concern is to retrieve kretprobe instance records as fast
>>>> as possible, i.e. performance and correctness. Tests of kretprobe on 96-CORE
>>>> ARM64 show the biggest gain as 466.7x of the original freelist throughput.
>>>> The raw queue throughput can be 1,975 times of freelist. Here are the results:
>>>>
>>>> Ubuntu 20.04, 5.13.0-rc6 (XEON E5-2660V3 2.4G, DDR4 2133MT/s, 10 CORES/20 THREADS):
>>>>                   1x        2x        4x        8x        10x        16x        20x        32x        40x
>>>> freelist: 13086080  22493637  32773854  20129772   18455899   18435561   18980332   18988603   18991334
>>>> array   :  13144036  26059941  47449954  94517172  115856027  116414714  125692971  125553061  125685981
>>>>
>>>> Ubuntu 21.04 - 5.12.10 QEMU 96 CORES (HUAWEI TaiShan 2280V2  KP920 96 CORES 2.6G, DDR4 2944 MT/s):
>>>>                     1x          2x          4x          8x          16x          24x          48x            96x           192x
>>>> freelist: 17,233,640  10,296,664   8,095,309   6,993,545    5,050,817    4,295,283    3,382,013      2,738,050      2,743,345
>>>> array:    19,360,905  37,395,225  56,417,463  10,020,136  209,876,209  328,940,014  632,754,916  1,277,862,473  1,169,076,739
>>>
>>> Interesting result! How would you measure the overhead?
>>> And also could you clarify the real scalability example of kretprobe usage ?
>>> E.g. putting kretprobes at some function and profiling with perf. See following
>>> slides for details.
>>>
>>> https://events.static.linuxfound.org/sites/events/files/slides/Handling%20the%20Massive%20Multiple%20Kprobes%20v2_1.pdf
>>> (BTW, these efforts totally stalls a while, needs to be reviewed again)
>>
>> I did two kinds of tests: one is real kretprobe, the other is throughput
>> comparison of different queue implementations.
>>
>> 1) kretprobe upon security_file_mprotect
>>
>>      We found the performance bottleneck due to udp_recvmsg kretprobe in
>>      our production environment, then re-produced the issue with a lighter
>>      syscall: mprotect.
>>
>>      "perf stat" is used to count number of sys_enter_mprotect calligs:
>>      perf stat -a -I 10000 -e 'syscalls:sys_enter_mprotect' vmstat 1 35
>>
>>      The user mode program is just a loop of mprotect() to trigger the
>>      registered kretprobe callbacks. The codes are pushed to:
>>      https://github.com/mattwuq/kretprobe/blob/main/mprotect/
>>
>>      I measured both kprobe and kretprobe for 4.14/5.9/5.12. The results
>>      of kprobe is really good, but kretprobe doesn't scale well (even for
>>      kernel 5.12 with "kprobes: Remove kretprobe hash").
> 
> Hmm, Ok if there is a real kretprobe issue (not freelist), it should
> be solved. Could you also point this result from your changelog?

Here are the resuts:

Linux 5.8.0-45-AMD64 Ubuntu T490 (i7-10510U 1.80G & DDR4 2667)
threads	   baseline	     kprobe	 kretprobe
1p	 72,816,571	 59,411,825	34,578,853
2p	111,336,194	 91,219,319	40,303,484
3p	144,082,415	112,813,784	41,762,717
4p	142,233,213	118,947,750	33,103,895

Linux 5.12.0-AMD64 Ubuntu T490 (i7-10510U 1.80G & DDR4 2667)
threads	   baseline	     kprobe	 kretprobe
1p	 72,705,816	 59,523,413	39,391,428
2p	108,577,114	 90,913,449	48,940,956
3p	143,493,477	118,791,390	41,067,841
4p	170,406,366	139,667,883	32,398,033

The chart picture is available at:
https://github.com/mattwuq/kretprobe/tree/main/doc/kprobe_krp_perf.png

For 5.8 the kretprobe performance is limited by kretprobe hash locking. 
Then I tried 5.12 with your patch of "Remove kretprobe hash" landed. But
kretprobe still don't scale, then I digged further and found freelist is
the culprit.

>> 2) raw queue throughput benchmarks
>>
>>      I wrote a module with dedicated kernel threads performing insertions
>>      and deletions of several freelist implementations for 10ms.
>>
>>      The codes and test scripts are available at:
>>      https://github.com/mattwuq/kretprobe/blob/main/scalable/
>>
>>      1) fl.h: original freelist, LIFO queue based on singly linked list
>>      2) ra.h: read from random position, write to last read pos
>>      3) sa.h: array-based queue, per-cpu slot to be equally distributed
>>      4) saca.h: the proposed version, allocating array with L1 cache line
>>         aligned for each core
>>      5) saea.h: make every elelment cache_line aligned
>>      6) zz.h: a.k.a zigzag, remap numerical order to L1 cache distance,
>>         for 64bit pointers, 0 to 0, 1 to 8, 2 to 16
>>      7) cq.h: native circular queue, not used, can not handle reentrance
>>
>>      Two types of tests are performanced:
>>      1) throughput bench: with no delay between deletion and insertion
>>      2) emulation bench of real kretprobe: 1us delay before inserting back
>>
>>      All the results and charts are available at:
>>      https://github.com/mattwuq/kretprobe/tree/main/doc/
>>
> 
> OK, this test report is also great :)

Thanks. I will give the bpf-percpu-freelist a try this weekend.

>>>> So linear scalability is still not available, limited by the following two
>>>> considerations:
>>>>
>>>> 1. keep it simple: best solution could be an implementation of per-cpu queues,
>>>>      but it's not applicable for this case due to complexity. After all for
>>>>      most cases the number of pre-allocated kretprobe instances (maxactive) is
>>>>      only a small value. If not specified by user during registering, maxactive
>>>>      is set as CPU cores or 2x when preemption is enabled
>>>> 2. keep it compact: cache-line-alignment can solve false-sharing and minimize
>>>>      cache thrashing, but it introduces memory wasting, considering the small
>>>>      body of structure kretprobe_instance. Secondly the performance improvement
>>>>      of cache-line-aligned is not significant as expected
>>>
>>> If you really need the linear scalability, drop useless entry-handler and per
>>> instance data (or just leave the data pointer) and allocate the instance pool
>>> for each task struct. This is perfectly scalable, because kretprobe instance
>>> is only for making a shadow stack for the task, not CPU.
>>
>> Yes, per-task list of kretprobe instances would deliver best throughput.
>> But the penality could be high in memory efficency and implementations.
> 
> How much penalty it would make? If we allocate a 4kb pool for each task,
> it would be enough small compared with other resources (and we may be
> able to select the pool on-line or compile option)

Servers here (typically 96 cores) can have 2000 tasks, but the hosts
providing docker services ccould have > 5000 tasks. One task can have
several threads, likely < 2 on average. So estimated penalty could be
5000 * 2 * 4K, 39M bytes, i.e. 0.4M bytes per core.

kretprobe is not a certain thing. It's might not used at all, or a task
might only trigger once in lifetime. The proposed solutions could provide
promising results with less than 0.4M bytes memory usage per core.

>> Inspired by your idea, I'm thinking of allocating from stack:
>>
>> 1) from stack top: need modify stack top limit, might “violate” the
>>      purpose of guard page
>> 2）reserve from current stack: need modify trampolines of fltrace and
>>      kprobe, but there are many challenges.
> 
> No, I don't like this change because it will disturb the stack unwinder
> and consuming the stack itself.

got it.

>>>> With a pre-built kernel, further performance tuning can be done by increasing
>>>> maxactive when registering kretprobe. Tests show 4x cores number is a fair
>>>> choice for both performance and memory efficiency.
>>>
>>> Which test should I check? If it is also good for the current freelist,
>>> I would like to expand default maxactive. (actually, current maxactive
>>> is chosen by the minimum availability)
>>
>> I tested with difference maxactive values. For current freelist, bigger
>> maxactive values have less effects upon performance.
> 
> So bigger 'maxactive' will scale better?

Yes, I guess it can reduce cache conflicts. Later I could do a measure
of cache misses.

XEON / X86_64 (preempt=0 / cycleus=0)
		       1x	      10x	     20x
zigzag:max=10	142649937	 102381284	  87993433
freelist:max=10	 90050953	  14533279	  12234181
array:max=10	170718610	 101061189	  84507025
strided:max=10	170885073	1645070467	 471586589
zigzag:max=20	142833611	 251344437	 124256740
freelist:max=20	 83193711	  13796546	  12035244
array:max=20	157751314	 208385189	 139943284
strided:max=20	157810810	1818188777	2188112898
zigzag:max=40	154501823	 682233175	 242334634
freelist:max=40	 83284714	  13852153	  11654861
array:max=40	157817022	 361685213	 251139824
strided:max=40	158885047	1791159293	1973298443

The chart url:
https://github.com/mattwuq/kretprobe/tree/main/doc/kretprobe_maxactive.png

>> "missed cases" was also tracked. Based on testings, so long as maxactive
>> is more than cores number, there won't be "missed cases".
> 
> That depends on where you put the probe. kretprobe can be nested and
> sleepable. If you put a kretprobe on the function which doesn't yield,
> you don't need bigger maxactive. But kretprobe on the function which
> can sleep or yield, you may need more than that.

Sure, it's depends on the environment (loads & apps). So that should be
the caller's duty to specify when registering kreprobe.

>>>>
>>>> More info is available at: https://github.com/mattwuq/kretprobe
>>>>
>>>> Signed-off-by: wuqiang <wuqiang.matt@bytedance.com>
>>>> ---
>>>>    include/linux/freelist.h | 187 +++++++++++++++++++--------------------
>>>>    kernel/kprobes.c         |  29 +++---
>>>>    2 files changed, 107 insertions(+), 109 deletions(-)
>>>>
>>>> diff --git a/include/linux/freelist.h b/include/linux/freelist.h
>>>> index fc1842b96469..3d4a0bc425b2 100644
>>>> --- a/include/linux/freelist.h
>>>> +++ b/include/linux/freelist.h
>>>> @@ -1,129 +1,122 @@
>>>> -/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
>>>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>>>
>>> Please do NOT change the license without the agreement of all copyright holders.
>>> Or, add a new file and remove the current freelist.h.
> 
> What about this?

Ok, it's fine to me. Actually it's a totally rewrite of freelist.h. I'll
change it back in next version.

Thanks.

>>>
>>>>    #ifndef FREELIST_H
>>>>    #define FREELIST_H
>>>>    
>>>> +#include <linux/slab.h>
>>>>    #include <linux/atomic.h>
>>>>    
>>>>    /*
>>>> - * Copyright: cameron@moodycamel.com
>>>> + * lockless queue for kretprobe instances
>>>>     *
>>>> - * A simple CAS-based lock-free free list. Not the fastest thing in the world
>>>> - * under heavy contention, but simple and correct (assuming nodes are never
>>>> - * freed until after the free list is destroyed), and fairly speedy under low
>>>> - * contention.
>>>> - *
>>>> - * Adapted from: https://moodycamel.com/blog/2014/solving-the-aba-problem-for-lock-free-free-lists
>>>> + * It's an array-based MPMC lockless queue, solely for better scalability
>>>> + * and contention mitigation. It's simple in implementation and compact in
>>>> + * memory efficiency. The only concern is to retrieve kretprobe instance
>>>> + * records as fast as possible, with both order and fairness ignored.
>>>>     */
>>>>    
>>>>    struct freelist_node {
>>>> -	atomic_t		refs;
>>>> -	struct freelist_node	*next;
>>>> +	struct freelist_node    *next;
>>>>    };
>>>> -
>>>>    struct freelist_head {
>>>> -	struct freelist_node	*head;
>>>> +	uint32_t                fh_size;	/* rounded to power of 2 */
>>>> +	uint32_t                fh_mask;	/* (fh_size - 1) */
>>>> +	uint16_t                fh_bits;	/* log2(fh_size) */
>>>> +	uint16_t                fh_step;	/* per-core shift stride */
>>>> +	uint32_t                fh_used;	/* num of elements in list */
>>>> +	struct freelist_node  **fh_ents;	/* array for krp instances */
>>>>    };
>>>>    
>>>> -#define REFS_ON_FREELIST 0x80000000
>>>> -#define REFS_MASK	 0x7FFFFFFF
>>>> +static inline int freelist_init(struct freelist_head *list, int max)
>>>> +{
>>>> +	uint32_t size, cores = num_possible_cpus();
>>>> +
>>>> +	list->fh_used = 0;
>>>> +	list->fh_step = ilog2(L1_CACHE_BYTES / sizeof(void *));
>>>> +	if (max < (cores << list->fh_step))
>>>> +		list->fh_size = roundup_pow_of_two(cores) << list->fh_step;
>>>> +	else
>>>> +		list->fh_size = roundup_pow_of_two(max);
>>>> +	list->fh_mask = list->fh_size - 1;
>>>> +	list->fh_bits = (uint16_t)ilog2(list->fh_size);
>>>> +	size = list->fh_size * sizeof(struct freelist_node *);
>>>> +	list->fh_ents = kzalloc(size, GFP_KERNEL);
>>>> +	if (!list->fh_ents)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	return 0;
>>>> +}
>>>>    
>>>> -static inline void __freelist_add(struct freelist_node *node, struct freelist_head *list)
>>>> +static inline int freelist_try_add(struct freelist_node *node, struct freelist_head *list)
>>>>    {
>>>> -	/*
>>>> -	 * Since the refcount is zero, and nobody can increase it once it's
>>>> -	 * zero (except us, and we run only one copy of this method per node at
>>>> -	 * a time, i.e. the single thread case), then we know we can safely
>>>> -	 * change the next pointer of the node; however, once the refcount is
>>>> -	 * back above zero, then other threads could increase it (happens under
>>>> -	 * heavy contention, when the refcount goes to zero in between a load
>>>> -	 * and a refcount increment of a node in try_get, then back up to
>>>> -	 * something non-zero, then the refcount increment is done by the other
>>>> -	 * thread) -- so if the CAS to add the node to the actual list fails,
>>>> -	 * decrese the refcount and leave the add operation to the next thread
>>>> -	 * who puts the refcount back to zero (which could be us, hence the
>>>> -	 * loop).
>>>> -	 */
>>>> -	struct freelist_node *head = READ_ONCE(list->head);
>>>> -
>>>> -	for (;;) {
>>>> -		WRITE_ONCE(node->next, head);
>>>> -		atomic_set_release(&node->refs, 1);
>>>> -
>>>> -		if (!try_cmpxchg_release(&list->head, &head, node)) {
>>>> -			/*
>>>> -			 * Hmm, the add failed, but we can only try again when
>>>> -			 * the refcount goes back to zero.
>>>> -			 */
>>>> -			if (atomic_fetch_add_release(REFS_ON_FREELIST - 1, &node->refs) == 1)
>>>> -				continue;
>>>> +	uint32_t i, hint = list->fh_used << list->fh_step;
>>>> +
>>>> +	for (i = 0; i < list->fh_size; i++) {
>>>> +		struct freelist_node *item = NULL;
>>>> +		uint32_t slot = (i + hint) & list->fh_mask;
>>>> +		if (try_cmpxchg_release(&list->fh_ents[slot], &item, node)) {
>>>> +			list->fh_used++;
>>>> +			break;
>>>>    		}
>>>> -		return;
>>>>    	}
>>>> +
>>>> +	return (i >= list->fh_size);
>>>>    }
>>>>    
>>>> -static inline void freelist_add(struct freelist_node *node, struct freelist_head *list)
>>>> +static inline int freelist_add(struct freelist_node *node, struct freelist_head *list)
>>>>    {
>>>> -	/*
>>>> -	 * We know that the should-be-on-freelist bit is 0 at this point, so
>>>> -	 * it's safe to set it using a fetch_add.
>>>> -	 */
>>>> -	if (!atomic_fetch_add_release(REFS_ON_FREELIST, &node->refs)) {
>>>> -		/*
>>>> -		 * Oh look! We were the last ones referencing this node, and we
>>>> -		 * know we want to add it to the free list, so let's do it!
>>>> -		 */
>>>> -		__freelist_add(node, list);
>>>> -	}
>>>> +	uint32_t hint = raw_smp_processor_id() << list->fh_step;
>>>> +	uint32_t slot = ((uint32_t) hint) & list->fh_mask;
>>>> +
>>>> +	do {
>>>> +		struct freelist_node *item = NULL;
>>>> +		if (try_cmpxchg_release(&list->fh_ents[slot], &item, node))
>>>> +			return 0;
>>>> +		slot = (slot + 1) & list->fh_mask;
>>>> +	} while (1);
>>>> +
>>>> +	return -1;
>>>>    }
>>>>    
>>>>    static inline struct freelist_node *freelist_try_get(struct freelist_head *list)
>>>>    {
>>>> -	struct freelist_node *prev, *next, *head = smp_load_acquire(&list->head);
>>>> -	unsigned int refs;
>>>> -
>>>> -	while (head) {
>>>> -		prev = head;
>>>> -		refs = atomic_read(&head->refs);
>>>> -		if ((refs & REFS_MASK) == 0 ||
>>>> -		    !atomic_try_cmpxchg_acquire(&head->refs, &refs, refs+1)) {
>>>> -			head = smp_load_acquire(&list->head);
>>>> -			continue;
>>>> +	struct freelist_node *node = NULL;
>>>> +	uint32_t i, hint = raw_smp_processor_id() << list->fh_step;
>>>> +
>>>> +	for (i = 0; i < list->fh_size; i++) {
>>>> +		uint32_t slot = (hint + i) & list->fh_mask;
>>>> +		struct freelist_node *item = smp_load_acquire(&list->fh_ents[slot]);
>>>> +		if (item && try_cmpxchg_release(&list->fh_ents[slot], &item, NULL)) {
>>>> +			node = item;
>>>> +			break;
>>>>    		}
>>>> +	}
>>>>    
>>>> -		/*
>>>> -		 * Good, reference count has been incremented (it wasn't at
>>>> -		 * zero), which means we can read the next and not worry about
>>>> -		 * it changing between now and the time we do the CAS.
>>>> -		 */
>>>> -		next = READ_ONCE(head->next);
>>>> -		if (try_cmpxchg_acquire(&list->head, &head, next)) {
>>>> -			/*
>>>> -			 * Yay, got the node. This means it was on the list,
>>>> -			 * which means should-be-on-freelist must be false no
>>>> -			 * matter the refcount (because nobody else knows it's
>>>> -			 * been taken off yet, it can't have been put back on).
>>>> -			 */
>>>> -			WARN_ON_ONCE(atomic_read(&head->refs) & REFS_ON_FREELIST);
>>>> -
>>>> -			/*
>>>> -			 * Decrease refcount twice, once for our ref, and once
>>>> -			 * for the list's ref.
>>>> -			 */
>>>> -			atomic_fetch_add(-2, &head->refs);
>>>> -
>>>> -			return head;
>>>> -		}
>>>> +	return node;
>>>> +}
>>>>    
>>>> -		/*
>>>> -		 * OK, the head must have changed on us, but we still need to decrement
>>>> -		 * the refcount we increased.
>>>> -		 */
>>>> -		refs = atomic_fetch_add(-1, &prev->refs);
>>>> -		if (refs == REFS_ON_FREELIST + 1)
>>>> -			__freelist_add(prev, list);
>>>> +static inline void freelist_destroy(struct freelist_head *list, void *context,
>>>> +                                    int (*release)(void *, void *))
>>>> +{
>>>> +	uint32_t i;
>>>> +
>>>> +	if (!list->fh_ents)
>>>> +		return;
>>>> +
>>>> +	for (i = 0; i < list->fh_size; i++) {
>>>> +		uint32_t slot = i & list->fh_mask;
>>>> +		struct freelist_node *item = smp_load_acquire(&list->fh_ents[slot]);
>>>> +		while (item) {
>>>> +			if (try_cmpxchg_release(&list->fh_ents[slot], &item, NULL)) {
>>>> +				if (release)
>>>> +					release(context, item);
>>>> +				break;
>>>> +			}
>>>> +		}
>>>>    	}
>>>>    
>>>> -	return NULL;
>>>> +	if (list->fh_ents) {
>>>> +		kfree(list->fh_ents);
>>>> +		list->fh_ents = NULL;
>>>> +	}
>>>>    }
>>>> -
>>>>    #endif /* FREELIST_H */
>>>> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
>>>> index 471b1d18a92f..5c41bee25983 100644
>>>> --- a/kernel/kprobes.c
>>>> +++ b/kernel/kprobes.c
>>>> @@ -1277,20 +1277,21 @@ void kprobe_flush_task(struct task_struct *tk)
>>>>    }
>>>>    NOKPROBE_SYMBOL(kprobe_flush_task);
>>>>    
>>>> -static inline void free_rp_inst(struct kretprobe *rp)
>>>> +static int release_ri(void *context, void *node)
>>>>    {
>>>>    	struct kretprobe_instance *ri;
>>>> -	struct freelist_node *node;
>>>> -	int count = 0;
>>>> +	ri = container_of(node, struct kretprobe_instance, freelist);
>>>> +	kfree(ri);
>>>> +	if (context)
>>>> +		(*((int *)context))++;
>>>> +	return 0;
>>>> +}
>>>>    
>>>> -	node = rp->freelist.head;
>>>> -	while (node) {
>>>> -		ri = container_of(node, struct kretprobe_instance, freelist);
>>>> -		node = node->next;
>>>> +static inline void free_rp_inst(struct kretprobe *rp)
>>>> +{
>>>> +	int count = 0;
>>>>    
>>>> -		kfree(ri);
>>>> -		count++;
>>>> -	}
>>>> +	freelist_destroy(&rp->freelist, &count, release_ri);
>>>>    
>>>>    	if (refcount_sub_and_test(count, &rp->rph->ref)) {
>>>>    		kfree(rp->rph);
>>>> @@ -2015,10 +2016,14 @@ int register_kretprobe(struct kretprobe *rp)
>>>>    		rp->maxactive = num_possible_cpus();
>>>>    #endif
>>>>    	}
>>>> -	rp->freelist.head = NULL;
>>>> +	if (freelist_init(&rp->freelist, rp->maxactive))
>>>> +		return -ENOMEM;
>>>> +
>>>>    	rp->rph = kzalloc(sizeof(struct kretprobe_holder), GFP_KERNEL);
>>>> -	if (!rp->rph)
>>>> +	if (!rp->rph) {
>>>> +		freelist_destroy(&rp->freelist, NULL, NULL);
>>>>    		return -ENOMEM;
>>>> +	}
>>>>    
>>>>    	rp->rph->rp = rp;
>>>>    	for (i = 0; i < rp->maxactive; i++) {
>>>> -- 
>>>> 2.25.1
> 
> 
