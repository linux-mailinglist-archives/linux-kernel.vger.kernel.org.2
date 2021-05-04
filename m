Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF9C3731FE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 23:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbhEDVmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 17:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbhEDVmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 17:42:04 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCE0C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 14:41:09 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id b11-20020a7bc24b0000b0290148da0694ffso2221570wmj.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 14:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eByLdTcR3kZYZ2FEQ5tF/oEz6aYvsLFRSIL/hHsDCj8=;
        b=HEU7xgnEeSJKZA10SG15z/tUFEeng59skCTFZGeFo483ED7ffK0z2R9X9D+gd9UaqD
         xNTjRp9fNhadqiXTxK9mSnYYXtat4PqRr1BKwjFN8KE1lSqrfnBJYdH6iUdyqJ/HhsAO
         8Hk3Ws3QyWveXCDj24yKTHAoe5G/eMlaFO2eMH4b8TsmSPbrSXSNEtm7Xan8UxpQd81n
         acUY2QRwnX3C9CJ9I6OlJQOmL0jJDbeP20qZYb0B7zQRZ1wBnFLoGDbONANiyjv34VVv
         idJJp4eWkabdkcJRNVIqWq+TFC20Rj0gk9X93ME4ZNEcY/xdUh5KBLYFgqKlGZK9Y05E
         W6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eByLdTcR3kZYZ2FEQ5tF/oEz6aYvsLFRSIL/hHsDCj8=;
        b=qOTRRyysbBVjjX7C5DTffAQzNP//18QO4H9MoAe6TQM6PjSpqfK8D8ui1dG824bBVx
         bMGt7hjOYd+0YqD7LbaOXcVPOZ+Dht76sntx+AheNU2SbRIxvtA21RSBVfw1SHvmok6M
         7G264sYSy/RnTICIc1C7eQnuYDB7l06AP9HnCtGH6rA1FsP6cqUjIxzHe3H39OQo4acr
         nsRv3UnPVq20qkG/hX8bGmVpCGmqx4WqPJCM3h4WGPJcpl6J2wY/+DjMyHKt452AUvQy
         GWCBk3tN/JK4DpkUSwpmww+owY+tFQkYOjSDrYNTm574kXTE2mV8uXCSfxxafPhqKlWA
         u8bA==
X-Gm-Message-State: AOAM531I3J1dq7/BIKaHHsf/4Cc9fmn5IeWEYdMRZK+b1nnZnplJLt6U
        PH+ZAbKJMyzVa3/FL+NE9isic11PgYUhZO5sKQ0W+g==
X-Google-Smtp-Source: ABdhPJxInnJUwirxn1R4K6Kn8JSrmc1DqOKYjB0Jq55eQQoc6tF4Mv9zWdfD9HfS+zqRS4a3xzH62yV4vWeiiA2Wly8=
X-Received: by 2002:a1c:cc0b:: with SMTP id h11mr6406330wmb.87.1620164466796;
 Tue, 04 May 2021 14:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210311000837.3630499-1-robh@kernel.org> <20210311000837.3630499-7-robh@kernel.org>
In-Reply-To: <20210311000837.3630499-7-robh@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 4 May 2021 14:40:52 -0700
Message-ID: <CAP-5=fUEu1EO7GreYYjZ178BH_riYYa0HdY4GZhi=0DdjkCMJg@mail.gmail.com>
Subject: Re: [PATCH v6 06/10] libperf: Add support for user space counter access
To:     Rob Herring <robh@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
        Zachary.Leaf@arm.com, Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 4:08 PM Rob Herring <robh@kernel.org> wrote:
>
> x86 and arm64 can both support direct access of event counters in
> userspace. The access sequence is less than trivial and currently exists
> in perf test code (tools/perf/arch/x86/tests/rdpmc.c) with copies in
> projects such as PAPI and libpfm4.
>
> In order to support usersapce access, an event must be mmapped first
> with perf_evsel__mmap(). Then subsequent calls to perf_evsel__read()
> will use the fast path (assuming the arch supports it).
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v6:
>  - Adapt to mmap changes adding MMAP NULL check
> v5:
>  - Make raw count s64 instead of u64 so that counter width shifting
>    works
>  - Adapt to mmap changes
> v4:
>  - Update perf_evsel__mmap size to pages
> v3:
>  - Split out perf_evsel__mmap() to separate patch
> ---
>  tools/lib/perf/evsel.c                 |  4 ++
>  tools/lib/perf/include/internal/mmap.h |  3 +
>  tools/lib/perf/mmap.c                  | 88 ++++++++++++++++++++++++++
>  tools/lib/perf/tests/test-evsel.c      | 65 +++++++++++++++++++
>  4 files changed, 160 insertions(+)
>
> diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> index 1057e9b15528..4d67343d36c9 100644
> --- a/tools/lib/perf/evsel.c
> +++ b/tools/lib/perf/evsel.c
> @@ -242,6 +242,10 @@ int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
>         if (FD(evsel, cpu, thread) < 0)
>                 return -EINVAL;
>
> +       if (MMAP(evsel, cpu, thread) &&
> +           !perf_mmap__read_self(MMAP(evsel, cpu, thread), count))
> +               return 0;
> +
>         if (readn(FD(evsel, cpu, thread), count->values, size) <= 0)
>                 return -errno;
>
> diff --git a/tools/lib/perf/include/internal/mmap.h b/tools/lib/perf/include/internal/mmap.h
> index be7556e0a2b2..5e3422f40ed5 100644
> --- a/tools/lib/perf/include/internal/mmap.h
> +++ b/tools/lib/perf/include/internal/mmap.h
> @@ -11,6 +11,7 @@
>  #define PERF_SAMPLE_MAX_SIZE (1 << 16)
>
>  struct perf_mmap;
> +struct perf_counts_values;
>
>  typedef void (*libperf_unmap_cb_t)(struct perf_mmap *map);
>
> @@ -52,4 +53,6 @@ void perf_mmap__put(struct perf_mmap *map);
>
>  u64 perf_mmap__read_head(struct perf_mmap *map);
>
> +int perf_mmap__read_self(struct perf_mmap *map, struct perf_counts_values *count);
> +
>  #endif /* __LIBPERF_INTERNAL_MMAP_H */
> diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
> index 79d5ed6c38cc..915469f00cf4 100644
> --- a/tools/lib/perf/mmap.c
> +++ b/tools/lib/perf/mmap.c
> @@ -8,9 +8,11 @@
>  #include <linux/perf_event.h>
>  #include <perf/mmap.h>
>  #include <perf/event.h>
> +#include <perf/evsel.h>
>  #include <internal/mmap.h>
>  #include <internal/lib.h>
>  #include <linux/kernel.h>
> +#include <linux/math64.h>
>  #include "internal.h"
>
>  void perf_mmap__init(struct perf_mmap *map, struct perf_mmap *prev,
> @@ -273,3 +275,89 @@ union perf_event *perf_mmap__read_event(struct perf_mmap *map)
>
>         return event;
>  }
> +
> +#if defined(__i386__) || defined(__x86_64__)
> +static u64 read_perf_counter(unsigned int counter)
> +{
> +       unsigned int low, high;
> +
> +       asm volatile("rdpmc" : "=a" (low), "=d" (high) : "c" (counter));
> +
> +       return low | ((u64)high) << 32;
> +}
> +
> +static u64 read_timestamp(void)
> +{
> +       unsigned int low, high;
> +
> +       asm volatile("rdtsc" : "=a" (low), "=d" (high));
> +
> +       return low | ((u64)high) << 32;
> +}
> +#else
> +static u64 read_perf_counter(unsigned int counter) { return 0; }
> +static u64 read_timestamp(void) { return 0; }
> +#endif
> +
> +int perf_mmap__read_self(struct perf_mmap *map, struct perf_counts_values *count)
> +{
> +       struct perf_event_mmap_page *pc = map->base;
> +       u32 seq, idx, time_mult = 0, time_shift = 0;
> +       u64 cnt, cyc = 0, time_offset = 0, time_cycles = 0, time_mask = ~0ULL;
> +
> +       if (!pc || !pc->cap_user_rdpmc)
> +               return -1;
> +
> +       do {
> +               seq = READ_ONCE(pc->lock);
> +               barrier();
> +
> +               count->ena = READ_ONCE(pc->time_enabled);
> +               count->run = READ_ONCE(pc->time_running);
> +
> +               if (pc->cap_user_time && count->ena != count->run) {
> +                       cyc = read_timestamp();
> +                       time_mult = READ_ONCE(pc->time_mult);
> +                       time_shift = READ_ONCE(pc->time_shift);
> +                       time_offset = READ_ONCE(pc->time_offset);
> +
> +                       if (pc->cap_user_time_short) {
> +                               time_cycles = READ_ONCE(pc->time_cycles);
> +                               time_mask = READ_ONCE(pc->time_mask);
> +                       }

Nit, this is now out of sync with the comment code in perf_event.h.

> +               }
> +
> +               idx = READ_ONCE(pc->index);
> +               cnt = READ_ONCE(pc->offset);
> +               if (pc->cap_user_rdpmc && idx) {
> +                       s64 evcnt = read_perf_counter(idx - 1);
> +                       u16 width = READ_ONCE(pc->pmc_width);
> +
> +                       evcnt <<= 64 - width;
> +                       evcnt >>= 64 - width;
> +                       cnt += evcnt;
> +               } else
> +                       return -1;
> +
> +               barrier();
> +       } while (READ_ONCE(pc->lock) != seq);
> +
> +       if (count->ena != count->run) {
> +               u64 delta;
> +
> +               /* Adjust for cap_usr_time_short, a nop if not */
> +               cyc = time_cycles + ((cyc - time_cycles) & time_mask);
> +
> +               delta = time_offset + mul_u64_u32_shr(cyc, time_mult, time_shift);
> +
> +               count->ena += delta;
> +               if (idx)
> +                       count->run += delta;
> +
> +               cnt = mul_u64_u64_div64(cnt, count->ena, count->run);

Does this still suffer the divide by zero if multiplexing hasn't run
the counter? If so, we still need to add something like:
https://lore.kernel.org/lkml/CAP-5=fVRdqvswtyQMg5cB+ntTGda+SAYskjTQednEH-AeZo13g@mail.gmail.com/

> +       }
> +
> +       count->val = cnt;
> +
> +       return 0;
> +}
> diff --git a/tools/lib/perf/tests/test-evsel.c b/tools/lib/perf/tests/test-evsel.c
> index 0ad82d7a2a51..54fb4809b9ee 100644
> --- a/tools/lib/perf/tests/test-evsel.c
> +++ b/tools/lib/perf/tests/test-evsel.c
> @@ -120,6 +120,69 @@ static int test_stat_thread_enable(void)
>         return 0;
>  }
>
> +static int test_stat_user_read(int event)
> +{
> +       struct perf_counts_values counts = { .val = 0 };
> +       struct perf_thread_map *threads;
> +       struct perf_evsel *evsel;
> +       struct perf_event_mmap_page *pc;
> +       struct perf_event_attr attr = {
> +               .type   = PERF_TYPE_HARDWARE,
> +               .config = event,
> +       };

A nit, previously test-evsel was able to run and pass on a hypervisor.
As now there is a reliance on hardware events the evsel open fails on
a hypervisor. It'd be nice if we could detect running on a hypervisor
and test software events in that case.

Thanks,
Ian

> +       int err, i;
> +
> +       threads = perf_thread_map__new_dummy();
> +       __T("failed to create threads", threads);
> +
> +       perf_thread_map__set_pid(threads, 0, 0);
> +
> +       evsel = perf_evsel__new(&attr);
> +       __T("failed to create evsel", evsel);
> +
> +       err = perf_evsel__open(evsel, NULL, threads);
> +       __T("failed to open evsel", err == 0);
> +
> +       err = perf_evsel__mmap(evsel, 0);
> +       __T("failed to mmap evsel", err == 0);
> +
> +       pc = perf_evsel__mmap_base(evsel, 0, 0);
> +
> +#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
> +       __T("userspace counter access not supported", pc->cap_user_rdpmc);
> +       __T("userspace counter access not enabled", pc->index);
> +       __T("userspace counter width not set", pc->pmc_width >= 32);
> +#endif
> +
> +       perf_evsel__read(evsel, 0, 0, &counts);
> +       __T("failed to read value for evsel", counts.val != 0);
> +
> +       for (i = 0; i < 5; i++) {
> +               volatile int count = 0x10000 << i;
> +               __u64 start, end, last = 0;
> +
> +               __T_VERBOSE("\tloop = %u, ", count);
> +
> +               perf_evsel__read(evsel, 0, 0, &counts);
> +               start = counts.val;
> +
> +               while (count--) ;
> +
> +               perf_evsel__read(evsel, 0, 0, &counts);
> +               end = counts.val;
> +
> +               __T("invalid counter data", (end - start) > last);
> +               last = end - start;
> +               __T_VERBOSE("count = %llu\n", end - start);
> +       }
> +
> +       perf_evsel__close(evsel);
> +       perf_evsel__delete(evsel);
> +
> +       perf_thread_map__put(threads);
> +       return 0;
> +}
> +
>  int main(int argc, char **argv)
>  {
>         __T_START;
> @@ -129,6 +192,8 @@ int main(int argc, char **argv)
>         test_stat_cpu();
>         test_stat_thread();
>         test_stat_thread_enable();
> +       test_stat_user_read(PERF_COUNT_HW_INSTRUCTIONS);
> +       test_stat_user_read(PERF_COUNT_HW_CPU_CYCLES);
>
>         __T_END;
>         return tests_failed == 0 ? 0 : -1;
> --
> 2.27.0
>
