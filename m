Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7096A33C144
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 17:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbhCOQKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 12:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbhCOQJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 12:09:50 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EB9C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 09:09:50 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id b130so32151713qkc.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 09:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dn/BYdPmPgpvcXruqRlax0DqbdC/XbjJpw3iTQ9fPJs=;
        b=JCGTGkeIH3bXXwKj5NEZMJj68zxYSDeRq84Frf+K2wUc5D1C+igHbEK1yKZnPGpGKb
         YqYuyWj3CkXKI00iIA5LSSidrZzDbNSxuDumModgqSHYQi4EdajujbWyHKNbCLcNZVnT
         ISiLWD2lZeo0QMDGELKlRBFpc3BQywfpG1OkbDGKuHiT/4NxdxX5R1R77SshR50KIM8Y
         s/+d7t/6tV8Bom6C1F0hNvtBP81v/f5QwistYualIopP5YiGK+ZE9atdVmHBrxE1CSVJ
         lknsdEZTeV9D6vmqz1IFt0P480EUTB6MrePLta5zepTDLBPjSJpeXO/6Gc79daPAhHte
         b8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dn/BYdPmPgpvcXruqRlax0DqbdC/XbjJpw3iTQ9fPJs=;
        b=pxg06MejGMHfOXcuvVAW5FwY+Z2F7dZQgJTjOwXqcOgoqvdfV8GuUIY6QmFAgtg9Pq
         ANKSLr/0y6bvShvFSqpSGXXuQcaUJ8T5U9x1tPy/Kf5egDh+KScbGU1eevjOUjdhf6Vf
         2CuwR7rInvhRUh+BVDqbSjdlv4hjCIkUwmaFlbf8sHSbKHocSWy5HjghVa7F+e1cfd23
         Kumh6Nd4tfOPZMLNfvTGCV2DQeJwxa2Q9CH53qVZ6vD9xO9Yb4MSvOiSk8HBHs4bvn6X
         G1++e8IIp3j0YadNhf7hC3N87Dq0ulpeawlah98Bi0FJDYUyZlKHoHe/1o/pRNpI3Gi0
         lD1A==
X-Gm-Message-State: AOAM532/mnXDxw2Z08KnphZGv2u7IFz6jOw+b76nSpc/53csQHYkvn9N
        Jjk5ssZRSA6lvLV/15Ix7w==
X-Google-Smtp-Source: ABdhPJzhTS+wIL85cPmmVJCrnVbLEw2+1k4TqV13oxzV2fECiaKQ7BxpFlKwR7l2bHxz2ObUJwb2GQ==
X-Received: by 2002:a05:620a:2206:: with SMTP id m6mr25563559qkh.176.1615824589604;
        Mon, 15 Mar 2021 09:09:49 -0700 (PDT)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id r17sm11015224qtx.62.2021.03.15.09.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 09:09:48 -0700 (PDT)
Date:   Mon, 15 Mar 2021 12:09:46 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        honnappa.nagarahalli@arm.com, Zachary.Leaf@arm.com,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 08/10] perf: arm64: Add test for userspace counter
 access on heterogeneous systems
Message-ID: <20210315160946.k7l5dwlgsbaeytd6@gabell>
References: <20210311000837.3630499-1-robh@kernel.org>
 <20210311000837.3630499-9-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311000837.3630499-9-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 05:08:35PM -0700, Rob Herring wrote:
> Userspace counter access only works on heterogeneous systems with some
> restrictions. The userspace process must be pinned to a homogeneous
> subset of CPUs and must open the corresponding PMU for those CPUs. This
> commit adds a test implementing these requirements.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v6:
>  - Add a check on cap_user_rdpmc
> v5:
>  - Adapt to libperf mmap API changes
> v4:
>  - Update perf_evsel__mmap params
> v2:
>  - Drop all but heterogeneous test as others covered by libperf tests
>  - Rework to use libperf
> ---
>  tools/perf/arch/arm64/include/arch-tests.h |   7 +
>  tools/perf/arch/arm64/tests/Build          |   1 +
>  tools/perf/arch/arm64/tests/arch-tests.c   |   4 +
>  tools/perf/arch/arm64/tests/user-events.c  | 177 +++++++++++++++++++++
>  4 files changed, 189 insertions(+)
>  create mode 100644 tools/perf/arch/arm64/tests/user-events.c
> 
> diff --git a/tools/perf/arch/arm64/include/arch-tests.h b/tools/perf/arch/arm64/include/arch-tests.h
> index 90ec4c8cb880..380ad34a3f09 100644
> --- a/tools/perf/arch/arm64/include/arch-tests.h
> +++ b/tools/perf/arch/arm64/include/arch-tests.h
> @@ -2,11 +2,18 @@
>  #ifndef ARCH_TESTS_H
>  #define ARCH_TESTS_H
>  
> +#include <linux/compiler.h>
> +
>  #ifdef HAVE_DWARF_UNWIND_SUPPORT
>  struct thread;
>  struct perf_sample;
> +int test__arch_unwind_sample(struct perf_sample *sample,
> +			     struct thread *thread);
>  #endif

I got the following compile error with aarch64:

    # make tools/perf
    ...
      GEN      /root/linux/tools/perf/python/perf.so
      CC       /root/linux/tools/perf/arch/arm64/tests/user-events.o
      CC       /root/linux/tools/perf/arch/arm64/tests/arch-tests.o
    In file included from arch/arm64/tests/arch-tests.c:4:
    /root/linux/tools/perf/arch/arm64/include/arch-tests.h:10:5: error: redundant redeclaration of 'test__arch_unwind_sample' [-Werror=redundant-decls]
     int test__arch_unwind_sample(struct perf_sample *sample,
         ^~~~~~~~~~~~~~~~~~~~~~~~
    In file included from arch/arm64/tests/arch-tests.c:3:
    /root/linux/tools/perf/tests/tests.h:140:5: note: previous declaration of 'test__arch_unwind_sample' was here
     int test__arch_unwind_sample(struct perf_sample *sample,
         ^~~~~~~~~~~~~~~~~~~~~~~~
    cc1: all warnings being treated as errors
    make[8]: *** [/root/linux/tools/build/Makefile.build:97: /root/linux/tools/perf/arch/arm64/tests/arch-tests.o] Error 1

That's because test__arch_unwind_sample() is in tools/perf/tests/tests.h as well.

    tools/perf/tests/tests.h:
    ...
    #if defined(__arm__) || defined(__aarch64__)
    #ifdef HAVE_DWARF_UNWIND_SUPPORT
    struct thread;
    struct perf_sample;
    int test__arch_unwind_sample(struct perf_sample *sample,
    			     struct thread *thread);
    #endif
    #endif

I'm not sure the best way to resolve the error, but the error is gone
with the following additional patch.
Could you take a look it?

diff --git a/tools/perf/arch/arm64/include/arch-tests.h b/tools/perf/arch/arm64/include/arch-tests.h
index ddfa7460e1e1..7ff2e29bdc1c 100644
--- a/tools/perf/arch/arm64/include/arch-tests.h
+++ b/tools/perf/arch/arm64/include/arch-tests.h
@@ -4,13 +4,6 @@
 
 #include <linux/compiler.h>
 
-#ifdef HAVE_DWARF_UNWIND_SUPPORT
-struct thread;
-struct perf_sample;
-int test__arch_unwind_sample(struct perf_sample *sample,
-                            struct thread *thread);
-#endif
-
 extern struct test arch_tests[];
 int test__rd_pinned(struct test __maybe_unused *test,
                       int __maybe_unused subtest);

Thanks!
Masa

>  
>  extern struct test arch_tests[];
> +int test__rd_pinned(struct test __maybe_unused *test,
> +		       int __maybe_unused subtest);
> +
>  
>  #endif
> diff --git a/tools/perf/arch/arm64/tests/Build b/tools/perf/arch/arm64/tests/Build
> index a61c06bdb757..3f9a20c17fc6 100644
> --- a/tools/perf/arch/arm64/tests/Build
> +++ b/tools/perf/arch/arm64/tests/Build
> @@ -1,4 +1,5 @@
>  perf-y += regs_load.o
>  perf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
>  
> +perf-y += user-events.o
>  perf-y += arch-tests.o
> diff --git a/tools/perf/arch/arm64/tests/arch-tests.c b/tools/perf/arch/arm64/tests/arch-tests.c
> index 5b1543c98022..80ce7bd3c16d 100644
> --- a/tools/perf/arch/arm64/tests/arch-tests.c
> +++ b/tools/perf/arch/arm64/tests/arch-tests.c
> @@ -10,6 +10,10 @@ struct test arch_tests[] = {
>  		.func = test__dwarf_unwind,
>  	},
>  #endif
> +	{
> +		.desc = "Pinned CPU user counter access",
> +		.func = test__rd_pinned,
> +	},
>  	{
>  		.func = NULL,
>  	},
> diff --git a/tools/perf/arch/arm64/tests/user-events.c b/tools/perf/arch/arm64/tests/user-events.c
> new file mode 100644
> index 000000000000..c8efc6b369e6
> --- /dev/null
> +++ b/tools/perf/arch/arm64/tests/user-events.c
> @@ -0,0 +1,177 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <unistd.h>
> +#include <sched.h>
> +#include <cpumap.h>
> +
> +#include <perf/core.h>
> +#include <perf/threadmap.h>
> +#include <perf/evsel.h>
> +
> +#include "pmu.h"
> +#include "debug.h"
> +#include "tests/tests.h"
> +#include "arch-tests.h"
> +
> +static int run_test(struct perf_evsel *evsel)
> +{
> +	int n;
> +	volatile int tmp = 0;
> +	u64 delta, i, loops = 1000;
> +	struct perf_counts_values counts = { .val = 0 };
> +
> +	for (n = 0; n < 6; n++) {
> +		u64 stamp, now;
> +
> +		perf_evsel__read(evsel, 0, 0, &counts);
> +		stamp = counts.val;
> +
> +		for (i = 0; i < loops; i++)
> +			tmp++;
> +
> +		perf_evsel__read(evsel, 0, 0, &counts);
> +		now = counts.val;
> +		loops *= 10;
> +
> +		delta = now - stamp;
> +		pr_debug("%14d: %14llu\n", n, (long long)delta);
> +
> +		if (!delta)
> +			break;
> +	}
> +	return delta ? 0 : -1;
> +}
> +
> +static struct perf_pmu *pmu_for_cpu(int cpu)
> +{
> +	int acpu, idx;
> +	struct perf_pmu *pmu = NULL;
> +
> +	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
> +		if (pmu->is_uncore)
> +			continue;
> +		perf_cpu_map__for_each_cpu(acpu, idx, pmu->cpus)
> +			if (acpu == cpu)
> +				return pmu;
> +	}
> +	return NULL;
> +}
> +
> +static bool pmu_is_homogeneous(void)
> +{
> +	int core_cnt = 0;
> +	struct perf_pmu *pmu = NULL;
> +
> +	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
> +		if (!pmu->is_uncore && !perf_cpu_map__empty(pmu->cpus))
> +			core_cnt++;
> +	}
> +	return core_cnt == 1;
> +}
> +
> +static int libperf_print(enum libperf_print_level level,
> +			 const char *fmt, va_list ap)
> +{
> +	(void)level;
> +	return vfprintf(stderr, fmt, ap);
> +}
> +
> +static struct perf_evsel *perf_init(struct perf_event_attr *attr)
> +{
> +	int err;
> +	struct perf_thread_map *threads;
> +	struct perf_evsel *evsel;
> +	struct perf_event_mmap_page *pc;
> +
> +	libperf_init(libperf_print);
> +
> +	threads = perf_thread_map__new_dummy();
> +	if (!threads) {
> +		pr_err("failed to create threads\n");
> +		return NULL;
> +	}
> +
> +	perf_thread_map__set_pid(threads, 0, 0);
> +
> +	evsel = perf_evsel__new(attr);
> +	if (!evsel) {
> +		pr_err("failed to create evsel\n");
> +		goto out_thread;
> +	}
> +
> +	err = perf_evsel__open(evsel, NULL, threads);
> +	if (err) {
> +		pr_err("failed to open evsel\n");
> +		goto out_open;
> +	}
> +
> +	if (perf_evsel__mmap(evsel, 0)) {
> +		pr_err("failed to mmap evsel\n");
> +		goto out_mmap;
> +	}
> +
> +	pc = perf_evsel__mmap_base(evsel, 0, 0);
> +	if (!pc->cap_user_rdpmc) {
> +		pr_err("userspace access not enabled\n");
> +		goto out_mmap;
> +	}
> +
> +	return evsel;
> +
> +out_mmap:
> +	perf_evsel__close(evsel);
> +out_open:
> +	perf_evsel__delete(evsel);
> +out_thread:
> +	perf_thread_map__put(threads);
> +	return NULL;
> +}
> +
> +int test__rd_pinned(struct test __maybe_unused *test,
> +		    int __maybe_unused subtest)
> +{
> +	int cpu, cputmp, ret = -1;
> +	struct perf_evsel *evsel;
> +	struct perf_event_attr attr = {
> +		.config = 0x8, /* Instruction count */
> +		.config1 = 0, /* 32-bit counter */
> +		.exclude_kernel = 1,
> +	};
> +	cpu_set_t cpu_set;
> +	struct perf_pmu *pmu;
> +
> +	if (pmu_is_homogeneous())
> +		return TEST_SKIP;
> +
> +	cpu = sched_getcpu();
> +	pmu = pmu_for_cpu(cpu);
> +	if (!pmu)
> +		return -1;
> +	attr.type = pmu->type;
> +
> +	CPU_ZERO(&cpu_set);
> +	perf_cpu_map__for_each_cpu(cpu, cputmp, pmu->cpus)
> +		CPU_SET(cpu, &cpu_set);
> +	if (sched_setaffinity(0, sizeof(cpu_set), &cpu_set) < 0)
> +		pr_err("Could not set affinity\n");
> +
> +	evsel = perf_init(&attr);
> +	if (!evsel)
> +		return -1;
> +
> +	perf_cpu_map__for_each_cpu(cpu, cputmp, pmu->cpus) {
> +		CPU_ZERO(&cpu_set);
> +		CPU_SET(cpu, &cpu_set);
> +		if (sched_setaffinity(0, sizeof(cpu_set), &cpu_set) < 0)
> +			pr_err("Could not set affinity\n");
> +
> +		pr_debug("Running on CPU %d\n", cpu);
> +
> +		ret = run_test(evsel);
> +		if (ret)
> +			break;
> +	}
> +
> +	perf_evsel__close(evsel);
> +	perf_evsel__delete(evsel);
> +	return ret;
> +}
> -- 
> 2.27.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
