Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC1A3BB764
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 08:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhGEHC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 03:02:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:56526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229823AbhGEHC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 03:02:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF37961351;
        Mon,  5 Jul 2021 06:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625468390;
        bh=ki5Ol/E0F5woFezZ39yLHm08zdD2LUzGXEtQlx5rDxM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jVlDugHvNNfNrUKR97G5N2cMvQ08V2q82z2Q10f4m2gyOcZVDVv/LKrCrOQMBmaj4
         /gRhsR/64ku/fhGPykEFmC0P+cvIjNWNNQ3Pv24YkeyPEK7O/wBu+tXuWSMwt0BvVD
         9tHbzos0xHg+uUObZrVAWNhwxeO1rAu+gPox7vNlwAL5Wlam1DV80qp8qXrIfrionJ
         DQnfbD7uILNMrPNQJ10AZ+gUCw4mhXcHAZYFlzUL7m76oGwvdgBNW8jRxsHo0zombU
         qwUZ4+czFsV/np7m0K9dybtCp7TAk5czOByx7+mWpXfBocF8NrzYhKF9uSvHIA8yLr
         fEQVYC4MFtJFw==
Date:   Mon, 5 Jul 2021 15:59:48 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "wuqiang.matt" <wuqiang.matt@bytedance.com>
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mingo@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, mattwu@163.com,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] kretprobe scalability improvement
Message-Id: <20210705155948.d00db849150308b2ff662edc@kernel.org>
In-Reply-To: <20210703102818.20766-1-wuqiang.matt@bytedance.com>
References: <20210703102818.20766-1-wuqiang.matt@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat,  3 Jul 2021 18:28:18 +0800
"wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:

> From: wuqiang <wuqiang.matt@bytedance.com>
> 
> The original freelist is a LIFO queue based on singly linked list, which lacks
> of scalability, and thus becomes bottleneck under high workloads. freelist was
> introduced by Masami Hiramatsu's work of removing kretprobe hash lock:
> url: https://lkml.org/lkml/2020/8/29/209.
> 
> Here an array-based MPMC lockless queue is proposed. The solution of bounded
> array can nicely avoid ABA issue, while freelist or circular queue etc. have
> to perform 2 CAS loops. The other advantage is that order and fairness can be
> ignored, the only concern is to retrieve kretprobe instance records as fast
> as possible, i.e. performance and correctness. Tests of kretprobe on 96-CORE
> ARM64 show the biggest gain as 466.7x of the original freelist throughput.
> The raw queue throughput can be 1,975 times of freelist. Here are the results:
> 
> Ubuntu 20.04, 5.13.0-rc6 (XEON E5-2660V3 2.4G, DDR4 2133MT/s, 10 CORES/20 THREADS):
>                 1x        2x        4x        8x        10x        16x        20x        32x        40x
> freelist: 13086080  22493637  32773854  20129772   18455899   18435561   18980332   18988603   18991334
> array   :  13144036  26059941  47449954  94517172  115856027  116414714  125692971  125553061  125685981
> 
> Ubuntu 21.04 - 5.12.10 QEMU 96 CORES (HUAWEI TaiShan 2280V2  KP920 96 CORES 2.6G, DDR4 2944 MT/s):
>                   1x          2x          4x          8x          16x          24x          48x            96x           192x
> freelist: 17,233,640  10,296,664   8,095,309   6,993,545    5,050,817    4,295,283    3,382,013      2,738,050      2,743,345
> array:    19,360,905  37,395,225  56,417,463  10,020,136  209,876,209  328,940,014  632,754,916  1,277,862,473  1,169,076,739

Interesting result! How would you measure the overhead?
And also could you clarify the real scalability example of kretprobe usage ?
E.g. putting kretprobes at some function and profiling with perf. See following
slides for details.

https://events.static.linuxfound.org/sites/events/files/slides/Handling%20the%20Massive%20Multiple%20Kprobes%20v2_1.pdf
(BTW, these efforts totally stalls a while, needs to be reviewed again)

> 
> So linear scalability is still not available, limited by the following two
> considerations:
> 
> 1. keep it simple: best solution could be an implementation of per-cpu queues,
>    but it's not applicable for this case due to complexity. After all for
>    most cases the number of pre-allocated kretprobe instances (maxactive) is
>    only a small value. If not specified by user during registering, maxactive
>    is set as CPU cores or 2x when preemption is enabled
> 2. keep it compact: cache-line-alignment can solve false-sharing and minimize
>    cache thrashing, but it introduces memory wasting, considering the small
>    body of structure kretprobe_instance. Secondly the performance improvement
>    of cache-line-aligned is not significant as expected

If you really need the linear scalability, drop useless entry-handler and per
instance data (or just leave the data pointer) and allocate the instance pool
for each task struct. This is perfectly scalable, because kretprobe instance
is only for making a shadow stack for the task, not CPU.

> 
> With a pre-built kernel, further performance tuning can be done by increasing
> maxactive when registering kretprobe. Tests show 4x cores number is a fair
> choice for both performance and memory efficiency.

Which test should I check? If it is also good for the current freelist,
I would like to expand default maxactive. (actually, current maxactive
is chosen by the minimum availability)

Thank you,

> 
> More info is available at: https://github.com/mattwuq/kretprobe
> 
> Signed-off-by: wuqiang <wuqiang.matt@bytedance.com>
> ---
>  include/linux/freelist.h | 187 +++++++++++++++++++--------------------
>  kernel/kprobes.c         |  29 +++---
>  2 files changed, 107 insertions(+), 109 deletions(-)
> 
> diff --git a/include/linux/freelist.h b/include/linux/freelist.h
> index fc1842b96469..3d4a0bc425b2 100644
> --- a/include/linux/freelist.h
> +++ b/include/linux/freelist.h
> @@ -1,129 +1,122 @@
> -/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
> +/* SPDX-License-Identifier: GPL-2.0-or-later */

Please do NOT change the license without the agreement of all copyright holders.
Or, add a new file and remove the current freelist.h. 

>  #ifndef FREELIST_H
>  #define FREELIST_H
>  
> +#include <linux/slab.h>
>  #include <linux/atomic.h>
>  
>  /*
> - * Copyright: cameron@moodycamel.com
> + * lockless queue for kretprobe instances
>   *
> - * A simple CAS-based lock-free free list. Not the fastest thing in the world
> - * under heavy contention, but simple and correct (assuming nodes are never
> - * freed until after the free list is destroyed), and fairly speedy under low
> - * contention.
> - *
> - * Adapted from: https://moodycamel.com/blog/2014/solving-the-aba-problem-for-lock-free-free-lists
> + * It's an array-based MPMC lockless queue, solely for better scalability
> + * and contention mitigation. It's simple in implementation and compact in
> + * memory efficiency. The only concern is to retrieve kretprobe instance
> + * records as fast as possible, with both order and fairness ignored.
>   */
>  
>  struct freelist_node {
> -	atomic_t		refs;
> -	struct freelist_node	*next;
> +	struct freelist_node    *next;
>  };
> -
>  struct freelist_head {
> -	struct freelist_node	*head;
> +	uint32_t                fh_size;	/* rounded to power of 2 */
> +	uint32_t                fh_mask;	/* (fh_size - 1) */
> +	uint16_t                fh_bits;	/* log2(fh_size) */
> +	uint16_t                fh_step;	/* per-core shift stride */
> +	uint32_t                fh_used;	/* num of elements in list */
> +	struct freelist_node  **fh_ents;	/* array for krp instances */
>  };
>  
> -#define REFS_ON_FREELIST 0x80000000
> -#define REFS_MASK	 0x7FFFFFFF
> +static inline int freelist_init(struct freelist_head *list, int max)
> +{
> +	uint32_t size, cores = num_possible_cpus();
> +
> +	list->fh_used = 0;
> +	list->fh_step = ilog2(L1_CACHE_BYTES / sizeof(void *));
> +	if (max < (cores << list->fh_step))
> +		list->fh_size = roundup_pow_of_two(cores) << list->fh_step;
> +	else
> +		list->fh_size = roundup_pow_of_two(max);
> +	list->fh_mask = list->fh_size - 1;
> +	list->fh_bits = (uint16_t)ilog2(list->fh_size);
> +	size = list->fh_size * sizeof(struct freelist_node *);
> +	list->fh_ents = kzalloc(size, GFP_KERNEL);
> +	if (!list->fh_ents)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
>  
> -static inline void __freelist_add(struct freelist_node *node, struct freelist_head *list)
> +static inline int freelist_try_add(struct freelist_node *node, struct freelist_head *list)
>  {
> -	/*
> -	 * Since the refcount is zero, and nobody can increase it once it's
> -	 * zero (except us, and we run only one copy of this method per node at
> -	 * a time, i.e. the single thread case), then we know we can safely
> -	 * change the next pointer of the node; however, once the refcount is
> -	 * back above zero, then other threads could increase it (happens under
> -	 * heavy contention, when the refcount goes to zero in between a load
> -	 * and a refcount increment of a node in try_get, then back up to
> -	 * something non-zero, then the refcount increment is done by the other
> -	 * thread) -- so if the CAS to add the node to the actual list fails,
> -	 * decrese the refcount and leave the add operation to the next thread
> -	 * who puts the refcount back to zero (which could be us, hence the
> -	 * loop).
> -	 */
> -	struct freelist_node *head = READ_ONCE(list->head);
> -
> -	for (;;) {
> -		WRITE_ONCE(node->next, head);
> -		atomic_set_release(&node->refs, 1);
> -
> -		if (!try_cmpxchg_release(&list->head, &head, node)) {
> -			/*
> -			 * Hmm, the add failed, but we can only try again when
> -			 * the refcount goes back to zero.
> -			 */
> -			if (atomic_fetch_add_release(REFS_ON_FREELIST - 1, &node->refs) == 1)
> -				continue;
> +	uint32_t i, hint = list->fh_used << list->fh_step;
> +
> +	for (i = 0; i < list->fh_size; i++) {
> +		struct freelist_node *item = NULL;
> +		uint32_t slot = (i + hint) & list->fh_mask;
> +		if (try_cmpxchg_release(&list->fh_ents[slot], &item, node)) {
> +			list->fh_used++;
> +			break;
>  		}
> -		return;
>  	}
> +
> +	return (i >= list->fh_size);
>  }
>  
> -static inline void freelist_add(struct freelist_node *node, struct freelist_head *list)
> +static inline int freelist_add(struct freelist_node *node, struct freelist_head *list)
>  {
> -	/*
> -	 * We know that the should-be-on-freelist bit is 0 at this point, so
> -	 * it's safe to set it using a fetch_add.
> -	 */
> -	if (!atomic_fetch_add_release(REFS_ON_FREELIST, &node->refs)) {
> -		/*
> -		 * Oh look! We were the last ones referencing this node, and we
> -		 * know we want to add it to the free list, so let's do it!
> -		 */
> -		__freelist_add(node, list);
> -	}
> +	uint32_t hint = raw_smp_processor_id() << list->fh_step;
> +	uint32_t slot = ((uint32_t) hint) & list->fh_mask;
> +
> +	do {
> +		struct freelist_node *item = NULL;
> +		if (try_cmpxchg_release(&list->fh_ents[slot], &item, node))
> +			return 0;
> +		slot = (slot + 1) & list->fh_mask;
> +	} while (1);
> +
> +	return -1;
>  }
>  
>  static inline struct freelist_node *freelist_try_get(struct freelist_head *list)
>  {
> -	struct freelist_node *prev, *next, *head = smp_load_acquire(&list->head);
> -	unsigned int refs;
> -
> -	while (head) {
> -		prev = head;
> -		refs = atomic_read(&head->refs);
> -		if ((refs & REFS_MASK) == 0 ||
> -		    !atomic_try_cmpxchg_acquire(&head->refs, &refs, refs+1)) {
> -			head = smp_load_acquire(&list->head);
> -			continue;
> +	struct freelist_node *node = NULL;
> +	uint32_t i, hint = raw_smp_processor_id() << list->fh_step;
> +
> +	for (i = 0; i < list->fh_size; i++) {
> +		uint32_t slot = (hint + i) & list->fh_mask;
> +		struct freelist_node *item = smp_load_acquire(&list->fh_ents[slot]);
> +		if (item && try_cmpxchg_release(&list->fh_ents[slot], &item, NULL)) {
> +			node = item;
> +			break;
>  		}
> +	}
>  
> -		/*
> -		 * Good, reference count has been incremented (it wasn't at
> -		 * zero), which means we can read the next and not worry about
> -		 * it changing between now and the time we do the CAS.
> -		 */
> -		next = READ_ONCE(head->next);
> -		if (try_cmpxchg_acquire(&list->head, &head, next)) {
> -			/*
> -			 * Yay, got the node. This means it was on the list,
> -			 * which means should-be-on-freelist must be false no
> -			 * matter the refcount (because nobody else knows it's
> -			 * been taken off yet, it can't have been put back on).
> -			 */
> -			WARN_ON_ONCE(atomic_read(&head->refs) & REFS_ON_FREELIST);
> -
> -			/*
> -			 * Decrease refcount twice, once for our ref, and once
> -			 * for the list's ref.
> -			 */
> -			atomic_fetch_add(-2, &head->refs);
> -
> -			return head;
> -		}
> +	return node;
> +}
>  
> -		/*
> -		 * OK, the head must have changed on us, but we still need to decrement
> -		 * the refcount we increased.
> -		 */
> -		refs = atomic_fetch_add(-1, &prev->refs);
> -		if (refs == REFS_ON_FREELIST + 1)
> -			__freelist_add(prev, list);
> +static inline void freelist_destroy(struct freelist_head *list, void *context,
> +                                    int (*release)(void *, void *))
> +{
> +	uint32_t i;
> +
> +	if (!list->fh_ents)
> +		return;
> +
> +	for (i = 0; i < list->fh_size; i++) {
> +		uint32_t slot = i & list->fh_mask;
> +		struct freelist_node *item = smp_load_acquire(&list->fh_ents[slot]);
> +		while (item) {
> +			if (try_cmpxchg_release(&list->fh_ents[slot], &item, NULL)) {
> +				if (release)
> +					release(context, item);
> +				break;
> +			}
> +		}
>  	}
>  
> -	return NULL;
> +	if (list->fh_ents) {
> +		kfree(list->fh_ents);
> +		list->fh_ents = NULL;
> +	}
>  }
> -
>  #endif /* FREELIST_H */
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 471b1d18a92f..5c41bee25983 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1277,20 +1277,21 @@ void kprobe_flush_task(struct task_struct *tk)
>  }
>  NOKPROBE_SYMBOL(kprobe_flush_task);
>  
> -static inline void free_rp_inst(struct kretprobe *rp)
> +static int release_ri(void *context, void *node)
>  {
>  	struct kretprobe_instance *ri;
> -	struct freelist_node *node;
> -	int count = 0;
> +	ri = container_of(node, struct kretprobe_instance, freelist);
> +	kfree(ri);
> +	if (context)
> +		(*((int *)context))++;
> +	return 0;
> +}
>  
> -	node = rp->freelist.head;
> -	while (node) {
> -		ri = container_of(node, struct kretprobe_instance, freelist);
> -		node = node->next;
> +static inline void free_rp_inst(struct kretprobe *rp)
> +{
> +	int count = 0;
>  
> -		kfree(ri);
> -		count++;
> -	}
> +	freelist_destroy(&rp->freelist, &count, release_ri);
>  
>  	if (refcount_sub_and_test(count, &rp->rph->ref)) {
>  		kfree(rp->rph);
> @@ -2015,10 +2016,14 @@ int register_kretprobe(struct kretprobe *rp)
>  		rp->maxactive = num_possible_cpus();
>  #endif
>  	}
> -	rp->freelist.head = NULL;
> +	if (freelist_init(&rp->freelist, rp->maxactive))
> +		return -ENOMEM;
> +
>  	rp->rph = kzalloc(sizeof(struct kretprobe_holder), GFP_KERNEL);
> -	if (!rp->rph)
> +	if (!rp->rph) {
> +		freelist_destroy(&rp->freelist, NULL, NULL);
>  		return -ENOMEM;
> +	}
>  
>  	rp->rph->rp = rp;
>  	for (i = 0; i < rp->maxactive; i++) {
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
