Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209AE3775C2
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 09:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhEIHPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 03:15:05 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:43972 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhEIHPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 03:15:04 -0400
Received: by mail-lj1-f178.google.com with SMTP id w15so16854491ljo.10
        for <linux-kernel@vger.kernel.org>; Sun, 09 May 2021 00:14:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eXUE+5ZQfok9t39b/97Fg/w+ZqXTTKWUS3l6waHj4k4=;
        b=uhrd4KhXTuAWuF7XMsWnsGMLeuomIyhWmjcr9ICOBe3GMt9C2pQWyBKqDsj4sP4Qa1
         6BdtsmEnxVx+hWn5mYg6uuk62DKIdRhR2EvzG4zdZxn27oOMtcFrmro3+88057zYC5yV
         mKK+PSeJ3hslEa/BnL5JqbVCjese+v47JqK6itVqdzlH6J8kXXRegpraGF9QrpoJ7iZA
         qlBWo1lqoLVk06pmPW+ifDvv9AyYTxyCV6gv4ozVcCQ24QpBnrOU+5gox4iYxvsIn4W6
         EwZCxpoQ/LZRsNHF9bIFfwZLsP2URtX3L9P4WCE3964MitVo23MJx+S8A7zTI1h6OyB3
         n76A==
X-Gm-Message-State: AOAM5324i4so+3WbEFnr7WSaTNEc3+/9mDQxxrmP81AP8pPFr50SpNvV
        izFt2uoDz2bFE/6U7DcWIhK6/Irc0L8RPxPKe00=
X-Google-Smtp-Source: ABdhPJwAAq8D7UXl95heRyjFeu/LD9n1bTBEy2HGSUfRvp0zFzGwH0wgsYGG5Pk56cKxkyvWOn0pV74oHu7e+HdUgQk=
X-Received: by 2002:a2e:7807:: with SMTP id t7mr14605417ljc.393.1620544439544;
 Sun, 09 May 2021 00:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210413155337.644993-1-namhyung@kernel.org> <20210413155337.644993-2-namhyung@kernel.org>
 <YHhS6kjeA8AvcFgz@hirez.programming.kicks-ass.net> <CAM9d7chrHYNOB4ShJ=34WwXOUY-grXhkiW_wursywTH1FbZdvA@mail.gmail.com>
 <YHlYT+tHrkNyMFuh@hirez.programming.kicks-ass.net> <YHlY+qd2hF00OrFw@hirez.programming.kicks-ass.net>
 <YHlmq2q4nNSqJBw6@hirez.programming.kicks-ass.net> <CAM9d7cgjkZuHL=-38DTu8ieMNhLN86Ccg_UUZLb-ZF95Jv6=cw@mail.gmail.com>
 <YHl8IpC/tJSrlg7l@hirez.programming.kicks-ass.net>
In-Reply-To: <YHl8IpC/tJSrlg7l@hirez.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sun, 9 May 2021 00:13:48 -0700
Message-ID: <CAM9d7ciZQVkfFhaEZ8aNyTXUVhuVtATtpXt1t6Ya2Wazgwr-vg@mail.gmail.com>
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

Thinking about the interface a bit more...

On Fri, Apr 16, 2021 at 4:59 AM Peter Zijlstra <peterz@infradead.org> wrote:
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

So I'd like to have vector support for cgroups but it could be
extended later.  So open with a flag that it'd accept a vector

    fd = perf_event_open(.pid=-1, .cpu=N, .flag=VECTOR);

Then it'd still need an additional interface (probably ioctl) to
set (or append) the vector.

    ioctl(fd, ADD_VECTOR, { .type = VEC_CGROUP, .nr = N, ... });

Maybe we also need to add FORMAT_VECTOR and use read(v)
or friends to read the contents for each entry.  It'd be nice
if it can have a vector-specific info like cgroup-id in this case.

What do you think?

Thanks,
Namhyung
