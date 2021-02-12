Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B862319B47
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 09:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhBLIgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 03:36:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29161 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229788AbhBLIf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 03:35:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613118872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0luyEnYMejlJ3a0ORpe3HnE/v6OmL43zNvFWCluHIio=;
        b=Ue3bWsqIPksE4JlzuErgpVi1yqfGIi++3JLiFpUGGZ/UsnIi93fofDCsAgrHJapYKzbuJZ
        I6kQxMezQLSX2N6CSfTBmP1y2obEwA+P514UA6oU1RFuixgQ7sxackCOesXqEXxhfZa5V1
        vuwckZkUSpJ+pSXj5VqRHQw6i6a52Ak=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-tDWqQ29_P_undHmnLvrmjA-1; Fri, 12 Feb 2021 03:33:50 -0500
X-MC-Unique: tDWqQ29_P_undHmnLvrmjA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9A9D19611A6;
        Fri, 12 Feb 2021 08:33:48 +0000 (UTC)
Received: from krava (unknown [10.40.193.237])
        by smtp.corp.redhat.com (Postfix) with SMTP id 427E75DEFA;
        Fri, 12 Feb 2021 08:33:46 +0000 (UTC)
Date:   Fri, 12 Feb 2021 09:33:45 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf env: Remove unneeded internal/cpumap inclusions
Message-ID: <YCY9aTcEMS1pFP6+@krava>
References: <20210211183914.4093187-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211183914.4093187-1-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 10:39:14AM -0800, Ian Rogers wrote:
> Minor cleanup.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/bench/epoll-ctl.c               | 1 -
>  tools/perf/bench/epoll-wait.c              | 1 -
>  tools/perf/bench/futex-hash.c              | 1 -
>  tools/perf/bench/futex-lock-pi.c           | 1 -
>  tools/perf/bench/futex-requeue.c           | 1 -
>  tools/perf/bench/futex-wake-parallel.c     | 1 -
>  tools/perf/bench/futex-wake.c              | 1 -
>  tools/perf/tests/openat-syscall-all-cpus.c | 1 -
>  tools/perf/util/synthetic-events.c         | 1 -
>  9 files changed, 9 deletions(-)
> 
> diff --git a/tools/perf/bench/epoll-ctl.c b/tools/perf/bench/epoll-ctl.c
> index ca2d591aad8a..ddaca75c3bc0 100644
> --- a/tools/perf/bench/epoll-ctl.c
> +++ b/tools/perf/bench/epoll-ctl.c
> @@ -21,7 +21,6 @@
>  #include <sys/resource.h>
>  #include <sys/epoll.h>
>  #include <sys/eventfd.h>
> -#include <internal/cpumap.h>
>  #include <perf/cpumap.h>
>  
>  #include "../util/stat.h"
> diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
> index 75dca9773186..0a0ff1247c83 100644
> --- a/tools/perf/bench/epoll-wait.c
> +++ b/tools/perf/bench/epoll-wait.c
> @@ -76,7 +76,6 @@
>  #include <sys/epoll.h>
>  #include <sys/eventfd.h>
>  #include <sys/types.h>
> -#include <internal/cpumap.h>
>  #include <perf/cpumap.h>
>  
>  #include "../util/stat.h"
> diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
> index 915bf3da7ce2..b65373ce5c4f 100644
> --- a/tools/perf/bench/futex-hash.c
> +++ b/tools/perf/bench/futex-hash.c
> @@ -20,7 +20,6 @@
>  #include <linux/kernel.h>
>  #include <linux/zalloc.h>
>  #include <sys/time.h>
> -#include <internal/cpumap.h>
>  #include <perf/cpumap.h>
>  
>  #include "../util/stat.h"
> diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-lock-pi.c
> index bb25d8beb3b8..89c6d160379c 100644
> --- a/tools/perf/bench/futex-lock-pi.c
> +++ b/tools/perf/bench/futex-lock-pi.c
> @@ -14,7 +14,6 @@
>  #include <linux/kernel.h>
>  #include <linux/zalloc.h>
>  #include <errno.h>
> -#include <internal/cpumap.h>
>  #include <perf/cpumap.h>
>  #include "bench.h"
>  #include "futex.h"
> diff --git a/tools/perf/bench/futex-requeue.c b/tools/perf/bench/futex-requeue.c
> index 7a15c2e61022..5fa23295ee5f 100644
> --- a/tools/perf/bench/futex-requeue.c
> +++ b/tools/perf/bench/futex-requeue.c
> @@ -20,7 +20,6 @@
>  #include <linux/kernel.h>
>  #include <linux/time64.h>
>  #include <errno.h>
> -#include <internal/cpumap.h>
>  #include <perf/cpumap.h>
>  #include "bench.h"
>  #include "futex.h"
> diff --git a/tools/perf/bench/futex-wake-parallel.c b/tools/perf/bench/futex-wake-parallel.c
> index cd2b81a845ac..6e6f5247e1fe 100644
> --- a/tools/perf/bench/futex-wake-parallel.c
> +++ b/tools/perf/bench/futex-wake-parallel.c
> @@ -29,7 +29,6 @@ int bench_futex_wake_parallel(int argc __maybe_unused, const char **argv __maybe
>  #include <linux/time64.h>
>  #include <errno.h>
>  #include "futex.h"
> -#include <internal/cpumap.h>
>  #include <perf/cpumap.h>
>  
>  #include <err.h>
> diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.c
> index 2dfcef3e371e..6d217868f53c 100644
> --- a/tools/perf/bench/futex-wake.c
> +++ b/tools/perf/bench/futex-wake.c
> @@ -20,7 +20,6 @@
>  #include <linux/kernel.h>
>  #include <linux/time64.h>
>  #include <errno.h>
> -#include <internal/cpumap.h>
>  #include <perf/cpumap.h>
>  #include "bench.h"
>  #include "futex.h"
> diff --git a/tools/perf/tests/openat-syscall-all-cpus.c b/tools/perf/tests/openat-syscall-all-cpus.c
> index 71f85e2cc127..f7dd6c463f04 100644
> --- a/tools/perf/tests/openat-syscall-all-cpus.c
> +++ b/tools/perf/tests/openat-syscall-all-cpus.c
> @@ -15,7 +15,6 @@
>  #include "tests.h"
>  #include "thread_map.h"
>  #include <perf/cpumap.h>
> -#include <internal/cpumap.h>
>  #include "debug.h"
>  #include "stat.h"
>  #include "util/counts.h"
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index c6f9db3faf83..0b767233ae1f 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -24,7 +24,6 @@
>  #include <linux/perf_event.h>
>  #include <asm/bug.h>
>  #include <perf/evsel.h>
> -#include <internal/cpumap.h>
>  #include <perf/cpumap.h>
>  #include <internal/lib.h> // page_size
>  #include <internal/threadmap.h>
> -- 
> 2.30.0.478.g8a0d178c01-goog
> 

