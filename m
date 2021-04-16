Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B62361D5F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 12:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242040AbhDPJtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 05:49:49 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:36723 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbhDPJts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 05:49:48 -0400
Received: by mail-lf1-f54.google.com with SMTP id n138so43934529lfa.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 02:49:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+sN+IMpxPiYirmRd3UCR4Dufdza7Uxh5Q+Gt8GHMluY=;
        b=nuz2g7FCQtLm0PyQYyDN34/9VlpmHEi90TXulZabmR/ZPN6iZtKplW/QjQrJtEWw7p
         IHJGJqCbZR2SvqOnofCc7cZM7QcxG5dWKFlpTer6HgPHk/Tdz75kBGKlOxAeicpShbNI
         VKrLeV6MEgVp3DobxrtUZUSx6FVOr4KnS6PFSDRmVtyn0XFk/WvWBbfWlKc0ZCtfRJ2R
         mFTx/gshdupQH6m1zEZRr8dQeEnvfxHtg2Xkym/nG8ziDjDnP7J/5vD0Os1U1nRqbjUH
         bwrKsrw9Hoj1Aseq9pfaKxtCgWzXoBkqGkSS++qkmjQq23+xKkRU+NT2SwOy3YboYoP8
         zcnQ==
X-Gm-Message-State: AOAM530BhwV3y/xM3E+CSu8FI6ZF0RfMNj2HBDvCVjLMi2XgbiPZ5ANJ
        T13CEumRUASMx9OMRprdRi80JmSwCfL/PwKnywzsgsSRaCw=
X-Google-Smtp-Source: ABdhPJy/a3r09ImSXL4HdcspbbxQ7QM3+af+R5Ar1d9Hxg9scWhERfaOKmIgtxIlyRTwcoO9jmrob/J0agDPm7+xh3A=
X-Received: by 2002:ac2:4e6d:: with SMTP id y13mr2480782lfs.509.1618566561351;
 Fri, 16 Apr 2021 02:49:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210413155337.644993-1-namhyung@kernel.org> <20210413155337.644993-2-namhyung@kernel.org>
 <YHhS6kjeA8AvcFgz@hirez.programming.kicks-ass.net>
In-Reply-To: <YHhS6kjeA8AvcFgz@hirez.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 16 Apr 2021 18:49:09 +0900
Message-ID: <CAM9d7civd59i4hquyxExQALcxOeDxk_ODpJwCRr-Rm3iMeahxQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] perf/core: Share an event with multiple cgroups
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>, Tejun Heo <tj@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 11:51 PM Peter Zijlstra <peterz@infradead.org> wrote:
> Lots of random comments below.
>
> > This attaches all cgroups in a single syscall and I didn't add the
> > DETACH command deliberately to make the implementation simple.  The
> > attached cgroup nodes would be deleted when the file descriptor of the
> > perf_event is closed.
> >
> > Cc: Tejun Heo <tj@kernel.org>
> > Reported-by: kernel test robot <lkp@intel.com>
>
> What, the whole thing?

Oh, it's just for build issues when !CONFIG_CGROUP_PERF

>
> > Acked-by: Song Liu <songliubraving@fb.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  include/linux/perf_event.h      |  22 ++
> >  include/uapi/linux/perf_event.h |   2 +
> >  kernel/events/core.c            | 480 ++++++++++++++++++++++++++++++--
> >  3 files changed, 477 insertions(+), 27 deletions(-)
> >
> > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > index 3f7f89ea5e51..4b03cbadf4a0 100644
> > --- a/include/linux/perf_event.h
> > +++ b/include/linux/perf_event.h
> > @@ -771,6 +771,19 @@ struct perf_event {
> >
> >  #ifdef CONFIG_CGROUP_PERF
> >       struct perf_cgroup              *cgrp; /* cgroup event is attach to */
> > +
> > +     /* to share an event for multiple cgroups */
> > +     struct hlist_head               *cgrp_node_hash;
> > +     struct perf_cgroup_node         *cgrp_node_entries;
> > +     int                             nr_cgrp_nodes;
> > +     int                             cgrp_node_hash_bits;
> > +
> > +     struct list_head                cgrp_node_entry;
>
> Not related to perf_cgroup_node below, afaict the name is just plain
> wrong.

Right, it should be cgrp_event_entry or something, but we
have the notion of "cgroup event" for a different thing.
Maybe cgrp_node_event_entry or cgrp_vec_event_entry
(once we get the vector support)?

>
> > +
> > +     /* snapshot of previous reading (for perf_cgroup_node below) */
> > +     u64                             cgrp_node_count;
> > +     u64                             cgrp_node_time_enabled;
> > +     u64                             cgrp_node_time_running;
> >  #endif
> >
> >  #ifdef CONFIG_SECURITY
> > @@ -780,6 +793,13 @@ struct perf_event {
> >  #endif /* CONFIG_PERF_EVENTS */
> >  };
> >
> > +struct perf_cgroup_node {
> > +     struct hlist_node               node;
> > +     u64                             id;
> > +     u64                             count;
> > +     u64                             time_enabled;
> > +     u64                             time_running;
> > +} ____cacheline_aligned;
> >
> >  struct perf_event_groups {
> >       struct rb_root  tree;
> > @@ -843,6 +863,8 @@ struct perf_event_context {
> >       int                             pin_count;
> >  #ifdef CONFIG_CGROUP_PERF
> >       int                             nr_cgroups;      /* cgroup evts */
> > +     struct list_head                cgrp_node_list;
>
> AFAICT this is actually a list of events, not a list of cgroup_node
> thingies, hence the name is wrong.

Correct, will update.

>
> > +     struct list_head                cgrp_ctx_entry;
> >  #endif
> >       void                            *task_ctx_data; /* pmu specific data */
> >       struct rcu_head                 rcu_head;
> > diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> > index ad15e40d7f5d..06bc7ab13616 100644
> > --- a/include/uapi/linux/perf_event.h
> > +++ b/include/uapi/linux/perf_event.h
> > @@ -479,6 +479,8 @@ struct perf_event_query_bpf {
> >  #define PERF_EVENT_IOC_PAUSE_OUTPUT          _IOW('$', 9, __u32)
> >  #define PERF_EVENT_IOC_QUERY_BPF             _IOWR('$', 10, struct perf_event_query_bpf *)
> >  #define PERF_EVENT_IOC_MODIFY_ATTRIBUTES     _IOW('$', 11, struct perf_event_attr *)
> > +#define PERF_EVENT_IOC_ATTACH_CGROUP         _IOW('$', 12, __u64 *)
> > +#define PERF_EVENT_IOC_READ_CGROUP           _IOWR('$', 13, __u64 *)
> >
> >  enum perf_event_ioc_flags {
> >       PERF_IOC_FLAG_GROUP             = 1U << 0,
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index f07943183041..bcf51c0b7855 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -379,6 +379,7 @@ enum event_type_t {
> >   * perf_cgroup_events: >0 per-cpu cgroup events exist on this cpu
> >   */
> >
> > +static void perf_sched_enable(void);
> >  static void perf_sched_delayed(struct work_struct *work);
> >  DEFINE_STATIC_KEY_FALSE(perf_sched_events);
> >  static DECLARE_DELAYED_WORK(perf_sched_work, perf_sched_delayed);
> > @@ -2124,6 +2125,323 @@ static int perf_get_aux_event(struct perf_event *event,
> >       return 1;
> >  }
> >
> > +#ifdef CONFIG_CGROUP_PERF
> > +static DEFINE_PER_CPU(struct list_head, cgroup_ctx_list);
> > +
> > +static bool event_can_attach_cgroup(struct perf_event *event)
> > +{
> > +     if (is_sampling_event(event))
> > +             return false;
> > +     if (event->attach_state & PERF_ATTACH_TASK)
> > +             return false;
> > +     if (is_cgroup_event(event))
> > +             return false;
>
> Why? You could be doing a subtree.

Well.. I didn't want to make it more complicated.  And we can
do cgroup subtree monitoring with the new interface alone.

>
> > +
> > +     return true;
> > +}
> > +
> > +static bool event_has_cgroup_node(struct perf_event *event)
> > +{
> > +     return event->nr_cgrp_nodes > 0;
> > +}
> > +
> > +static struct perf_cgroup_node *
> > +find_cgroup_node(struct perf_event *event, u64 cgrp_id)
> > +{
> > +     struct perf_cgroup_node *cgrp_node;
> > +     int key = hash_64(cgrp_id, event->cgrp_node_hash_bits);
> > +
> > +     hlist_for_each_entry(cgrp_node, &event->cgrp_node_hash[key], node) {
> > +             if (cgrp_node->id == cgrp_id)
> > +                     return cgrp_node;
> > +     }
> > +
> > +     return NULL;
> > +}
> > +
> > +static void perf_update_cgroup_node(struct perf_event *event, struct cgroup *cgrp)
> > +{
> > +     u64 delta_count, delta_time_enabled, delta_time_running;
> > +     int i;
> > +
> > +     if (event->cgrp_node_count == 0)
> > +             goto out;
> > +
> > +     delta_count = local64_read(&event->count) - event->cgrp_node_count;
> > +     delta_time_enabled = event->total_time_enabled - event->cgrp_node_time_enabled;
> > +     delta_time_running = event->total_time_running - event->cgrp_node_time_running;
> > +
> > +     /* account delta to all ancestor cgroups */
> > +     for (i = 0; i <= cgrp->level; i++) {
> > +             struct perf_cgroup_node *node;
> > +
> > +             node = find_cgroup_node(event, cgrp->ancestor_ids[i]);
> > +             if (node) {
> > +                     node->count += delta_count;
> > +                     node->time_enabled += delta_time_enabled;
> > +                     node->time_running += delta_time_running;
> > +             }
> > +     }
> > +
> > +out:
> > +     event->cgrp_node_count = local64_read(&event->count);
> > +     event->cgrp_node_time_enabled = event->total_time_enabled;
> > +     event->cgrp_node_time_running = event->total_time_running;
>
> This is wrong; there's no guarantee these are the same values you read
> at the begin, IOW you could be loosing events.

Could you please elaborate?

They are read first during perf_event_enable (perf_add_cgrp_node_list),
and will be updated in cgroup switches.  And it should be fine if the event
was scheduled in/out (due to multiplexing) in the middle as it collects the
enabled/running time as well.

>
> > +}
> > +
> > +static void update_cgroup_node(struct perf_event *event, struct cgroup *cgrp)
> > +{
> > +     if (event->state == PERF_EVENT_STATE_ACTIVE)
> > +             event->pmu->read(event);
> > +
> > +     perf_event_update_time(event);
> > +     perf_update_cgroup_node(event, cgrp);
> > +}
> > +
> > +/* this is called from context switch */
> > +static void update_cgroup_node_events(struct perf_event_context *ctx,
> > +                                   struct cgroup *cgrp)
> > +{
> > +     struct perf_event *event;
> > +
> > +     lockdep_assert_held(&ctx->lock);
> > +
> > +     if (ctx->is_active & EVENT_TIME)
> > +             update_context_time(ctx);
> > +
> > +     list_for_each_entry(event, &ctx->cgrp_node_list, cgrp_node_entry)
> > +             update_cgroup_node(event, cgrp);
> > +}
> > +
> > +static void cgroup_node_sched_out(struct task_struct *task)
>
> Naming seems confused.

What about cgrp_node_event_sched_out?  (I know I'm terrible at
naming..)

>
> > +{
> > +     struct list_head *cgrp_ctx_list = this_cpu_ptr(&cgroup_ctx_list);
> > +     struct perf_cgroup *cgrp = perf_cgroup_from_task(task, NULL);
> > +     struct perf_event_context *ctx;
> > +
> > +     list_for_each_entry(ctx, cgrp_ctx_list, cgrp_ctx_entry) {
> > +             raw_spin_lock(&ctx->lock);
> > +             update_cgroup_node_events(ctx, cgrp->css.cgroup);
> > +             raw_spin_unlock(&ctx->lock);
> > +     }
> > +}
> > +
> > +/* these are called from the when an event is enabled/disabled */
>
> That sentence needs help.

Ok.  When an event is enabled, it puts the event in the context list
and puts the context in the per-cpu list if it was not.  Also updates
snapshot of cgroup node count and timestamps to be used during
(cgroup) context switches.

When the event is disabled, it updates the current cgroup's node
(if exists) and removes the event (and possibly the context) from
the list.

>
> > +static void perf_add_cgrp_node_list(struct perf_event *event,
> > +                                 struct perf_event_context *ctx)
> > +{
> > +     struct list_head *cgrp_ctx_list = this_cpu_ptr(&cgroup_ctx_list);
> > +     struct perf_cgroup *cgrp = perf_cgroup_from_task(current, ctx);
> > +     bool is_first;
> > +
> > +     lockdep_assert_irqs_disabled();
> > +     lockdep_assert_held(&ctx->lock);
>
> The latter very much implies the former, no?

Right, will remove.

>
> > +
> > +     is_first = list_empty(&ctx->cgrp_node_list);
> > +     list_add_tail(&event->cgrp_node_entry, &ctx->cgrp_node_list);
>
> See the naming being daft.

I see.

>
> > +
> > +     if (is_first)
> > +             list_add_tail(&ctx->cgrp_ctx_entry, cgrp_ctx_list);
>
> While here it actually makes sense.

:)

>
> > +
> > +     update_cgroup_node(event, cgrp->css.cgroup);
> > +}
> > +
> > +static void perf_del_cgrp_node_list(struct perf_event *event,
> > +                                 struct perf_event_context *ctx)
> > +{
> > +     struct perf_cgroup *cgrp = perf_cgroup_from_task(current, ctx);
> > +
> > +     lockdep_assert_irqs_disabled();
> > +     lockdep_assert_held(&ctx->lock);
> > +
> > +     update_cgroup_node(event, cgrp->css.cgroup);
> > +     /* to refresh delta when it's enabled */
> > +     event->cgrp_node_count = 0;
> > +
> > +     list_del(&event->cgrp_node_entry);
> > +
> > +     if (list_empty(&ctx->cgrp_node_list))
> > +             list_del(&ctx->cgrp_ctx_entry);
> > +}
> > +
> > +static void perf_attach_cgroup_node(struct perf_event *event,
> > +                                 struct perf_cpu_context *cpuctx,
> > +                                 struct perf_event_context *ctx,
> > +                                 void *data)
> > +{
> > +     if (ctx->is_active & EVENT_TIME)
> > +             update_context_time(ctx);
> > +
> > +     perf_add_cgrp_node_list(event, ctx);
> > +}
> > +
> > +#define MIN_CGRP_NODE_HASH  4
> > +#define MAX_CGRP_NODE_HASH  (4 * 1024)
>
> So today you think 200 cgroups is sane, tomorrow you'll complain 4k
> cgroups is not enough.

Maybe.. I just wanted to prevent too large malicious allocations but
cannot determine what's the proper upper bound.  Hmm.. we can
add a sysctl knob for this if you want.

>
> > +
> > +/* this is called from ioctl */
> > +static int perf_event_attach_cgroup_node(struct perf_event *event, u64 nr_cgrps,
> > +                                      u64 *cgroup_ids)
> > +{
> > +     struct perf_cgroup_node *cgrp_node;
> > +     struct perf_event_context *ctx = event->ctx;
> > +     struct hlist_head *cgrp_node_hash;
> > +     int node = (event->cpu >= 0) ? cpu_to_node(event->cpu) : -1;
>
> How many more copies of that do we need?

Will refactor this bit into a static inline function.

>
> > +     unsigned long flags;
> > +     bool is_first = true;
> > +     bool enabled;
> > +     int i, nr_hash;
> > +     int hash_bits;
> > +
> > +     if (nr_cgrps < MIN_CGRP_NODE_HASH)
> > +             nr_hash = MIN_CGRP_NODE_HASH;
> > +     else
> > +             nr_hash = roundup_pow_of_two(nr_cgrps);
> > +     hash_bits = ilog2(nr_hash);
>
> That's like the complicated version of:
>
>         hash_bits = 1 + ilog2(max(MIN_CGRP_NODE_HASH, nr_cgrps) - 1);
>
> ?

Great, will update.

>
> > +
> > +     cgrp_node_hash = kcalloc_node(nr_hash, sizeof(*cgrp_node_hash),
> > +                                   GFP_KERNEL, node);
> > +     if (cgrp_node_hash == NULL)
> > +             return -ENOMEM;
> > +
> > +     cgrp_node = kcalloc_node(nr_cgrps, sizeof(*cgrp_node), GFP_KERNEL, node);
> > +     if (cgrp_node == NULL) {
> > +             kfree(cgrp_node_hash);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     for (i = 0; i < (int)nr_cgrps; i++) {
> > +             int key = hash_64(cgroup_ids[i], hash_bits);
> > +
> > +             cgrp_node[i].id = cgroup_ids[i];
> > +             hlist_add_head(&cgrp_node[i].node, &cgrp_node_hash[key]);
> > +     }
> > +
> > +     raw_spin_lock_irqsave(&ctx->lock, flags);
> > +
> > +     enabled = event->state >= PERF_EVENT_STATE_INACTIVE;
> > +
> > +     if (event->nr_cgrp_nodes != 0) {
> > +             kfree(event->cgrp_node_hash);
> > +             kfree(event->cgrp_node_entries);
> > +             is_first = false;
> > +     }
>
> So if we already had cgroups attached, we just plunk whatever state we
> had, without re-hashing? That's hardly sane semantics for something
> called 'attach'.

I think that's what Song wanted and we can make it work that way.
Basically I wanted to avoid many small allocations for nodes.

>
> And if you want this behaviour, then you should probably also accept
> nr_cgrps==0, but you don't do that either.

OK, probably I can go with the add and re-hash approach then.

>
> > +
> > +     event->cgrp_node_hash = cgrp_node_hash;
> > +     event->cgrp_node_entries = cgrp_node;
> > +     event->cgrp_node_hash_bits = hash_bits;
> > +     event->nr_cgrp_nodes = nr_cgrps;
> > +
> > +     raw_spin_unlock_irqrestore(&ctx->lock, flags);
> > +
> > +     if (is_first && enabled)
> > +             event_function_call(event, perf_attach_cgroup_node, NULL);
> > +
> > +     return 0;
> > +}
> > +
> > +static void perf_event_destroy_cgroup_nodes(struct perf_event *event)
> > +{
> > +     struct perf_event_context *ctx = event->ctx;
> > +     unsigned long flags;
> > +
> > +     raw_spin_lock_irqsave(&ctx->lock, flags);
> > +
> > +     if (event_has_cgroup_node(event)) {
> > +             if (!atomic_add_unless(&perf_sched_count, -1, 1))
> > +                     schedule_delayed_work(&perf_sched_work, HZ);
> > +     }
>
> Below you extract perf_sched_enable(), so this is somewhat inconsistent
> for not being perf_sched_disable() I'm thinking.

I can add that too.

>
> Also, the placement seems weird, do you really want this under
> ctx->lock?

It's because it needs to check the presence of the cgroup nodes
under the lock.

>
> > +
> > +     kfree(event->cgrp_node_hash);
> > +     kfree(event->cgrp_node_entries);
> > +     event->nr_cgrp_nodes = 0;
> > +
> > +     raw_spin_unlock_irqrestore(&ctx->lock, flags);
> > +}
> > +
> > +static int perf_event_read(struct perf_event *event, bool group);
> > +
> > +static void __perf_read_cgroup_node(struct perf_event *event)
> > +{
> > +     struct perf_cgroup *cgrp;
> > +
> > +     if (event_has_cgroup_node(event)) {
> > +             cgrp = perf_cgroup_from_task(current, NULL);
> > +             perf_update_cgroup_node(event, cgrp->css.cgroup);
> > +     }
> > +}
> > +
> > +static int perf_event_read_cgroup_node(struct perf_event *event, u64 read_size,
> > +                                    u64 cgrp_id, char __user *buf)
> > +{
> > +     struct perf_cgroup_node *cgrp;
> > +     struct perf_event_context *ctx = event->ctx;
> > +     unsigned long flags;
> > +     u64 read_format = event->attr.read_format;
> > +     u64 values[4];
> > +     int n = 0;
> > +
> > +     /* update event count and times (possibly run on other cpu) */
> > +     (void)perf_event_read(event, false);
> > +
> > +     raw_spin_lock_irqsave(&ctx->lock, flags);
> > +
> > +     cgrp = find_cgroup_node(event, cgrp_id);
> > +     if (cgrp == NULL) {
> > +             raw_spin_unlock_irqrestore(&ctx->lock, flags);
> > +             return -ENOENT;
> > +     }
> > +
> > +     values[n++] = cgrp->count;
> > +     if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
> > +             values[n++] = cgrp->time_enabled;
> > +     if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
> > +             values[n++] = cgrp->time_running;
> > +     if (read_format & PERF_FORMAT_ID)
> > +             values[n++] = primary_event_id(event);
> > +
> > +     raw_spin_unlock_irqrestore(&ctx->lock, flags);
> > +
> > +     if (copy_to_user(buf, values, n * sizeof(u64)))
> > +             return -EFAULT;
> > +
> > +     return n * sizeof(u64);
> > +}
> > +#else  /* !CONFIG_CGROUP_PERF */
> > +static inline bool event_can_attach_cgroup(struct perf_event *event)
> > +{
> > +     return false;
> > +}
> > +
> > +static inline bool event_has_cgroup_node(struct perf_event *event)
> > +{
> > +     return false;
> > +}
> > +
> > +static inline void cgroup_node_sched_out(struct task_struct *task) {}
> > +
> > +static inline void perf_add_cgrp_node_list(struct perf_event *event,
> > +                                        struct perf_event_context *ctx) {}
> > +static inline void perf_del_cgrp_node_list(struct perf_event *event,
> > +                                        struct perf_event_context *ctx) {}
> > +
> > +#define MAX_CGRP_NODE_HASH  1
> > +static inline int perf_event_attach_cgroup_node(struct perf_event *event,
> > +                                             u64 nr_cgrps, u64 *cgrp_ids)
> > +{
> > +     return -ENODEV;
> > +}
> > +
> > +static inline void perf_event_destroy_cgroup_nodes(struct perf_event *event) {}
> > +static inline  void __perf_read_cgroup_node(struct perf_event *event) {}
> > +
> > +static inline int perf_event_read_cgroup_node(struct perf_event *event,
> > +                                           u64 read_size, u64 cgrp_id,
> > +                                           char __user *buf)
> > +{
> > +     return -EINVAL;
> > +}
> > +#endif  /* CONFIG_CGROUP_PERF */
> > +
> >  static inline struct list_head *get_event_list(struct perf_event *event)
> >  {
> >       struct perf_event_context *ctx = event->ctx;
> > @@ -2407,6 +2725,7 @@ static void __perf_event_disable(struct perf_event *event,
> >
> >       perf_event_set_state(event, PERF_EVENT_STATE_OFF);
> >       perf_cgroup_event_disable(event, ctx);
> > +     perf_del_cgrp_node_list(event, ctx);
> >  }
> >
> >  /*
> > @@ -2946,6 +3265,7 @@ static void __perf_event_enable(struct perf_event *event,
> >
> >       perf_event_set_state(event, PERF_EVENT_STATE_INACTIVE);
> >       perf_cgroup_event_enable(event, ctx);
> > +     perf_add_cgrp_node_list(event, ctx);
> >
> >       if (!ctx->is_active)
> >               return;
> > @@ -3568,6 +3888,13 @@ void __perf_event_task_sched_out(struct task_struct *task,
> >        */
> >       if (atomic_read(this_cpu_ptr(&perf_cgroup_events)))
> >               perf_cgroup_sched_out(task, next);
> > +
> > +#ifdef CONFIG_CGROUP_PERF
> > +     if (!list_empty(this_cpu_ptr(&cgroup_ctx_list)) &&
> > +         perf_cgroup_from_task(task, NULL) !=
> > +         perf_cgroup_from_task(next, NULL))
> > +             cgroup_node_sched_out(task);
> > +#endif
>
> Please, fold this into that one cgroup branch you already have here.
> Don't pullute things further.

Will do.

>
> >  }
> >
> >  /*
> > @@ -4268,6 +4595,7 @@ static void __perf_event_read(void *info)
> >
> >       if (!data->group) {
> >               pmu->read(event);
> > +             __perf_read_cgroup_node(event);
> >               data->ret = 0;
> >               goto unlock;
> >       }
> > @@ -4283,6 +4611,7 @@ static void __perf_event_read(void *info)
> >                        * sibling could be on different (eg: software) PMU.
> >                        */
> >                       sub->pmu->read(sub);
> > +                     __perf_read_cgroup_node(sub);
> >               }
> >       }
> >
>
> Why though; nothing here looks at the new cgroup state.
>
> > @@ -4462,6 +4791,10 @@ static void __perf_event_init_context(struct perf_event_context *ctx)
> >       INIT_LIST_HEAD(&ctx->pinned_active);
> >       INIT_LIST_HEAD(&ctx->flexible_active);
> >       refcount_set(&ctx->refcount, 1);
> > +#ifdef CONFIG_CGROUP_PERF
> > +     INIT_LIST_HEAD(&ctx->cgrp_ctx_entry);
> > +     INIT_LIST_HEAD(&ctx->cgrp_node_list);
> > +#endif
> >  }
> >
> >  static struct perf_event_context *
> > @@ -4851,6 +5184,8 @@ static void _free_event(struct perf_event *event)
> >       if (is_cgroup_event(event))
> >               perf_detach_cgroup(event);
> >
> > +     perf_event_destroy_cgroup_nodes(event);
> > +
> >       if (!event->parent) {
> >               if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
> >                       put_callchain_buffers();
> > @@ -5571,6 +5906,58 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
> >
> >               return perf_event_modify_attr(event,  &new_attr);
> >       }
> > +
> > +     case PERF_EVENT_IOC_ATTACH_CGROUP: {
> > +             u64 nr_cgrps;
> > +             u64 *cgrp_buf;
> > +             size_t cgrp_bufsz;
> > +             int ret;
> > +
> > +             if (!event_can_attach_cgroup(event))
> > +                     return -EINVAL;
> > +
> > +             if (copy_from_user(&nr_cgrps, (u64 __user *)arg,
> > +                                sizeof(nr_cgrps)))
> > +                     return -EFAULT;
> > +
> > +             if (nr_cgrps == 0 || nr_cgrps > MAX_CGRP_NODE_HASH)
> > +                     return -EINVAL;
> > +
> > +             cgrp_bufsz = nr_cgrps * sizeof(*cgrp_buf);
> > +
> > +             cgrp_buf = kmalloc(cgrp_bufsz, GFP_KERNEL);
> > +             if (cgrp_buf == NULL)
> > +                     return -ENOMEM;
> > +
> > +             if (copy_from_user(cgrp_buf, (u64 __user *)(arg + 8),
> > +                                cgrp_bufsz)) {
> > +                     kfree(cgrp_buf);
> > +                     return -EFAULT;
> > +             }
> > +
> > +             ret = perf_event_attach_cgroup_node(event, nr_cgrps, cgrp_buf);
> > +
> > +             kfree(cgrp_buf);
> > +             return ret;
> > +     }
> > +
> > +     case PERF_EVENT_IOC_READ_CGROUP: {
> > +             u64 read_size, cgrp_id;
> > +
> > +             if (!event_can_attach_cgroup(event))
> > +                     return -EINVAL;
> > +
> > +             if (copy_from_user(&read_size, (u64 __user *)arg,
> > +                                sizeof(read_size)))
> > +                     return -EFAULT;
> > +             if (copy_from_user(&cgrp_id, (u64 __user *)(arg + 8),
> > +                                sizeof(cgrp_id)))
> > +                     return -EFAULT;
> > +
> > +             return perf_event_read_cgroup_node(event, read_size, cgrp_id,
> > +                                                (char __user *)(arg + 16));
> > +     }
> > +
> >       default:
> >               return -ENOTTY;
> >       }
> > @@ -5583,10 +5970,39 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
> >       return 0;
> >  }
> >
> > +static void perf_sched_enable(void)
> > +{
> > +     /*
> > +      * We need the mutex here because static_branch_enable()
> > +      * must complete *before* the perf_sched_count increment
> > +      * becomes visible.
> > +      */
> > +     if (atomic_inc_not_zero(&perf_sched_count))
> > +             return;
> > +
> > +     mutex_lock(&perf_sched_mutex);
> > +     if (!atomic_read(&perf_sched_count)) {
> > +             static_branch_enable(&perf_sched_events);
> > +             /*
> > +              * Guarantee that all CPUs observe they key change and
> > +              * call the perf scheduling hooks before proceeding to
> > +              * install events that need them.
> > +              */
> > +             synchronize_rcu();
> > +     }
> > +     /*
> > +      * Now that we have waited for the sync_sched(), allow further
> > +      * increments to by-pass the mutex.
> > +      */
> > +     atomic_inc(&perf_sched_count);
> > +     mutex_unlock(&perf_sched_mutex);
> > +}
>
> Per the above, this is missing perf_sched_disable(). Also, this should
> probably be a separate patch then.

Got it.

>
> > +
> >  static long perf_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> >  {
> >       struct perf_event *event = file->private_data;
> >       struct perf_event_context *ctx;
> > +     bool do_sched_enable = false;
> >       long ret;
> >
> >       /* Treat ioctl like writes as it is likely a mutating operation. */
> > @@ -5595,9 +6011,19 @@ static long perf_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> >               return ret;
> >
> >       ctx = perf_event_ctx_lock(event);
> > +     /* ATTACH_CGROUP requires context switch callback */
> > +     if (cmd == PERF_EVENT_IOC_ATTACH_CGROUP && !event_has_cgroup_node(event))
> > +             do_sched_enable = true;
> >       ret = _perf_ioctl(event, cmd, arg);
> >       perf_event_ctx_unlock(event, ctx);
> >
> > +     /*
> > +      * Due to the circular lock dependency, it cannot call
> > +      * static_branch_enable() under the ctx->mutex.
> > +      */
> > +     if (do_sched_enable && ret >= 0)
> > +             perf_sched_enable();
> > +
> >       return ret;
> >  }
>
> Hurmph... not much choice there I suppose.

Yeah, I couldn't find a better way.

Thanks a lot for your detailed review!
Namhyung

>
> > @@ -11240,33 +11666,8 @@ static void account_event(struct perf_event *event)
> >       if (event->attr.text_poke)
> >               atomic_inc(&nr_text_poke_events);
> >
> > -     if (inc) {
> > -             /*
> > -              * We need the mutex here because static_branch_enable()
> > -              * must complete *before* the perf_sched_count increment
> > -              * becomes visible.
> > -              */
> > -             if (atomic_inc_not_zero(&perf_sched_count))
> > -                     goto enabled;
> > -
> > -             mutex_lock(&perf_sched_mutex);
> > -             if (!atomic_read(&perf_sched_count)) {
> > -                     static_branch_enable(&perf_sched_events);
> > -                     /*
> > -                      * Guarantee that all CPUs observe they key change and
> > -                      * call the perf scheduling hooks before proceeding to
> > -                      * install events that need them.
> > -                      */
> > -                     synchronize_rcu();
> > -             }
> > -             /*
> > -              * Now that we have waited for the sync_sched(), allow further
> > -              * increments to by-pass the mutex.
> > -              */
> > -             atomic_inc(&perf_sched_count);
> > -             mutex_unlock(&perf_sched_mutex);
> > -     }
> > -enabled:
> > +     if (inc)
> > +             perf_sched_enable();
> >
> >       account_event_cpu(event, event->cpu);
> >
> > @@ -13008,6 +13409,7 @@ static void __init perf_event_init_all_cpus(void)
> >
> >  #ifdef CONFIG_CGROUP_PERF
> >               INIT_LIST_HEAD(&per_cpu(cgrp_cpuctx_list, cpu));
> > +             INIT_LIST_HEAD(&per_cpu(cgroup_ctx_list, cpu));
> >  #endif
> >               INIT_LIST_HEAD(&per_cpu(sched_cb_list, cpu));
> >       }
> > @@ -13218,6 +13620,29 @@ static int perf_cgroup_css_online(struct cgroup_subsys_state *css)
> >       return 0;
> >  }
> >
> > +static int __perf_cgroup_update_node(void *info)
> > +{
> > +     struct task_struct *task = info;
> > +
> > +     rcu_read_lock();
> > +     cgroup_node_sched_out(task);
> > +     rcu_read_unlock();
> > +
> > +     return 0;
> > +}
> > +
> > +/* update cgroup counter BEFORE task's cgroup is changed */
> > +static int perf_cgroup_can_attach(struct cgroup_taskset *tset)
> > +{
> > +     struct task_struct *task;
> > +     struct cgroup_subsys_state *css;
> > +
> > +     cgroup_taskset_for_each(task, css, tset)
> > +             task_function_call(task, __perf_cgroup_update_node, task);
> > +
> > +     return 0;
> > +}
> > +
> >  static int __perf_cgroup_move(void *info)
> >  {
> >       struct task_struct *task = info;
> > @@ -13240,6 +13665,7 @@ struct cgroup_subsys perf_event_cgrp_subsys = {
> >       .css_alloc      = perf_cgroup_css_alloc,
> >       .css_free       = perf_cgroup_css_free,
> >       .css_online     = perf_cgroup_css_online,
> > +     .can_attach     = perf_cgroup_can_attach,
> >       .attach         = perf_cgroup_attach,
> >       /*
> >        * Implicitly enable on dfl hierarchy so that perf events can
