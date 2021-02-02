Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33A330BE75
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 13:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbhBBMmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 07:42:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27724 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230439AbhBBMlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 07:41:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612269614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tcfgWIrQUgzhoGrS2VFoy8N33q+DK/NFBMN5hKNRz5I=;
        b=g5oILDGqS+FrMau6GnTCrsmjEr+i6h23MLn3AyRS5rVMNXf5WzLG2aQ029V9UvRTI8w/GQ
        m35t5rNsIX15o/9/30P9GK63JbO0Bbc0YO9nJlIP9aOM4HKml5nr6+m2yCdt8wd+Chkxbj
        yDHW2hVnzTa3mU3C0dOI0Xh8fiFMqdQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-ggBi5ohKPiOI0JIJf8INKQ-1; Tue, 02 Feb 2021 07:40:12 -0500
X-MC-Unique: ggBi5ohKPiOI0JIJf8INKQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 684971005501;
        Tue,  2 Feb 2021 12:40:10 +0000 (UTC)
Received: from krava (unknown [10.40.193.189])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5ABAF5D9C6;
        Tue,  2 Feb 2021 12:40:08 +0000 (UTC)
Date:   Tue, 2 Feb 2021 13:40:07 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCHSET v3 0/3] perf tools: Minor improvements in event
 synthesis
Message-ID: <YBlIJzIZ1nEesWS9@krava>
References: <20210202090118.2008551-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202090118.2008551-1-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 06:01:15PM +0900, Namhyung Kim wrote:
> Hello,
> 
> This is to optimize the event synthesis during perf record.
> 
> Changes in v3:
>  * remove unnecessary pid check
>  * update change log in patch #2

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> 
> The first patch is to reduce memory usage when many threads are used.
> The second is to avoid unncessary syscalls for kernel threads.  And
> the last one is to reduce the number of threads to iterate when new
> threads are being created at the same time.
> 
> Unfortunately there's no dramatic improvement here but I can see ~5%
> gain in the 'perf bench internals synthesize' on a big machine.
> (The numbers are not stable though)
> 
> 
> Before:
>   # perf bench internals synthesize --mt -M1 -I 100
>   # Running 'internals/synthesize' benchmark:
>   Computing performance of multi threaded perf event synthesis by
>   synthesizing events on CPU 0:
>     Number of synthesis threads: 1
>       Average synthesis took: 68831.480 usec (+- 101.450 usec)
>       Average num. events: 9982.000 (+- 0.000)
>       Average time per event 6.896 usec
> 
> 
> After:
>   # perf bench internals synthesize --mt -M1 -I 100
>   # Running 'internals/synthesize' benchmark:
>   Computing performance of multi threaded perf event synthesis by
>   synthesizing events on CPU 0:
>     Number of synthesis threads: 1
>       Average synthesis took: 65036.370 usec (+- 158.121 usec)
>       Average num. events: 9982.000 (+- 0.000)
>       Average time per event 6.515 usec
> 
> 
> Thanks,
> Namhyung
> 
> 
> Namhyung Kim (3):
>   perf tools: Use /proc/<PID>/task/<TID>/status for synthesis
>   perf tools: Skip MMAP record synthesis for kernel threads
>   perf tools: Use scandir() to iterate threads
> 
>  tools/perf/util/synthetic-events.c | 83 +++++++++++++++++++-----------
>  1 file changed, 53 insertions(+), 30 deletions(-)
> 
> -- 
> 2.30.0.365.g02bc693789-goog
> 

