Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316F232945E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 23:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244846AbhCAV6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 16:58:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46752 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238394AbhCAR0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 12:26:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614619472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=db0ZON+CWTPzTto0Mt7xczjtYMy52Uyv+gBcfkL8LZM=;
        b=EsuT0HflKYO/i0Yo3dQZOpc+9mBlxNtncrqlshpwdndzxRfhBH1pKwKuwwgLxapIR9FIEW
        6H974PEFQvMP0EvIIdd8cosKWhmNT/idIWXKfWiDowuAJ5mt3DZ7WiPtCC40yOLsCNk1Vo
        ftQGi8pA5bik19GxKuOd8Z9XHnJHxpo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383--QoipTG7PBiI_St6Mc31vQ-1; Mon, 01 Mar 2021 12:24:28 -0500
X-MC-Unique: -QoipTG7PBiI_St6Mc31vQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1698801965;
        Mon,  1 Mar 2021 17:24:26 +0000 (UTC)
Received: from krava (unknown [10.40.192.173])
        by smtp.corp.redhat.com (Postfix) with SMTP id 41FFA5C1D1;
        Mon,  1 Mar 2021 17:24:24 +0000 (UTC)
Date:   Mon, 1 Mar 2021 18:24:23 +0100
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
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH 04/11] perf test: Fix cpu and thread map leaks in
 sw_clock_freq test
Message-ID: <YD0jR7ENbD7u01Zq@krava>
References: <20210301140409.184570-1-namhyung@kernel.org>
 <20210301140409.184570-5-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301140409.184570-5-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 11:04:02PM +0900, Namhyung Kim wrote:
> The evlist has the maps with its own refcounts so we don't need to set
> the pointers to NULL.  Otherwise following error was reported by Asan.
> 
> Also change the goto label since it doesn't need to have two.
> 
>   # perf test -v 25
>   25: Software clock events period values        :
>   --- start ---
>   test child forked, pid 149154
>   mmap size 528384B
>   mmap size 528384B
> 
>   =================================================================
>   ==149154==ERROR: LeakSanitizer: detected memory leaks
> 
>   Direct leak of 32 byte(s) in 1 object(s) allocated from:
>     #0 0x7fef5cd071f8 in __interceptor_realloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:164
>     #1 0x56260d5e8b8e in perf_thread_map__realloc /home/namhyung/project/linux/tools/lib/perf/threadmap.c:23
>     #2 0x56260d3df7a9 in thread_map__new_by_tid util/thread_map.c:63
>     #3 0x56260d2ac6b2 in __test__sw_clock_freq tests/sw-clock.c:65
>     #4 0x56260d26d8fb in run_test tests/builtin-test.c:428
>     #5 0x56260d26d8fb in test_and_print tests/builtin-test.c:458
>     #6 0x56260d26fa53 in __cmd_test tests/builtin-test.c:679
>     #7 0x56260d26fa53 in cmd_test tests/builtin-test.c:825
>     #8 0x56260d2dbb64 in run_builtin /home/namhyung/project/linux/tools/perf/perf.c:313
>     #9 0x56260d165a88 in handle_internal_command /home/namhyung/project/linux/tools/perf/perf.c:365
>     #10 0x56260d165a88 in run_argv /home/namhyung/project/linux/tools/perf/perf.c:409
>     #11 0x56260d165a88 in main /home/namhyung/project/linux/tools/perf/perf.c:539
>     #12 0x7fef5c83cd09 in __libc_start_main ../csu/libc-start.c:308
> 
>     ...
>   test child finished with 1
>   ---- end ----
>   Software clock events period values      : FAILED!
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/sw-clock.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
> index a49c9e23053b..74988846be1d 100644
> --- a/tools/perf/tests/sw-clock.c
> +++ b/tools/perf/tests/sw-clock.c
> @@ -42,8 +42,8 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
>  		.disabled = 1,
>  		.freq = 1,
>  	};
> -	struct perf_cpu_map *cpus;
> -	struct perf_thread_map *threads;
> +	struct perf_cpu_map *cpus = NULL;
> +	struct perf_thread_map *threads = NULL;
>  	struct mmap *md;
>  
>  	attr.sample_freq = 500;
> @@ -66,14 +66,11 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
>  	if (!cpus || !threads) {
>  		err = -ENOMEM;
>  		pr_debug("Not enough memory to create thread/cpu maps\n");
> -		goto out_free_maps;
> +		goto out_delete_evlist;
>  	}
>  
>  	perf_evlist__set_maps(&evlist->core, cpus, threads);
>  
> -	cpus	= NULL;
> -	threads = NULL;

hum, so IIUC we added these and the other you remove in your patches long time ago,
because there was no refcounting at that time, right?

jirka

> -
>  	if (evlist__open(evlist)) {
>  		const char *knob = "/proc/sys/kernel/perf_event_max_sample_rate";
>  
> @@ -129,10 +126,9 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
>  		err = -1;
>  	}
>  
> -out_free_maps:
> +out_delete_evlist:
>  	perf_cpu_map__put(cpus);
>  	perf_thread_map__put(threads);
> -out_delete_evlist:
>  	evlist__delete(evlist);
>  	return err;
>  }
> -- 
> 2.30.1.766.gb4fecdf3b7-goog
> 

