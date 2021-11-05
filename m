Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE18446837
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 19:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbhKESDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 14:03:25 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:44574 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbhKESDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 14:03:22 -0400
Received: by mail-lf1-f44.google.com with SMTP id y26so20250895lfa.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 11:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sdBRipuhd/DnnvTp2K6X1I90WSvK4UoQDH9TPK1ZEYc=;
        b=aMgtr3tZ05Ompywz5n7xguWZ0wIJQVp2OHiBKHLJGbgGX8KftBPyqldjn9hCc9XrHZ
         V62r2I+iUA0HiN32gRhSIHvuR+L+dRNnCTAATYsaRQ37S4qdQ1h2WE+ffg2oCaM+8iHJ
         FmgWhHskqmAHjCwnnuJA+TWsuYCjgiVYoHVhL7/ePsYYy8tS6E04n+bkdq3DoBEC0cLa
         3b8uy5ybmvovk93qccv1cahVdbhAmcoSYAt773WDa9QTyWzhyBJ0qq7SZeAzqMNjwPth
         rJUE4uP9Ag/5nVq0CTj+x5c9f9yw6oQHNt7B1sxGMho3jNkCRNs3U46Bq1JC0dABx7SA
         NZew==
X-Gm-Message-State: AOAM533aC5jB7ryQAgYgZNErPWn8BeouG4orFpr4qzK+uc+wv2Vy9flW
        D3mga1UFK8K606J8yI+/jZPUBprqoPHg9sIIs6g=
X-Google-Smtp-Source: ABdhPJzSnxxLZZr8dVz8B5at9ASoSqDHgsF/72vRLICKzVl+uEAeH8XRnErbsx0CT95avzxmc+og2CoFDJtAYwDm4FU=
X-Received: by 2002:a05:6512:1515:: with SMTP id bq21mr54570057lfb.71.1636135241059;
 Fri, 05 Nov 2021 11:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <20211029224929.379505-1-namhyung@kernel.org> <20211103072112.32312-1-ravi.bangoria@amd.com>
In-Reply-To: <20211103072112.32312-1-ravi.bangoria@amd.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 5 Nov 2021 11:00:29 -0700
Message-ID: <CAM9d7chQH+Br6NJhDdjjOdV7FsODS0_Rj+w-UsfzUud27iPNbQ@mail.gmail.com>
Subject: Re: [PATCH v3] perf evsel: Fix missing exclude_{host,guest} setting
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Kim Phillips <kim.phillips@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Nov 3, 2021 at 12:22 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
> > The current logic for the perf missing feature has a bug that it can
> > wrongly clear some modifiers like G or H.  Actually some PMUs don't
> > support any filtering or exclusion while others do.  But we check it
> > as a global feature.
>
> (Sorry to pitch in bit late)
>
> AMD has one more problem on a similar line. On AMD, non-precise and
> precise sampling are provided by core and IBS pmu respectively. Plus,
> core pmu has filtering capability but IBS does not. Perf by default
> sets precise_ip=3 and exclude_guest=1 and goes on decreasing precise_ip
> with exclude_guest set until perf_event_open() succeeds. This is
> causing perf to always fallback to core pmu (non-precise mode) even if
> it's perfectly feasible to do precise sampling. Do you guys think this
> problem should also be addressed while designing solution for Namhyung's
> patch or solve it seperately like below patch:
>
> ---><---
>
> From 48808299679199c39ff737a30a7f387669314fd7 Mon Sep 17 00:00:00 2001
> From: Ravi Bangoria <ravi.bangoria@amd.com>
> Date: Tue, 2 Nov 2021 11:01:12 +0530
> Subject: [PATCH] perf/amd/ibs: Don't set exclude_guest by default
>
> Perf tool sets exclude_guest by default while calling perf_event_open().
> Because IBS does not have filtering capability, it always gets rejected
> by IBS PMU driver and thus perf falls back to non-precise sampling. Fix
> it by not setting exclude_guest by default on AMD.
>
> Before:
>   $ sudo ./perf record -C 0 -vvv true |& grep precise
>     precise_ip                       3
>   decreasing precise_ip by one (2)
>     precise_ip                       2
>   decreasing precise_ip by one (1)
>     precise_ip                       1
>   decreasing precise_ip by one (0)
>
> After:
>   $ sudo ./perf record -C 0 -vvv true |& grep precise
>     precise_ip                       3
>   decreasing precise_ip by one (2)
>     precise_ip                       2
>
> Reported-by: Kim Phillips <kim.phillips@amd.com>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>

It'd be nice if it can cover explicit -e cycles:pp as well.  Anyway,

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/arch/x86/util/evsel.c | 23 +++++++++++++++++++++++
>  tools/perf/util/evsel.c          | 12 +++++++-----
>  tools/perf/util/evsel.h          |  1 +
>  3 files changed, 31 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
> index 2f733cdc8dbb..7841a49ce856 100644
> --- a/tools/perf/arch/x86/util/evsel.c
> +++ b/tools/perf/arch/x86/util/evsel.c
> @@ -1,8 +1,31 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <stdio.h>
> +#include <stdlib.h>
>  #include "util/evsel.h"
> +#include "util/env.h"
> +#include "linux/string.h"
>
>  void arch_evsel__set_sample_weight(struct evsel *evsel)
>  {
>         evsel__set_sample_bit(evsel, WEIGHT_STRUCT);
>  }
> +
> +void arch_evsel__fixup_new_cycles(struct perf_event_attr *attr)
> +{
> +       struct perf_env env = {0};
> +
> +       if (!perf_env__cpuid(&env))
> +               return;
> +
> +       /*
> +        * On AMD, precise cycles event sampling internally uses IBS pmu.
> +        * But IBS does not have filtering capabilities and perf by default
> +        * sets exclude_guest = 1. This makes IBS pmu event init fail and
> +        * thus perf ends up doing non-precise sampling. Avoid it by clearing
> +        * exclude_guest.
> +        */
> +       if (env.cpuid && strstarts(env.cpuid, "AuthenticAMD"))
> +               attr->exclude_guest = 0;
> +
> +       free(env.cpuid);
> +}
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index dbfeceb2546c..0b4267d4bb38 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -294,7 +294,7 @@ static bool perf_event_can_profile_kernel(void)
>         return perf_event_paranoid_check(1);
>  }
>
> -struct evsel *evsel__new_cycles(bool precise, __u32 type, __u64 config)
> +struct evsel *evsel__new_cycles(bool precise __maybe_unused, __u32 type, __u64 config)
>  {
>         struct perf_event_attr attr = {
>                 .type   = type,
> @@ -305,18 +305,16 @@ struct evsel *evsel__new_cycles(bool precise, __u32 type, __u64 config)
>
>         event_attr_init(&attr);
>
> -       if (!precise)
> -               goto new_event;
> -
>         /*
>          * Now let the usual logic to set up the perf_event_attr defaults
>          * to kick in when we return and before perf_evsel__open() is called.
>          */
> -new_event:
>         evsel = evsel__new(&attr);
>         if (evsel == NULL)
>                 goto out;
>
> +       arch_evsel__fixup_new_cycles(&evsel->core.attr);
> +
>         evsel->precise_max = true;
>
>         /* use asprintf() because free(evsel) assumes name is allocated */
> @@ -1047,6 +1045,10 @@ void __weak arch_evsel__set_sample_weight(struct evsel *evsel)
>         evsel__set_sample_bit(evsel, WEIGHT);
>  }
>
> +void __weak arch_evsel__fixup_new_cycles(struct perf_event_attr *attr __maybe_unused)
> +{
> +}
> +
>  /*
>   * The enable_on_exec/disabled value strategy:
>   *
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 1f7edfa8568a..764e54c6a23d 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -277,6 +277,7 @@ void __evsel__reset_sample_bit(struct evsel *evsel, enum perf_event_sample_forma
>  void evsel__set_sample_id(struct evsel *evsel, bool use_sample_identifier);
>
>  void arch_evsel__set_sample_weight(struct evsel *evsel);
> +void arch_evsel__fixup_new_cycles(struct perf_event_attr *attr);
>
>  int evsel__set_filter(struct evsel *evsel, const char *filter);
>  int evsel__append_tp_filter(struct evsel *evsel, const char *filter);
> --
> 2.27.0
>
