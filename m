Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8476C370055
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 20:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhD3SSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 14:18:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:59506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229750AbhD3SSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 14:18:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3E466146D
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 18:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619806634;
        bh=2DEcEcqCVn7FiwOiyZBIn5VYJmyMfsPA/ZY3zVDjKGc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iOZuWuVsMBB6mTkMWMjSHjgM0tqD6IZD3KRh+dCitvGkuO9+MDBFg8jD5ywCcxJKN
         Wi6wQnT0jQQSmu4lV4TJjMK9s38TjHdHTq3dbNS7MdL3dRGpxPzv5LZBKJdhWIAkqV
         5sAsyrjjlLozuSsBzNIfX0SPHkdGwHsmwSy4K6+CsCKqIi2A31KSljCgms4NdibEzS
         N/99uRj+SZqx8G2p4lhAl3ey6QVb2zfQYaHg9FUVcqH0iooi0DUAmGVfX29jDBT7lb
         7HbUs9O27P7GI52ZHXpftOU+2pgo2JYpcFg257FKDHjRhjrxn1m7q0F9zaHB18VCX7
         mQxVynGFobHig==
Received: by mail-ed1-f52.google.com with SMTP id d14so19862596edc.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 11:17:14 -0700 (PDT)
X-Gm-Message-State: AOAM532NDkjeH4diEzj0vEDEfUytaUZwXZEcbeVR7XkEaiwD2g9X7STO
        P5YRBIBkaE44ldgSqemghxFHu6NA4JCKh+l+1g==
X-Google-Smtp-Source: ABdhPJy4z+Y3MQoOD88SadHV3tMUBs/zGibK3jzzD3HvYGqqrLKubs0m9RsHxGKYfMSIjW8djZNMykCiZdtDMnl3OcM=
X-Received: by 2002:aa7:cd83:: with SMTP id x3mr7457107edv.373.1619806633168;
 Fri, 30 Apr 2021 11:17:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210420031511.2348977-1-robh@kernel.org> <20210420031511.2348977-8-robh@kernel.org>
 <20210430164616.pzb7yxrsugexso25@gabell>
In-Reply-To: <20210430164616.pzb7yxrsugexso25@gabell>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 30 Apr 2021 13:17:01 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLtkik656hjHMqvPc3Ta6qR+nWx1BxPcj8GvzYypTUVWQ@mail.gmail.com>
Message-ID: <CAL_JsqLtkik656hjHMqvPc3Ta6qR+nWx1BxPcj8GvzYypTUVWQ@mail.gmail.com>
Subject: Re: [PATCH v7 7/9] perf: arm64: Add test for userspace counter access
 on heterogeneous systems
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
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
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 11:46 AM Masayoshi Mizuma <msys.mizuma@gmail.com> w=
rote:
>
> On Mon, Apr 19, 2021 at 10:15:09PM -0500, Rob Herring wrote:
> > Userspace counter access only works on heterogeneous systems with some
> > restrictions. The userspace process must be pinned to a homogeneous
> > subset of CPUs and must open the corresponding PMU for those CPUs. This
> > commit adds a test implementing these requirements.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > v6:
> >  - Add a check on cap_user_rdpmc
> > v5:
> >  - Adapt to libperf mmap API changes
> > v4:
> >  - Update perf_evsel__mmap params
> > v2:
> >  - Drop all but heterogeneous test as others covered by libperf tests
> >  - Rework to use libperf
> > ---
> >  tools/perf/arch/arm64/include/arch-tests.h |   7 +
> >  tools/perf/arch/arm64/tests/Build          |   1 +
> >  tools/perf/arch/arm64/tests/arch-tests.c   |   4 +
> >  tools/perf/arch/arm64/tests/user-events.c  | 177 +++++++++++++++++++++
> >  4 files changed, 189 insertions(+)
> >  create mode 100644 tools/perf/arch/arm64/tests/user-events.c
> >
> > diff --git a/tools/perf/arch/arm64/include/arch-tests.h b/tools/perf/ar=
ch/arm64/include/arch-tests.h
> > index 90ec4c8cb880..380ad34a3f09 100644
> > --- a/tools/perf/arch/arm64/include/arch-tests.h
> > +++ b/tools/perf/arch/arm64/include/arch-tests.h
> > @@ -2,11 +2,18 @@
> >  #ifndef ARCH_TESTS_H
> >  #define ARCH_TESTS_H
> >
> > +#include <linux/compiler.h>
> > +
> >  #ifdef HAVE_DWARF_UNWIND_SUPPORT
> >  struct thread;
> >  struct perf_sample;
> > +int test__arch_unwind_sample(struct perf_sample *sample,
> > +                          struct thread *thread);
> >  #endif
>
> Hello,
>
> I got the following compile error with aarch64 on Fedora33.
>
>     # make tools/perf
>     ...
>     In file included from arch/arm64/tests/arch-tests.c:4:
>     /root//libperf_v7/tools/perf/arch/arm64/include/arch-tests.h:10:5: er=
ror: redundant redeclaration of =E2=80=98test__arch_unwind_sample=E2=80=99 =
[-Werror=3Dredundant-decls]
>        10 | int test__arch_unwind_sample(struct perf_sample *sample,
>           |     ^~~~~~~~~~~~~~~~~~~~~~~~
>     In file included from arch/arm64/tests/arch-tests.c:3:
>     /root//libperf_v7/tools/perf/tests/tests.h:140:5: note: previous decl=
aration of =E2=80=98test__arch_unwind_sample=E2=80=99 was here
>       140 | int test__arch_unwind_sample(struct perf_sample *sample,
>           |     ^~~~~~~~~~~~~~~~~~~~~~~~
>     cc1: all warnings being treated as errors
>     make[8]: *** [/root//libperf_v7/tools/build/Makefile.build:97: /root/=
libperf_v7/tools/perf/arch/arm64/tests/arch-tests.o] Error 1
>     make[8]: *** Waiting for unfinished jobs....
>     In file included from arch/arm64/tests/user-events.c:13:
>     /root//libperf_v7/tools/perf/arch/arm64/include/arch-tests.h:10:5: er=
ror: redundant redeclaration of =E2=80=98test__arch_unwind_sample=E2=80=99 =
[-Werror=3Dredundant-decls]
>        10 | int test__arch_unwind_sample(struct perf_sample *sample,
>           |     ^~~~~~~~~~~~~~~~~~~~~~~~
>     In file included from arch/arm64/tests/user-events.c:12:
>     /root//libperf_v7/tools/perf/tests/tests.h:140:5: note: previous decl=
aration of =E2=80=98test__arch_unwind_sample=E2=80=99 was here
>       140 | int test__arch_unwind_sample(struct perf_sample *sample,
>           |     ^~~~~~~~~~~~~~~~~~~~~~~~
>     cc1: all warnings being treated as errors
>     ...
>
> The error is gone after the following patch is applied.

Thanks. Honestly, I'm not sure why it was there in the first place.
Looking at the git history and this series history doesn't give any
clues.

> ---
>  tools/perf/arch/arm64/include/arch-tests.h | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/tools/perf/arch/arm64/include/arch-tests.h b/tools/perf/arch=
/arm64/include/arch-tests.h
> index ddfa7460e..7ff2e29bd 100644
> --- a/tools/perf/arch/arm64/include/arch-tests.h
> +++ b/tools/perf/arch/arm64/include/arch-tests.h
> @@ -4,13 +4,6 @@
>
>  #include <linux/compiler.h>
>
> -#ifdef HAVE_DWARF_UNWIND_SUPPORT
> -struct thread;
> -struct perf_sample;
> -int test__arch_unwind_sample(struct perf_sample *sample,
> -                            struct thread *thread);
> -#endif
> -
>  extern struct test arch_tests[];
>  int test__rd_pinned(struct test __maybe_unused *test,
>                        int __maybe_unused subtest);
> --
>
> Thanks!
> Masa
>
> >
> >  extern struct test arch_tests[];
> > +int test__rd_pinned(struct test __maybe_unused *test,
> > +                    int __maybe_unused subtest);
> > +
> >
> >  #endif
> > diff --git a/tools/perf/arch/arm64/tests/Build b/tools/perf/arch/arm64/=
tests/Build
> > index a61c06bdb757..3f9a20c17fc6 100644
> > --- a/tools/perf/arch/arm64/tests/Build
> > +++ b/tools/perf/arch/arm64/tests/Build
> > @@ -1,4 +1,5 @@
> >  perf-y +=3D regs_load.o
> >  perf-$(CONFIG_DWARF_UNWIND) +=3D dwarf-unwind.o
> >
> > +perf-y +=3D user-events.o
> >  perf-y +=3D arch-tests.o
> > diff --git a/tools/perf/arch/arm64/tests/arch-tests.c b/tools/perf/arch=
/arm64/tests/arch-tests.c
> > index 5b1543c98022..80ce7bd3c16d 100644
> > --- a/tools/perf/arch/arm64/tests/arch-tests.c
> > +++ b/tools/perf/arch/arm64/tests/arch-tests.c
> > @@ -10,6 +10,10 @@ struct test arch_tests[] =3D {
> >               .func =3D test__dwarf_unwind,
> >       },
> >  #endif
> > +     {
> > +             .desc =3D "Pinned CPU user counter access",
> > +             .func =3D test__rd_pinned,
> > +     },
> >       {
> >               .func =3D NULL,
> >       },
> > diff --git a/tools/perf/arch/arm64/tests/user-events.c b/tools/perf/arc=
h/arm64/tests/user-events.c
> > new file mode 100644
> > index 000000000000..c8efc6b369e6
> > --- /dev/null
> > +++ b/tools/perf/arch/arm64/tests/user-events.c
> > @@ -0,0 +1,177 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <unistd.h>
> > +#include <sched.h>
> > +#include <cpumap.h>
> > +
> > +#include <perf/core.h>
> > +#include <perf/threadmap.h>
> > +#include <perf/evsel.h>
> > +
> > +#include "pmu.h"
> > +#include "debug.h"
> > +#include "tests/tests.h"
> > +#include "arch-tests.h"
> > +
> > +static int run_test(struct perf_evsel *evsel)
> > +{
> > +     int n;
> > +     volatile int tmp =3D 0;
> > +     u64 delta, i, loops =3D 1000;
> > +     struct perf_counts_values counts =3D { .val =3D 0 };
> > +
> > +     for (n =3D 0; n < 6; n++) {
> > +             u64 stamp, now;
> > +
> > +             perf_evsel__read(evsel, 0, 0, &counts);
> > +             stamp =3D counts.val;
> > +
> > +             for (i =3D 0; i < loops; i++)
> > +                     tmp++;
> > +
> > +             perf_evsel__read(evsel, 0, 0, &counts);
> > +             now =3D counts.val;
> > +             loops *=3D 10;
> > +
> > +             delta =3D now - stamp;
> > +             pr_debug("%14d: %14llu\n", n, (long long)delta);
> > +
> > +             if (!delta)
> > +                     break;
> > +     }
> > +     return delta ? 0 : -1;
> > +}
> > +
> > +static struct perf_pmu *pmu_for_cpu(int cpu)
> > +{
> > +     int acpu, idx;
> > +     struct perf_pmu *pmu =3D NULL;
> > +
> > +     while ((pmu =3D perf_pmu__scan(pmu)) !=3D NULL) {
> > +             if (pmu->is_uncore)
> > +                     continue;
> > +             perf_cpu_map__for_each_cpu(acpu, idx, pmu->cpus)
> > +                     if (acpu =3D=3D cpu)
> > +                             return pmu;
> > +     }
> > +     return NULL;
> > +}
> > +
> > +static bool pmu_is_homogeneous(void)
> > +{
> > +     int core_cnt =3D 0;
> > +     struct perf_pmu *pmu =3D NULL;
> > +
> > +     while ((pmu =3D perf_pmu__scan(pmu)) !=3D NULL) {
> > +             if (!pmu->is_uncore && !perf_cpu_map__empty(pmu->cpus))
> > +                     core_cnt++;
> > +     }
> > +     return core_cnt =3D=3D 1;
> > +}
> > +
> > +static int libperf_print(enum libperf_print_level level,
> > +                      const char *fmt, va_list ap)
> > +{
> > +     (void)level;
> > +     return vfprintf(stderr, fmt, ap);
> > +}
> > +
> > +static struct perf_evsel *perf_init(struct perf_event_attr *attr)
> > +{
> > +     int err;
> > +     struct perf_thread_map *threads;
> > +     struct perf_evsel *evsel;
> > +     struct perf_event_mmap_page *pc;
> > +
> > +     libperf_init(libperf_print);
> > +
> > +     threads =3D perf_thread_map__new_dummy();
> > +     if (!threads) {
> > +             pr_err("failed to create threads\n");
> > +             return NULL;
> > +     }
> > +
> > +     perf_thread_map__set_pid(threads, 0, 0);
> > +
> > +     evsel =3D perf_evsel__new(attr);
> > +     if (!evsel) {
> > +             pr_err("failed to create evsel\n");
> > +             goto out_thread;
> > +     }
> > +
> > +     err =3D perf_evsel__open(evsel, NULL, threads);
> > +     if (err) {
> > +             pr_err("failed to open evsel\n");
> > +             goto out_open;
> > +     }
> > +
> > +     if (perf_evsel__mmap(evsel, 0)) {
> > +             pr_err("failed to mmap evsel\n");
> > +             goto out_mmap;
> > +     }
> > +
> > +     pc =3D perf_evsel__mmap_base(evsel, 0, 0);
> > +     if (!pc->cap_user_rdpmc) {
> > +             pr_err("userspace access not enabled\n");
> > +             goto out_mmap;
> > +     }
> > +
> > +     return evsel;
> > +
> > +out_mmap:
> > +     perf_evsel__close(evsel);
> > +out_open:
> > +     perf_evsel__delete(evsel);
> > +out_thread:
> > +     perf_thread_map__put(threads);
> > +     return NULL;
> > +}
> > +
> > +int test__rd_pinned(struct test __maybe_unused *test,
> > +                 int __maybe_unused subtest)
> > +{
> > +     int cpu, cputmp, ret =3D -1;
> > +     struct perf_evsel *evsel;
> > +     struct perf_event_attr attr =3D {
> > +             .config =3D 0x8, /* Instruction count */
> > +             .config1 =3D 0, /* 32-bit counter */
> > +             .exclude_kernel =3D 1,
> > +     };
> > +     cpu_set_t cpu_set;
> > +     struct perf_pmu *pmu;
> > +
> > +     if (pmu_is_homogeneous())
> > +             return TEST_SKIP;
> > +
> > +     cpu =3D sched_getcpu();
> > +     pmu =3D pmu_for_cpu(cpu);
> > +     if (!pmu)
> > +             return -1;
> > +     attr.type =3D pmu->type;
> > +
> > +     CPU_ZERO(&cpu_set);
> > +     perf_cpu_map__for_each_cpu(cpu, cputmp, pmu->cpus)
> > +             CPU_SET(cpu, &cpu_set);
> > +     if (sched_setaffinity(0, sizeof(cpu_set), &cpu_set) < 0)
> > +             pr_err("Could not set affinity\n");
> > +
> > +     evsel =3D perf_init(&attr);
> > +     if (!evsel)
> > +             return -1;
> > +
> > +     perf_cpu_map__for_each_cpu(cpu, cputmp, pmu->cpus) {
> > +             CPU_ZERO(&cpu_set);
> > +             CPU_SET(cpu, &cpu_set);
> > +             if (sched_setaffinity(0, sizeof(cpu_set), &cpu_set) < 0)
> > +                     pr_err("Could not set affinity\n");
> > +
> > +             pr_debug("Running on CPU %d\n", cpu);
> > +
> > +             ret =3D run_test(evsel);
> > +             if (ret)
> > +                     break;
> > +     }
> > +
> > +     perf_evsel__close(evsel);
> > +     perf_evsel__delete(evsel);
> > +     return ret;
> > +}
> > --
> > 2.27.0
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
