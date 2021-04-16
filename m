Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65361361DDA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 12:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240929AbhDPKSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 06:18:54 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:36699 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238871AbhDPKSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 06:18:45 -0400
Received: by mail-lf1-f49.google.com with SMTP id n138so44049569lfa.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 03:18:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=++isrNpC3mIHok4YR8XvI/+XcBPWIqUXXvBAj0ra310=;
        b=qQZnvzLZHzSEaVRI+Ob/AfI98YUHG6WP6VJ62JS8+xBCfQ3AtK+VQLVVbNp0lA4qEy
         gq8HpzApaQ6PeiYSR17veznCCPIPDLvqqVLxdEzWwuED2ZveD9G6EwxU2E1E+OVKUhsw
         g3uHgxYCEEd58uFKlbNfE6r0RTXXYrJqiiNTCME6WtN2cbKGa83IS+M7qWs7Aw5msYb0
         yBqEEPBbnue+6i1c6sgi7+orfbyc0QTFeoHFvt6G5D+odwfl7V0vgtRlT7dCQa1X5+cv
         VMqdRtt62IERliZgSo0QXmtIJrx4+ei59EK53TVpRAAG1dXZximWOYwx68lPun8019Eu
         DG4Q==
X-Gm-Message-State: AOAM531D9JDGofJiMOPVeunPrOEseJoKsQ/0pkm4NIh4/wZ60bkY/l0p
        gAhtIMsDuHZu+SmBpSGJGgtz6DRP5+cp0MdWOftqZWmoCr0=
X-Google-Smtp-Source: ABdhPJzBKgwqhOC7u0MZhfXaXdasp9C7939AOcA7k2+08z/koohDShK+5rCTZicJygnGugr1ie/dNNQ7P9SSicSGBBk=
X-Received: by 2002:a05:6512:b26:: with SMTP id w38mr2506117lfu.152.1618568300183;
 Fri, 16 Apr 2021 03:18:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210413155337.644993-1-namhyung@kernel.org> <20210413155337.644993-2-namhyung@kernel.org>
 <YHhS6kjeA8AvcFgz@hirez.programming.kicks-ass.net> <CAM9d7chrHYNOB4ShJ=34WwXOUY-grXhkiW_wursywTH1FbZdvA@mail.gmail.com>
 <YHlYT+tHrkNyMFuh@hirez.programming.kicks-ass.net>
In-Reply-To: <YHlYT+tHrkNyMFuh@hirez.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 16 Apr 2021 19:18:08 +0900
Message-ID: <CAM9d7cjcGUPcRJhSiHZukuHbnbPc8dh88Gb83k8689s3ug_1Og@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] perf/core: Share an event with multiple cgroups
To:     Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>,
        kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 6:27 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Apr 16, 2021 at 08:48:12AM +0900, Namhyung Kim wrote:
> > On Thu, Apr 15, 2021 at 11:51 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > On Tue, Apr 13, 2021 at 08:53:36AM -0700, Namhyung Kim wrote:
>
> > > > cgroup event counting (i.e. perf stat).
> > > >
> > > >  * PERF_EVENT_IOC_ATTACH_CGROUP - it takes a buffer consists of a
> > > >      64-bit array to attach given cgroups.  The first element is a
> > > >      number of cgroups in the buffer, and the rest is a list of cgroup
> > > >      ids to add a cgroup info to the given event.
> > >
> > > WTH is a cgroup-id? The syscall takes a fd to the path, why have two
> > > different ways?
> >
> > As you know, we already use cgroup-id for sampling.  Yeah we
> > can do it with the fd but one of the point in this patch is to reduce
> > the number of file descriptors. :)
>
> Well, I found those patches again after I wrote that. But I'm still not
> sure what a cgroup-id is from userspace.

It's a file handle that can be get from name_to_handle_at(2).

>
> How does userspace get one given a cgroup? (I actually mounted cgroupfs
> in order to see if there's some new 'id' file to read, there is not)
> Does having the cgroup-id ensure the cgroup exists? Can the cgroup-id
> get re-used?

It doesn't guarantee the existence of the cgroup as far as I know.
The cgroup can go away anytime.  Actually it doesn't matter for
this interface as users will get 0 result for them.  So I didn't check
the validity of the cgroup-id in the code.

And I don't think the cgroup-id is reused without reboot at least
for 64 bit systems.  It's came from a 64 bit integer increased
when a new cgroup is created.  Tejun?

>
> I really don't konw what the thing is. I don't use cgroups, like ever,
> except when I'm forced to due to some regression or bugreport.

I hope I made it clear.

>
> > Also, having cgroup-id is good to match with the result (from read)
> > as it contains the cgroup information.
>
> What?

I mean we need to match the result to a cgroup.  Either by passing
cgroup-id through ioctl or add the info in the read format.

>
> > > >  * PERF_EVENT_IOC_READ_CGROUP - it takes a buffer consists of a 64-bit
> > > >      array to get the event counter values.  The first element is size
> > > >      of the array in byte, and the second element is a cgroup id to
> > > >      read.  The rest is to save the counter value and timings.
> > >
> > > :-(
> > >
> > > So basically you're doing a whole seconds cgroup interface, one that
> > > violates the one counter per file premise and lives off of ioctl()s.
> >
> > Right, but I'm not sure that we really want a separate event for each
> > cgroup if underlying hardware events are all the same.
>
> Sure, I see where you're coming from; I just don't much like where it
> got you :-)

Ok, let's make it better. :-)

>
> > > *IF* we're going to do something like this, I feel we should explore the
> > > whole vector-per-fd concept before proceeding. Can we make it less yuck
> > > (less special ioctl() and more regular file ops. Can we apply the
> > > concept to more things?
> >
> > Ideally it'd do without keeping file descriptors open.  Maybe we can make
> > the vector accept various types like vector-per-cgroup_id or so.
>
> So I think we've had proposals for being able to close fds in the past;
> while preserving groups etc. We've always pushed back on that because of
> the resource limit issue. By having each counter be a filedesc we get a
> natural limit on the amount of resources you can consume. And in that
> respect, having to use 400k fds is things working as designed.
>
> Anyway, there might be a way around this..

It's not just a file descriptor problem.  By having each counter per cgroup
it should pay the price on multiplexing or event scheduling.  That caused
serious performance problems in production environment so we had
to limit the number of cgroups monitored at a time.

>
> > > The second patch extends the ioctl() to be more read() like, instead of
> > > doing the sane things and extending read() by adding PERF_FORMAT_VECTOR
> > > or whatever. In fact, this whole second ioctl() doesn't make sense to
> > > have if we do indeed want to do vector-per-fd.
> >
> > One of the upside of the ioctl() is that we can pass cgroup-id to read.
> > Probably we can keep the index in the vector and set the file offset
> > with it.  Or else just read the whole vector, and then it has a cgroup-id
> > in the output like PERF_FORMAT_CGROUP?
> >
> > >
> > > Also, I suppose you can already fake this, by having a
> > > SW_CGROUP_SWITCHES (sorry, I though I picked those up, done now) event
> >
> > Thanks!
> >
> > > with PERF_SAMPLE_READ|PERF_SAMPLE_CGROUP and PERF_FORMAT_GROUP in a
> > > group with a bunch of events. Then the buffer will fill with the values
> > > you use here.
> >
> > Right, I'll do an experiment with it.
> >
> > >
> > > Yes, I suppose it has higher overhead, but you get the data you want
> > > without having to do terrible things like this.
> >
> > That's true.  And we don't need many things in the perf record like
> > synthesizing task/mmap info.  Also there's a risk we can miss some
> > samples for some reason.
> >
> > Another concern is that it'd add huge slow down in the perf event
> > open as it creates a mixed sw/hw group.  The synchronized_rcu in
> > the move_cgroup path caused significant problems in my
> > environment as it adds up in proportion to the number of cpus.
>
> Since when is perf_event_open() a performance concern? That thing is
> slow in all possible ways.

I found that perf record is stuck in the perf_event_open for several
*seconds*.  And the worst part is that it'll prevent other users from
moving forward as it holds the ctx->mutex.  So I got some complaints
from random users for their mysterious slow down in the perf (like
in open, enable, disable and close).

Thanks,
Namhyung
