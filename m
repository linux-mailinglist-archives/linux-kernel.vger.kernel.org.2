Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7951933FE30
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 05:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbhCREcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 00:32:55 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:42510 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhCREcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 00:32:43 -0400
Received: by mail-lf1-f51.google.com with SMTP id o10so2398566lfb.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 21:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=boH6m1jSA/WN9PxrEykfEhqNhVP+e9nXbufeG1rDlxg=;
        b=ZHInkikUjjd5haEJJ8Ai7CVPCK136bGOmoTK7JV/kL3Aon7nldbvS+RyJix5L7Kqr7
         6VIQVrpZdVcUEPUV08t07ZkClc+2iamBX580DI6ZDcGXFA8OSheR1v3UziPg9HdZ60Bt
         qzHem+Rtmdy43hqgZonunlwUoZYN3B2n1ivP1PBWX8mKjaMQnuRIgCfpNsvXkyGj/wig
         M686SygI/46WpgpdrpXrrAM+cSZifZs0Duoy1bf3/phe/gXiV9EqAS3rKj0eWlNDlRKS
         4CRXCKf/6awY9cE/pOEIjRzCb/5CwZdBxnJML5S6mDK4vAg3KWojb6fQykv76rxYUvFc
         PNtg==
X-Gm-Message-State: AOAM533L3HGC02Dr05amL98ca0JvOldhNglloJm+6dLavJuV74+YSJgl
        1RghhkU4TPtiiFAH2GXU811VYfQDA5C/vVucSp3O2DdH
X-Google-Smtp-Source: ABdhPJyHa/urGDQlvOW8jDAzRusi83V0+t0Zy/jytarlCErtdKNN9ykBZ5WKEabkazOaio06hNDfwdlCyoxLXMRNAxQ=
X-Received: by 2002:ac2:5093:: with SMTP id f19mr4389827lfm.494.1616041961766;
 Wed, 17 Mar 2021 21:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210316211837.910506-1-songliubraving@fb.com>
 <CAM9d7ci=hfFjq3+XuBcCZ0TUJxv6AmdFk0dkHFQD3wx27aJMjA@mail.gmail.com>
 <YFH//FRPvrPswhld@kernel.org> <7D48A756-C253-48DE-B536-826314778404@fb.com>
In-Reply-To: <7D48A756-C253-48DE-B536-826314778404@fb.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 18 Mar 2021 13:32:30 +0900
Message-ID: <CAM9d7cjAngAKo9EazV=iyNncBZY53-rnE5_8SYuJiEuG4f4-yg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] perf-stat: share hardware PMCs with BPF
To:     Song Liu <songliubraving@fb.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 12:52 PM Song Liu <songliubraving@fb.com> wrote:
>
>
>
> > On Mar 17, 2021, at 6:11 AM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > Em Wed, Mar 17, 2021 at 02:29:28PM +0900, Namhyung Kim escreveu:
> >> Hi Song,
> >>
> >> On Wed, Mar 17, 2021 at 6:18 AM Song Liu <songliubraving@fb.com> wrote:
> >>>
> >>> perf uses performance monitoring counters (PMCs) to monitor system
> >>> performance. The PMCs are limited hardware resources. For example,
> >>> Intel CPUs have 3x fixed PMCs and 4x programmable PMCs per cpu.
> >>>
> >>> Modern data center systems use these PMCs in many different ways:
> >>> system level monitoring, (maybe nested) container level monitoring, per
> >>> process monitoring, profiling (in sample mode), etc. In some cases,
> >>> there are more active perf_events than available hardware PMCs. To allow
> >>> all perf_events to have a chance to run, it is necessary to do expensive
> >>> time multiplexing of events.
> >>>
> >>> On the other hand, many monitoring tools count the common metrics (cycles,
> >>> instructions). It is a waste to have multiple tools create multiple
> >>> perf_events of "cycles" and occupy multiple PMCs.
> >>
> >> Right, it'd be really helpful when the PMCs are frequently or mostly shared.
> >> But it'd also increase the overhead for uncontended cases as BPF programs
> >> need to run on every context switch.  Depending on the workload, it may
> >> cause a non-negligible performance impact.  So users should be aware of it.
> >
> > Would be interesting to, humm, measure both cases to have a firm number
> > of the impact, how many instructions are added when sharing using
> > --bpf-counters?
> >
> > I.e. compare the "expensive time multiplexing of events" with its
> > avoidance by using --bpf-counters.
> >
> > Song, have you perfmormed such measurements?
>
> I have got some measurements with perf-bench-sched-messaging:
>
> The system: x86_64 with 23 cores (46 HT)
>
> The perf-stat command:
> perf stat -e cycles,cycles,instructions,instructions,ref-cycles,ref-cycles <target, etc.>
>
> The benchmark command and output:
> ./perf bench sched messaging -g 40 -l 50000 -t
> # Running 'sched/messaging' benchmark:
> # 20 sender and receiver threads per group
> # 40 groups == 1600 threads run
>      Total time: 10X.XXX [sec]
>
>
> I use the "Total time" as measurement, so smaller number is better.
>
> For each condition, I run the command 5 times, and took the median of
> "Total time".
>
> Baseline (no perf-stat)                 104.873 [sec]
> # global
> perf stat -a                            107.887 [sec]
> perf stat -a --bpf-counters             106.071 [sec]
> # per task
> perf stat                               106.314 [sec]
> perf stat --bpf-counters                105.965 [sec]
> # per cpu
> perf stat -C 1,3,5                      107.063 [sec]
> perf stat -C 1,3,5 --bpf-counters       106.406 [sec]
>
> From the data, --bpf-counters is slightly better than the regular event
> for all targets. I noticed that the results are not very stable. There
> are a couple 108.xx runs in some of the conditions (w/ and w/o
> --bpf-counters).

Hmm.. so this result is when multiplexing happened, right?
I wondered how/why the regular perf stat is slower..

Thanks,
Namhyung

>
>
> I also measured the average runtime of the BPF programs, with
>
>         sysctl kernel.bpf_stats_enabled=1
>
> For each event, if we have one leader and two followers, the total run
> time is about 340ns. IOW, 340ns for two perf-stat reading instructions,
> 340ns for two perf-stat reading cycles, etc.
>
> Thanks,
> Song
