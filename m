Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5953730F7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 21:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbhEDTop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 15:44:45 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:42924 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbhEDToo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 15:44:44 -0400
Received: by mail-lf1-f54.google.com with SMTP id c11so15005441lfi.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 12:43:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XECX9L88R5n0fWFQf600RELq+nS/7DtQUpWyy5dmED4=;
        b=c1OFNYZqjC4qJyLBKyLDuia6HyMqqdrCiYrcoIb1qTQSqhRTd3kAD51yp/YySNuHCa
         3SsOG74XYGNX7EE2fi1z7yVavBJm204VMRaLJ9mCQFH/VpV+xFfXuCzlZU5weNKY/7vI
         yhpTzPdFsjoibX6R5+HlpSfRw4uQ+Nn227mXWiObk1GeJ8+fEP9UdBIvrtbp4e9Z2c1s
         0B8DWimAs11ZAAqUPshtoazVBfxiZb2SljKb9OqY1wuVurZnWocre1bmsxM7PAQZnA5+
         aPDIs814HdbM7909zxV1B4z6U1OcNbvuTbRERYNi0X5h4gP62kNXkzq6227qxADr3S/o
         ChIQ==
X-Gm-Message-State: AOAM530gbDqEANlzG4JjwpBkjDFwJg2b8c9r/1b60zPrGdhRJDNC+qa6
        S2vWbTg6NSt+H4MTBG3gNjPXztGArM9dqEuVLLE=
X-Google-Smtp-Source: ABdhPJwmSBq/8WiPJhQaKb9qGYeYTRPmMCL0b024Q48LXoklraLDU0og9IZwaI6WsBCoXknfRu6h1GSuhWFDTZq29NU=
X-Received: by 2002:ac2:499e:: with SMTP id f30mr6439021lfl.635.1620157428439;
 Tue, 04 May 2021 12:43:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210504191227.793712-1-irogers@google.com>
In-Reply-To: <20210504191227.793712-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 4 May 2021 12:43:37 -0700
Message-ID: <CAM9d7chEbYU6mnCsAo7+rGH7PCtJy8NT7BedLBT8Lda8fbjy5A@mail.gmail.com>
Subject: Re: [PATCH] perf arm: Fix off-by-one directory paths.
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Tue, May 4, 2021 at 12:12 PM Ian Rogers <irogers@google.com> wrote:
>
> Relative path include works in the regular build due to -I paths but may
> fail in other situations.

Right, can we simply change them all to have a relative path from the
$(srctree)/tools/perf ?  I think it'd be cleaner and easier to maintain.

Thanks,
Namhyung

>
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
> index b187bddbd01a..7ed57222465e 100644
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
> index d942f118d32c..67c7fb8d7eb0 100644
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
>         SMPL_REG_END
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
> 2.31.1.607.g51e8a6a459-goog
>
