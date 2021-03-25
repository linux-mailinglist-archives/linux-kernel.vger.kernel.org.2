Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F84D34870B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 03:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbhCYCp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 22:45:26 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:38406 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235357AbhCYCoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 22:44:55 -0400
Received: by mail-lf1-f54.google.com with SMTP id v15so314431lfq.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 19:44:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lMAYxqeDZR7ASvNFPmICMdWuP0no9TDz7dvV3tmPFXY=;
        b=bDaxDI9fTpogWBUjsed2CPopjXY5yPK6xa9ydcqTzkb0gspiWS5soLNNPcp4Uzo5Tc
         Svxin0HMYJ3u2GbJiw0cFd0gtQzrr5KBfmwWIry2H5MNkYutErfpV0YJ0WdYlmp0pS9S
         WxAKZ/XodIf1TXv0OSnvwsTz+JMV5Lnxx0Zu1sK2fg6Gyo/vNS03DqACzpYipLhJkqXY
         7aiw0ZbLTca8Fc3RMFBpdols+IjaxISGT/EjUXV7C8gh+uPhjQRWluM5pVXliHUMPMhr
         HSrRpDZi7m11LrEul/uLzwbqbCwSbXDefR8bEJFy4dR1rN3ibUoFUsef2ACQZWVx7gPw
         MhqQ==
X-Gm-Message-State: AOAM530wH9pP5hj1ua9uo2WcL9cbGfqBENCl3LbY3DdPbqK2V2SUVjQY
        vkBOsPkEu3QAIXVjD5g5USLui1zwvFOWL3vFM0w=
X-Google-Smtp-Source: ABdhPJxiM7nv8y1BdUP1mQLyEZAwD/nDbGMHuTo58LeLboqCzyu3qHghVnpytpyd0dH5T+F94B8Rj4/uoNhvTnVI31Y=
X-Received: by 2002:ac2:51b4:: with SMTP id f20mr3706153lfk.509.1616640291938;
 Wed, 24 Mar 2021 19:44:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210323162156.1340260-1-namhyung@kernel.org> <20210323162156.1340260-2-namhyung@kernel.org>
 <C0AF9F1F-F525-4047-AD89-F75E3FEFC215@fb.com>
In-Reply-To: <C0AF9F1F-F525-4047-AD89-F75E3FEFC215@fb.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 25 Mar 2021 11:44:40 +0900
Message-ID: <CAM9d7cjwj_0eujj5YUd+XG=je7Yjei00L228mzSo7ZrH4U0qug@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf/core: Share an event with multiple cgroups
To:     Song Liu <songliubraving@fb.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Song,

Thanks for your review!

On Thu, Mar 25, 2021 at 9:56 AM Song Liu <songliubraving@fb.com> wrote:
> > On Mar 23, 2021, at 9:21 AM, Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > As we can run many jobs (in container) on a big machine, we want to
> > measure each job's performance during the run.  To do that, the
> > perf_event can be associated to a cgroup to measure it only.
> >
> > However such cgroup events need to be opened separately and it causes
> > significant overhead in event multiplexing during the context switch
> > as well as resource consumption like in file descriptors and memory
> > footprint.
> >
> > As a cgroup event is basically a cpu event, we can share a single cpu
> > event for multiple cgroups.  All we need is a separate counter (and
> > two timing variables) for each cgroup.  I added a hash table to map
> > from cgroup id to the attached cgroups.
> >
> > With this change, the cpu event needs to calculate a delta of event
> > counter values when the cgroups of current and the next task are
> > different.  And it attributes the delta to the current task's cgroup.
> >
> > This patch adds two new ioctl commands to perf_event for light-weight
> > cgroup event counting (i.e. perf stat).
> >
> > * PERF_EVENT_IOC_ATTACH_CGROUP - it takes a buffer consists of a
> >     64-bit array to attach given cgroups.  The first element is a
> >     number of cgroups in the buffer, and the rest is a list of cgroup
> >     ids to add a cgroup info to the given event.
> >
> > * PERF_EVENT_IOC_READ_CGROUP - it takes a buffer consists of a 64-bit
> >     array to get the event counter values.  The first element is size
> >     of the array in byte, and the second element is a cgroup id to
> >     read.  The rest is to save the counter value and timings.
> >
> > This attaches all cgroups in a single syscall and I didn't add the
> > DETACH command deliberately to make the implementation simple.  The
> > attached cgroup nodes would be deleted when the file descriptor of the
> > perf_event is closed.
> >
> > Cc: Tejun Heo <tj@kernel.org>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> > include/linux/perf_event.h      |  22 ++
> > include/uapi/linux/perf_event.h |   2 +
> > kernel/events/core.c            | 474 ++++++++++++++++++++++++++++++--
> > 3 files changed, 471 insertions(+), 27 deletions(-)
> >
> > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > index 3f7f89ea5e51..2760f3b07534 100644
> > --- a/include/linux/perf_event.h
> > +++ b/include/linux/perf_event.h
> > @@ -771,6 +771,18 @@ struct perf_event {
> >
> > #ifdef CONFIG_CGROUP_PERF
> >       struct perf_cgroup              *cgrp; /* cgroup event is attach to */
> > +
> > +     /* to share an event for multiple cgroups */
> > +     struct hlist_head               *cgrp_node_hash;
> > +     struct perf_cgroup_node         *cgrp_node_entries;
> > +     int                             nr_cgrp_nodes;
> > +     int                             cgrp_node_hash_bits;
> > +
> > +     struct list_head                cgrp_node_entry;
> > +
> > +     u64                             cgrp_node_count;
> > +     u64                             cgrp_node_time_enabled;
> > +     u64                             cgrp_node_time_running;
>
> A comment saying the above values are from previous reading would be helpful.

Sure, will add.

>
> > #endif
> >
> > #ifdef CONFIG_SECURITY
> > @@ -780,6 +792,14 @@ struct perf_event {
> > #endif /* CONFIG_PERF_EVENTS */
> > };
> >
> > +struct perf_cgroup_node {
> > +     struct hlist_node               node;
> > +     u64                             id;
> > +     u64                             count;
> > +     u64                             time_enabled;
> > +     u64                             time_running;
> > +     u64                             padding[2];
>
> Do we really need the padding? For cache line alignment?

Yeah I was thinking about it.  It seems I need to use the
___cacheline_aligned macro instead.

>
> > +};
> >
> > struct perf_event_groups {
> >       struct rb_root  tree;
> > @@ -843,6 +863,8 @@ struct perf_event_context {
> >       int                             pin_count;
> > #ifdef CONFIG_CGROUP_PERF
> >       int                             nr_cgroups;      /* cgroup evts */
> > +     struct list_head                cgrp_node_list;
> > +     struct list_head                cgrp_ctx_entry;
> > #endif
> >       void                            *task_ctx_data; /* pmu specific data */
> >       struct rcu_head                 rcu_head;
> > diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> > index ad15e40d7f5d..06bc7ab13616 100644
> > --- a/include/uapi/linux/perf_event.h
> > +++ b/include/uapi/linux/perf_event.h
> > @@ -479,6 +479,8 @@ struct perf_event_query_bpf {
> > #define PERF_EVENT_IOC_PAUSE_OUTPUT           _IOW('$', 9, __u32)
> > #define PERF_EVENT_IOC_QUERY_BPF              _IOWR('$', 10, struct perf_event_query_bpf *)
> > #define PERF_EVENT_IOC_MODIFY_ATTRIBUTES      _IOW('$', 11, struct perf_event_attr *)
> > +#define PERF_EVENT_IOC_ATTACH_CGROUP         _IOW('$', 12, __u64 *)
> > +#define PERF_EVENT_IOC_READ_CGROUP           _IOWR('$', 13, __u64 *)
> >
> > enum perf_event_ioc_flags {
> >       PERF_IOC_FLAG_GROUP             = 1U << 0,
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index f07943183041..38c26a23418a 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -379,6 +379,7 @@ enum event_type_t {
> >  * perf_cgroup_events: >0 per-cpu cgroup events exist on this cpu
> >  */
> >
> > +static void perf_sched_enable(void);
> > static void perf_sched_delayed(struct work_struct *work);
> > DEFINE_STATIC_KEY_FALSE(perf_sched_events);
> > static DECLARE_DELAYED_WORK(perf_sched_work, perf_sched_delayed);
> > @@ -2124,6 +2125,322 @@ static int perf_get_aux_event(struct perf_event *event,
> >       return 1;
> > }
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
>
> Do you mean to use nr_cgrp_nodes above?

No, this is to calculate delta so it needs to be set first.
If it's the first call, it just updates the count and time and
skips the delta accounting.

>
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
> > +/* this is called from the when event is enabled/disabled */
>
> I don't think we call this when the event is disabled.

Oh, sorry.  I meant 'add' for enable, 'del' for disable..
Maybe I can change it to 'these are called from ...'.

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
> > +
> > +     is_first = list_empty(&ctx->cgrp_node_list);
> > +     list_add_tail(&event->cgrp_node_entry, &ctx->cgrp_node_list);
> > +
> > +     if (is_first)
> > +             list_add_tail(&ctx->cgrp_ctx_entry, cgrp_ctx_list);
> > +
> > +     update_cgroup_node(event, cgrp->css.cgroup);
>
> Will this add some readings before PERF_EVENT_IOC_ATTACH_CGROUP to the counters?

At this moment, the event is just enabled so the cgrp_node_count
is 0 like I said above.  So it'll update the timestamp and count in
the event but won't update the cgroup nodes.

>
> > +
> > }
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
> [...]
> > +
> > +/* this is called from ioctl */
> > +static int perf_event_attach_cgroup_node(struct perf_event *event, u64 nr_cgrps,
> > +                                      u64 *cgroup_ids)
> > +{
> > +     struct perf_cgroup_node *cgrp_node;
> > +     struct perf_event_context *ctx = event->ctx;
> > +     struct hlist_head *cgrp_node_hash;
> > +     int node = (event->cpu >= 0) ? cpu_to_node(event->cpu) : -1;
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
> To add another cgroup to the list, we use PERF_EVENT_IOC_ATTACH_CGROUP to
> do the whole list. So we may lost some readings during this, right?

So the basic use case is perf stat which can have a list of all
cgroups to measure
when it calls the ioctl.  Then it creates all nodes in the table at
once and sets it.

If someone wants to measure more cgroups, [s]he can call the ioctl again with
the update cgroup list (original + new).

Thanks,
Namhyung

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
>
> [...]
> >
>
