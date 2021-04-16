Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0827C361FA2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 14:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243347AbhDPMTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 08:19:48 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:35506 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235322AbhDPMTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 08:19:45 -0400
Received: by mail-lj1-f171.google.com with SMTP id a1so30848788ljp.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 05:19:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yUy8EU1mElR2i15utVVboyM5/3qDK5M11BRNkYUG9oM=;
        b=aes4NoiH2VyiZcQX7V/9Oru3imkSAVBiF8OBdQbcVZPq48znMIY7yNkZSedVFYI3wA
         xEA1i7RZFEswhEQPT63iBrKx+fa9Y2OPJlMMh8k8QW6Uw3IlkdaTYKl+xt4z588fe/Bk
         UIeimoasPOPoxSGXpbyhKuaRIi3wPH+8l/n+LDG2PSD7gceLVcxmdAe6xSZGLShk4awb
         0unTrnNWtRWx0h/shPSbiaN322xuXTBA6oUqQUjXolXvHm+aWjw3U6oI/eG0fv57RZ+a
         KK59E4kAQPId0mHxQMFZwTWddZu4awJ2gTDg3nh8Ikyy1s4G3jkwmgjfseWO/Mjmhx5s
         RumQ==
X-Gm-Message-State: AOAM532kO/HKU1seiHFqLRQUm6ApJmJbFT8DElN1TfC6HXm4tikWX8Ay
        d1VPVT44Cc4hhAUl+mv7Hhw/0SJ7SYH4wAcRMgU=
X-Google-Smtp-Source: ABdhPJwhQAaXGc9z+t/km9/QxczbgL8DPa4+rNtPa218gPaE6GsTpQrLO+BTofNz5eAu0eUSYhiEwYr94yP2r6cLXHI=
X-Received: by 2002:a2e:5057:: with SMTP id v23mr2330380ljd.393.1618575559558;
 Fri, 16 Apr 2021 05:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210413155337.644993-1-namhyung@kernel.org> <20210413155337.644993-2-namhyung@kernel.org>
 <YHhS6kjeA8AvcFgz@hirez.programming.kicks-ass.net> <CAM9d7chrHYNOB4ShJ=34WwXOUY-grXhkiW_wursywTH1FbZdvA@mail.gmail.com>
 <YHlYT+tHrkNyMFuh@hirez.programming.kicks-ass.net> <YHlY+qd2hF00OrFw@hirez.programming.kicks-ass.net>
 <YHlmq2q4nNSqJBw6@hirez.programming.kicks-ass.net> <CAM9d7cgjkZuHL=-38DTu8ieMNhLN86Ccg_UUZLb-ZF95Jv6=cw@mail.gmail.com>
 <YHl8IpC/tJSrlg7l@hirez.programming.kicks-ass.net>
In-Reply-To: <YHl8IpC/tJSrlg7l@hirez.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 16 Apr 2021 21:19:08 +0900
Message-ID: <CAM9d7chmLNTVrnKk3AEmLucR6Zi6Vd1ZESt9xNi2Q-vxudt32Q@mail.gmail.com>
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

On Fri, Apr 16, 2021 at 8:59 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Apr 16, 2021 at 08:22:38PM +0900, Namhyung Kim wrote:
> > On Fri, Apr 16, 2021 at 7:28 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Fri, Apr 16, 2021 at 11:29:30AM +0200, Peter Zijlstra wrote:
> > >
> > > > > So I think we've had proposals for being able to close fds in the past;
> > > > > while preserving groups etc. We've always pushed back on that because of
> > > > > the resource limit issue. By having each counter be a filedesc we get a
> > > > > natural limit on the amount of resources you can consume. And in that
> > > > > respect, having to use 400k fds is things working as designed.
> > > > >
> > > > > Anyway, there might be a way around this..
> > >
> > > So how about we flip the whole thing sideways, instead of doing one
> > > event for multiple cgroups, do an event for multiple-cpus.
> > >
> > > Basically, allow:
> > >
> > >         perf_event_open(.pid=fd, cpu=-1, .flag=PID_CGROUP);
> > >
> > > Which would have the kernel create nr_cpus events [the corrolary is that
> > > we'd probably also allow: (.pid=-1, cpu=-1) ].
> >
> > Do you mean it'd have separate perf_events per cpu internally?
> > From a cpu's perspective, there's nothing changed, right?
> > Then it will have the same performance problem as of now.
>
> Yes, but we'll not end up in ioctl() hell. The interface is sooo much
> better. The performance thing just means we need to think harder.
>
> I thought cgroup scheduling got a lot better with the work Ian did a
> while back? What's the actual bottleneck now?

Yep, that's true but it still comes with a high cost of multiplexing in
context (cgroup) switch.  It's inefficient that it programs the PMU
with exactly the same config just for a different cgroup.  You know
accessing the MSRs is no cheap operation.

>
> > > Output could be done by adding FORMAT_PERCPU, which takes the current
> > > read() format and writes a copy for each CPU event. (p)read(v)() could
> > > be used to explode or partial read that.
> >
> > Yeah, I think it's good for read.  But what about mmap?
> > I don't think we can use file offset since it's taken for auxtrace.
> > Maybe we can simply disallow that..
>
> Are you actually using mmap() to read? I had a proposal for FORMAT_GROUP
> like thing for mmap(), but I never implemented that (didn't get the
> enthousiatic response I thought it would). But yeah, there's nowhere
> near enough space in there for PERCPU.

Recently there's a patch to do it with rdpmc which needs to mmap first.

https://lore.kernel.org/lkml/20210414155412.3697605-1-robh@kernel.org/

>
> Not sure how to do that, these counters must not be sampling counters
> because we can't be sharing a buffer from multiple CPUs, so data/aux
> just isn't a concern. But it's weird to have them magically behave
> differently.

Yeah it's weird, and we should limit the sampling use case.

Thanks,
Namhyung
