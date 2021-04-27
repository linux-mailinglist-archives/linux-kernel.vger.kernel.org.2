Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C68636C6D8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238157AbhD0NQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:16:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58004 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235489AbhD0NQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619529317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y6H84GJnAeW5Ki6EBx9km44PwX2+BvONGaZl7eHFjHc=;
        b=S+czmyoRO2pMVv+IuXiITPHUaBKYXjPKkPJpLi87NHbqxaobIV0LWGFlDkTvNZ3wd4z4Hn
        KId0IB7mOtPwavH6MIgdNKuN6okoR/K0AuvQTjcA75H8Pd0JPBZgnZN8xQxrXzIycer57g
        09D3CdopGElmJvTGdW+Ke5mbMpmcAQA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-4e4MrcP5NGefOCkCzR12zg-1; Tue, 27 Apr 2021 09:15:15 -0400
X-MC-Unique: 4e4MrcP5NGefOCkCzR12zg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5175801AC1;
        Tue, 27 Apr 2021 13:15:13 +0000 (UTC)
Received: from krava (unknown [10.40.192.237])
        by smtp.corp.redhat.com (Postfix) with SMTP id A648B19718;
        Tue, 27 Apr 2021 13:15:11 +0000 (UTC)
Date:   Tue, 27 Apr 2021 15:15:10 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCHSET v2 0/6] perf report: Make --stat output more compact
Message-ID: <YIgOXhhbe9qwOSgd@krava>
References: <20210427013717.1651674-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427013717.1651674-1-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 06:37:11PM -0700, Namhyung Kim wrote:
> Hello,
> 
> This patchset changes the output of perf report --stat.
> 
> Changes from v1)
>  * fix build error in TUI  (Jiri)
>  * print percentage of each event  (Andi)
> 
> 
> The perf report --stat shows event statistics like below:
> 
>   $ perf report --stat
> 
>   Aggregated stats:
>              TOTAL events:      20064
>               MMAP events:        239
>               LOST events:          0
>               COMM events:       1518
>               EXIT events:          1
>           THROTTLE events:          0
>         UNTHROTTLE events:          0
>               FORK events:       1517
>               READ events:          0
>             SAMPLE events:       4015
>              MMAP2 events:      12769
>                AUX events:          0
>       ITRACE_START events:          0
>       LOST_SAMPLES events:          0
>             SWITCH events:          0
>    SWITCH_CPU_WIDE events:          0
>         NAMESPACES events:          0
>            KSYMBOL events:          0
>          BPF_EVENT events:          0
>             CGROUP events:          0
>          TEXT_POKE events:          0
>               ATTR events:          0
>         EVENT_TYPE events:          0
>       TRACING_DATA events:          0
>           BUILD_ID events:          0
>     FINISHED_ROUND events:          2
>           ID_INDEX events:          0
>      AUXTRACE_INFO events:          0
>           AUXTRACE events:          0
>     AUXTRACE_ERROR events:          0
>         THREAD_MAP events:          1
>            CPU_MAP events:          1
>        STAT_CONFIG events:          0
>               STAT events:          0
>         STAT_ROUND events:          0
>       EVENT_UPDATE events:          0
>          TIME_CONV events:          1
>            FEATURE events:          0
>         COMPRESSED events:          0
> 
> But it's too long and mostly 0 so we can make it more compact.  Also
> perf report -D has similar output at the end with each event's sample
> count.  It'd be better if we can have the same output in both case.
> 
> So I added --skip-empty (and --no-skip-empty automatically) to suppres
> the 0 output and add the event stats like below.
> 
>   $ perf report --stat --skip-empty
>   
>   Aggregated stats:
>              TOTAL events:      20064
>               MMAP events:        239  ( 1.2%)
>               COMM events:       1518  ( 7.6%)
>               EXIT events:          1  ( 0.0%)
>               FORK events:       1517  ( 7.6%)
>             SAMPLE events:       4015  (20.0%)
>              MMAP2 events:      12769  (63.6%)
>     FINISHED_ROUND events:          2  ( 0.0%)
>         THREAD_MAP events:          1  ( 0.0%)
>            CPU_MAP events:          1  ( 0.0%)
>          TIME_CONV events:          1  ( 0.0%)
>   cycles stats:
>             SAMPLE events:       2475
>   instructions stats:
>             SAMPLE events:       1540
> 
> 
> And I make it enabled by default with a new config option
> report.skip-empty to change the behavior if needed.
> 
> Thanks,
> Namhyung
> 
> 
> Namhyung Kim (6):
>   perf top: Use evlist->events_stat to count events
>   perf hists: Split hists_stats from events_stats
>   perf report: Show event sample counts in --stat output
>   perf report: Add --skip-empty option to suppress 0 event stat
>   perf report: Make --skip-empty as default
>   perf report: Print percentage of each event statistics

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

