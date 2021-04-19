Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352CC3648DA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 19:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239788AbhDSRNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 13:13:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:33468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232748AbhDSRNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 13:13:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A68D60FEA;
        Mon, 19 Apr 2021 17:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618852397;
        bh=I353GWjQMcTbRO2goUOHayQzuP6GkAnsd1OUMQtsNoc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TZnYrdqwZR/mig2LMxV8U6U83mvShkQgu2nTA1hWNfUOJVNL+V8SdBr9yh61+k0I5
         empO4BQGNqYOMvMeggxQsVsr04BCKACoMqSc3edROyNPafGXel25G0yRH44b1Ouls2
         jwC+RWOR62NM7EcDiojGoguNgtaafRvDP730RacxIMFfa1azLbRT3/GewilahjApEq
         DjFVQ6ydfbdXNzgOEp+6Ei/if93+3hnUWLH43z8skXmY3mMhoETHPx9OS8BwIgU8Tu
         2cYHi4gReHpddu6OsbWS8tA09jYH9n6eMRFhNWLIy38/z3Jaagiop6zGwBv42awWci
         pVJnmi4+WNgXA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CE96B40647; Mon, 19 Apr 2021 14:13:14 -0300 (-03)
Date:   Mon, 19 Apr 2021 14:13:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf arm64: Fix off-by-one directory paths.
Message-ID: <YH26KvbSPGA0I/zs@kernel.org>
References: <20210416214113.552252-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416214113.552252-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Apr 16, 2021 at 02:41:13PM -0700, Ian Rogers escreveu:
> Relative path include works in the regular build due to -I paths but may
> break in other situations.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/arm64/util/kvm-stat.c         | 4 ++--
>  tools/perf/arch/arm64/util/pmu.c              | 4 ++--
>  tools/perf/arch/arm64/util/unwind-libunwind.c | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/arch/arm64/util/kvm-stat.c b/tools/perf/arch/arm64/util/kvm-stat.c
> index 50376b9062c1..2303256b7d05 100644
> --- a/tools/perf/arch/arm64/util/kvm-stat.c
> +++ b/tools/perf/arch/arm64/util/kvm-stat.c
> @@ -1,8 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <errno.h>
>  #include <memory.h>
> -#include "../../util/evsel.h"
> -#include "../../util/kvm-stat.h"
> +#include "../../../util/evsel.h"
> +#include "../../../util/kvm-stat.h"
>  #include "arm64_exception_types.h"
>  #include "debug.h"
>  
> diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/util/pmu.c
> index d3259d61ca75..2234fbd0a912 100644
> --- a/tools/perf/arch/arm64/util/pmu.c
> +++ b/tools/perf/arch/arm64/util/pmu.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> -#include "../../util/cpumap.h"
> -#include "../../util/pmu.h"
> +#include "../../../util/cpumap.h"
> +#include "../../../util/pmu.h"
>  
>  struct pmu_events_map *pmu_events_map__find(void)
>  {
> diff --git a/tools/perf/arch/arm64/util/unwind-libunwind.c b/tools/perf/arch/arm64/util/unwind-libunwind.c
> index 1495a9523a23..5aecf88e3de6 100644
> --- a/tools/perf/arch/arm64/util/unwind-libunwind.c
> +++ b/tools/perf/arch/arm64/util/unwind-libunwind.c
> @@ -4,9 +4,9 @@
>  #ifndef REMOTE_UNWIND_LIBUNWIND
>  #include <libunwind.h>
>  #include "perf_regs.h"
> -#include "../../util/unwind.h"
> +#include "../../../util/unwind.h"
>  #endif
> -#include "../../util/debug.h"
> +#include "../../../util/debug.h"
>  
>  int LIBUNWIND__ARCH_REG_ID(int regnum)
>  {
> -- 
> 2.31.1.368.gbe11c130af-goog
> 

-- 

- Arnaldo
