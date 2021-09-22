Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E38415327
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 00:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238240AbhIVWBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 18:01:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38789 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232149AbhIVWBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 18:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632348016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MSufQgcqxvHFrHlhUjYOqfQRYT76lvHJVVdac9iuZ2k=;
        b=Sh5o7wJ7AbH5KV7jPQi2ykzgjyr6apYwiDTmsI3VBzxuSGrvN3YdwBf6C3xPKhw6hCtyNq
        jUUR1wKL26240JmS1of64EM5iZOoIRtW/wlciDDaHJ8DoS/FBPIMXfZXHwwFmdYQsm6bEu
        dRmFzrZcmapOTAQFi1AHLqQ5rcyxyLg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-fW3d8VfgN7e4fqYqh4APKQ-1; Wed, 22 Sep 2021 18:00:15 -0400
X-MC-Unique: fW3d8VfgN7e4fqYqh4APKQ-1
Received: by mail-wr1-f72.google.com with SMTP id v1-20020adfc401000000b0015e11f71e65so3441549wrf.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 15:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MSufQgcqxvHFrHlhUjYOqfQRYT76lvHJVVdac9iuZ2k=;
        b=OsB6jq+GRkz/F67Ai213vIJ8M8YTwpckLj+wNf5pk4P/HRVRAqZpmaj/PBD+SIZnk+
         zKoz4byaO90WVVTUMfYO0ZLZCuwCc7kyD1FzAt14GjZQSZnM7J2ZJZUQVSPvuiP70WR/
         +/x9gi9uzoHBglagE8r9yNxPSjq5EvjPLuihzB3pdBaUqEFVHGO2gQ3QWA1/KGUUleCw
         ToRdy/u/gLtksEvH4yAEVGDQfYbzbdPv6k5CpMWsU4id1avcAdvEFC9dqqcnyf1c1aBB
         //W2w/+XfoyeCqKI5JBXogvtrkqufIZAy8koi2+yVs9idch+ATfFHVeXRIYhmk1h1v3I
         ZUvA==
X-Gm-Message-State: AOAM531zQdzWOJWrmfvJRuzLdQ1L6vwAiNARGQZoY/QIuoYmX1TMcTM+
        i4Y3cjctgFVk1ZS32UZDw43RHLz8IH7qM3NvZ/pzx/UOB11eUsydCF4rrjLesJkZ2C6rCRWcIZE
        m9h9qT5smG/FMt2JcO2Ygmx+o
X-Received: by 2002:a1c:7714:: with SMTP id t20mr12669543wmi.163.1632348014292;
        Wed, 22 Sep 2021 15:00:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPLS4+2WcBvrD8GrV27JqERjbGfGscJjJMuEEgM2vk2AWcATO3CB7llcUIylvt1H9uYjy4wg==
X-Received: by 2002:a1c:7714:: with SMTP id t20mr12669531wmi.163.1632348014097;
        Wed, 22 Sep 2021 15:00:14 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id c7sm3462958wmq.13.2021.09.22.15.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 15:00:13 -0700 (PDT)
Date:   Thu, 23 Sep 2021 00:00:11 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2] perf test: Fix dwarf unwind for optimized builds.
Message-ID: <YUuna3dv+mgkkzqj@krava>
References: <20210922173812.456348-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922173812.456348-1-irogers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 10:38:12AM -0700, Ian Rogers wrote:
> To ensure the stack frames are on the stack tail calls optimizations
> need to be inhibited. If your compiler supports an attribute use it,
> otherwise use an asm volatile barrier.
> 
> The barrier fix was suggested here:
> https://lore.kernel.org/lkml/20201028081123.GT2628@hirez.programming.kicks-ass.net/
> Tested with an optimized clang build and by forcing the asm barrier
> route with an optimized clang build.
> 
> A GCC bug tracking a proper disable_tail_calls is:
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97831
> 
> Fixes: 9ae1e990f1ab ("perf tools: Remove broken __no_tail_call
>        attribute")
> 
> v2. is a rebase. The original fix patch generated quite a lot of
>     discussion over the right place for the fix:
> https://lore.kernel.org/lkml/20201114000803.909530-1-irogers@google.com/
>     The patch reflects my preference of it being near the use, so that
>     future code cleanups don't break this somewhat special usage.

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/dwarf-unwind.c | 39 +++++++++++++++++++++++++++------
>  1 file changed, 32 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/tests/dwarf-unwind.c b/tools/perf/tests/dwarf-unwind.c
> index a288035eb362..c756284b3b13 100644
> --- a/tools/perf/tests/dwarf-unwind.c
> +++ b/tools/perf/tests/dwarf-unwind.c
> @@ -20,6 +20,23 @@
>  /* For bsearch. We try to unwind functions in shared object. */
>  #include <stdlib.h>
>  
> +/*
> + * The test will assert frames are on the stack but tail call optimizations lose
> + * the frame of the caller. Clang can disable this optimization on a called
> + * function but GCC currently (11/2020) lacks this attribute. The barrier is
> + * used to inhibit tail calls in these cases.
> + */
> +#ifdef __has_attribute
> +#if __has_attribute(disable_tail_calls)
> +#define NO_TAIL_CALL_ATTRIBUTE __attribute__((disable_tail_calls))
> +#define NO_TAIL_CALL_BARRIER
> +#endif
> +#endif
> +#ifndef NO_TAIL_CALL_ATTRIBUTE
> +#define NO_TAIL_CALL_ATTRIBUTE
> +#define NO_TAIL_CALL_BARRIER __asm__ __volatile__("" : : : "memory");
> +#endif
> +
>  static int mmap_handler(struct perf_tool *tool __maybe_unused,
>  			union perf_event *event,
>  			struct perf_sample *sample,
> @@ -91,7 +108,7 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
>  	return strcmp((const char *) symbol, funcs[idx]);
>  }
>  
> -noinline int test_dwarf_unwind__thread(struct thread *thread)
> +NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__thread(struct thread *thread)
>  {
>  	struct perf_sample sample;
>  	unsigned long cnt = 0;
> @@ -122,7 +139,7 @@ noinline int test_dwarf_unwind__thread(struct thread *thread)
>  
>  static int global_unwind_retval = -INT_MAX;
>  
> -noinline int test_dwarf_unwind__compare(void *p1, void *p2)
> +NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__compare(void *p1, void *p2)
>  {
>  	/* Any possible value should be 'thread' */
>  	struct thread *thread = *(struct thread **)p1;
> @@ -141,7 +158,7 @@ noinline int test_dwarf_unwind__compare(void *p1, void *p2)
>  	return p1 - p2;
>  }
>  
> -noinline int test_dwarf_unwind__krava_3(struct thread *thread)
> +NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__krava_3(struct thread *thread)
>  {
>  	struct thread *array[2] = {thread, thread};
>  	void *fp = &bsearch;
> @@ -160,14 +177,22 @@ noinline int test_dwarf_unwind__krava_3(struct thread *thread)
>  	return global_unwind_retval;
>  }
>  
> -noinline int test_dwarf_unwind__krava_2(struct thread *thread)
> +NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__krava_2(struct thread *thread)
>  {
> -	return test_dwarf_unwind__krava_3(thread);
> +	int ret;
> +
> +	ret =  test_dwarf_unwind__krava_3(thread);
> +	NO_TAIL_CALL_BARRIER;
> +	return ret;
>  }
>  
> -noinline int test_dwarf_unwind__krava_1(struct thread *thread)
> +NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__krava_1(struct thread *thread)
>  {
> -	return test_dwarf_unwind__krava_2(thread);
> +	int ret;
> +
> +	ret =  test_dwarf_unwind__krava_2(thread);
> +	NO_TAIL_CALL_BARRIER;
> +	return ret;
>  }
>  
>  int test__dwarf_unwind(struct test *test __maybe_unused, int subtest __maybe_unused)
> -- 
> 2.33.0.464.g1972c5931b-goog
> 

