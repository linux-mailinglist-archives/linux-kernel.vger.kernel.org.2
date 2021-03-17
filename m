Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D8D33E918
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 06:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhCQF3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 01:29:48 -0400
Received: from mail-qv1-f47.google.com ([209.85.219.47]:47057 "EHLO
        mail-qv1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhCQF3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 01:29:40 -0400
Received: by mail-qv1-f47.google.com with SMTP id j17so825183qvo.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 22:29:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ctdN4TeyqzaNOqRMHx1C8Oo16k++Z/liv1N61G/8B50=;
        b=KAmZRZbIKTixs0AIyVHRMhLySJoZ9atuq3Fz5B6irtXTaxMSUINVKZR+B00bG+5L1s
         yRCAmxxKhIcR6v/SJ7JggI8ouw6DlZnDuLUbcHx9Yy3C0uuR2tGSCg3YalMmeWxCWp2O
         64i7w+ocAt/nR1FHKOSz8keTY2lZNNM5Ctnuz2M4+WoaID+fWzgAIc9dbAxpnjXG+/9E
         ZDR4BsYJ3+iNJ+9pFNIua5Eqn+rw+z/xDA1aiqd9dbLoE7sf5YBJRNDubBOGZY727KQ6
         ozQViWWs7PJ4NIJnWCNZhen8FRe4AbzicDcyAyom4dtFVOUT3UYQwcp8PTN1UtWfczXM
         69lw==
X-Gm-Message-State: AOAM530qLdRARNxs2e7tyghdggMvDpf0vyet4Cyv+c6r/aZbD/GyPof7
        BFUPGBbkpb6tUNneKF/nMlfCE5dJ/KaFMbjxwRc=
X-Google-Smtp-Source: ABdhPJzXAGQOSo5N3DOZ4NdadMB5BI6FoKfQ3i12S680rlmk9smquIRxGV7w+qQsIR0mg5E1LAGIDeHHm0VSY41mPUk=
X-Received: by 2002:ad4:4bc7:: with SMTP id l7mr3718683qvw.36.1615958979966;
 Tue, 16 Mar 2021 22:29:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210316211837.910506-1-songliubraving@fb.com>
In-Reply-To: <20210316211837.910506-1-songliubraving@fb.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 17 Mar 2021 14:29:28 +0900
Message-ID: <CAM9d7ci=hfFjq3+XuBcCZ0TUJxv6AmdFk0dkHFQD3wx27aJMjA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] perf-stat: share hardware PMCs with BPF
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Song,

On Wed, Mar 17, 2021 at 6:18 AM Song Liu <songliubraving@fb.com> wrote:
>
> perf uses performance monitoring counters (PMCs) to monitor system
> performance. The PMCs are limited hardware resources. For example,
> Intel CPUs have 3x fixed PMCs and 4x programmable PMCs per cpu.
>
> Modern data center systems use these PMCs in many different ways:
> system level monitoring, (maybe nested) container level monitoring, per
> process monitoring, profiling (in sample mode), etc. In some cases,
> there are more active perf_events than available hardware PMCs. To allow
> all perf_events to have a chance to run, it is necessary to do expensive
> time multiplexing of events.
>
> On the other hand, many monitoring tools count the common metrics (cycles,
> instructions). It is a waste to have multiple tools create multiple
> perf_events of "cycles" and occupy multiple PMCs.

Right, it'd be really helpful when the PMCs are frequently or mostly shared.
But it'd also increase the overhead for uncontended cases as BPF programs
need to run on every context switch.  Depending on the workload, it may
cause a non-negligible performance impact.  So users should be aware of it.

Thanks,
Namhyung

>
> bperf tries to reduce such wastes by allowing multiple perf_events of
> "cycles" or "instructions" (at different scopes) to share PMUs. Instead
> of having each perf-stat session to read its own perf_events, bperf uses
> BPF programs to read the perf_events and aggregate readings to BPF maps.
> Then, the perf-stat session(s) reads the values from these BPF maps.
>
> Changes v1 => v2:
>   1. Add documentation.
>   2. Add a shell test.
>   3. Rename options, default path of the atto-map, and some variables.
>   4. Add a separate patch that moves clock_gettime() in __run_perf_stat()
>      to after enable_counters().
>   5. Make perf_cpu_map for all cpus a global variable.
>   6. Use sysfs__mountpoint() for default attr-map path.
>   7. Use cpu__max_cpu() instead of libbpf_num_possible_cpus().
>   8. Add flag "enabled" to the follower program. Then move follower attach
>      to bperf__load() and simplify bperf__enable().
>
> Song Liu (3):
>   perf-stat: introduce bperf, share hardware PMCs with BPF
>   perf-stat: measure t0 and ref_time after enable_counters()
>   perf-test: add a test for perf-stat --bpf-counters option
>
>  tools/perf/Documentation/perf-stat.txt        |  11 +
>  tools/perf/Makefile.perf                      |   1 +
>  tools/perf/builtin-stat.c                     |  20 +-
>  tools/perf/tests/shell/stat_bpf_counters.sh   |  34 ++
>  tools/perf/util/bpf_counter.c                 | 519 +++++++++++++++++-
>  tools/perf/util/bpf_skel/bperf.h              |  14 +
>  tools/perf/util/bpf_skel/bperf_follower.bpf.c |  69 +++
>  tools/perf/util/bpf_skel/bperf_leader.bpf.c   |  46 ++
>  tools/perf/util/bpf_skel/bperf_u.h            |  14 +
>  tools/perf/util/evsel.h                       |  20 +-
>  tools/perf/util/target.h                      |   4 +-
>  11 files changed, 742 insertions(+), 10 deletions(-)
>  create mode 100755 tools/perf/tests/shell/stat_bpf_counters.sh
>  create mode 100644 tools/perf/util/bpf_skel/bperf.h
>  create mode 100644 tools/perf/util/bpf_skel/bperf_follower.bpf.c
>  create mode 100644 tools/perf/util/bpf_skel/bperf_leader.bpf.c
>  create mode 100644 tools/perf/util/bpf_skel/bperf_u.h
>
> --
> 2.30.2
