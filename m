Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A89F350EAA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 08:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbhDAGBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 02:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbhDAGA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 02:00:58 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44262C0613E6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 23:00:58 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso2203074wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 23:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bOuO/SomUyftEDfBlu1o3TTCUlyQnNkw9jFExw5ouN0=;
        b=P+y++9ovHFRXgOTm+JzrPT+5ktl84UYml6V5UbXiI0hs2FsvDwJQ8fpHV+lsnh+7AV
         OrbBqtk3SlkyFcA32UoI/MPBABjrDNzstzGazQ7y6jWZqvAPDxw6zR5SRyiP77ItsiNO
         vvinCJnX0MpwyruoHCe0+wqyOea+lk3s582xWd/hI1KOksfBtu4O+Ga8PRIYWdTr3yXj
         wCWJ751aSJI4ccWGht3mhyl6axrlHu330HMwj96ZRRDkwvQLttTdUwuQZkJpUOJmF0EJ
         xwET9dbKyC5NmTpMkN/gr0Abzpim3H6DBzUFIaOZZ+XV5frHGSbClEcNffsEhBsGSijJ
         7ZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bOuO/SomUyftEDfBlu1o3TTCUlyQnNkw9jFExw5ouN0=;
        b=NNvLB6paKnHPuOEnHTo8xn1ZKkX5wxm6xeheL2aSG/TG+t3G7/85iJmGJZJ1pEnZBD
         zOW8LrRwDTeFfgPEva5x7uNY0JwLfSQW+s1qig1apx5H5eCTftX6uoBEFS6DZCIJNfy+
         AMbB1cSxmAwHWGsI4/ltCbVXsg0xOjcRpxZeZMHh+uUvD8N8OIO24PEkVo/kKsePcBzx
         XllQUwy/hL/kqQfV/gnBmsruVSAGdIrF9TO/A5kWsHWiCGP1Pf3yHPHyS803shCyyaD1
         jjd8WnRI60gCaOcqNAcLPnoZY0btvdgagEXcFk8xzFMGnye9IsmShOF45zqYBHQemiOG
         DU7w==
X-Gm-Message-State: AOAM531nUOEEmbCrs4XlUFxApnjhvK9WqoNPEVn5a5gBx/ardFn9kUNq
        2kFvg/uTjSCNgG3HNa6zuTQFiNI3mz+5ouTmwpkmUw==
X-Google-Smtp-Source: ABdhPJxUClMqFITI9C291uVIachKnDaMAIFwmBR++afKICeK+pelouSnB0UH9QnQY7MA+nWePkfq2lTLHX9QczqOemc=
X-Received: by 2002:a1c:5f89:: with SMTP id t131mr6036605wmb.173.1617256856743;
 Wed, 31 Mar 2021 23:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210323162156.1340260-1-namhyung@kernel.org> <20210323162156.1340260-2-namhyung@kernel.org>
 <180E871A-7C5E-4DB2-80F4-643237A7FA69@fb.com> <CAM9d7cg6-D2G7ii0sEJoEynvvmXUz=QsqjXG5K7j947DL1PymQ@mail.gmail.com>
 <8B2062CE-9BD5-4F17-B831-38C9274A1509@fb.com> <CAM9d7chtYw0v49Q5ue6B=D_8kV6ZyMvT7p10_jxsHMc+H309tA@mail.gmail.com>
In-Reply-To: <CAM9d7chtYw0v49Q5ue6B=D_8kV6ZyMvT7p10_jxsHMc+H309tA@mail.gmail.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Wed, 31 Mar 2021 23:00:45 -0700
Message-ID: <CABPqkBSjDt-Me-VwppO52ShYnopDuqai__sXo-m1AkuC2PKKew@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf/core: Share an event with multiple cgroups
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Song Liu <songliubraving@fb.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I would like to re-emphasize why this patch is important. As Namhyung
outlined in his cover message,
cgroup monitoring build on top of per-cpu monitoring and offers
maximum flexibility by allowing each event
to be attached to a single cgroup. Although this is fine when the
machines were much smaller and the number
of simultaneous cgroups was also small, it does not work anymore with
today's machines and even less with future
machines.  Over the last couple of years, we have tried to make cgroup
monitoring more scalable. Ian  Rogers
patch series addressed the RB-tree handling of the event to avoid
walking the whole tree to find events from the
sched in cgroup. This helped reduce some of the overhead we are seeing
and which is causing serious problems
to our end users, forcing them to tone down monitoring and slice
collection over cgroup over time which is far from
ideal.

Namhyung's series goes a lot further, by addressing two key overhead factors:
  1- the file descriptor consumption explosion
  2- the context switch overhead

Again this is a major cause of problems for us and needed to be
addressed in a way that maintained backward compatibility.
We are interested in the case where the same events are measured
across all cgroups and I believe this is a common usage
model.

1/ File descriptor issue

With the current interface, if you want to monitor 10 events on a 112
CPU server across 200 cgroups, you need:

    num_fds = num_events x num_cpus x num_cgroups = 10 x 112 x 200 =
224,000 descriptors

A usual Linux distribution allows around 1024. Although if you are
root, you could increase the limit, this has some other impact to the
system: the memory footprint in kernel memory to back these file
descriptors and struct perf_event is large (see our presentation at
LPC2019).

2/ Context switch overhead

Each time you have a cgroup switch, i.e., a context switch where you
switch cgroups, then you incur a PMU event reschedule. A cgroup sched
in
is more expensive than a per-process sched in because you have to find
the events which are relevant to the next cgroup, i.e., you may have
to
walk more entries in the RB-tree. If the events are identical across
cgroups, you may end up paying that cost to reinstall the same events
(ignoring
multiplexing).
Furthermore, event scheduling is an expensive operation because of
memory access and PMU register accesses. It is always best, if it can
be avoided.
From our experience, that has caused significant overhead in our
systems to the point where we have to reduce the interval at which we
collect the data
and the number of cgroups we can monitor at once.


3/ Namhyung's solution

I personally like Namhyung's solution to the problem because it fits
within the interface, does not break existing per-cgroup mode. The
implementation is fairly
simple and non-invasive. It provides a very significant reduction of
overhead on BOTH the file descriptor pressure and context switch
overheads. It matches perfectly
with the common usage model of monitoring the same events across
multiple cgroups simultaneously. The patch does not disrupt existing
perf_event_open() or
read()/close() syscalls. Everything is handled via a pair of new ioctl().

It eliminates the file descriptor overhead as follows using the same
example as before:

Before:
    num_fds = num_events x num_cpus x num_cgroups = 10 x 112 x 200 =
224,000 descriptors
After:
    num_fds = num_events x num_cpus = 10 x 112 = 1120 descriptors
(200x reduction in fds and the memory savings that go with that in the
kernel)

In other words, it reduces the file descriptor consumption to what is
necessary for plain system-wide monitoring.

On context switch, the kernel computes the event delta and stores into
a hash table, i.e., a single PMU register access instead of the full
PMU rescheduling.
The delta is propagated to the proper cgroup hierarchy if needed.

The change is generic and benefits ALL processor architectures in the
same manner.

We have tested the patch on our servers with large configurations and
it has delivered significant savings and enabled monitoring of more
cgroups simultaneously
instead of monitoring in batches which never yielded a consistent view
of the system.

Furthermore, the patches could be extended to add, as Song Lu
suggested, the possibility of deleting cgroups attached to an event to
allow continuous monitoring
without having to restart the monitoring tool. I believe the extension
can be further improved by allowing a vector read of the counts as
well. That would eliminate a
significant number of ioctl(READ) syscalls.

Overall, I think this patch series delivers significant value-add to
the perf_events interface and should be committed ASAP.

Thanks.




On Tue, Mar 30, 2021 at 8:11 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Tue, Mar 30, 2021 at 3:33 PM Song Liu <songliubraving@fb.com> wrote:
> > > On Mar 29, 2021, at 4:33 AM, Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > On Mon, Mar 29, 2021 at 2:17 AM Song Liu <songliubraving@fb.com> wrote:
> > >>> On Mar 23, 2021, at 9:21 AM, Namhyung Kim <namhyung@kernel.org> wrote:
> > >>>
> > >>> As we can run many jobs (in container) on a big machine, we want to
> > >>> measure each job's performance during the run.  To do that, the
> > >>> perf_event can be associated to a cgroup to measure it only.
> > >>>
> >
> > [...]
> >
> > >>> +     return 0;
> > >>> +}
> > >>
> > >> Could you please explain why we need this logic in can_attach?
> > >
> > > IIUC the ss->attach() is called after a task's cgroup membership
> > > is changed.  But we want to collect the performance numbers for
> > > the old cgroup just before the change.  As the logic merely checks
> > > the current task's cgroup, it should be done in the can_attach()
> > > which is called before the cgroup change.
> >
> > Thanks for the explanations.
> >
> > Overall, I really like the core idea, especially that the overhead on
> > context switch is bounded (by the depth of cgroup tree).
>
> Thanks!
>
> >
> > Is it possible to make PERF_EVENT_IOC_ATTACH_CGROUP more flexible?
> > Specifically, if we can have
> >
> >   PERF_EVENT_IOC_ADD_CGROUP     add a cgroup to the list
> >   PERF_EVENT_IOC_EL_CGROUP      delete a cgroup from the list
> >
> > we can probably share these events among multiple processes, and
> > these processes don't need to know others' cgroup list. I think
> > this will be useful for users to build customized monitoring in
> > its own container.
> >
> > Does this make sense?
>
> Maybe we can add ADD/DEL interface for more flexible monitoring
> but I'm not sure which use cases it'll be used actually.
>
> For your multi-process sharing case, the original events' file
> descriptors should be shared first.  Also adding and deleting
> (or just reading) arbitrary cgroups from a container can be a
> security concern IMHO.
>
> So I just focused on the single-process multi-cgroup case which is
> already used (perf stat --for-each-cgroup) and very important in my
> company's setup.  In this case we have a list of interested cgroups
> from the beginning so it's more efficient to create a properly sized
> hash table and all the nodes at once.
>
> Thanks,
> Namhyung
