Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E463B9716
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 22:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbhGAUTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 16:19:20 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:34553 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbhGAUTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 16:19:18 -0400
Received: by mail-lf1-f50.google.com with SMTP id f30so14045073lfj.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 13:16:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8mQfJhy/afYnu3LxE1JplF09WreFKT8Z8BPPwomL7ww=;
        b=a7Tz0CQ2AA7yrU/todKsgZFz3zz2vCr8fpkAufr5PRSM1ljn/PyznS9cdBbL3wA7E2
         P+tsRSDvUdVpB7iD2ZSgNcxnQde9geG05CUs9568ybpZ3FEZA6a/je52WLHyGShqEFiC
         piGJsBLjBSABKXPCafeNykxRc4+60YsO+bwRUbsHsXAHychUgfZmTniiQ8hmKFIGTaJc
         fcBORDABERkZgv7n5QJ4gSopksqOOuljEroHnBIrktKi80ExaDLLUmdLLNnpJHXgbNTe
         r0Pz4r2Le7Fef862pcrcFG0v5Ou0LXOc5VkBDoI9du+pRgGmxJzXNRgMOco7/t6pmgN1
         VkBA==
X-Gm-Message-State: AOAM530XgypLUVJBIuQ6DjJCjtWJ8mGRseHWc/CyfOF7c14vf5Jyod+s
        ekU/mZqNBVSld1iED+aaBtWYY11Mc+bSYQK+tWw=
X-Google-Smtp-Source: ABdhPJzeUb/VzNiwLUWlvWR60r6/wjlDIA/snarhNtDB/QZQe1jerl7RC4OASqIAon/oUqyZEkzlLMQY3HBj5AVm93Y=
X-Received: by 2002:ac2:5f0c:: with SMTP id 12mr282486lfq.635.1625170605838;
 Thu, 01 Jul 2021 13:16:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210625071826.608504-1-namhyung@kernel.org> <20210625071826.608504-5-namhyung@kernel.org>
 <43811928-C46C-45CE-AB5A-4DE84DCDB1AF@fb.com> <CAM9d7ciSjaVsAKGo8Y5x2UucfBZVPX-yGwcvoeUhGjQQ50ADVA@mail.gmail.com>
In-Reply-To: <CAM9d7ciSjaVsAKGo8Y5x2UucfBZVPX-yGwcvoeUhGjQQ50ADVA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 1 Jul 2021 13:16:34 -0700
Message-ID: <CAM9d7ch=khPthTmCNai9Mit4poiJ69Y0JuowDyBsPtpgSxUdDA@mail.gmail.com>
Subject: Re: [PATCH 4/4] perf stat: Enable BPF counter with --for-each-cgroup
To:     Song Liu <songliubraving@fb.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2021 at 1:09 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Song,
>
> On Wed, Jun 30, 2021 at 11:47 AM Song Liu <songliubraving@fb.com> wrote:
> >
> >
> >
> > > On Jun 25, 2021, at 12:18 AM, Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > Recently bperf was added to use BPF to count perf events for various
> > > purposes.  This is an extension for the approach and targetting to
> > > cgroup usages.
> > >
> > > Unlike the other bperf, it doesn't share the events with other
> > > processes but it'd reduce unnecessary events (and the overhead of
> > > multiplexing) for each monitored cgroup within the perf session.
> > >
> > > When --for-each-cgroup is used with --bpf-counters, it will open
> > > cgroup-switches event per cpu internally and attach the new BPF
> > > program to read given perf_events and to aggregate the results for
> > > cgroups.  It's only called when task is switched to a task in a
> > > different cgroup.
> > >
> > > Cc: Song Liu <songliubraving@fb.com>
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > > tools/perf/Makefile.perf                    |  17 +-
> > > tools/perf/util/Build                       |   1 +
> > > tools/perf/util/bpf_counter.c               |   5 +
> > > tools/perf/util/bpf_counter_cgroup.c        | 299 ++++++++++++++++++++
> > > tools/perf/util/bpf_skel/bperf_cgroup.bpf.c | 191 +++++++++++++
> > > tools/perf/util/cgroup.c                    |   2 +
> > > tools/perf/util/cgroup.h                    |   1 +
> > > 7 files changed, 515 insertions(+), 1 deletion(-)
> > > create mode 100644 tools/perf/util/bpf_counter_cgroup.c
> > > create mode 100644 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> >
> > [...]
> >
> > > diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_counter_cgroup.c
> > > new file mode 100644
> > > index 000000000000..327f97a23a84
> > > --- /dev/null
> > > +++ b/tools/perf/util/bpf_counter_cgroup.c
> > > @@ -0,0 +1,299 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +/* Copyright (c) 2019 Facebook */
> >
> > I am not sure whether this ^^^ is accurate.
>
> Well, I just copied it from the bpf_counter.c file which was the base
> of this patch.  Now I don't think I have many lines of code directly
> came from the origin.
>
> So I'm not sure what I can do.  Do you want to update the
> copyright year to 2021?  Or are you ok with removing the
> line at all?
>

> > [...]
> >
> > > +
> > > +/*
> > > + * trigger the leader prog on each cpu, so the cgrp_reading map could get
> > > + * the latest results.
> > > + */
> > > +static int bperf_cgrp__sync_counters(struct evlist *evlist)
> > > +{
> > > +     int i, cpu;
> > > +     int nr_cpus = evlist->core.all_cpus->nr;
> > > +     int prog_fd = bpf_program__fd(skel->progs.trigger_read);
> > > +
> > > +     for (i = 0; i < nr_cpus; i++) {
> > > +             cpu = evlist->core.all_cpus->map[i];
> > > +             bperf_trigger_reading(prog_fd, cpu);
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int bperf_cgrp__enable(struct evsel *evsel)
> > > +{
> >
> > Do we need to call bperf_cgrp__sync_counters() before setting enabled to 1?
> > If we don't, we may count some numbers before setting enabled to 1, no?
>
> Actually it'll update the prev_readings even if enabled = 0.
> So I think it should get the correct counts after setting it to 1
> without the bperf_cgrp__sync_counters().

I thought about this again, and you're right.  Will change.

Thanks,
Namhyung
