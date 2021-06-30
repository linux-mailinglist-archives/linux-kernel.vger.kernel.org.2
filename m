Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41A03B8994
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 22:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbhF3UPE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 30 Jun 2021 16:15:04 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:43860 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbhF3UPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 16:15:00 -0400
Received: by mail-lf1-f46.google.com with SMTP id a18so7363046lfs.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 13:12:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qkhtb/Z3/Lfu4wzfzMpPHgn7YGxmP6lS4b+MzhFSQB4=;
        b=iQGDLpNRGn54Nm7lfEcs+IdP83BuElgSwzs0jF5e98iGB4ZFNNKYp0vJQiHdEVnbab
         VAtKXIRpCBdfjsjC62hgJfIQnIn/JMKDc7YhfJBNeqVl2TxMGgZrKbyqQdInE3vSfLV1
         DDI+GYNw3oKxazbsddhk5SH9dmeSpGmvnB4UTXyv82JsLD5RDtb2UxLVCJnMyvoQ26A3
         XKzPl0XC7Ivv0XdfDDx8glccS7Y8c3Nuy2F2D9hNY0ZO36zmQ6C/tMHsdiY8X6SXTGOP
         2tZ/aUMJcAowTrRjABWtp2APiXYeXvjrMyNCTEB9TX5iNdfpRQWpIHebaNjaJMZ2KTTI
         6M6g==
X-Gm-Message-State: AOAM5308hu45yBMnilUW2MlyNnRitSHLSkL6UcRxKVoUvrVc1kdNku9w
        V2aKwoF4WGjt9YctLUwvmY1iPF4eboVdO+27XxI=
X-Google-Smtp-Source: ABdhPJwueC/6wvIbtKqwBTAdjqEjnzvQEIJCQ+6yIx7qdwdWzFqln7AXvH6pxjHXt9PixgbUGy1YHyC+XcVCtjJpeWw=
X-Received: by 2002:ac2:4314:: with SMTP id l20mr3196692lfh.509.1625083948542;
 Wed, 30 Jun 2021 13:12:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210625071826.608504-1-namhyung@kernel.org> <20210625071826.608504-5-namhyung@kernel.org>
 <YNy85M22XZ8Sc/Gz@kernel.org>
In-Reply-To: <YNy85M22XZ8Sc/Gz@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 30 Jun 2021 13:12:17 -0700
Message-ID: <CAM9d7chZmydDJr-QBfGkQ-bWCTOH96sTO6fzrFLaHkgeGYVomw@mail.gmail.com>
Subject: Re: [PATCH 4/4] perf stat: Enable BPF counter with --for-each-cgroup
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Wed, Jun 30, 2021 at 11:50 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, Jun 25, 2021 at 12:18:26AM -0700, Namhyung Kim escreveu:
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
>
> I'll take a stab at fixing these:

Oops, sorry about that.  My build environment didn't catch this..
Will fix it in the v5.

Thanks,
Namhyung

>
> ⬢[acme@toolbox perf]$ make -k CORESIGHT=1 BUILD_BPF_SKEL=1 PYTHON=python3 DEBUG=1 O=/tmp/build/perf -C tools/perf install-bin
> make: Entering directory '/var/home/acme/git/perf/tools/perf'
>   BUILD:   Doing 'make -j24' parallel build
> Warning: Kernel ABI header at 'tools/include/uapi/linux/kvm.h' differs from latest version at 'include/uapi/linux/kvm.h'
> diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
> Warning: Kernel ABI header at 'tools/include/uapi/linux/mount.h' differs from latest version at 'include/uapi/linux/mount.h'
> diff -u tools/include/uapi/linux/mount.h include/uapi/linux/mount.h
> Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
> diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h
> Warning: Kernel ABI header at 'tools/arch/x86/include/asm/msr-index.h' differs from latest version at 'arch/x86/include/asm/msr-index.h'
> diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h
> Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/kvm.h' differs from latest version at 'arch/x86/include/uapi/asm/kvm.h'
> diff -u tools/arch/x86/include/uapi/asm/kvm.h arch/x86/include/uapi/asm/kvm.h
> Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/svm.h' differs from latest version at 'arch/x86/include/uapi/asm/svm.h'
> diff -u tools/arch/x86/include/uapi/asm/svm.h arch/x86/include/uapi/asm/svm.h
> Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/kvm.h' differs from latest version at 'arch/arm64/include/uapi/asm/kvm.h'
> diff -u tools/arch/arm64/include/uapi/asm/kvm.h arch/arm64/include/uapi/asm/kvm.h
>   DESCEND plugins
>   GEN     /tmp/build/perf/python/perf.so
>   INSTALL trace_plugins
>   CC      /tmp/build/perf/util/bpf_counter_cgroup.o
>   CC      /tmp/build/perf/util/demangle-java.o
>   CC      /tmp/build/perf/util/demangle-rust.o
>   CC      /tmp/build/perf/util/jitdump.o
>   CC      /tmp/build/perf/util/genelf.o
>   CC      /tmp/build/perf/util/genelf_debug.o
>   CC      /tmp/build/perf/util/perf-hooks.o
>   CC      /tmp/build/perf/util/bpf-event.o
> util/bpf_counter_cgroup.c: In function ‘bperf_load_program’:
> util/bpf_counter_cgroup.c:96:23: error: comparison of integer expressions of different signedness: ‘__u32’ {aka ‘unsigned int’} and ‘int’ [-Werror=sign-compare]
>    96 |         for (i = 0; i < nr_cpus; i++) {
>       |                       ^
> util/bpf_counter_cgroup.c:125:43: error: comparison of integer expressions of different signedness: ‘__u32’ {aka ‘unsigned int’} and ‘int’ [-Werror=sign-compare]
>   125 |                         for (cpu = 0; cpu < nr_cpus; cpu++) {
>       |                                           ^
> util/bpf_counter_cgroup.c: In function ‘bperf_cgrp__load’:
> util/bpf_counter_cgroup.c:178:65: error: unused parameter ‘target’ [-Werror=unused-parameter]
>   178 | static int bperf_cgrp__load(struct evsel *evsel, struct target *target)
>       |                                                  ~~~~~~~~~~~~~~~^~~~~~
> util/bpf_counter_cgroup.c: In function ‘bperf_cgrp__install_pe’:
> util/bpf_counter_cgroup.c:195:49: error: unused parameter ‘evsel’ [-Werror=unused-parameter]
>   195 | static int bperf_cgrp__install_pe(struct evsel *evsel, int cpu, int fd)
>       |                                   ~~~~~~~~~~~~~~^~~~~
> util/bpf_counter_cgroup.c:195:60: error: unused parameter ‘cpu’ [-Werror=unused-parameter]
>   195 | static int bperf_cgrp__install_pe(struct evsel *evsel, int cpu, int fd)
>       |                                                        ~~~~^~~
> util/bpf_counter_cgroup.c:195:69: error: unused parameter ‘fd’ [-Werror=unused-parameter]
>   195 | static int bperf_cgrp__install_pe(struct evsel *evsel, int cpu, int fd)
>       |                                                                 ~~~~^~
> util/bpf_counter_cgroup.c: In function ‘bperf_cgrp__enable’:
> util/bpf_counter_cgroup.c:219:45: error: unused parameter ‘evsel’ [-Werror=unused-parameter]
>   219 | static int bperf_cgrp__enable(struct evsel *evsel)
>       |                               ~~~~~~~~~~~~~~^~~~~
> cc1: all warnings being treated as errors
> make[4]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/util/bpf_counter_cgroup.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
> make[3]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:139: util] Error 2
> make[2]: *** [Makefile.perf:655: /tmp/build/perf/perf-in.o] Error 2
> make[1]: *** [Makefile.perf:238: sub-make] Error 2
> make: *** [Makefile:113: install-bin] Error 2
> make: Leaving directory '/var/home/acme/git/perf/tools/perf'
> ⬢[acme@toolbox perf]$
