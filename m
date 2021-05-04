Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27BA83731A4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 22:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbhEDUxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 16:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhEDUxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 16:53:11 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2C0C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 13:52:16 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso2146973wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 13:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pB1cSw8N7Kbpj7dnwbMaLVxrx2u+EZa/lTS1Rg7F7Ag=;
        b=Ye0/tey/nu68rJEsQM1G0OFBAXALXV5Jkp1ySsXkJDXr+YUi6TwnGwG2f2giKzrHLr
         oJN31mc3T3jZg1nqld5rxMO8Wobd7tvLKhMh3V8lO2TOP7IGqeiPo18JAi7lC+59JlkK
         WwTNfKqQxDybg0ddfdYK1zqo83xYuXHi5ahOgWgiwLE043NeaQDbhRRZhAOvUMyBR7Xd
         W/3zYlX9f5Apml2XWDpsm8PMVa8j3ZmV4AmoaESqfe9lwutKsBi79AWu3E3D+b3G9NOv
         zFX64vDdATUvBHVvTeIgSA3ARlqyeRaV6mpc/3wiSl3lfg7AtLTntUt6EGGosEIUbOfF
         ntyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pB1cSw8N7Kbpj7dnwbMaLVxrx2u+EZa/lTS1Rg7F7Ag=;
        b=rcmv/P0jbqBtGEw2dypsEEgC0+N/DzFltqBnByezfcKV8M6DLHnnbC0WgR7Irerhsc
         y+QFPeQ99mTPOzYSFMRULTyWXjFDYg1N4ZscFKGmGmS0+ca1E2wpY2VtiM0DnwS6YhMq
         oHzUTKdoqoOPQLfCE90sNoxsBuI4RWEec9ecgwH+e0Jpv8nqAq7sFkZcAWpyGukhF+wm
         FLm3ByDKCFrchRlbxeQmO8FkcdIYRyBtuKIiO3E7cuGtqdZ08pcblq4ZQ3fyzFX2nA7a
         cSj4sS3W4RvlVdsxoK5086teJh6Gq5KHES7X3cuJkpyPNGBF20DM04NpH9iA3Y4gauR+
         yFcA==
X-Gm-Message-State: AOAM5334lJxxprX3BtKIEbAB+HOP4iVM31TDzqmzX5ym5SReJF+vyr03
        lktvgIz/OkLO+CsUnKdYxMs1UGgTp6V2gbtJJIUdug==
X-Google-Smtp-Source: ABdhPJw6HCTABPbj/4S4PixfN/fu8ap5wlnAnHCOsq+/muqSjUgpVm67GtUJ6PZKQ7sYxCTgFbf5b5czTUH3jm1m9ck=
X-Received: by 2002:a1c:55ca:: with SMTP id j193mr6130791wmb.58.1620161533798;
 Tue, 04 May 2021 13:52:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210504191227.793712-1-irogers@google.com> <CAM9d7chEbYU6mnCsAo7+rGH7PCtJy8NT7BedLBT8Lda8fbjy5A@mail.gmail.com>
In-Reply-To: <CAM9d7chEbYU6mnCsAo7+rGH7PCtJy8NT7BedLBT8Lda8fbjy5A@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 4 May 2021 13:52:00 -0700
Message-ID: <CAP-5=fU4q8hYn+h4JAAEtK6e6N3=tFC6hq9Ja-YjZR2_o6omiA@mail.gmail.com>
Subject: Re: [PATCH] perf arm: Fix off-by-one directory paths.
To:     Namhyung Kim <namhyung@kernel.org>
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 4, 2021 at 12:43 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Ian,
>
> On Tue, May 4, 2021 at 12:12 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Relative path include works in the regular build due to -I paths but may
> > fail in other situations.
>
> Right, can we simply change them all to have a relative path from the
> $(srctree)/tools/perf ?  I think it'd be cleaner and easier to maintain.

It'd be a larger change but I agree it would be cleaner. I had a
related problem here:
https://lore.kernel.org/lkml/20210307223024.4081067-1-irogers@google.com/
Relying less on include path order, especially confusing in the ARM vs
ARM64 case where both arch directories are necessary, and on linker
tricks like weak I think would make the build cleaner and easier to
understand. Not calling C and header files the same name would also I
think reduce confusion. The cost would likely be more #ifs.

Given that is a larger refactor I think we can merge this while
working out a better plan.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/arch/arm/util/auxtrace.c         |  8 +++----
> >  tools/perf/arch/arm/util/cs-etm.c           | 24 ++++++++++-----------
> >  tools/perf/arch/arm/util/perf_regs.c        |  2 +-
> >  tools/perf/arch/arm/util/pmu.c              |  2 +-
> >  tools/perf/arch/arm/util/unwind-libdw.c     |  6 +++---
> >  tools/perf/arch/arm/util/unwind-libunwind.c |  4 ++--
> >  6 files changed, 23 insertions(+), 23 deletions(-)
> >
> > diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
> > index b187bddbd01a..7ed57222465e 100644
> > --- a/tools/perf/arch/arm/util/auxtrace.c
> > +++ b/tools/perf/arch/arm/util/auxtrace.c
> > @@ -8,10 +8,10 @@
> >  #include <linux/coresight-pmu.h>
> >  #include <linux/zalloc.h>
> >
> > -#include "../../util/auxtrace.h"
> > -#include "../../util/debug.h"
> > -#include "../../util/evlist.h"
> > -#include "../../util/pmu.h"
> > +#include "../../../util/auxtrace.h"
> > +#include "../../../util/debug.h"
> > +#include "../../../util/evlist.h"
> > +#include "../../../util/pmu.h"
> >  #include "cs-etm.h"
> >  #include "arm-spe.h"
> >
> > diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> > index d942f118d32c..67c7fb8d7eb0 100644
> > --- a/tools/perf/arch/arm/util/cs-etm.c
> > +++ b/tools/perf/arch/arm/util/cs-etm.c
> > @@ -16,19 +16,19 @@
> >  #include <linux/zalloc.h>
> >
> >  #include "cs-etm.h"
> > -#include "../../util/debug.h"
> > -#include "../../util/record.h"
> > -#include "../../util/auxtrace.h"
> > -#include "../../util/cpumap.h"
> > -#include "../../util/event.h"
> > -#include "../../util/evlist.h"
> > -#include "../../util/evsel.h"
> > -#include "../../util/perf_api_probe.h"
> > -#include "../../util/evsel_config.h"
> > -#include "../../util/pmu.h"
> > -#include "../../util/cs-etm.h"
> > +#include "../../../util/debug.h"
> > +#include "../../../util/record.h"
> > +#include "../../../util/auxtrace.h"
> > +#include "../../../util/cpumap.h"
> > +#include "../../../util/event.h"
> > +#include "../../../util/evlist.h"
> > +#include "../../../util/evsel.h"
> > +#include "../../../util/perf_api_probe.h"
> > +#include "../../../util/evsel_config.h"
> > +#include "../../../util/pmu.h"
> > +#include "../../../util/cs-etm.h"
> >  #include <internal/lib.h> // page_size
> > -#include "../../util/session.h"
> > +#include "../../../util/session.h"
> >
> >  #include <errno.h>
> >  #include <stdlib.h>
> > diff --git a/tools/perf/arch/arm/util/perf_regs.c b/tools/perf/arch/arm/util/perf_regs.c
> > index 2864e2e3776d..2833e101a7c6 100644
> > --- a/tools/perf/arch/arm/util/perf_regs.c
> > +++ b/tools/perf/arch/arm/util/perf_regs.c
> > @@ -1,5 +1,5 @@
> >  // SPDX-License-Identifier: GPL-2.0
> > -#include "../../util/perf_regs.h"
> > +#include "../../../util/perf_regs.h"
> >
> >  const struct sample_reg sample_reg_masks[] = {
> >         SMPL_REG_END
> > diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
> > index bbc297a7e2e3..b8b23b9dc598 100644
> > --- a/tools/perf/arch/arm/util/pmu.c
> > +++ b/tools/perf/arch/arm/util/pmu.c
> > @@ -10,7 +10,7 @@
> >  #include <linux/string.h>
> >
> >  #include "arm-spe.h"
> > -#include "../../util/pmu.h"
> > +#include "../../../util/pmu.h"
> >
> >  struct perf_event_attr
> >  *perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
> > diff --git a/tools/perf/arch/arm/util/unwind-libdw.c b/tools/perf/arch/arm/util/unwind-libdw.c
> > index 36ba4c69c3c5..b7692cb0c733 100644
> > --- a/tools/perf/arch/arm/util/unwind-libdw.c
> > +++ b/tools/perf/arch/arm/util/unwind-libdw.c
> > @@ -1,8 +1,8 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <elfutils/libdwfl.h>
> > -#include "../../util/unwind-libdw.h"
> > -#include "../../util/perf_regs.h"
> > -#include "../../util/event.h"
> > +#include "../../../util/unwind-libdw.h"
> > +#include "../../../util/perf_regs.h"
> > +#include "../../../util/event.h"
> >
> >  bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> >  {
> > diff --git a/tools/perf/arch/arm/util/unwind-libunwind.c b/tools/perf/arch/arm/util/unwind-libunwind.c
> > index 3a550225dfaf..438906bf0014 100644
> > --- a/tools/perf/arch/arm/util/unwind-libunwind.c
> > +++ b/tools/perf/arch/arm/util/unwind-libunwind.c
> > @@ -3,8 +3,8 @@
> >  #include <errno.h>
> >  #include <libunwind.h>
> >  #include "perf_regs.h"
> > -#include "../../util/unwind.h"
> > -#include "../../util/debug.h"
> > +#include "../../../util/unwind.h"
> > +#include "../../../util/debug.h"
> >
> >  int libunwind__arch_reg_id(int regnum)
> >  {
> > --
> > 2.31.1.607.g51e8a6a459-goog
> >
