Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666DD367383
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 21:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243518AbhDUTiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 15:38:12 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:34433 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235949AbhDUTiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 15:38:04 -0400
Received: by mail-lf1-f53.google.com with SMTP id t14so11387051lfe.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 12:37:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ekhWhrhz9TUwBrqEkhr3jaEF7+/PXZSw9GQDhfaAAw4=;
        b=cDhuZ8/q3DOA2ExkCfAl7SeQEw4KVx738uuirsrb0uYStw3sTLog3cX8IzL634PXTQ
         /UAj8pFchg0bqNJYtl4zFEk4CXw8Ev/tw+5Gqs31KG5lxR/y3Sv1HQK8+LeCo0UU+G7j
         Gf9I+t37FMHPq9u6EztHu9i7NrpTkjjnK15m6yQHo9BcoBon5XUMVSOlP9VkbMG+fNsN
         UgDJiRt5fM3NXSjObS29CgD5Zopr04v3sjMmzJvjgIB0yGdmeRoVXjBOU9NDX/HPe9mE
         BDR+7L9Vw+RloeY7G2wqC+Coy455T9zLTVjA2MCGJ3bt4XFePlhTppJsqhnx7o9ciZFt
         EGGw==
X-Gm-Message-State: AOAM532hTJ4UggzlMTt98HBQzIB5v8vakcjrV3AB2bNvFq+GUdvzDhny
        Vh6u1EnncUjskeHRhdSPkcQmZVYUzV6f0E8S/44=
X-Google-Smtp-Source: ABdhPJxsEDo2oiLQKU53xxa7/vsBvHe1ooHfgLXOytO4cfXUo+8O/uek0ccjTqRMsQzFtDtwsh1LXDsEvEgYJMJMHpk=
X-Received: by 2002:a05:6512:150:: with SMTP id m16mr21377244lfo.374.1619033850205;
 Wed, 21 Apr 2021 12:37:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210413155337.644993-1-namhyung@kernel.org> <20210413155337.644993-2-namhyung@kernel.org>
 <YHhS6kjeA8AvcFgz@hirez.programming.kicks-ass.net> <CABPqkBTncWfeFWY=kYXTAr3gRjpyFVL-YJN4K1YOPpHO35PHBw@mail.gmail.com>
 <YH664QumxBAIyYpt@hirez.programming.kicks-ass.net>
In-Reply-To: <YH664QumxBAIyYpt@hirez.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 22 Apr 2021 04:37:18 +0900
Message-ID: <CAM9d7cjXtGLuEkVaCOgJifwJUJmSABcZ5LRAdUsRM8TRYsVGsQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] perf/core: Share an event with multiple cgroups
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Stephane Eranian <eranian@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>, Tejun Heo <tj@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 8:29 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Apr 20, 2021 at 01:34:40AM -0700, Stephane Eranian wrote:
> > The sampling approach will certainly incur more overhead and be at
> > risk of losing the ability to reconstruct the total counter
> > per-cgroup, unless  you set the period for SW_CGROUP_SWITCHES to 1.
> > But then, you run the risk of losing samples if the buffer is full or
> > sampling is throtlled.  In some scenarios, we believe the number of
> > context switches between cgroup could be quite high (>> 1000/s).  And
> > on top you would have to add the processing of the samples to extract
> > the counts per cgroup. That would require a synthesis on cgroup on
> > perf record and some post-processing on perf report. We are interested
> > in using the data live to make some policy decisions, so a counting
> > approach with perf stat will always be best.
> >
> > The fundamental problem Namhyung is trying to solve is the following:
> >
> > num_fds = num_cpus x num_events x num_cgroups
> >
> > On an 256-CPU AMD server running 200 cgroups with 6 events/cgroup (as
> > an example):
> >
> > num_fds = 256 x 200 x 6 = 307,200 fds (with all the kernel memory
> > associated with them).
>
> So the PERCPU proposal would reduce that to 200 * 6 = 1200 fds, which is
> a definite win.

Sure.  It's good for the fd reduction.  But it won't help event scheduling
on a cpu which is a more important problem for us.

>
> > On each CPU, that implies: 200 x 6 = 1200
> > events to schedule and 6 to find on each cgroup switch
>
> Right, so here we could optimize; if we find the event-groups are
> identical in composition we can probably frob something that swizzles
> the counts around without touching the PMU. That would be very similar
> to what we already have in perf_event_context_sched_out().

Right, that's what we want.

>
> This gets a wee bit tricky when you consider cgroup hierarchy though;
> suppose you have:
>
>            R
>           / \
>          A   B
>             / \
>            C   D
>
> And are monitoring both B and D, then you'll end up with 12 counters
> active instead of the 6. I'm not sure how to make that go away. 'Don't
> do that then' might be good enough.

In my approach, it propagates the delta to the parents (if exist)
all the way to the root cgroup.

>
> > This does not scale for us:
> >    - run against the fd limit, but also memory consumption in the
> >    kernel per struct file, struct inode, struct perf_event ....
> >    - number of events per-cpu is still also large
> >    - require event scheduling on cgroup switches, even with RB-tree
> >    improvements, still heavy
> >    - require event scheduling even if measuring the same events across
> >    all cgroups
> >
> > One factor in that equation above needs to disappear. The one counter
> > per file descriptor is respected with Nahmyung's patch because he is
> > operating a plain per-cpu mode. What changes is just how and where the
> > count is accumulated in perf_events. The resulting programming on the
> > hardware is the same as before.
>
> Yes, you're aggregating differently. And that's exactly the problem. The
> aggregation is a variable one with fairly poor semantics. Suppose you
> create a new cgroup, then you have to tear down and recreate the whole
> thing, which is pretty crap.

Yep, but I think cgroup aggregation is an important use case and
we'd better support it efficiently.

Tracking all cgroups (including new one) can be difficult, that's why
I suggested passing a list of interested cgroups and counting them
only.  I can change it to allow adding new cgroups without tearing
down the existing list.  Is that ok to you?

>
> Ftrace had a similar issue; where people wanted aggregation, and that
> resulted in the event histogram, which, quite frankla,y is a scary
> monster that I've no intention of duplicating. That's half a programming
> language implemented.

The ftrace event histogram supports generic aggregation.  IOW users
can specify which key and data field to aggregate.  That surely would
complicate the things.

>
> > As you point out, the difficulty is how to express the cgroups of
> > interest and how to read the counts back.  I agree that the ioctl() is
> > not ideal for the latter. For the former, if you do not want ioctl()
> > then you would have to overload perf_event_open() with a vector of
> > cgroup fd, for instance. As for the read, you could, as you suggest,
> > use the read syscall if you want to read all the cgroups at once using
> > a new read_format. I don't have a problem with that.  As for cgroup-id
> > vs. cgroup-fd, I think you make a fair point about consistency with
> > the existing approach. I don't have a problem with that either
>
> So that is a problem of aggregation; which is basically a
> programmability problem. You're asking for a variadic-fixed-function
> now, but tomorrow someone else will come and want another one.

Well.. maybe we can add more stuff later if it's really needed.
But BPF also can handle many aggregations these days. :)

Thanks,
Namhyung
