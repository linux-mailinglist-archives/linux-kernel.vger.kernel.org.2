Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D6C3B2700
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 07:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhFXFvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 01:51:45 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:35446 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhFXFvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 01:51:42 -0400
Received: by mail-lf1-f45.google.com with SMTP id u13so8236825lfk.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 22:49:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=noEUIyDdQVPOjvsU816MKdfUlbrdBcO3H+2xDNjhF54=;
        b=n0MtRK0pssCbwzF72XTPR6RyXxdRbnN2a165wBopEEPPHjivhkR1CIgNxWKagLiWbj
         ZRd2SMDHN1d4CeC1lhtSolm37bdGyge41n/j6z/i4BoXrM+WUINy/xYnVqFD8xv4WiTd
         lIO+FQa3sv2BV9O0NL/C9P+gNLxVs8tCFhVWnHm7fVEOMfiqPbddJLOyFfBPcBfDdBE7
         9BVD9JpIstfF2KAtBmj6qHVpKMj60JAkyYNnIPCe7WzfhgK/g9WCVQkYJbtA0WZ+Mrbu
         Aq8ZtJHLSDnus8Bw6ecMLoki4V8hU+ukWWwr+iHX6/CtEvPgEINWwkgHvBLYr3I7e1v3
         07lg==
X-Gm-Message-State: AOAM531ucEHnW0eoD245mU8U9H37ON+8TjabZFOAWd6Le7M6gN+kNckJ
        Uc7ooWKgkiU8lpIv2ZZAQOfbfwnOOjrziSt0Ol0=
X-Google-Smtp-Source: ABdhPJwzfnc2KPreHT3ZqVcgvip+CEQRzVgLCdDUZKyLfbaUhfSLsYq1UnntlVcOJYtBaV5jtojgwGt/IJ9WdZ7vyEQ=
X-Received: by 2002:a19:7b1c:: with SMTP id w28mr2541827lfc.509.1624513762653;
 Wed, 23 Jun 2021 22:49:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210622071221.128271-1-namhyung@kernel.org> <20210622071221.128271-4-namhyung@kernel.org>
 <C2ABEEDF-04AF-4AB5-BA6C-C8AC5E8579C6@fb.com>
In-Reply-To: <C2ABEEDF-04AF-4AB5-BA6C-C8AC5E8579C6@fb.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 23 Jun 2021 22:49:11 -0700
Message-ID: <CAM9d7ci3kS+=ObL_mfx1Qi2rQ7SYRjdLQLJ5+SVmRUsaUepj_w@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf stat: Enable BPF counter with --for-each-cgroup
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

On Wed, Jun 23, 2021 at 9:54 PM Song Liu <songliubraving@fb.com> wrote:
>
>
>
> > On Jun 22, 2021, at 12:12 AM, Namhyung Kim <namhyung@kernel.org> wrote:
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
> > tools/perf/Makefile.perf                    |   7 +-
> > tools/perf/util/Build                       |   1 +
> > tools/perf/util/bpf_counter.c               |   5 +
> > tools/perf/util/bpf_counter_cgroup.c        | 337 ++++++++++++++++++++
> > tools/perf/util/bpf_skel/bperf_cgroup.bpf.c | 207 ++++++++++++
> > tools/perf/util/cgroup.c                    |   2 +
> > tools/perf/util/cgroup.h                    |   1 +
> > 7 files changed, 559 insertions(+), 1 deletion(-)
> > create mode 100644 tools/perf/util/bpf_counter_cgroup.c
> > create mode 100644 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> >
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index e47f04e5b51e..786cba8f3798 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@ -1015,6 +1015,7 @@ SKEL_OUT := $(abspath $(OUTPUT)util/bpf_skel)
> > SKEL_TMP_OUT := $(abspath $(SKEL_OUT)/.tmp)
> > SKELETONS := $(SKEL_OUT)/bpf_prog_profiler.skel.h
> > SKELETONS += $(SKEL_OUT)/bperf_leader.skel.h $(SKEL_OUT)/bperf_follower.skel.h
> > +SKELETONS += $(SKEL_OUT)/bperf_cgroup.skel.h
> >
> > ifdef BUILD_BPF_SKEL
> > BPFTOOL := $(SKEL_TMP_OUT)/bootstrap/bpftool
> > @@ -1032,7 +1033,11 @@ $(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) | $(SKEL_TMP_OUT)
> >       $(QUIET_CLANG)$(CLANG) -g -O2 -target bpf -Wall -Werror $(BPF_INCLUDE) \
> >         -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@ && $(LLVM_STRIP) -g $@
> >
> > -$(SKEL_OUT)/%.skel.h: $(SKEL_TMP_OUT)/%.bpf.o | $(BPFTOOL)
> > +$(SKEL_OUT)/vmlinux.h:
> > +     $(MAKE) -C ../bpf/bpftool OUTPUT=$(SKEL_TMP_OUT)/ $(SKEL_TMP_OUT)/vmlinux.h
>
> We build bpftool with $(BPFTOOL), which is a few lines above.
> Can we reuse some of that?

Ok, will do.

>
> > +     $(Q)mv $(SKEL_TMP_OUT)/vmlinux.h $(SKEL_OUT)/vmlinux.h
> > +
> > +$(SKEL_OUT)/%.skel.h: $(SKEL_TMP_OUT)/%.bpf.o $(SKEL_OUT)/vmlinux.h | $(BPFTOOL)
> >       $(QUIET_GENSKEL)$(BPFTOOL) gen skeleton $< > $@
> >
> > bpf-skel: $(SKELETONS)
> > diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> > index 95e15d1035ab..700d635448ff 100644
> > --- a/tools/perf/util/Build
> > +++ b/tools/perf/util/Build
> > @@ -140,6 +140,7 @@ perf-y += clockid.o
> > perf-$(CONFIG_LIBBPF) += bpf-loader.o
> > perf-$(CONFIG_LIBBPF) += bpf_map.o
> > perf-$(CONFIG_PERF_BPF_SKEL) += bpf_counter.o
> > +perf-$(CONFIG_PERF_BPF_SKEL) += bpf_counter_cgroup.o
> > perf-$(CONFIG_BPF_PROLOGUE) += bpf-prologue.o
> > perf-$(CONFIG_LIBELF) += symbol-elf.o
> > perf-$(CONFIG_LIBELF) += probe-file.o
> > diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
> > index 974f10e356f0..7812c5d9b826 100644
> > --- a/tools/perf/util/bpf_counter.c
> > +++ b/tools/perf/util/bpf_counter.c
> > @@ -22,6 +22,7 @@
> > #include "evsel.h"
> > #include "evlist.h"
> > #include "target.h"
> > +#include "cgroup.h"
> > #include "cpumap.h"
> > #include "thread_map.h"
> >
> > @@ -792,6 +793,8 @@ struct bpf_counter_ops bperf_ops = {
> >       .destroy    = bperf__destroy,
> > };
> >
> > +extern struct bpf_counter_ops bperf_cgrp_ops;
> > +
> > static inline bool bpf_counter_skip(struct evsel *evsel)
> > {
> >       return list_empty(&evsel->bpf_counter_list) &&
> > @@ -809,6 +812,8 @@ int bpf_counter__load(struct evsel *evsel, struct target *target)
> > {
> >       if (target->bpf_str)
> >               evsel->bpf_counter_ops = &bpf_program_profiler_ops;
> > +     else if (cgrp_event_expanded && target->use_bpf)
> > +             evsel->bpf_counter_ops = &bperf_cgrp_ops;
> >       else if (target->use_bpf || evsel->bpf_counter ||
> >                evsel__match_bpf_counter_events(evsel->name))
> >               evsel->bpf_counter_ops = &bperf_ops;
>
> [...]
>
>
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
> > +static struct xyarray *cgrp_prog_fds;
> > +static struct bperf_cgroup_bpf *skel;
> > +
> > +#define FD(evt, cpu) (*(int *)xyarray__entry(evt->core.fd, cpu, 0))
> > +#define PROG(cpu)    (*(int *)xyarray__entry(cgrp_prog_fds, cpu, 0))
> > +
> > +static void set_max_rlimit(void)
> > +{
> > +     struct rlimit rinf = { RLIM_INFINITY, RLIM_INFINITY };
> > +
> > +     setrlimit(RLIMIT_MEMLOCK, &rinf);
> > +}
> > +
> > +static __u32 bpf_link_get_prog_id(int fd)
> > +{
> > +     struct bpf_link_info link_info = {0};
> > +     __u32 link_info_len = sizeof(link_info);
> > +
> > +     bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
> > +     return link_info.prog_id;
> > +}
>
> How about we move set_max_rlimit() and bpf_link_get_prog_id() to
> a header so we don't have to duplicate it?

Sounds good.

>
> > +
> > +static int bperf_load_program(struct evlist *evlist)
> > +{
> > +     struct bpf_link *link;
> > +     struct evsel *evsel;
> > +     struct cgroup *cgrp, *leader_cgrp;
> > +     __u32 i, cpu, prog_id;
> > +     int nr_cpus = evlist->core.all_cpus->nr;
> > +     int map_size, map_fd;
> > +     int prog_fd, err;
> > +
> > +     skel = bperf_cgroup_bpf__open();
> > +     if (!skel) {
> > +             pr_err("Failed to open cgroup skeleton\n");
> > +             return -1;
> > +     }
> > +
> > +     skel->rodata->num_cpus = nr_cpus;
> > +     skel->rodata->num_events = evlist->core.nr_entries / nr_cgroups;
> > +
> > +     BUG_ON(evlist->core.nr_entries % nr_cgroups != 0);
> > +
> > +     /* we need one copy of events per cpu for reading */
> > +     map_size = nr_cpus * evlist->core.nr_entries / nr_cgroups;
> > +     bpf_map__resize(skel->maps.events, map_size);
> > +     bpf_map__resize(skel->maps.cpu_idx, nr_cpus);
> > +     bpf_map__resize(skel->maps.cgrp_idx, nr_cgroups);
> > +     /* previous result is saved in a per-cpu array */
> > +     map_size = evlist->core.nr_entries / nr_cgroups;
> > +     bpf_map__resize(skel->maps.prev_readings, map_size);
> > +     /* cgroup result needs all events */
> > +     map_size = nr_cpus * evlist->core.nr_entries;
> > +     bpf_map__resize(skel->maps.cgrp_readings, map_size);
>
> We are setting map_size back and forth here.

But they are all different sizes.

>
> [...]
>
>
> > diff --git a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> > new file mode 100644
> > index 000000000000..6d74e93dd1f5
> > --- /dev/null
> > +++ b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> > @@ -0,0 +1,207 @@
> > +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +// Copyright (c) 2021 Facebook
> > +// Copyright (c) 2021 Google
> > +#include "vmlinux.h"
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +#include <bpf/bpf_core_read.h>
> > +
> > +#define MAX_LEVELS  10  // max cgroup hierarchy level: arbitrary
> > +#define MAX_EVENTS  32  // max events per cgroup: arbitrary
> > +
> > +// NOTE: many of map and global data will be modified before loading
> > +//       from the userspace (perf tool) using the skeleton helpers.
> > +
> > +// single set of global perf events to measure
> > +struct {
> > +     __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
> > +     __uint(key_size, sizeof(__u32));
> > +     __uint(value_size, sizeof(int));
> > +     __uint(max_entries, 1);
> > +} events SEC(".maps");
> > +
> > +// from logical cpu number to event index
> > +// useful when user wants to count subset of cpus
> > +struct {
> > +     __uint(type, BPF_MAP_TYPE_HASH);
> > +     __uint(key_size, sizeof(__u32));
> > +     __uint(value_size, sizeof(__u32));
> > +     __uint(max_entries, 1);
> > +} cpu_idx SEC(".maps");
>
> How about we make cpu_idx a percpu array and use 0,1 for
> disable/enable profiling on this cpu?

No, it's to calculate an index to the cgrp_readings map which
has the event x cpu x cgroup number of elements.

It controls enabling events with a global (bss) variable.

>
> > +
> > +// from cgroup id to event index
> > +struct {
> > +     __uint(type, BPF_MAP_TYPE_HASH);
> > +     __uint(key_size, sizeof(__u64));
> > +     __uint(value_size, sizeof(__u32));
> > +     __uint(max_entries, 1);
> > +} cgrp_idx SEC(".maps");
> > +
> > +// per-cpu event snapshots to calculate delta
> > +struct {
> > +     __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> > +     __uint(key_size, sizeof(__u32));
> > +     __uint(value_size, sizeof(struct bpf_perf_event_value));
> > +} prev_readings SEC(".maps");
> > +
> > +// aggregated event values for each cgroup
> > +// will be read from the user-space
> > +struct {
> > +     __uint(type, BPF_MAP_TYPE_ARRAY);
> > +     __uint(key_size, sizeof(__u32));
> > +     __uint(value_size, sizeof(struct bpf_perf_event_value));
> > +} cgrp_readings SEC(".maps");
>
> Maybe also make this a percpu array? This should make the BPF program
> faster.

Maybe.  But I don't know how to access the elements
in a per-cpu map from userspace.

Thanks,
Namhyung


>
> > +
> > +const volatile __u32 num_events = 1;
> > +const volatile __u32 num_cpus = 1;
> > +
> > +int enabled = 0;
> > +int use_cgroup_v2 = 0;
> > +
> [...]
>
