Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5D0417B62
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 21:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345850AbhIXTCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 15:02:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:49692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343938AbhIXTB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 15:01:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E96B60F70;
        Fri, 24 Sep 2021 19:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632510025;
        bh=qa8Tpyw2WT+IKc8NvId4wOq8NNLMxHWeCNOjWmC3PuY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b3OuT3zaDXhm7nbt3eOdtNDCXHXPUVucWgwXpI6T8Q3J/kup5Rd04YkZ5M3dAvTLN
         2sQSWC6TllMrNfAbItDO4Rj1Q1aaT6w7s3/6ZZRZyCEDJeblrufrG3ahSHquk2jIFo
         OUnCF5/MI3xCn2jVItuJ3FkJ2lrXb1Rq78mhZH+nX6cOaSUFytDBjllfWezBBHPiYY
         UTq7SF/SJpB3heb3NSlBTspsP36RFj+z1m3+nAmr1RN5UN4J/Do0O8XIwKqEQUcgbL
         vEm7PfGDQBioGdtSS93twuZczX22IyVHGK6edj2L7MH/DhqYKBkmaxIk8TVSVFrKud
         xWvhZ/b4acnow==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 28AD3410A1; Fri, 24 Sep 2021 16:00:23 -0300 (-03)
Date:   Fri, 24 Sep 2021 16:00:23 -0300
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
Subject: Re: [PATCH v2] perf arm: Fix off-by-one directory paths.
Message-ID: <YU4gR3z/cmO4FtV3@kernel.org>
References: <20210923154254.737657-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923154254.737657-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 23, 2021 at 08:42:54AM -0700, Ian Rogers escreveu:
> Relative path include works in the regular build due to -I paths but may
> fail in other situations.
> 
> v2. Rebase. Comments on v1 were that we should handle include paths
>     differently and it is agreed that can be a sensible refactor but
>     beyond the scope of this change.
> https://lore.kernel.org/lkml/20210504191227.793712-1-irogers@google.com/

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/arm/util/auxtrace.c         |  8 +++----
>  tools/perf/arch/arm/util/cs-etm.c           | 24 ++++++++++-----------
>  tools/perf/arch/arm/util/perf_regs.c        |  2 +-
>  tools/perf/arch/arm/util/pmu.c              |  2 +-
>  tools/perf/arch/arm/util/unwind-libdw.c     |  6 +++---
>  tools/perf/arch/arm/util/unwind-libunwind.c |  4 ++--
>  6 files changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
> index c7c7ec0812d5..5fc6a2a3dbc5 100644
> --- a/tools/perf/arch/arm/util/auxtrace.c
> +++ b/tools/perf/arch/arm/util/auxtrace.c
> @@ -8,10 +8,10 @@
>  #include <linux/coresight-pmu.h>
>  #include <linux/zalloc.h>
>  
> -#include "../../util/auxtrace.h"
> -#include "../../util/debug.h"
> -#include "../../util/evlist.h"
> -#include "../../util/pmu.h"
> +#include "../../../util/auxtrace.h"
> +#include "../../../util/debug.h"
> +#include "../../../util/evlist.h"
> +#include "../../../util/pmu.h"
>  #include "cs-etm.h"
>  #include "arm-spe.h"
>  
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index 515aae470e23..293a23bf8be3 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -16,19 +16,19 @@
>  #include <linux/zalloc.h>
>  
>  #include "cs-etm.h"
> -#include "../../util/debug.h"
> -#include "../../util/record.h"
> -#include "../../util/auxtrace.h"
> -#include "../../util/cpumap.h"
> -#include "../../util/event.h"
> -#include "../../util/evlist.h"
> -#include "../../util/evsel.h"
> -#include "../../util/perf_api_probe.h"
> -#include "../../util/evsel_config.h"
> -#include "../../util/pmu.h"
> -#include "../../util/cs-etm.h"
> +#include "../../../util/debug.h"
> +#include "../../../util/record.h"
> +#include "../../../util/auxtrace.h"
> +#include "../../../util/cpumap.h"
> +#include "../../../util/event.h"
> +#include "../../../util/evlist.h"
> +#include "../../../util/evsel.h"
> +#include "../../../util/perf_api_probe.h"
> +#include "../../../util/evsel_config.h"
> +#include "../../../util/pmu.h"
> +#include "../../../util/cs-etm.h"
>  #include <internal/lib.h> // page_size
> -#include "../../util/session.h"
> +#include "../../../util/session.h"
>  
>  #include <errno.h>
>  #include <stdlib.h>
> diff --git a/tools/perf/arch/arm/util/perf_regs.c b/tools/perf/arch/arm/util/perf_regs.c
> index 2864e2e3776d..2833e101a7c6 100644
> --- a/tools/perf/arch/arm/util/perf_regs.c
> +++ b/tools/perf/arch/arm/util/perf_regs.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include "../../util/perf_regs.h"
> +#include "../../../util/perf_regs.h"
>  
>  const struct sample_reg sample_reg_masks[] = {
>  	SMPL_REG_END
> diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
> index bbc297a7e2e3..b8b23b9dc598 100644
> --- a/tools/perf/arch/arm/util/pmu.c
> +++ b/tools/perf/arch/arm/util/pmu.c
> @@ -10,7 +10,7 @@
>  #include <linux/string.h>
>  
>  #include "arm-spe.h"
> -#include "../../util/pmu.h"
> +#include "../../../util/pmu.h"
>  
>  struct perf_event_attr
>  *perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
> diff --git a/tools/perf/arch/arm/util/unwind-libdw.c b/tools/perf/arch/arm/util/unwind-libdw.c
> index 36ba4c69c3c5..b7692cb0c733 100644
> --- a/tools/perf/arch/arm/util/unwind-libdw.c
> +++ b/tools/perf/arch/arm/util/unwind-libdw.c
> @@ -1,8 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <elfutils/libdwfl.h>
> -#include "../../util/unwind-libdw.h"
> -#include "../../util/perf_regs.h"
> -#include "../../util/event.h"
> +#include "../../../util/unwind-libdw.h"
> +#include "../../../util/perf_regs.h"
> +#include "../../../util/event.h"
>  
>  bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
>  {
> diff --git a/tools/perf/arch/arm/util/unwind-libunwind.c b/tools/perf/arch/arm/util/unwind-libunwind.c
> index 3a550225dfaf..438906bf0014 100644
> --- a/tools/perf/arch/arm/util/unwind-libunwind.c
> +++ b/tools/perf/arch/arm/util/unwind-libunwind.c
> @@ -3,8 +3,8 @@
>  #include <errno.h>
>  #include <libunwind.h>
>  #include "perf_regs.h"
> -#include "../../util/unwind.h"
> -#include "../../util/debug.h"
> +#include "../../../util/unwind.h"
> +#include "../../../util/debug.h"
>  
>  int libunwind__arch_reg_id(int regnum)
>  {
> -- 
> 2.33.0.464.g1972c5931b-goog

-- 

- Arnaldo
