Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F346C361E88
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 13:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241067AbhDPLXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 07:23:17 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:34645 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbhDPLXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 07:23:16 -0400
Received: by mail-lf1-f41.google.com with SMTP id n8so44300083lfh.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 04:22:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8oDIcF6tB08EFimooEXCJuWZOMCbsVJL8J7KW+y0494=;
        b=SjdMLeTc+FTuGcnObg+mjFgdO5z6ae/qM1QYOoa+ob12NTpxuaC8NsLNt+lH9n4MRR
         xDyetGGODYjKlkN5Df2t0PVfuGcsr50KmVTlB2ofZv134swbXv3JVUxr9HT1f0r5rJ6O
         sOmorrdhCVqHf/IL1Qra44KzKcmXMuXL8TFei+dJnqX4ZIo3y1udK3jGqPi9EW4ObzTw
         Fjj2qIpMrmwVQ4dHOL27/hzBqLBa94/upM8H7JacSLlTrAuWlO1u43NhVY0mGX0Ocs/X
         xnGRljGJ+qqP8G7ELCII90Sy09M2K2b9FkNZDODexZ9szmXoy46x7uYl1h+6ID+i2uVn
         SYiw==
X-Gm-Message-State: AOAM531S1XR/ZTBiqOwWWw3cnxqm90jKKijbe5llICKNIXncki8orYnO
        nlSS6R2EwE6kUMI93eFmXcsGHUVe9VebWbjV4V4=
X-Google-Smtp-Source: ABdhPJzSKl3R647otcxPt7DfW2kE+akHQALOyeBAGe8IkdhOoFgNndMs0uRJUHHvh9jQg2IplsqKKh6uZG/nqAKYejE=
X-Received: by 2002:a05:6512:b26:: with SMTP id w38mr2665678lfu.152.1618572169926;
 Fri, 16 Apr 2021 04:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210413155337.644993-1-namhyung@kernel.org> <20210413155337.644993-2-namhyung@kernel.org>
 <YHhS6kjeA8AvcFgz@hirez.programming.kicks-ass.net> <CAM9d7chrHYNOB4ShJ=34WwXOUY-grXhkiW_wursywTH1FbZdvA@mail.gmail.com>
 <YHlYT+tHrkNyMFuh@hirez.programming.kicks-ass.net> <YHlY+qd2hF00OrFw@hirez.programming.kicks-ass.net>
 <YHlmq2q4nNSqJBw6@hirez.programming.kicks-ass.net>
In-Reply-To: <YHlmq2q4nNSqJBw6@hirez.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 16 Apr 2021 20:22:38 +0900
Message-ID: <CAM9d7cgjkZuHL=-38DTu8ieMNhLN86Ccg_UUZLb-ZF95Jv6=cw@mail.gmail.com>
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

On Fri, Apr 16, 2021 at 7:28 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Apr 16, 2021 at 11:29:30AM +0200, Peter Zijlstra wrote:
>
> > > So I think we've had proposals for being able to close fds in the past;
> > > while preserving groups etc. We've always pushed back on that because of
> > > the resource limit issue. By having each counter be a filedesc we get a
> > > natural limit on the amount of resources you can consume. And in that
> > > respect, having to use 400k fds is things working as designed.
> > >
> > > Anyway, there might be a way around this..
>
> So how about we flip the whole thing sideways, instead of doing one
> event for multiple cgroups, do an event for multiple-cpus.
>
> Basically, allow:
>
>         perf_event_open(.pid=fd, cpu=-1, .flag=PID_CGROUP);
>
> Which would have the kernel create nr_cpus events [the corrolary is that
> we'd probably also allow: (.pid=-1, cpu=-1) ].

Do you mean it'd have separate perf_events per cpu internally?
From a cpu's perspective, there's nothing changed, right?
Then it will have the same performance problem as of now.

>
> Output could be done by adding FORMAT_PERCPU, which takes the current
> read() format and writes a copy for each CPU event. (p)read(v)() could
> be used to explode or partial read that.

Yeah, I think it's good for read.  But what about mmap?
I don't think we can use file offset since it's taken for auxtrace.
Maybe we can simply disallow that..

>
> This gets rid of the nasty variadic nature of the
> 'get-me-these-n-cgroups'. While still getting rid of the n*m fd issue
> you're facing.

As I said, it's not just a file descriptor problem.  In fact, performance
is more concerning.

Thanks,
Namhyung
