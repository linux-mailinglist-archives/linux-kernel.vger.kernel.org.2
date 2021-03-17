Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA0033F0E5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 14:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhCQNLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 09:11:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:35934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229923AbhCQNL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 09:11:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 999D664F50;
        Wed, 17 Mar 2021 13:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615986688;
        bh=PM/ITx/4cj04FoH3ut8nJkszY5kII9DKsT9EoujwW8I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MJ9lM0VDYBWn8J0Mz+2oQOJEKdF9VdKHdA4WZcQlToQ+ITpphpTe+c594Ei8PjYSM
         boo6Qp3EOVQQanexbMbd/cfomF/sF7Ha/w7NH033d+Mxk9KGCs3PxMLKdWx0b3F7vc
         hQPCPSITbplan8ZR8CgNdl72qLvNGdI6cOMJZ3f0Z59XrZ3TSC91EWsdeWHEnEKc2L
         auK0kmLZhp9IkrOZQNRMzx0XpZu78hOFrfCZJNjDA2XLoIxD9hMfN4zfVSsVZTxy4/
         0gpO1uue1ZvXAHaEwi34gwo7Vke4S1xDJ02UFw5czNxS2zL2fGTTgXkwklyUc9Vd+G
         Dysw2B+KAkk6Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D8FEA40647; Wed, 17 Mar 2021 10:11:24 -0300 (-03)
Date:   Wed, 17 Mar 2021 10:11:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Song Liu <songliubraving@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2 0/3] perf-stat: share hardware PMCs with BPF
Message-ID: <YFH//FRPvrPswhld@kernel.org>
References: <20210316211837.910506-1-songliubraving@fb.com>
 <CAM9d7ci=hfFjq3+XuBcCZ0TUJxv6AmdFk0dkHFQD3wx27aJMjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ci=hfFjq3+XuBcCZ0TUJxv6AmdFk0dkHFQD3wx27aJMjA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 17, 2021 at 02:29:28PM +0900, Namhyung Kim escreveu:
> Hi Song,
> 
> On Wed, Mar 17, 2021 at 6:18 AM Song Liu <songliubraving@fb.com> wrote:
> >
> > perf uses performance monitoring counters (PMCs) to monitor system
> > performance. The PMCs are limited hardware resources. For example,
> > Intel CPUs have 3x fixed PMCs and 4x programmable PMCs per cpu.
> >
> > Modern data center systems use these PMCs in many different ways:
> > system level monitoring, (maybe nested) container level monitoring, per
> > process monitoring, profiling (in sample mode), etc. In some cases,
> > there are more active perf_events than available hardware PMCs. To allow
> > all perf_events to have a chance to run, it is necessary to do expensive
> > time multiplexing of events.
> >
> > On the other hand, many monitoring tools count the common metrics (cycles,
> > instructions). It is a waste to have multiple tools create multiple
> > perf_events of "cycles" and occupy multiple PMCs.
> 
> Right, it'd be really helpful when the PMCs are frequently or mostly shared.
> But it'd also increase the overhead for uncontended cases as BPF programs
> need to run on every context switch.  Depending on the workload, it may
> cause a non-negligible performance impact.  So users should be aware of it.

Would be interesting to, humm, measure both cases to have a firm number
of the impact, how many instructions are added when sharing using
--bpf-counters?

I.e. compare the "expensive time multiplexing of events" with its
avoidance by using --bpf-counters.

Song, have you perfmormed such measurements?

- Arnaldo
 
> Thanks,
> Namhyung
> 
> >
> > bperf tries to reduce such wastes by allowing multiple perf_events of
> > "cycles" or "instructions" (at different scopes) to share PMUs. Instead
> > of having each perf-stat session to read its own perf_events, bperf uses
> > BPF programs to read the perf_events and aggregate readings to BPF maps.
> > Then, the perf-stat session(s) reads the values from these BPF maps.
> >
> > Changes v1 => v2:
> >   1. Add documentation.
> >   2. Add a shell test.
> >   3. Rename options, default path of the atto-map, and some variables.
> >   4. Add a separate patch that moves clock_gettime() in __run_perf_stat()
> >      to after enable_counters().
> >   5. Make perf_cpu_map for all cpus a global variable.
> >   6. Use sysfs__mountpoint() for default attr-map path.
> >   7. Use cpu__max_cpu() instead of libbpf_num_possible_cpus().
> >   8. Add flag "enabled" to the follower program. Then move follower attach
> >      to bperf__load() and simplify bperf__enable().
> >
> > Song Liu (3):
> >   perf-stat: introduce bperf, share hardware PMCs with BPF
> >   perf-stat: measure t0 and ref_time after enable_counters()
> >   perf-test: add a test for perf-stat --bpf-counters option
> >
> >  tools/perf/Documentation/perf-stat.txt        |  11 +
> >  tools/perf/Makefile.perf                      |   1 +
> >  tools/perf/builtin-stat.c                     |  20 +-
> >  tools/perf/tests/shell/stat_bpf_counters.sh   |  34 ++
> >  tools/perf/util/bpf_counter.c                 | 519 +++++++++++++++++-
> >  tools/perf/util/bpf_skel/bperf.h              |  14 +
> >  tools/perf/util/bpf_skel/bperf_follower.bpf.c |  69 +++
> >  tools/perf/util/bpf_skel/bperf_leader.bpf.c   |  46 ++
> >  tools/perf/util/bpf_skel/bperf_u.h            |  14 +
> >  tools/perf/util/evsel.h                       |  20 +-
> >  tools/perf/util/target.h                      |   4 +-
> >  11 files changed, 742 insertions(+), 10 deletions(-)
> >  create mode 100755 tools/perf/tests/shell/stat_bpf_counters.sh
> >  create mode 100644 tools/perf/util/bpf_skel/bperf.h
> >  create mode 100644 tools/perf/util/bpf_skel/bperf_follower.bpf.c
> >  create mode 100644 tools/perf/util/bpf_skel/bperf_leader.bpf.c
> >  create mode 100644 tools/perf/util/bpf_skel/bperf_u.h
> >
> > --
> > 2.30.2

-- 

- Arnaldo
