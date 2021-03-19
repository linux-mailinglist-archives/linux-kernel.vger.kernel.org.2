Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5AE93411CF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 01:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbhCSAzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 20:55:45 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:36564 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbhCSAzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 20:55:12 -0400
Received: by mail-lf1-f50.google.com with SMTP id n138so7442138lfa.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 17:55:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oxe5YfOrxBUWElx/94xRYd2RS+DDZ7+GbaS5AvvQUPE=;
        b=Rlh4iKp/sExQVEy2DwT2vDRNRVS+GSlmqOBqeKy4TPpZ/nM0WW2NNeTz1Mk+DpG4wc
         /ycWdzhDrNTJgr36LJ0GkehpPChEGP77q8Mk++t2j97KIujfK9y/jK010/NtD+HVcEIC
         WzZFuM/XpwJqFKf7dHqOW9Ut2yCtJsCsbr8sO8EU1kdnFiQTzIQFvzxgOOhfNcLoTuxW
         E0R3kMy7gOnM5IlAKn4uCtnGaQGJzuG8Fru1wjbfj8Re5gq320kuJfEJCp+B9JHoLd1K
         +3DKsrw5MDtkCGQVSyW2HHAkoQn5pF39r7+8LuOtjCLTjjXFRvE4fJqVxdOEC2tLsQVH
         W1SQ==
X-Gm-Message-State: AOAM533pJcOgyvZaSfPDwrzFtOqW8hOBItQiRHX0d9FgrdP7An27ENi1
        rZsLSigbFaezaj22m5uBL+owhGriddTBxFheWp8=
X-Google-Smtp-Source: ABdhPJzkWxPEnet+fnejlv/+SbnTkOJ2Cjq2CfPYM75mu32pliw/LzfLZftLYg802Z5irGzgA7LXA2d5qWWUfCTM4Sw=
X-Received: by 2002:a05:6512:3c9a:: with SMTP id h26mr2190442lfv.112.1616115310824;
 Thu, 18 Mar 2021 17:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210316211837.910506-1-songliubraving@fb.com>
 <CAM9d7ci=hfFjq3+XuBcCZ0TUJxv6AmdFk0dkHFQD3wx27aJMjA@mail.gmail.com>
 <YFH//FRPvrPswhld@kernel.org> <7D48A756-C253-48DE-B536-826314778404@fb.com>
 <YFPCul51MjrlY65P@krava> <388AF530-5176-4DB9-93C4-6C302432CE12@gmail.com> <3E65B60E-B120-4E1A-BAF2-2FAEF136A4CD@fb.com>
In-Reply-To: <3E65B60E-B120-4E1A-BAF2-2FAEF136A4CD@fb.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 19 Mar 2021 09:54:59 +0900
Message-ID: <CAM9d7ch_axD_4E0W7MEx8ueeq9QsvhxNWaJ0J3AtVgeKqKQmbA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] perf-stat: share hardware PMCs with BPF
To:     Song Liu <songliubraving@fb.com>
Cc:     Arnaldo <arnaldo.melo@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 9:22 AM Song Liu <songliubraving@fb.com> wrote:
>
>
>
> > On Mar 18, 2021, at 5:09 PM, Arnaldo <arnaldo.melo@gmail.com> wrote:
> >
> >
> >
> > On March 18, 2021 6:14:34 PM GMT-03:00, Jiri Olsa <jolsa@redhat.com> wrote:
> >> On Thu, Mar 18, 2021 at 03:52:51AM +0000, Song Liu wrote:
> >>>
> >>>
> >>>> On Mar 17, 2021, at 6:11 AM, Arnaldo Carvalho de Melo
> >> <acme@kernel.org> wrote:
> >>>>
> >>>> Em Wed, Mar 17, 2021 at 02:29:28PM +0900, Namhyung Kim escreveu:
> >>>>> Hi Song,
> >>>>>
> >>>>> On Wed, Mar 17, 2021 at 6:18 AM Song Liu <songliubraving@fb.com>
> >> wrote:
> >>>>>>
> >>>>>> perf uses performance monitoring counters (PMCs) to monitor
> >> system
> >>>>>> performance. The PMCs are limited hardware resources. For
> >> example,
> >>>>>> Intel CPUs have 3x fixed PMCs and 4x programmable PMCs per cpu.
> >>>>>>
> >>>>>> Modern data center systems use these PMCs in many different ways:
> >>>>>> system level monitoring, (maybe nested) container level
> >> monitoring, per
> >>>>>> process monitoring, profiling (in sample mode), etc. In some
> >> cases,
> >>>>>> there are more active perf_events than available hardware PMCs.
> >> To allow
> >>>>>> all perf_events to have a chance to run, it is necessary to do
> >> expensive
> >>>>>> time multiplexing of events.
> >>>>>>
> >>>>>> On the other hand, many monitoring tools count the common metrics
> >> (cycles,
> >>>>>> instructions). It is a waste to have multiple tools create
> >> multiple
> >>>>>> perf_events of "cycles" and occupy multiple PMCs.
> >>>>>
> >>>>> Right, it'd be really helpful when the PMCs are frequently or
> >> mostly shared.
> >>>>> But it'd also increase the overhead for uncontended cases as BPF
> >> programs
> >>>>> need to run on every context switch.  Depending on the workload,
> >> it may
> >>>>> cause a non-negligible performance impact.  So users should be
> >> aware of it.
> >>>>
> >>>> Would be interesting to, humm, measure both cases to have a firm
> >> number
> >>>> of the impact, how many instructions are added when sharing using
> >>>> --bpf-counters?
> >>>>
> >>>> I.e. compare the "expensive time multiplexing of events" with its
> >>>> avoidance by using --bpf-counters.
> >>>>
> >>>> Song, have you perfmormed such measurements?
> >>>
> >>> I have got some measurements with perf-bench-sched-messaging:
> >>>
> >>> The system: x86_64 with 23 cores (46 HT)
> >>>
> >>> The perf-stat command:
> >>> perf stat -e
> >> cycles,cycles,instructions,instructions,ref-cycles,ref-cycles <target,
> >> etc.>
> >>>
> >>> The benchmark command and output:
> >>> ./perf bench sched messaging -g 40 -l 50000 -t
> >>> # Running 'sched/messaging' benchmark:
> >>> # 20 sender and receiver threads per group
> >>> # 40 groups == 1600 threads run
> >>>     Total time: 10X.XXX [sec]
> >>>
> >>>
> >>> I use the "Total time" as measurement, so smaller number is better.
> >>>
> >>> For each condition, I run the command 5 times, and took the median of
> >>
> >>> "Total time".
> >>>
> >>> Baseline (no perf-stat)                     104.873 [sec]
> >>> # global
> >>> perf stat -a                                107.887 [sec]
> >>> perf stat -a --bpf-counters         106.071 [sec]
> >>> # per task
> >>> perf stat                           106.314 [sec]
> >>> perf stat --bpf-counters            105.965 [sec]
> >>> # per cpu
> >>> perf stat -C 1,3,5                  107.063 [sec]
> >>> perf stat -C 1,3,5 --bpf-counters   106.406 [sec]
> >>
> >> I can't see why it's actualy faster than normal perf ;-)
> >> would be worth to find out
> >
> > Isn't this all about contended cases?
>
> Yeah, the normal perf is doing time multiplexing; while --bpf-counters
> doesn't need it.

Yep, so for uncontended cases, normal perf should be the same as the
baseline (faster than the bperf).  But for contended cases, the bperf
works faster.

Thanks,
Namhyung
