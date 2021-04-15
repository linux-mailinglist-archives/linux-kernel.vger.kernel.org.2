Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38DB0361680
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 01:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbhDOXsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 19:48:50 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:41891 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234815AbhDOXsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 19:48:47 -0400
Received: by mail-lf1-f41.google.com with SMTP id f41so18518262lfv.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 16:48:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YDV36V9SxRVi5g2VPh244OA9lLtSaXhZ7lcG531gho4=;
        b=JvBpBnvKwH0Vv/6Krqwmp+V9AKKH8Dj4A9p+pxLydFPpKPM3A6RxAXX8V4KCgsbAtc
         CFzvM3OC9U/NmcR/WIdoTRnwtr3IKoLlSOfT2KVRlzSfvtDqcseDcIP+tWGNTCeAgS8/
         ia8zs9LoY7PSClSXE61Wf3U80NHzIQPL0fBlRWolyligtHpS7DF8Gy2HrsoCL+yCaiVY
         Af9BwvE5mZJYUXpTJOELIejlbxQCglhHdDoz5NzXkYyH4uKxmax9loAPHKRhVxEUqoHN
         g65ciCzl9eFb/31CvCnSh6EQzgGW+Wl1XUdUwg0kYzJEXG2SW5J2IGuWbIZjFpxFiVns
         whww==
X-Gm-Message-State: AOAM532PmlD4BZn3HZqrc2s/gbkpbI4vzzatTWdx2kh9TtD/KvQA0iza
        iqhlgl8XhUpUbuiPcpWt8vOtUypQPpbkGnKrhEw3bKtURcw=
X-Google-Smtp-Source: ABdhPJwAfXjK98o69Cmc5OKZHWqPxLugqKx6U0qJGFjkpOKC/Ht6bvRb2qctogjPVSvM5Jt7CRZ1A7KeqOea1xZPApo=
X-Received: by 2002:a05:6512:150:: with SMTP id m16mr559508lfo.374.1618530503259;
 Thu, 15 Apr 2021 16:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210413155337.644993-1-namhyung@kernel.org> <20210413155337.644993-2-namhyung@kernel.org>
 <YHhS6kjeA8AvcFgz@hirez.programming.kicks-ass.net>
In-Reply-To: <YHhS6kjeA8AvcFgz@hirez.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 16 Apr 2021 08:48:12 +0900
Message-ID: <CAM9d7chrHYNOB4ShJ=34WwXOUY-grXhkiW_wursywTH1FbZdvA@mail.gmail.com>
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

Hi Peter,

Thanks for your review!

On Thu, Apr 15, 2021 at 11:51 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Apr 13, 2021 at 08:53:36AM -0700, Namhyung Kim wrote:
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
>
> git grep "This patch" Documentation/

Ok, will change.

>
> > cgroup event counting (i.e. perf stat).
> >
> >  * PERF_EVENT_IOC_ATTACH_CGROUP - it takes a buffer consists of a
> >      64-bit array to attach given cgroups.  The first element is a
> >      number of cgroups in the buffer, and the rest is a list of cgroup
> >      ids to add a cgroup info to the given event.
>
> WTH is a cgroup-id? The syscall takes a fd to the path, why have two
> different ways?

As you know, we already use cgroup-id for sampling.  Yeah we
can do it with the fd but one of the point in this patch is to reduce
the number of file descriptors. :)

Also, having cgroup-id is good to match with the result (from read)
as it contains the cgroup information.


>
> >  * PERF_EVENT_IOC_READ_CGROUP - it takes a buffer consists of a 64-bit
> >      array to get the event counter values.  The first element is size
> >      of the array in byte, and the second element is a cgroup id to
> >      read.  The rest is to save the counter value and timings.
>
> :-(
>
> So basically you're doing a whole seconds cgroup interface, one that
> violates the one counter per file premise and lives off of ioctl()s.

Right, but I'm not sure that we really want a separate event for each
cgroup if underlying hardware events are all the same.

>
> *IF* we're going to do something like this, I feel we should explore the
> whole vector-per-fd concept before proceeding. Can we make it less yuck
> (less special ioctl() and more regular file ops. Can we apply the
> concept to more things?

Ideally it'd do without keeping file descriptors open.  Maybe we can make
the vector accept various types like vector-per-cgroup_id or so.

>
> The second patch extends the ioctl() to be more read() like, instead of
> doing the sane things and extending read() by adding PERF_FORMAT_VECTOR
> or whatever. In fact, this whole second ioctl() doesn't make sense to
> have if we do indeed want to do vector-per-fd.

One of the upside of the ioctl() is that we can pass cgroup-id to read.
Probably we can keep the index in the vector and set the file offset
with it.  Or else just read the whole vector, and then it has a cgroup-id
in the output like PERF_FORMAT_CGROUP?

>
> Also, I suppose you can already fake this, by having a
> SW_CGROUP_SWITCHES (sorry, I though I picked those up, done now) event

Thanks!

> with PERF_SAMPLE_READ|PERF_SAMPLE_CGROUP and PERF_FORMAT_GROUP in a
> group with a bunch of events. Then the buffer will fill with the values
> you use here.

Right, I'll do an experiment with it.

>
> Yes, I suppose it has higher overhead, but you get the data you want
> without having to do terrible things like this.

That's true.  And we don't need many things in the perf record like
synthesizing task/mmap info.  Also there's a risk we can miss some
samples for some reason.

Another concern is that it'd add huge slow down in the perf event
open as it creates a mixed sw/hw group.  The synchronized_rcu in
the move_cgroup path caused significant problems in my
environment as it adds up in proportion to the number of cpus.

>
>
>
>
> Lots of random comments below.

Thanks for the review, I'll reply in a separate thread.

Namhyung
