Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378CE35FAC5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353049AbhDNSYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:24:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:41712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234422AbhDNSX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:23:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 568E761131;
        Wed, 14 Apr 2021 18:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618424614;
        bh=3A66iy0mmrIUSj1m2qis51C3ROXRhXAXjk0fvQ5hPYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d3TXMDP7z6Zl+cWVr7Bl+MI9DuLyj8dHSKnhEIUsOyzXdRu/jiRChCGlKvLkii6A0
         tIGry/YocYWXQwjKOG2BYDwVktCPX1v1ZEPsqVftk2ZuowEInW5gEDS+KIjD7CZnf/
         Uv7MHz4+Kacfqaegx/4bOjFAeoky+ejL/0713l5QxfExAhOYbjLRUIr2NhDcPbnMvc
         b59B4EY0Nb55wGt5+SjOAt5o3/36izmBvAq5RlmjIfsvWqIknBwa0UUy3t+S59K7YK
         JqwWRhbJ8hebx9IK80Lxhh2DHcl6+fyriSzyjxt2Sxd/h/d4AQdtwP0gJEhVyYWkSK
         cmOOhN8jybn6g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BC64B40647; Wed, 14 Apr 2021 15:23:31 -0300 (-03)
Date:   Wed, 14 Apr 2021 15:23:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Itaru Kitayama <itaru.kitayama@gmail.com>
Subject: Re: [PATCH v8 2/4] libperf: Add evsel mmap support
Message-ID: <YHczIzjv6Kt3cxI7@kernel.org>
References: <20210414155412.3697605-1-robh@kernel.org>
 <20210414155412.3697605-2-robh@kernel.org>
 <CAM9d7cibppJUQuqcxEO9gU-KcHJNsoMJQw=1+_Fw3oXXHEKUCA@mail.gmail.com>
 <YHcuIKjNDkOUCupx@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHcuIKjNDkOUCupx@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 14, 2021 at 03:02:08PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Apr 15, 2021 at 01:41:35AM +0900, Namhyung Kim escreveu:
> > Hello,
> > 
> > On Thu, Apr 15, 2021 at 1:07 AM Rob Herring <robh@kernel.org> wrote:
> > > +void *perf_evsel__mmap_base(struct perf_evsel *evsel, int cpu, int thread)
> > > +{
> > > +       if (FD(evsel, cpu, thread) < 0 || MMAP(evsel, cpu, thread) == NULL)
> > > +               return NULL;
> > 
> > I think you should check the cpu and the thread is in
> > a valid range.  Currently xyarray__entry() simply accesses
> > the content without checking the boundaries.
> 
> So, since xyarray has the bounds, it should check it, i.e. we need to
> have a __xyarray__entry() that is what xyarray__entry() does, i.e.
> assume the values have been bounds checked, then a new method,
> xyarray__entry() that does bounds check, if it fails, return NULL,
> otherwise calls __xyarray__entry().
> 
> I see this is frustrating and I should've chimed in earlier, but at
> least now this is getting traction, and the end result will be better
> not just for the feature you've been dilligently working on,
> 
> Thank you for your persistence,

Re-reading, yeah, this can be done in a separate patch, Namhyung, can I
have your Reviewed-by? That or an Acked-by?

- Arnaldo
 
> - Arnaldo
>  
> > Thanks,
> > Namhyung
> > 
> > 
> > > +
> > > +       return MMAP(evsel, cpu, thread)->base;
> > > +}
> > > +
> > >  int perf_evsel__read_size(struct perf_evsel *evsel)
> > >  {
> > >         u64 read_format = evsel->attr.read_format;
> > > diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
> > > index 1ffd083b235e..1c067d088bc6 100644
> > > --- a/tools/lib/perf/include/internal/evsel.h
> > > +++ b/tools/lib/perf/include/internal/evsel.h
> > > @@ -41,6 +41,7 @@ struct perf_evsel {
> > >         struct perf_cpu_map     *own_cpus;
> > >         struct perf_thread_map  *threads;
> > >         struct xyarray          *fd;
> > > +       struct xyarray          *mmap;
> > >         struct xyarray          *sample_id;
> > >         u64                     *id;
> > >         u32                      ids;
> > > diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
> > > index c82ec39a4ad0..60eae25076d3 100644
> > > --- a/tools/lib/perf/include/perf/evsel.h
> > > +++ b/tools/lib/perf/include/perf/evsel.h
> > > @@ -27,6 +27,9 @@ LIBPERF_API int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *
> > >                                  struct perf_thread_map *threads);
> > >  LIBPERF_API void perf_evsel__close(struct perf_evsel *evsel);
> > >  LIBPERF_API void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu);
> > > +LIBPERF_API int perf_evsel__mmap(struct perf_evsel *evsel, int pages);
> > > +LIBPERF_API void perf_evsel__munmap(struct perf_evsel *evsel);
> > > +LIBPERF_API void *perf_evsel__mmap_base(struct perf_evsel *evsel, int cpu, int thread);
> > >  LIBPERF_API int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
> > >                                  struct perf_counts_values *count);
> > >  LIBPERF_API int perf_evsel__enable(struct perf_evsel *evsel);
> > > diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
> > > index 7be1af8a546c..c0c7ceb11060 100644
> > > --- a/tools/lib/perf/libperf.map
> > > +++ b/tools/lib/perf/libperf.map
> > > @@ -23,6 +23,9 @@ LIBPERF_0.0.1 {
> > >                 perf_evsel__disable;
> > >                 perf_evsel__open;
> > >                 perf_evsel__close;
> > > +               perf_evsel__mmap;
> > > +               perf_evsel__munmap;
> > > +               perf_evsel__mmap_base;
> > >                 perf_evsel__read;
> > >                 perf_evsel__cpus;
> > >                 perf_evsel__threads;
> > > --
> > > 2.27.0
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
