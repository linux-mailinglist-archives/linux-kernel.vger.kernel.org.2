Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3820231A61D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 21:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhBLUhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 15:37:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:54076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229797AbhBLUhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 15:37:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D55D364D9F;
        Fri, 12 Feb 2021 20:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613162180;
        bh=U/81S6udlah0JZgUh9eZXBAvF005a3uhKn9HB8qtlbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bU8lkmY1qxm3jI92j6PIyXI/jBsWaJjK5sdSWDNLjha2Vfx3tvpLGzMRYMU39NA/U
         A6YudtDS/CnJUuRvP5/2Qkzfkcs7P9/bw1IWbpAzB8Dbix3EybZ/t5BjSLMrCM+gEz
         k/36w6G34VtMUKzmIjasN8dy+7j1zbOHzf3CVVo6AZsV3Ybyeb0cmZQT9TsAskdbt/
         MhY+0X9XLZ27gRgtEHBzDFSz8y6RJCB2/mLvGejhrs0Xbqvo+kerx5QOLfyHUK8bLo
         frITOop4O2dmc6t/9b44Q2JCt2cSnmuh3oI2iZZoON/6gw01Jk++U7P/oRiV03te6Y
         iAMcFaRHN8R2g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C66AB40513; Fri, 12 Feb 2021 17:36:17 -0300 (-03)
Date:   Fri, 12 Feb 2021 17:36:17 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf env: Remove unneeded internal/cpumap inclusions
Message-ID: <20210212203617.GI1398414@kernel.org>
References: <20210211183914.4093187-1-irogers@google.com>
 <YCY9aTcEMS1pFP6+@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCY9aTcEMS1pFP6+@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 12, 2021 at 09:33:45AM +0100, Jiri Olsa escreveu:
> On Thu, Feb 11, 2021 at 10:39:14AM -0800, Ian Rogers wrote:
> > Minor cleanup.
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo

 
> thanks,
> jirka
> 
> > ---
> >  tools/perf/bench/epoll-ctl.c               | 1 -
> >  tools/perf/bench/epoll-wait.c              | 1 -
> >  tools/perf/bench/futex-hash.c              | 1 -
> >  tools/perf/bench/futex-lock-pi.c           | 1 -
> >  tools/perf/bench/futex-requeue.c           | 1 -
> >  tools/perf/bench/futex-wake-parallel.c     | 1 -
> >  tools/perf/bench/futex-wake.c              | 1 -
> >  tools/perf/tests/openat-syscall-all-cpus.c | 1 -
> >  tools/perf/util/synthetic-events.c         | 1 -
> >  9 files changed, 9 deletions(-)
> > 
> > diff --git a/tools/perf/bench/epoll-ctl.c b/tools/perf/bench/epoll-ctl.c
> > index ca2d591aad8a..ddaca75c3bc0 100644
> > --- a/tools/perf/bench/epoll-ctl.c
> > +++ b/tools/perf/bench/epoll-ctl.c
> > @@ -21,7 +21,6 @@
> >  #include <sys/resource.h>
> >  #include <sys/epoll.h>
> >  #include <sys/eventfd.h>
> > -#include <internal/cpumap.h>
> >  #include <perf/cpumap.h>
> >  
> >  #include "../util/stat.h"
> > diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
> > index 75dca9773186..0a0ff1247c83 100644
> > --- a/tools/perf/bench/epoll-wait.c
> > +++ b/tools/perf/bench/epoll-wait.c
> > @@ -76,7 +76,6 @@
> >  #include <sys/epoll.h>
> >  #include <sys/eventfd.h>
> >  #include <sys/types.h>
> > -#include <internal/cpumap.h>
> >  #include <perf/cpumap.h>
> >  
> >  #include "../util/stat.h"
> > diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
> > index 915bf3da7ce2..b65373ce5c4f 100644
> > --- a/tools/perf/bench/futex-hash.c
> > +++ b/tools/perf/bench/futex-hash.c
> > @@ -20,7 +20,6 @@
> >  #include <linux/kernel.h>
> >  #include <linux/zalloc.h>
> >  #include <sys/time.h>
> > -#include <internal/cpumap.h>
> >  #include <perf/cpumap.h>
> >  
> >  #include "../util/stat.h"
> > diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-lock-pi.c
> > index bb25d8beb3b8..89c6d160379c 100644
> > --- a/tools/perf/bench/futex-lock-pi.c
> > +++ b/tools/perf/bench/futex-lock-pi.c
> > @@ -14,7 +14,6 @@
> >  #include <linux/kernel.h>
> >  #include <linux/zalloc.h>
> >  #include <errno.h>
> > -#include <internal/cpumap.h>
> >  #include <perf/cpumap.h>
> >  #include "bench.h"
> >  #include "futex.h"
> > diff --git a/tools/perf/bench/futex-requeue.c b/tools/perf/bench/futex-requeue.c
> > index 7a15c2e61022..5fa23295ee5f 100644
> > --- a/tools/perf/bench/futex-requeue.c
> > +++ b/tools/perf/bench/futex-requeue.c
> > @@ -20,7 +20,6 @@
> >  #include <linux/kernel.h>
> >  #include <linux/time64.h>
> >  #include <errno.h>
> > -#include <internal/cpumap.h>
> >  #include <perf/cpumap.h>
> >  #include "bench.h"
> >  #include "futex.h"
> > diff --git a/tools/perf/bench/futex-wake-parallel.c b/tools/perf/bench/futex-wake-parallel.c
> > index cd2b81a845ac..6e6f5247e1fe 100644
> > --- a/tools/perf/bench/futex-wake-parallel.c
> > +++ b/tools/perf/bench/futex-wake-parallel.c
> > @@ -29,7 +29,6 @@ int bench_futex_wake_parallel(int argc __maybe_unused, const char **argv __maybe
> >  #include <linux/time64.h>
> >  #include <errno.h>
> >  #include "futex.h"
> > -#include <internal/cpumap.h>
> >  #include <perf/cpumap.h>
> >  
> >  #include <err.h>
> > diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.c
> > index 2dfcef3e371e..6d217868f53c 100644
> > --- a/tools/perf/bench/futex-wake.c
> > +++ b/tools/perf/bench/futex-wake.c
> > @@ -20,7 +20,6 @@
> >  #include <linux/kernel.h>
> >  #include <linux/time64.h>
> >  #include <errno.h>
> > -#include <internal/cpumap.h>
> >  #include <perf/cpumap.h>
> >  #include "bench.h"
> >  #include "futex.h"
> > diff --git a/tools/perf/tests/openat-syscall-all-cpus.c b/tools/perf/tests/openat-syscall-all-cpus.c
> > index 71f85e2cc127..f7dd6c463f04 100644
> > --- a/tools/perf/tests/openat-syscall-all-cpus.c
> > +++ b/tools/perf/tests/openat-syscall-all-cpus.c
> > @@ -15,7 +15,6 @@
> >  #include "tests.h"
> >  #include "thread_map.h"
> >  #include <perf/cpumap.h>
> > -#include <internal/cpumap.h>
> >  #include "debug.h"
> >  #include "stat.h"
> >  #include "util/counts.h"
> > diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> > index c6f9db3faf83..0b767233ae1f 100644
> > --- a/tools/perf/util/synthetic-events.c
> > +++ b/tools/perf/util/synthetic-events.c
> > @@ -24,7 +24,6 @@
> >  #include <linux/perf_event.h>
> >  #include <asm/bug.h>
> >  #include <perf/evsel.h>
> > -#include <internal/cpumap.h>
> >  #include <perf/cpumap.h>
> >  #include <internal/lib.h> // page_size
> >  #include <internal/threadmap.h>
> > -- 
> > 2.30.0.478.g8a0d178c01-goog
> > 
> 

-- 

- Arnaldo
