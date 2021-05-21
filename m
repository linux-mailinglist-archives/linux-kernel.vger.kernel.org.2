Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0263B38C0BD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 09:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235879AbhEUHbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 03:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbhEUHbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 03:31:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7ACC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 00:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7t+i/SQC8GIsg5cy5XmaD11lOMnBzCrTvSlj5/pXisw=; b=Br0PPEMqoc1/wxVqSgr5ZvM2wa
        +9Dt7C2KsCDFy/hwJXjNU5SOELVJUZ/K/GFo3TL18Nzu3sC1xz3vaFxG9qEUB5NnVEStBsU+iOgk/
        aiG/i0awnqgXvM3OZt3+nKXjqJsmktuReeegVQCBQMXG91VZDHsCICF97dOx0x4b25c8nlS+vSyCB
        d1fSkD1kvQOiBnYUuiB9PuYbPJmVkLOXrnf4mknlPEANNz1nf2t/ytn4UDWXEyYpB2ineAClXIkw+
        j2ntI7IsbrMgOJfnWRTdIrAjcTJWXKNTHbLxvZkCy7NUkZ9skpZwD/wcegDJpN3Jea9Gq6ol1t5no
        C0oNqSwQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1ljzWI-00GkYY-GP; Fri, 21 May 2021 07:25:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C3782300103;
        Fri, 21 May 2021 09:24:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 827632C6D2B92; Fri, 21 May 2021 09:24:28 +0200 (CEST)
Date:   Fri, 21 May 2021 09:24:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, acme@kernel.org, tglx@linutronix.de,
        bp@alien8.de, linux-kernel@vger.kernel.org, eranian@google.com,
        vitaly.slobodskoy@intel.com, namhyung@kernel.org,
        ak@linux.intel.com
Subject: Re: [PATCH V4 1/6] perf: Save PMU specific data in task_struct
Message-ID: <YKdgLP0l7+7LVhSs@hirez.programming.kicks-ass.net>
References: <1621436766-112801-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621436766-112801-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I'm replying to the whole thing squashed, because I couldn't make sense
of the individual patches much.

> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index f5a6a2f069ed..5624792c2c87 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -428,23 +428,13 @@ struct pmu {
>  	 * context-switches callback
>  	 */
>  	void (*sched_task)		(struct perf_event_context *ctx,
> -					bool sched_in);
> +					 struct task_struct *task, bool sched_in);
>  
>  	/*
>  	 * Kmem cache of PMU specific data
>  	 */
>  	struct kmem_cache		*task_ctx_cache;
>  
> -	/*
> -	 * PMU specific parts of task perf event context (i.e. ctx->task_ctx_data)
> -	 * can be synchronized using this function. See Intel LBR callstack support
> -	 * implementation and Perf core context switch handling callbacks for usage
> -	 * examples.
> -	 */
> -	void (*swap_task_ctx)		(struct perf_event_context *prev,
> -					 struct perf_event_context *next);
> -					/* optional */
> -
>  	/*
>  	 * Set up pmu-private data structures for an AUX area
>  	 */
> @@ -847,10 +837,37 @@ struct perf_event_context {
>  #ifdef CONFIG_CGROUP_PERF
>  	int				nr_cgroups;	 /* cgroup evts */
>  #endif
> -	void				*task_ctx_data; /* pmu specific data */
>  	struct rcu_head			rcu_head;
>  };

So this I like, less is more. The rest however needs some serious
surgery :/

> @@ -401,6 +402,39 @@ static atomic_t nr_cgroup_events __read_mostly;
>  static atomic_t nr_text_poke_events __read_mostly;
>  static atomic_t nr_build_id_events __read_mostly;
>  
> +/* Track the number of system-wide event which requires pmu specific data */
> +static atomic_t nr_task_data_sys_wide_events;
> +
> +/*
> + * There are two types of users for pmu specific data, system-wide event and
> + * per-task event.
> + *
> + * The number of system-wide events is already tracked by global variable
> + * nr_task_data_sys_wide_events. Set TASK_DATA_SYS_WIDE in refcount to
> + * indicate the PMU specific data is used by system-wide events.
> + *
> + * The number of per-task event users is tracked by refcount. Since the
> + * TASK_DATA_SYS_WIDE is already occupied by system-wide events, limit
> + * the max number of per-task event users less than half of TASK_DATA_SYS_WIDE.
> + */
> +#define TASK_DATA_SYS_WIDE		0x1000000
> +#define MAX_NR_TASK_DATA_EVENTS		(TASK_DATA_SYS_WIDE >> 1)
> +
> +static inline bool has_task_data_sys_wide(struct perf_ctx_data *perf_ctx_data)
> +{
> +	return !!(refcount_read(&perf_ctx_data->refcount) & TASK_DATA_SYS_WIDE);
> +}
> +
> +static inline bool exceed_task_data_events_limit(struct perf_ctx_data *perf_ctx_data)
> +{
> +	unsigned int count = refcount_read(&perf_ctx_data->refcount);
> +
> +	if (has_task_data_sys_wide(perf_ctx_data))
> +		return (count - TASK_DATA_SYS_WIDE) > MAX_NR_TASK_DATA_EVENTS;
> +	else
> +		return count > MAX_NR_TASK_DATA_EVENTS;
> +}

This OTOH is terrible. Please don't play games like that with
refcount_t. Also naming :/

Just add an extra variable that indicates we hold one global reference
on the object. You have a hole anyway:

struct perf_ctx_data {
	struct rcu_head                 rcu_head;
	refcount_t                      refcount;
	int				global;
	struct kmem_cache               *ctx_cache;
	void                            *data;
};

> @@ -4768,6 +4756,288 @@ static void unaccount_freq_event(void)
>  		atomic_dec(&nr_freq_events);
>  }
>  
> +static int
> +alloc_perf_ctx_data(struct kmem_cache *ctx_cache, gfp_t flags,
> +		    struct perf_ctx_data **task_ctx_data)
> +{
> +	struct perf_ctx_data *ctx_data;
> +
> +	if (!ctx_cache)
> +		return -EINVAL;
> +
> +	ctx_data = kzalloc(sizeof(struct perf_ctx_data), flags);
> +	if (!ctx_data)
> +		return -ENOMEM;
> +
> +	ctx_data->data = kmem_cache_zalloc(ctx_cache, flags);
> +	if (!ctx_data->data) {
> +		kfree(ctx_data);
> +		return -ENOMEM;
> +	}
> +
> +	ctx_data->ctx_cache = ctx_cache;
> +	*task_ctx_data = ctx_data;
> +
> +	return 0;
> +}

That's pretty horrible too; what's wrong with something simpler?

static struct perf_ctx_data *alloc_perf_ctx_data(struct kmem_cache *ctx_cache, bool global)
{
	struct perf_ctx_data *cd;

	cd = kzalloc(sizeof(*cd), GFP_KERNEL);
	if (!cd)
		return NULL;

	cd->data = kmem_cache_zalloc(ctx_cache, GFP_KERNEL);
	if (!cd->data) {
		kfree(cd);
		return NULL;
	}

	cd->global = global;
	cd->ctx_cache = ctx_cache;
	refcount_set(&cd->refcount, 1);

	return cd;
}

> +
> +static void
> +free_perf_ctx_data(struct perf_ctx_data *ctx_data)
> +{
> +	kfree(ctx_data->data);

we just allocated that using kmem_cache_alloc(); shouldn't this be:

	kmem_cache_free(cd->ctx_cache, cd->data);

> +	kfree(ctx_data);
> +}
> +
> +static void
> +free_perf_ctx_data_rcu(struct rcu_head *rcu_head)
__free_perf_ctx_data_rcu(
> +{
> +	struct perf_ctx_data *ctx_data;
> +
> +	ctx_data = container_of(rcu_head, struct perf_ctx_data, rcu_head);
> +	free_perf_ctx_data(ctx_data);
> +}

static inline void perf_free_ctx_data_rcu(struct perf_ctx_data *cd)
{
	call_rcu(&cd->rcuhead, __free_perf_ctx_data_rcu);
}

> +static int
> +attach_task_ctx_data(struct task_struct *task, struct kmem_cache *ctx_cache)
> +{
> +	struct perf_ctx_data *ctx_data, *tsk_data;
> +
> +	/*
> +	 * To make the code RT friendly, make the allocation out of
> +	 * the spinlock.
> +	 */

Nothing RT specific there, doing allocations under spnilocks is crap at
all times. RT just really doesn't let you do it under raw_spinlock,
rightfully so.

> +	if (alloc_perf_ctx_data(ctx_cache, GFP_KERNEL, &ctx_data))
> +		return -ENOMEM;
> +
> +	raw_spin_lock(&task->perf_ctx_data_lock);
> +
> +	tsk_data = rcu_dereference_protected(task->perf_ctx_data,
> +				lockdep_is_held(&task->perf_ctx_data_lock));
> +	if (tsk_data) {
> +		free_perf_ctx_data(ctx_data);
> +		if (WARN_ON_ONCE(exceed_task_data_events_limit(tsk_data))) {
> +			raw_spin_unlock(&task->perf_ctx_data_lock);
> +			return -EINVAL;
> +		}
> +		refcount_inc(&tsk_data->refcount);
> +	} else {
> +		refcount_set(&ctx_data->refcount, 1);
> +		/* System-wide event is active as well */
> +		if (atomic_read(&nr_task_data_sys_wide_events))
> +			refcount_add(TASK_DATA_SYS_WIDE, &ctx_data->refcount);
> +
> +		rcu_assign_pointer(task->perf_ctx_data, ctx_data);
> +	}
> +
> +	raw_spin_unlock(&task->perf_ctx_data_lock);

I think you can do without that lock:

	struct perf_ctx_data *old = NULL;

	cd = alloc_perf_ctx_data(ctx_cache);
	if (!cd)
		return -ENOMEM;

	for (;;) {
		if (try_cmpxchg(&task->perf_ctx_data, &old, cd)) {
			if (old)
				free_perf_ctx_data_rcu(old);
			return 0;
		}

		if (!old) {
			/*
			 * After seeing a dead @old, we raced with
			 * removal and lost, try again to install @cd.
			 */
			continue;
		}

		if (refcount_inc_not_zero(&old->refcount)) {
			free_perf_ctx_data(cd); /* unused */
			return 0;
		}

		/*
		 * @old is a dead object, refcount==0 is stable, try and
		 * replace it with @cd.
		 */
	}

And it can be *much* simpler if we ditch that refcount crud and never
release the data once allocated.

> +	return 0;
> +}
> +
> +static int
> +attach_system_wide_ctx_data(struct kmem_cache *ctx_cache)
> +{
> +	int i, num_thread, pos, nr_failed_alloc;
> +	struct perf_ctx_data *tsk_data;
> +	struct perf_ctx_data **data;
> +	struct task_struct *g, *p;
> +	gfp_t flags = GFP_ATOMIC;
> +	bool re_alloc = true;
> +
> +	/* Retrieve total number of threads */
> +	num_thread = nr_threads;
> +
> +	data = kvcalloc(num_thread, sizeof(*data), GFP_KERNEL);
> +	if (!data) {
> +		printk_once(KERN_DEBUG
> +			    "Failed to allocate space for LBR callstack. "
> +			    "The LBR callstack for all tasks may be cutoff.\n");
> +		return -ENOMEM;
> +	}
> +
> +	atomic_inc(&nr_task_data_sys_wide_events);

This is rather unfortunate; you're going to do this massive amount of
allocation for every event, regardless of whether all tasks already have
a data entry.

The alternative is a global lock around this; whichever way around, a
second invocation is going to have to wait for completion anyway.

This suggests:

static DEFINE_MUTEX(global_ctx_data_lock);
static refcount_t global_ctx_data_ref;


attach_global_ctx_data()
{
	if (refcount_inc_not_zero(&global_ctx_data_ref))
		return;

	mutex_lock(&global_ctx_data_lock);
	if (!refcount_inc_not_zero(&global_ctx_data_ref)) {

		/*
		 * allocate everything
		 */

		refcount_set(&global_ctx_data_ref, 1);
	}
	mutex_unlock(&global_ctx_data_lock);
}


detach_global_ctx_data()
{
	if (refcount_dec_not_one(&global_ctx_data_ref))
		return;

	mutex_lock(&global_ctx_data_lock);
	if (!refcount_dec_and_test(&global_ctx_data_ref) {
		mutex_unlock(&global_ctx_data_lock);
		return;
	}

	/*
	 * remove everything
	 */

	mutex_unlock(&global_ctx_data_lock);
}

(NB. the beginning of detach is normally spelled
refcount_dec_and_mutex_lock(), but seeing how you're going to need
another lock type, read below, I figured I'd spell this out, since
otherwise you're likely to get it wrong)

But that leaves you in a bind vs perf_event_fork() <-
perf_event_alloc_task_data(), which can still race. I think the simplest
solution is replacing the above DEFINE_MUTEX with DEFINE_PERCPU_RWSEM
and using the read side in perf_event_alloc_task_data().

AFAICT this solves all the global races.

> +repeat:
> +	/*
> +	 * Allocate perf_ctx_data for all existing threads.
> +	 * The perf_ctx_data for new threads will be allocated in
> +	 * perf_event_fork().
> +	 * Do a quick allocation in first round with GFP_ATOMIC.
> +	 */
> +	for (i = 0; i < num_thread; i++) {
> +		if (alloc_perf_ctx_data(ctx_cache, flags, &data[i]))
> +			break;
> +	}
> +	num_thread = i;
> +	nr_failed_alloc = 0;
> +	pos = 0;
> +
> +	rcu_read_lock();
> +	for_each_process_thread(g, p) {
> +		raw_spin_lock(&p->perf_ctx_data_lock);
> +		tsk_data = p->perf_ctx_data;
> +		if (tsk_data) {
> +			/*
> +			 * The perf_ctx_data for this thread may has been
> +			 * allocated by per-task event.
> +			 * Only update refcount for the case.
> +			 */
> +			if (!has_task_data_sys_wide(tsk_data))
> +				refcount_add(TASK_DATA_SYS_WIDE, &tsk_data->refcount);
> +			raw_spin_unlock(&p->perf_ctx_data_lock);
> +			continue;
> +		}
> +
> +		if (pos < num_thread) {
> +			refcount_set(&data[pos]->refcount, TASK_DATA_SYS_WIDE);
> +			rcu_assign_pointer(p->perf_ctx_data, data[pos++]);
> +		} else {
> +			/*
> +			 * The quick allocation in first round may be failed.
> +			 * Track the number in nr_failed_alloc.
> +			 */
> +			nr_failed_alloc++;
> +		}
> +		raw_spin_unlock(&p->perf_ctx_data_lock);
> +	}
> +	rcu_read_unlock();
> +
> +	if (re_alloc && !nr_failed_alloc) {
> +		num_thread = nr_failed_alloc;
> +		flags = GFP_KERNEL;
> +		re_alloc = false;
> +		goto repeat;
> +	}
> +
> +	if (nr_failed_alloc) {
> +		printk_once(KERN_DEBUG
> +			    "Failed to allocate space for LBR callstack. "
> +			    "The LBR callstack for some tasks may be cutoff.\n");
> +	}
> +
> +	for (; pos < num_thread; pos++)
> +		free_perf_ctx_data(data[pos]);
> +
> +	kvfree(data);
> +	return 0;

*groan*

What's wrong with something simple, like this:

again:
	rcu_read_lock();
	for_each_process_thread(g, p) {
		struct perf_ctx_data *cd = rcu_dereference(p->perf_ctx_data);
		if (cd && !cd->global) {
			cd->global = 1;
			if (!refcount_inc_not_zero(&cd->refcount))
				cd = NULL;
		}
		if (!cd) {
			get_task_struct(p);
			rcu_read_unlock();

			ret = attach_task_ctx_data(p, ctx_cache, true);
			put_task_struct(p);
			if (ret)
				return ret;

			goto again;
		}
	}
	rcu_read_unlock();

> +}
> +
> +static int
> +attach_perf_ctx_data(struct perf_event *event)
> +{
> +	struct task_struct *task = event->hw.target;
> +	struct kmem_cache *ctx_cache = event->pmu->task_ctx_cache;

	if (!ctx_cache)
		return;

This is the place to stop if there's no ctx_cache.

> +
> +	if (task)
> +		return attach_task_ctx_data(task, ctx_cache);
> +	else
> +		return attach_system_wide_ctx_data(ctx_cache);
> +}
> +
> +/**
> + * detach_task_ctx_data - Detach perf_ctx_data RCU pointer for a task
> + *			  monitored by per-task event
> + * @task:        Target Task
> + * @force:       Unconditionally free perf_ctx_data
> + *
> + * If force is set, free perf_ctx_data unconditionally.
> + * Otherwise, free perf_ctx_data when there are no users.
> + * Lock is required to sync the writers of perf_ctx_data RCU pointer
> + */
> +static void
> +detach_task_ctx_data(struct task_struct *task, bool force)

You're conflating detach_task_ctx_data() with free_task_ctx_data_rcu().

> +{
> +	struct perf_ctx_data *ctx_data;
> +
> +	raw_spin_lock(&task->perf_ctx_data_lock);
> +
> +	ctx_data = rcu_dereference_protected(task->perf_ctx_data,
> +				lockdep_is_held(&task->perf_ctx_data_lock));
> +
> +	if (!ctx_data)
> +		goto unlock;
> +
> +	if (!force) {
> +		WARN_ON_ONCE(refcount_read(&ctx_data->refcount) == TASK_DATA_SYS_WIDE);
> +
> +		if (!refcount_dec_and_test(&ctx_data->refcount))
> +			goto unlock;
> +	}
> +
> +	RCU_INIT_POINTER(task->perf_ctx_data, NULL);
> +	call_rcu(&ctx_data->rcu_head, free_perf_ctx_data_rcu);
> +
> +unlock:
> +	raw_spin_unlock(&task->perf_ctx_data_lock);


detach_task_ctx_data(struct task_struct *p)
{
	struct perf_ctx_data *cd = rcu_dereference(p->perf_ctx_data);

	if (!cd)
		return;

	if (!refcount_dec_and_test(&cd->refcount))
		return;

	if (!try_cmpxchg(&p->perf_ctx_data, &cd, NULL)) {
		/* we lost the race, nothing more to do */
		return;
	}

	free_task_ctx_data_rcu(cd);
}

> +}
> +
> +/**
> + * detach_task_ctx_data_sys_wide - Detach perf_ctx_data RCU pointer for
> + *				   a task monitored by system-wide event
> + * @task:        Target Task
> + *
> + * Free perf_ctx_data when there are no users.
> + */
> +static void
> +detach_task_ctx_data_sys_wide(struct task_struct *task)
> +{
> +	struct perf_ctx_data *ctx_data;
> +
> +	lockdep_assert_held(&task->perf_ctx_data_lock);
> +
> +	ctx_data = rcu_dereference_protected(task->perf_ctx_data,
> +				lockdep_is_held(&task->perf_ctx_data_lock));
> +	if (!ctx_data)
> +		return;
> +
> +	WARN_ON_ONCE(!has_task_data_sys_wide(ctx_data));
> +
> +	if (!refcount_sub_and_test(TASK_DATA_SYS_WIDE, &ctx_data->refcount))
> +		return;
> +
> +	RCU_INIT_POINTER(task->perf_ctx_data, NULL);
> +	call_rcu(&ctx_data->rcu_head, free_perf_ctx_data_rcu);

	struct perf_ctx_data *cd = rcu_dereference(p->task_ctx_data);

	if (!cd || !cd->global)
		return;

	cd->global = 0;
	detach_task_ctx_data(p);

> +}
> +
> +static void detach_system_wide_ctx_data(void)
> +{
> +	struct task_struct *g, *p;
> +
> +	if (!atomic_dec_and_test(&nr_task_data_sys_wide_events))
> +		return;
> +
> +	rcu_read_lock();
> +	for_each_process_thread(g, p) {
> +		raw_spin_lock(&p->perf_ctx_data_lock);
> +
> +		/*
> +		 * A new system-wide event may be attached while freeing
> +		 * everything for the old event.
> +		 * If so, stop the free process immediately.
> +		 * For the freed threads, attach_system_wide_ctx_data()
> +		 * will re-allocate the space.
> +		 */
> +		if (unlikely(atomic_read(&nr_task_data_sys_wide_events))) {
> +			raw_spin_unlock(&p->perf_ctx_data_lock);
> +			goto unlock;
> +		}
> +
> +		detach_task_ctx_data_sys_wide(p);
> +		raw_spin_unlock(&p->perf_ctx_data_lock);
> +	}
> +unlock:
> +	rcu_read_unlock();

See above with attach().

> +}
> +
> +static void detach_perf_ctx_data(struct perf_event *event)
> +{
> +	struct task_struct *task = event->hw.target;

An early termination if !ctx_cache might be useful, saves a bunch of
iteration work.

> +	if (task)
> +		detach_task_ctx_data(task, false);
> +	else
> +		detach_system_wide_ctx_data();
> +}
> +
>  static void unaccount_event(struct perf_event *event)
>  {
>  	bool dec = false;

> @@ -7841,10 +8113,63 @@ static void perf_event_task(struct task_struct *task,
>  		       task_ctx);
>  }
>  
> +/*
> + * Allocate data for a new task when profiling system-wide
> + * events which require PMU specific data
> + */
> +static void perf_event_alloc_task_data(struct task_struct *child,
> +				       struct task_struct *parent)
> +{
> +	struct kmem_cache *ctx_cache = NULL;
> +	struct perf_ctx_data *ctx_data;
> +
> +	if (!atomic_read(&nr_task_data_sys_wide_events))
> +		return;
> +
> +	rcu_read_lock();
> +	ctx_data = rcu_dereference(parent->perf_ctx_data);
> +	if (ctx_data)
> +		ctx_cache = ctx_data->ctx_cache;
> +	rcu_read_unlock();
> +
> +	if (!ctx_cache)
> +		return;
> +
> +	if (alloc_perf_ctx_data(ctx_cache, GFP_KERNEL, &ctx_data))
> +		return;
> +
> +	raw_spin_lock(&child->perf_ctx_data_lock);
> +
> +	if (child->perf_ctx_data) {
> +		free_perf_ctx_data(ctx_data);
> +	} else {
> +		refcount_set(&ctx_data->refcount, TASK_DATA_SYS_WIDE);
> +		rcu_assign_pointer(child->perf_ctx_data, ctx_data);
> +	}
> +
> +	/*
> +	 * System-wide event may be unaccount when attaching the perf_ctx_data.
> +	 * For example,
> +	 *                CPU A                              CPU B
> +	 *        perf_event_alloc_task_data():
> +	 *          read(nr_task_data_sys_wide_events)
> +	 *                                         detach_system_wide_ctx_data()
> +	 *          alloc_perf_ctx_data()
> +	 *          rcu_assign_pointer(perf_ctx_data);
> +	 *
> +	 * The perf_ctx_data may never be freed until the task is terminated.
> +	 */
> +	if (unlikely(!atomic_read(&nr_task_data_sys_wide_events)))
> +		detach_task_ctx_data_sys_wide(child);
> +
> +	raw_spin_unlock(&child->perf_ctx_data_lock);
> +}

That race goes away if you use the percpu-rwsem properly.


