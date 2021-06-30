Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E4E3B88C2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 20:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbhF3Swq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 14:52:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:43620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233046AbhF3Swo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 14:52:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D39C6142C;
        Wed, 30 Jun 2021 18:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625079015;
        bh=Rw9dgEoEHUJsuWayKj0bW0RB2jLK+V/sNVZKAJFLewA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VGkJ2yAsWKn+WccNOGovczJATePNFbyNKvsG5SDeiuaRZFejawwmuBL6svnjUtufM
         lbTyg7nkoxZqJVD/JpGG0Kf1RNXobFiY8Pe1NJ0BTnI1k/hvWsIiDasrCPVhiX00Pc
         D2e5fnQHTBCsDgOj1stQMXzKwSTxUngh1QhEUx22ueiCIUWXpAsH+iwRgFIQc7hgz0
         qsWggavwOZOpOH7MIAC8QdFydha1d5lHaTfD7o3aEQ7tgstLKR54zQbXs7MiVEi5GY
         K16clCGE2g9mCDbj8/1spDkj8YksuKduIGGi9F5Hzkp0shHQGFSlMYORTF7J/t5uA3
         AWTF8ieqhbBpw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C65AC40B1A; Wed, 30 Jun 2021 15:50:12 -0300 (-03)
Date:   Wed, 30 Jun 2021 15:50:12 -0300
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
Message-ID: <YNy85M22XZ8Sc/Gz@kernel.org>
References: <20210625071826.608504-1-namhyung@kernel.org>
 <20210625071826.608504-5-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210625071826.608504-5-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jun 25, 2021 at 12:18:26AM -0700, Namhyung Kim escreveu:
> Recently bperf was added to use BPF to count perf events for various
> purposes.  This is an extension for the approach and targetting to
> cgroup usages.
> 
> Unlike the other bperf, it doesn't share the events with other
> processes but it'd reduce unnecessary events (and the overhead of
> multiplexing) for each monitored cgroup within the perf session.
> 
> When --for-each-cgroup is used with --bpf-counters, it will open
> cgroup-switches event per cpu internally and attach the new BPF
> program to read given perf_events and to aggregate the results for
> cgroups.  It's only called when task is switched to a task in a
> different cgroup.

I'll take a stab at fixing these:

⬢[acme@toolbox perf]$ make -k CORESIGHT=1 BUILD_BPF_SKEL=1 PYTHON=python3 DEBUG=1 O=/tmp/build/perf -C tools/perf install-bin
make: Entering directory '/var/home/acme/git/perf/tools/perf'
  BUILD:   Doing 'make -j24' parallel build
Warning: Kernel ABI header at 'tools/include/uapi/linux/kvm.h' differs from latest version at 'include/uapi/linux/kvm.h'
diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
Warning: Kernel ABI header at 'tools/include/uapi/linux/mount.h' differs from latest version at 'include/uapi/linux/mount.h'
diff -u tools/include/uapi/linux/mount.h include/uapi/linux/mount.h
Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h
Warning: Kernel ABI header at 'tools/arch/x86/include/asm/msr-index.h' differs from latest version at 'arch/x86/include/asm/msr-index.h'
diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h
Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/kvm.h' differs from latest version at 'arch/x86/include/uapi/asm/kvm.h'
diff -u tools/arch/x86/include/uapi/asm/kvm.h arch/x86/include/uapi/asm/kvm.h
Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/svm.h' differs from latest version at 'arch/x86/include/uapi/asm/svm.h'
diff -u tools/arch/x86/include/uapi/asm/svm.h arch/x86/include/uapi/asm/svm.h
Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/kvm.h' differs from latest version at 'arch/arm64/include/uapi/asm/kvm.h'
diff -u tools/arch/arm64/include/uapi/asm/kvm.h arch/arm64/include/uapi/asm/kvm.h
  DESCEND plugins
  GEN     /tmp/build/perf/python/perf.so
  INSTALL trace_plugins
  CC      /tmp/build/perf/util/bpf_counter_cgroup.o
  CC      /tmp/build/perf/util/demangle-java.o
  CC      /tmp/build/perf/util/demangle-rust.o
  CC      /tmp/build/perf/util/jitdump.o
  CC      /tmp/build/perf/util/genelf.o
  CC      /tmp/build/perf/util/genelf_debug.o
  CC      /tmp/build/perf/util/perf-hooks.o
  CC      /tmp/build/perf/util/bpf-event.o
util/bpf_counter_cgroup.c: In function ‘bperf_load_program’:
util/bpf_counter_cgroup.c:96:23: error: comparison of integer expressions of different signedness: ‘__u32’ {aka ‘unsigned int’} and ‘int’ [-Werror=sign-compare]
   96 |         for (i = 0; i < nr_cpus; i++) {
      |                       ^
util/bpf_counter_cgroup.c:125:43: error: comparison of integer expressions of different signedness: ‘__u32’ {aka ‘unsigned int’} and ‘int’ [-Werror=sign-compare]
  125 |                         for (cpu = 0; cpu < nr_cpus; cpu++) {
      |                                           ^
util/bpf_counter_cgroup.c: In function ‘bperf_cgrp__load’:
util/bpf_counter_cgroup.c:178:65: error: unused parameter ‘target’ [-Werror=unused-parameter]
  178 | static int bperf_cgrp__load(struct evsel *evsel, struct target *target)
      |                                                  ~~~~~~~~~~~~~~~^~~~~~
util/bpf_counter_cgroup.c: In function ‘bperf_cgrp__install_pe’:
util/bpf_counter_cgroup.c:195:49: error: unused parameter ‘evsel’ [-Werror=unused-parameter]
  195 | static int bperf_cgrp__install_pe(struct evsel *evsel, int cpu, int fd)
      |                                   ~~~~~~~~~~~~~~^~~~~
util/bpf_counter_cgroup.c:195:60: error: unused parameter ‘cpu’ [-Werror=unused-parameter]
  195 | static int bperf_cgrp__install_pe(struct evsel *evsel, int cpu, int fd)
      |                                                        ~~~~^~~
util/bpf_counter_cgroup.c:195:69: error: unused parameter ‘fd’ [-Werror=unused-parameter]
  195 | static int bperf_cgrp__install_pe(struct evsel *evsel, int cpu, int fd)
      |                                                                 ~~~~^~
util/bpf_counter_cgroup.c: In function ‘bperf_cgrp__enable’:
util/bpf_counter_cgroup.c:219:45: error: unused parameter ‘evsel’ [-Werror=unused-parameter]
  219 | static int bperf_cgrp__enable(struct evsel *evsel)
      |                               ~~~~~~~~~~~~~~^~~~~
cc1: all warnings being treated as errors
make[4]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/util/bpf_counter_cgroup.o] Error 1
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:139: util] Error 2
make[2]: *** [Makefile.perf:655: /tmp/build/perf/perf-in.o] Error 2
make[1]: *** [Makefile.perf:238: sub-make] Error 2
make: *** [Makefile:113: install-bin] Error 2
make: Leaving directory '/var/home/acme/git/perf/tools/perf'
⬢[acme@toolbox perf]$
