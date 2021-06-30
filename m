Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2160D3B898C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 22:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbhF3UMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 16:12:35 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:37799 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbhF3UMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 16:12:34 -0400
Received: by mail-lj1-f181.google.com with SMTP id k8so5013366lja.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 13:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KwMk+yYg4yq0UlvJwYGfzylb7KCXN/Db8wQDFzC4Hv0=;
        b=rVGreHRBlO3OivE+QHY95tdJFwYtOerx2blc2LLFdMeuMhtbKfnbE3Mo+GdzppfB5U
         uM1IGf+SE3j40exx1mwYj1kDUl5bLPh16L7FhZQvx5wyoAvoUpMviVFCLRC6j808bosM
         HX+/+XLm4Xici0B+EKARjAWSnSQfZ6FZuPH/FfNhSMmI8sPxNvF46iOpV/+Ez/bhE3q+
         aAoC3zQBRpD11ovN3W/hC0L2DHiM9NwMQ35+WAs31WQXw59rJax0VtCEUkK26uv0ODPV
         YgAZcDOMdUr0TUVHJei2GSDfkipscBL/Ovv3Ocz3ddk8HobqBp6IXsTnf3XVDajxMJGB
         r/Kg==
X-Gm-Message-State: AOAM531W03SzfU1f17DL/VYdjmJSpKeuiwQ8uOW2+hTE+diLCbJy8HLN
        HmsYhHov52Ci81nl4Qs0pl8CeQs8lY0n4lktfx8=
X-Google-Smtp-Source: ABdhPJzo9jwLLipfr5krrU5chP8AhgY1f4uiKBoYFzLJiMNOiJMT5TOrEzP5NHXDaUeGAZZ7dS8j+86SncQIYUW5BsI=
X-Received: by 2002:a2e:8e6d:: with SMTP id t13mr8975912ljk.26.1625083803161;
 Wed, 30 Jun 2021 13:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210625071826.608504-1-namhyung@kernel.org> <20210625071826.608504-5-namhyung@kernel.org>
 <43811928-C46C-45CE-AB5A-4DE84DCDB1AF@fb.com>
In-Reply-To: <43811928-C46C-45CE-AB5A-4DE84DCDB1AF@fb.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 30 Jun 2021 13:09:52 -0700
Message-ID: <CAM9d7ciSjaVsAKGo8Y5x2UucfBZVPX-yGwcvoeUhGjQQ50ADVA@mail.gmail.com>
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

Hi Song,

On Wed, Jun 30, 2021 at 11:47 AM Song Liu <songliubraving@fb.com> wrote:
>
>
>
> > On Jun 25, 2021, at 12:18 AM, Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Recently bperf was added to use BPF to count perf events for various
> > purposes.  This is an extension for the approach and targetting to
> > cgroup usages.
> >
> > Unlike the other bperf, it doesn't share the events with other
> > processes but it'd reduce unnecessary events (and the overhead of
> > multiplexing) for each monitored cgroup within the perf session.
> >
> > When --for-each-cgroup is used with --bpf-counters, it will open
> > cgroup-switches event per cpu internally and attach the new BPF
> > program to read given perf_events and to aggregate the results for
> > cgroups.  It's only called when task is switched to a task in a
> > different cgroup.
> >
> > Cc: Song Liu <songliubraving@fb.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> > tools/perf/Makefile.perf                    |  17 +-
> > tools/perf/util/Build                       |   1 +
> > tools/perf/util/bpf_counter.c               |   5 +
> > tools/perf/util/bpf_counter_cgroup.c        | 299 ++++++++++++++++++++
> > tools/perf/util/bpf_skel/bperf_cgroup.bpf.c | 191 +++++++++++++
> > tools/perf/util/cgroup.c                    |   2 +
> > tools/perf/util/cgroup.h                    |   1 +
> > 7 files changed, 515 insertions(+), 1 deletion(-)
> > create mode 100644 tools/perf/util/bpf_counter_cgroup.c
> > create mode 100644 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
>
> [...]
>
> > diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_counter_cgroup.c
> > new file mode 100644
> > index 000000000000..327f97a23a84
> > --- /dev/null
> > +++ b/tools/perf/util/bpf_counter_cgroup.c
> > @@ -0,0 +1,299 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/* Copyright (c) 2019 Facebook */
>
> I am not sure whether this ^^^ is accurate.

Well, I just copied it from the bpf_counter.c file which was the base
of this patch.  Now I don't think I have many lines of code directly
came from the origin.

So I'm not sure what I can do.  Do you want to update the
copyright year to 2021?  Or are you ok with removing the
line at all?

>
> > +/* Copyright (c) 2021 Google */
> > +
> > +#include <assert.h>
> > +#include <limits.h>
> > +#include <unistd.h>
> > +#include <sys/file.h>
> > +#include <sys/time.h>
> > +#include <sys/resource.h>
> > +#include <linux/err.h>
> > +#include <linux/zalloc.h>
> > +#include <linux/perf_event.h>
> > +#include <api/fs/fs.h>
> > +#include <perf/bpf_perf.h>
> > +
> > +#include "affinity.h"
> > +#include "bpf_counter.h"
> > +#include "cgroup.h"
> > +#include "counts.h"
> > +#include "debug.h"
> > +#include "evsel.h"
> > +#include "evlist.h"
> > +#include "target.h"
> > +#include "cpumap.h"
> > +#include "thread_map.h"
> > +
> > +#include "bpf_skel/bperf_cgroup.skel.h"
> > +
> > +static struct perf_event_attr cgrp_switch_attr = {
> > +     .type = PERF_TYPE_SOFTWARE,
> > +     .config = PERF_COUNT_SW_CGROUP_SWITCHES,
> > +     .size = sizeof(cgrp_switch_attr),
> > +     .sample_period = 1,
> > +     .disabled = 1,
> > +};
> > +
> > +static struct evsel *cgrp_switch;
> > +static struct bperf_cgroup_bpf *skel;
> > +
> > +#define FD(evt, cpu) (*(int *)xyarray__entry(evt->core.fd, cpu, 0))
> > +
> > +static int bperf_load_program(struct evlist *evlist)
> > +{
> > +     struct bpf_link *link;
> > +     struct evsel *evsel;
> > +     struct cgroup *cgrp, *leader_cgrp;
> > +     __u32 i, cpu;
> > +     int nr_cpus = evlist->core.all_cpus->nr;
> > +     int total_cpus = cpu__max_cpu();
> > +     int map_size, map_fd;
> > +     int prog_fd, err;
> > +
> > +     skel = bperf_cgroup_bpf__open();
> > +     if (!skel) {
> > +             pr_err("Failed to open cgroup skeleton\n");
> > +             return -1;
> > +     }
> > +
> > +     skel->rodata->num_cpus = total_cpus;
> > +     skel->rodata->num_events = evlist->core.nr_entries / nr_cgroups;
> > +
> > +     BUG_ON(evlist->core.nr_entries % nr_cgroups != 0);
> > +
> > +     /* we need one copy of events per cpu for reading */
> > +     map_size = total_cpus * evlist->core.nr_entries / nr_cgroups;
> > +     bpf_map__resize(skel->maps.events, map_size);
> > +     bpf_map__resize(skel->maps.cgrp_idx, nr_cgroups);
> > +     /* previous result is saved in a per-cpu array */
> > +     map_size = evlist->core.nr_entries / nr_cgroups;
> > +     bpf_map__resize(skel->maps.prev_readings, map_size);
> > +     /* cgroup result needs all events (per-cpu) */
> > +     map_size = evlist->core.nr_entries;
> > +     bpf_map__resize(skel->maps.cgrp_readings, map_size);
> > +
> > +     set_max_rlimit();
> > +
> > +     err = bperf_cgroup_bpf__load(skel);
> > +     if (err) {
> > +             pr_err("Failed to load cgroup skeleton\n");
> > +             goto out;
> > +     }
> > +
> > +     if (cgroup_is_v2("perf_event") > 0)
> > +             skel->bss->use_cgroup_v2 = 1;
> > +
> > +     err = -1;
> > +
> > +     cgrp_switch = evsel__new(&cgrp_switch_attr);
> > +     if (evsel__open_per_cpu(cgrp_switch, evlist->core.all_cpus, -1) < 0) {
> > +             pr_err("Failed to open cgroup switches event\n");
> > +             goto out;
> > +     }
> > +
> > +     for (i = 0; i < nr_cpus; i++) {
> > +             link = bpf_program__attach_perf_event(skel->progs.on_cgrp_switch,
> > +                                                   FD(cgrp_switch, i));
> > +             if (IS_ERR(link)) {
> > +                     pr_err("Failed to attach cgroup program\n");
> > +                     err = PTR_ERR(link);
> > +                     goto out;
> > +             }
> > +     }
> > +
> > +     /*
> > +      * Update cgrp_idx map from cgroup-id to event index.
> > +      */
> > +     cgrp = NULL;
> > +     i = 0;
> > +
> > +     evlist__for_each_entry(evlist, evsel) {
> > +             if (cgrp == NULL || evsel->cgrp == leader_cgrp) {
> > +                     leader_cgrp = evsel->cgrp;
> > +                     evsel->cgrp = NULL;
> > +
> > +                     /* open single copy of the events w/o cgroup */
> > +                     err = evsel__open_per_cpu(evsel, evlist->core.all_cpus, -1);
> > +                     if (err) {
> > +                             pr_err("Failed to open first cgroup events\n");
> > +                             goto out;
> > +                     }
> > +
> > +                     map_fd = bpf_map__fd(skel->maps.events);
> > +                     for (cpu = 0; cpu < nr_cpus; cpu++) {
> > +                             int fd = FD(evsel, cpu);
> > +                             __u32 idx = evsel->idx * total_cpus +
> > +                                     evlist->core.all_cpus->map[cpu];
> > +
> > +                             err = bpf_map_update_elem(map_fd, &idx, &fd,
> > +                                                       BPF_ANY);
> > +                             if (err < 0) {
> > +                                     pr_err("Failed to update perf_event fd\n");
> > +                                     goto out;
> > +                             }
> > +                     }
> > +
> > +                     evsel->cgrp = leader_cgrp;
> > +             }
> > +             evsel->supported = true;
> > +
> > +             if (evsel->cgrp == cgrp)
> > +                     continue;
> > +
> > +             cgrp = evsel->cgrp;
> > +
> > +             if (read_cgroup_id(cgrp) < 0) {
> > +                     pr_err("Failed to get cgroup id\n");
> > +                     err = -1;
> > +                     goto out;
> > +             }
> > +
> > +             map_fd = bpf_map__fd(skel->maps.cgrp_idx);
> > +             err = bpf_map_update_elem(map_fd, &cgrp->id, &i, BPF_ANY);
> > +             if (err < 0) {
> > +                     pr_err("Failed to update cgroup index map\n");
> > +                     goto out;
> > +             }
> > +
> > +             i++;
> > +     }
> > +
> > +     /*
> > +      * bperf uses BPF_PROG_TEST_RUN to get accurate reading. Check
> > +      * whether the kernel support it
> > +      */
> > +     prog_fd = bpf_program__fd(skel->progs.trigger_read);
> > +     err = bperf_trigger_reading(prog_fd, 0);
> > +     if (err) {
> > +             pr_debug("The kernel does not support test_run for raw_tp BPF programs.\n"
> > +                      "Therefore, --for-each-cgroup might show inaccurate readings\n");
>
> I think this should be a warning, and we should set err = 0 to continue?

Sounds good, will change.

>
> > +     }
> > +
> > +out:
> > +     return err;
> > +}
> > +
>
> [...]
>
> > +
> > +/*
> > + * trigger the leader prog on each cpu, so the cgrp_reading map could get
> > + * the latest results.
> > + */
> > +static int bperf_cgrp__sync_counters(struct evlist *evlist)
> > +{
> > +     int i, cpu;
> > +     int nr_cpus = evlist->core.all_cpus->nr;
> > +     int prog_fd = bpf_program__fd(skel->progs.trigger_read);
> > +
> > +     for (i = 0; i < nr_cpus; i++) {
> > +             cpu = evlist->core.all_cpus->map[i];
> > +             bperf_trigger_reading(prog_fd, cpu);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int bperf_cgrp__enable(struct evsel *evsel)
> > +{
>
> Do we need to call bperf_cgrp__sync_counters() before setting enabled to 1?
> If we don't, we may count some numbers before setting enabled to 1, no?

Actually it'll update the prev_readings even if enabled = 0.
So I think it should get the correct counts after setting it to 1
without the bperf_cgrp__sync_counters().

Thanks,
Namhyung


>
> > +     skel->bss->enabled = 1;
> > +     return 0;
> > +}
>
> [...]
>
