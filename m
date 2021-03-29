Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F55334CF2A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 13:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbhC2LeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 07:34:03 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:47023 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbhC2Ldj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 07:33:39 -0400
Received: by mail-lj1-f179.google.com with SMTP id u20so15452030lja.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 04:33:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=unbfo6L9hVvMoK+QhPvpdaFPuGJOSAwnwDIC1KW1cA4=;
        b=aLEPacCg75Bcd8NqUGDzIGKM5SVFsSALuiJOaPNvoao6ky7yJ58wmIM2TbF1ULYole
         mbjrx4KacncFixo2JMEpN8dVr/5k0L59WIHsBwOvieqOsM+XNYqqgOOdM8e6Yu1vpkfW
         lISPpOGpDjRcGtl+z7hTfGkKq6DRL3xTlu7jolLhg+E0SRDFOxsAYCHEb8abg82rPQeG
         9JI1R1Ifo5Msz5/k5uGOAy5vmdxoxweP6m7f9gTC0vqmhGa1S70wIjuef1m3/4xWWLPW
         xRxrM4j2o4szSCVSBT4kP/skRjRoD6PzbEt4x3v5dQEK+E+lpDHF12rwMtjZdX/G7XKC
         34Kw==
X-Gm-Message-State: AOAM531EpJh7T4CNdnk4iVs23sYephtvXm1C17ysGxLSjZRt6GqLIfvq
        KHM0YzpY+3l7CPMR+jq1BCL+A/0dqpnYuJhuwAc=
X-Google-Smtp-Source: ABdhPJxfWm6UNTLoqsY4TSMyz7dciO9VsGsWOYUIutnWRNuLVd+tNOFsAFLJX3kXyGEbJJarRA9n22uHnDiGKxxXDNA=
X-Received: by 2002:a05:651c:1055:: with SMTP id x21mr17360951ljm.275.1617017618454;
 Mon, 29 Mar 2021 04:33:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210323162156.1340260-1-namhyung@kernel.org> <20210323162156.1340260-2-namhyung@kernel.org>
 <180E871A-7C5E-4DB2-80F4-643237A7FA69@fb.com>
In-Reply-To: <180E871A-7C5E-4DB2-80F4-643237A7FA69@fb.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 29 Mar 2021 20:33:26 +0900
Message-ID: <CAM9d7cg6-D2G7ii0sEJoEynvvmXUz=QsqjXG5K7j947DL1PymQ@mail.gmail.com>
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

On Mon, Mar 29, 2021 at 2:17 AM Song Liu <songliubraving@fb.com> wrote:
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
>
> [...]
>
> > @@ -4461,6 +4787,8 @@ static void __perf_event_init_context(struct perf_event_context *ctx)
> >       INIT_LIST_HEAD(&ctx->event_list);
> >       INIT_LIST_HEAD(&ctx->pinned_active);
> >       INIT_LIST_HEAD(&ctx->flexible_active);
> > +     INIT_LIST_HEAD(&ctx->cgrp_ctx_entry);
> > +     INIT_LIST_HEAD(&ctx->cgrp_node_list);
>
> I guess we need ifdef CONFIG_CGROUP_PERF here?

Correct.  Thanks for pointing that out.

>
> >       refcount_set(&ctx->refcount, 1);
> > }
> >
> > @@ -4851,6 +5179,8 @@ static void _free_event(struct perf_event *event)
> >       if (is_cgroup_event(event))
> >               perf_detach_cgroup(event);
> >
> > +     perf_event_destroy_cgroup_nodes(event);
> > +
> >       if (!event->parent) {
> >               if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
> >                       put_callchain_buffers();
>
> [...]
>
> > +static void perf_sched_enable(void)
> > +{
> > +     /*
> > +      * We need the mutex here because static_branch_enable()
> > +      * must complete *before* the perf_sched_count increment
> > +      * becomes visible.
> > +      */
> > +     if (atomic_inc_not_zero(&perf_sched_count))
> > +             return;
>
> Why don't we use perf_cgroup_events for the new use case?

Maybe.. The two methods are mutually exclusive and I think
this will be preferred in the future due to the lower overhead.
And I'd like to separate it from the existing code to avoid
possible confusions.

For the perf_sched_enable(), the difference between the
existing cgroup events and this approach is when it calls
the function above.  Usually it calls during account_event()
which is a part of the event initialization.  But this approach
calls the function after an event is created.  That's why I
have the do_sched_enable variable in the perf_ioctl below
to ensure it's called exactly once for each event.


>
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
> > +
> > static long perf_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> > {
> >       struct perf_event *event = file->private_data;
> >       struct perf_event_context *ctx;
> > +     bool do_sched_enable = false;
> >       long ret;
> >
> >       /* Treat ioctl like writes as it is likely a mutating operation. */
> > @@ -5595,9 +6006,19 @@ static long perf_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
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
> > }
> >
> > @@ -11240,33 +11661,8 @@ static void account_event(struct perf_event *event)
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
> > @@ -13008,6 +13404,7 @@ static void __init perf_event_init_all_cpus(void)
> >
> > #ifdef CONFIG_CGROUP_PERF
> >               INIT_LIST_HEAD(&per_cpu(cgrp_cpuctx_list, cpu));
> > +             INIT_LIST_HEAD(&per_cpu(cgroup_ctx_list, cpu));
> > #endif
> >               INIT_LIST_HEAD(&per_cpu(sched_cb_list, cpu));
> >       }
> > @@ -13218,6 +13615,28 @@ static int perf_cgroup_css_online(struct cgroup_subsys_state *css)
> >       return 0;
> > }
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
>
> Could you please explain why we need this logic in can_attach?

IIUC the ss->attach() is called after a task's cgroup membership
is changed.  But we want to collect the performance numbers for
the old cgroup just before the change.  As the logic merely checks
the current task's cgroup, it should be done in the can_attach()
which is called before the cgroup change.

Thanks,
Namhyung
