Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300A33B9271
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 15:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbhGANqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 09:46:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhGANqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 09:46:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99C3F613FD;
        Thu,  1 Jul 2021 13:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625147013;
        bh=ETod3zHyxM26eXwPIY06Iw5iSqjkLxUInHPr6G5aHuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EF+cirrGChqU2nH23thk2UiArxj2bcvPw04gVkjA0eTKIqXA9HbWT+rRwJIVtxkR/
         XXF2h0fioZ3wN+XIQptP1OvtK8KsreghdIWa+bBK57EsczInVBPL9ctPkvLAt+5vaR
         Qb0PBCz2hawwiBeoV5zoNGV0dcLWp7M64fCHK+NCr632xuDdelC/9Lzg+CT5qIXHwM
         hbT3fRzs47h58HDA0CyHVwtZgx2tQxyB+qBBBVH52b3clg5R4XldSH71YeV3mu3kgA
         vkDucnx0fXFkmmk7i+uHhkVjs65KbRc4dOUjOQTGwnJBx2qjj77/2N1TmCL7NCXPY2
         N0Qnj3EiXCtRw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D173D40B1A; Thu,  1 Jul 2021 10:43:28 -0300 (-03)
Date:   Thu, 1 Jul 2021 10:43:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH 4/4] perf stat: Enable BPF counter with --for-each-cgroup
Message-ID: <YN3GgMUFtMCYpNI7@kernel.org>
References: <20210625071826.608504-1-namhyung@kernel.org>
 <20210625071826.608504-5-namhyung@kernel.org>
 <YNy85M22XZ8Sc/Gz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YNy85M22XZ8Sc/Gz@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jun 30, 2021 at 03:50:12PM -0300, Arnaldo Carvalho de Melo escreveu:
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

So, tried some 'make -C tools clean', etc but I'm now stuck with:

  CLANG   /tmp/build/perf/util/bpf_skel/.tmp/bperf_cgroup.bpf.o
util/bpf_skel/bperf_cgroup.bpf.c:4:10: fatal error: 'vmlinux.h' file not found
#include "vmlinux.h"
         ^~~~~~~~~~~
1 error generated.
make[2]: *** [Makefile.perf:1033: /tmp/build/perf/util/bpf_skel/.tmp/bperf_cgroup.bpf.o] Error 1
make[2]: *** Waiting for unfinished jobs....
  CC      /tmp/build/perf/pmu-events/pmu-events.o
  LD      /tmp/build/perf/pmu-events/pmu-events-in.o

Auto-detecting system features:
...                        libbfd: [ on  ]
...        disassembler-four-args: [ on  ]
...                          zlib: [ on  ]
...                        libcap: [ on  ]
...               clang-bpf-co-re: [ on  ]


  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/
  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/


Have to go errands now, will put what I have at tmp.perf/core now.
Please see if you can reproduce, I use this to build:

    make -k CORESIGHT=1 BUILD_BPF_SKEL=1 PYTHON=python3 DEBUG=1 O=/tmp/build/perf -C tools/perf install-bin

- Arnaldo
 
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

-- 

- Arnaldo
