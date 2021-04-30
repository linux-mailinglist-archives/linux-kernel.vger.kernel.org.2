Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9481A36FEDC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 18:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhD3QrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 12:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhD3QrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 12:47:07 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9968BC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 09:46:19 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id 8so37579135qkv.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 09:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VoOoDnLFffQWFuQJDoXRuYmMtQSKIrCggu2UIiGXyY8=;
        b=UC8XHwJJPxq/WnB1/wnFHgIu+94Ag3mx28oidWfjkfUtDz2r5tNWJblT97mVxqdF+C
         8vciCX37yQAkVoIZLSaW9N384eTTQfr3T+qFEZd/rlRDIQyjBPSu/c4hra8N7hinhRZ1
         KF134/2UTIuuZ88XS56DEE1oq/lzWQHw3cboqH8FXky+ovqbRkU0fXlZwXkIPGCw4ir/
         cW/kv/qPyhS4srQGuozj3l0RfbpmznlABrRgIJM3jRehj66qtthOqm9Arx6VojGob/S6
         oYewy+t0m3sGE5DwVtLa9ruGLbwafmk9+fGvzhZZWD9/qOxnQ1X95tzEM88fEbVU12br
         39gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VoOoDnLFffQWFuQJDoXRuYmMtQSKIrCggu2UIiGXyY8=;
        b=oBLUWaS151MPoMjlbf+f4YHAG+3eCDHcoSmb4WXkQ2/er6Mg89oemTsb48+I33OSUC
         wJud9D+6G/fY702cdhGRuW4+GvfAF+P7Z7ad8j1ebnjujyFbc8nwJGBOL0zFHDr5qn04
         WYEAiBDv03lWRQdhS1UVbfZDraOFunLqKUW/MGOTNolhRwsBj0AlaWaBOml2lXITXv+Z
         c3+MucDlhW0nvu1ROZSqUAHK9y7q0l9fo/8pW5lS6lOQwFCiwF3JZYRuNcawP/BSPl1G
         XAHw+WYeW2JK6a0UxodGhXscg2/kZgGa1XqHSNwdHCv6SfPMN46uZeaK7xjKPBBN9qni
         /1tQ==
X-Gm-Message-State: AOAM533JWMzjWXTxSAMiUvwSKQyFjPpYIxcmZDGw+JZLT8kJqlYh1mdl
        o3eXkx6iMhwoS9H0dDlFFpT3pH8vqw==
X-Google-Smtp-Source: ABdhPJwJT9dEzr5C027R46M1TLlUMqHtNztCbDNjnZ52euCihjuKNXzUCAbbWBhftUt2NOWLLicxhw==
X-Received: by 2002:a37:751:: with SMTP id 78mr6029731qkh.299.1619801178752;
        Fri, 30 Apr 2021 09:46:18 -0700 (PDT)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id k15sm1846278qke.55.2021.04.30.09.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 09:46:18 -0700 (PDT)
Date:   Fri, 30 Apr 2021 12:46:16 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        honnappa.nagarahalli@arm.com, Zachary.Leaf@arm.com,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 7/9] perf: arm64: Add test for userspace counter
 access on heterogeneous systems
Message-ID: <20210430164616.pzb7yxrsugexso25@gabell>
References: <20210420031511.2348977-1-robh@kernel.org>
 <20210420031511.2348977-8-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210420031511.2348977-8-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 10:15:09PM -0500, Rob Herring wrote:
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

Hello,

I got the following compile error with aarch64 on Fedora33.

    # make tools/perf
    ...
    In file included from arch/arm64/tests/arch-tests.c:4:
    /root//libperf_v7/tools/perf/arch/arm64/include/arch-tests.h:10:5: error: redundant redeclaration of ‘test__arch_unwind_sample’ [-Werror=redundant-decls]
       10 | int test__arch_unwind_sample(struct perf_sample *sample,
          |     ^~~~~~~~~~~~~~~~~~~~~~~~
    In file included from arch/arm64/tests/arch-tests.c:3:
    /root//libperf_v7/tools/perf/tests/tests.h:140:5: note: previous declaration of ‘test__arch_unwind_sample’ was here
      140 | int test__arch_unwind_sample(struct perf_sample *sample,
          |     ^~~~~~~~~~~~~~~~~~~~~~~~
    cc1: all warnings being treated as errors
    make[8]: *** [/root//libperf_v7/tools/build/Makefile.build:97: /root/libperf_v7/tools/perf/arch/arm64/tests/arch-tests.o] Error 1
    make[8]: *** Waiting for unfinished jobs....
    In file included from arch/arm64/tests/user-events.c:13:
    /root//libperf_v7/tools/perf/arch/arm64/include/arch-tests.h:10:5: error: redundant redeclaration of ‘test__arch_unwind_sample’ [-Werror=redundant-decls]
       10 | int test__arch_unwind_sample(struct perf_sample *sample,
          |     ^~~~~~~~~~~~~~~~~~~~~~~~
    In file included from arch/arm64/tests/user-events.c:12:
    /root//libperf_v7/tools/perf/tests/tests.h:140:5: note: previous declaration of ‘test__arch_unwind_sample’ was here
      140 | int test__arch_unwind_sample(struct perf_sample *sample,
          |     ^~~~~~~~~~~~~~~~~~~~~~~~
    cc1: all warnings being treated as errors
    ...

The error is gone after the following patch is applied.

---
 tools/perf/arch/arm64/include/arch-tests.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/tools/perf/arch/arm64/include/arch-tests.h b/tools/perf/arch/arm64/include/arch-tests.h
index ddfa7460e..7ff2e29bd 100644
--- a/tools/perf/arch/arm64/include/arch-tests.h
+++ b/tools/perf/arch/arm64/include/arch-tests.h
@@ -4,13 +4,6 @@
 
 #include <linux/compiler.h>
 
-#ifdef HAVE_DWARF_UNWIND_SUPPORT
-struct thread;
-struct perf_sample;
-int test__arch_unwind_sample(struct perf_sample *sample,
-			     struct thread *thread);
-#endif
-
 extern struct test arch_tests[];
 int test__rd_pinned(struct test __maybe_unused *test,
 		       int __maybe_unused subtest);
-- 

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
