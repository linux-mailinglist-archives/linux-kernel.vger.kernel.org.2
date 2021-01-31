Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6123309F44
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 23:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhAaWkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 17:40:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24065 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229481AbhAaWhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 17:37:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612132534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J4E9EA/l7JKgyS7qO1LRTs5yq4ElEah/eNdsAWoWkKQ=;
        b=bLFmPTIDSUUNWpLoRmSCwLkgWpb4cSHbOUnm1BrCdPT0kAS1+l2Vc56YFh/nML/qKMzjr/
        tTURv2CfGY3K8fSTwISz4DsYimb+kFKi9FiXPggsnztSVwkxrqcShDHNsni6Gc8QdHOUSX
        rI1H3T2151+r5E93vrPuH5dwwjZtSDk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-qNHcYscoMDSDRvrB2UPZgw-1; Sun, 31 Jan 2021 17:35:30 -0500
X-MC-Unique: qNHcYscoMDSDRvrB2UPZgw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBFA6802B44;
        Sun, 31 Jan 2021 22:35:28 +0000 (UTC)
Received: from krava (unknown [10.40.192.85])
        by smtp.corp.redhat.com (Postfix) with SMTP id BF57E10016FC;
        Sun, 31 Jan 2021 22:35:26 +0000 (UTC)
Date:   Sun, 31 Jan 2021 23:35:25 +0100
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
Subject: Re: [PATCH v2 0/3] perf tools: Minor improvements in event synthesis
Message-ID: <YBcwrQJATmToLua2@krava>
References: <20210129054901.1705483-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129054901.1705483-1-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 02:48:58PM +0900, Namhyung Kim wrote:
> Hello,
> 
> This is to optimize the event synthesis during perf record.
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

heya,
is there any change to previous version?

jirka

> 
>  tools/perf/util/synthetic-events.c | 88 ++++++++++++++++++++----------
>  1 file changed, 58 insertions(+), 30 deletions(-)
> 
> -- 
> 2.30.0.365.g02bc693789-goog
> 

