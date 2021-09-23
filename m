Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD62415FF6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 15:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241286AbhIWNdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 09:33:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:45942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241467AbhIWNds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:33:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F05D610D1;
        Thu, 23 Sep 2021 13:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632403936;
        bh=TyNFPW4VpmUhkf1H5RUpWm9BcVpjiDxX+ppA9eB8jFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b2IdFQ9TiOg4ur5jxX7J1YI3vT1u/Cwy4X1Ocmtm3SKwThJjpfXCv0tVaC6Qgjn1j
         xUthEQjFAM5Hzw2z3FeONXCYCSdfx16T3IKaxFNqleoO1eou7Swn1pIiap5Ap9734V
         3aZjQ9e3zlqtfcQq3rEJGAVkida7N8Oxr5K1Kt2ScTJwSJr5c/IYe8snJYBYkCaCIl
         crKzFfgq+SsLasAFrSG7Ipiu/NL5Gc0lpMhnXVursXoY24Ozhwp9DQQlCu3sUK2gut
         NS1ozVaj5bFIfd+EafaqfhTI93gACAqE1BtuuwnwrS6cbTgCRn6Xm9sAIUWLl+2hWx
         U2gSgM+onLTrg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C2E50410A1; Thu, 23 Sep 2021 10:32:13 -0300 (-03)
Date:   Thu, 23 Sep 2021 10:32:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2] perf test: Fix dwarf unwind for optimized builds.
Message-ID: <YUyB3WQzMIw6U77k@kernel.org>
References: <20210922173812.456348-1-irogers@google.com>
 <YUuna3dv+mgkkzqj@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUuna3dv+mgkkzqj@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 23, 2021 at 12:00:11AM +0200, Jiri Olsa escreveu:
> On Wed, Sep 22, 2021 at 10:38:12AM -0700, Ian Rogers wrote:
> > To ensure the stack frames are on the stack tail calls optimizations
> > need to be inhibited. If your compiler supports an attribute use it,
> > otherwise use an asm volatile barrier.
> > 
> > The barrier fix was suggested here:
> > https://lore.kernel.org/lkml/20201028081123.GT2628@hirez.programming.kicks-ass.net/
> > Tested with an optimized clang build and by forcing the asm barrier
> > route with an optimized clang build.
> > 
> > A GCC bug tracking a proper disable_tail_calls is:
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97831
> > 
> > Fixes: 9ae1e990f1ab ("perf tools: Remove broken __no_tail_call
> >        attribute")
> > 
> > v2. is a rebase. The original fix patch generated quite a lot of
> >     discussion over the right place for the fix:
> > https://lore.kernel.org/lkml/20201114000803.909530-1-irogers@google.com/
> >     The patch reflects my preference of it being near the use, so that
> >     future code cleanups don't break this somewhat special usage.
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo

 
> thanks,
> jirka
> 
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/dwarf-unwind.c | 39 +++++++++++++++++++++++++++------
> >  1 file changed, 32 insertions(+), 7 deletions(-)
> > 
> > diff --git a/tools/perf/tests/dwarf-unwind.c b/tools/perf/tests/dwarf-unwind.c
> > index a288035eb362..c756284b3b13 100644
> > --- a/tools/perf/tests/dwarf-unwind.c
> > +++ b/tools/perf/tests/dwarf-unwind.c
> > @@ -20,6 +20,23 @@
> >  /* For bsearch. We try to unwind functions in shared object. */
> >  #include <stdlib.h>
> >  
> > +/*
> > + * The test will assert frames are on the stack but tail call optimizations lose
> > + * the frame of the caller. Clang can disable this optimization on a called
> > + * function but GCC currently (11/2020) lacks this attribute. The barrier is
> > + * used to inhibit tail calls in these cases.
> > + */
> > +#ifdef __has_attribute
> > +#if __has_attribute(disable_tail_calls)
> > +#define NO_TAIL_CALL_ATTRIBUTE __attribute__((disable_tail_calls))
> > +#define NO_TAIL_CALL_BARRIER
> > +#endif
> > +#endif
> > +#ifndef NO_TAIL_CALL_ATTRIBUTE
> > +#define NO_TAIL_CALL_ATTRIBUTE
> > +#define NO_TAIL_CALL_BARRIER __asm__ __volatile__("" : : : "memory");
> > +#endif
> > +
> >  static int mmap_handler(struct perf_tool *tool __maybe_unused,
> >  			union perf_event *event,
> >  			struct perf_sample *sample,
> > @@ -91,7 +108,7 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
> >  	return strcmp((const char *) symbol, funcs[idx]);
> >  }
> >  
> > -noinline int test_dwarf_unwind__thread(struct thread *thread)
> > +NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__thread(struct thread *thread)
> >  {
> >  	struct perf_sample sample;
> >  	unsigned long cnt = 0;
> > @@ -122,7 +139,7 @@ noinline int test_dwarf_unwind__thread(struct thread *thread)
> >  
> >  static int global_unwind_retval = -INT_MAX;
> >  
> > -noinline int test_dwarf_unwind__compare(void *p1, void *p2)
> > +NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__compare(void *p1, void *p2)
> >  {
> >  	/* Any possible value should be 'thread' */
> >  	struct thread *thread = *(struct thread **)p1;
> > @@ -141,7 +158,7 @@ noinline int test_dwarf_unwind__compare(void *p1, void *p2)
> >  	return p1 - p2;
> >  }
> >  
> > -noinline int test_dwarf_unwind__krava_3(struct thread *thread)
> > +NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__krava_3(struct thread *thread)
> >  {
> >  	struct thread *array[2] = {thread, thread};
> >  	void *fp = &bsearch;
> > @@ -160,14 +177,22 @@ noinline int test_dwarf_unwind__krava_3(struct thread *thread)
> >  	return global_unwind_retval;
> >  }
> >  
> > -noinline int test_dwarf_unwind__krava_2(struct thread *thread)
> > +NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__krava_2(struct thread *thread)
> >  {
> > -	return test_dwarf_unwind__krava_3(thread);
> > +	int ret;
> > +
> > +	ret =  test_dwarf_unwind__krava_3(thread);
> > +	NO_TAIL_CALL_BARRIER;
> > +	return ret;
> >  }
> >  
> > -noinline int test_dwarf_unwind__krava_1(struct thread *thread)
> > +NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__krava_1(struct thread *thread)
> >  {
> > -	return test_dwarf_unwind__krava_2(thread);
> > +	int ret;
> > +
> > +	ret =  test_dwarf_unwind__krava_2(thread);
> > +	NO_TAIL_CALL_BARRIER;
> > +	return ret;
> >  }
> >  
> >  int test__dwarf_unwind(struct test *test __maybe_unused, int subtest __maybe_unused)
> > -- 
> > 2.33.0.464.g1972c5931b-goog
> > 

-- 

- Arnaldo
