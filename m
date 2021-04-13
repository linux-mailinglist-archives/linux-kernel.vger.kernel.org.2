Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036BD35E6ED
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 21:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343833AbhDMTIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 15:08:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231150AbhDMTI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 15:08:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BBEEB613C3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 19:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618340889;
        bh=ywzMELvuLStRdTUBxJiKFLMdIc6HNxynJnmE2U9/rqc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=swATTxQklp8zfyXQhR8trLeNK9PR+hOWOGGOjaphQGCGb5016ff1N7l0bXbJ9lFGv
         pupAr0RyIqgysjd1tGbAQ6RV6ZsFP88TTrqyvqLt2Pbk2vg/mDNap8p4kE4C6qEJLv
         B+GKgSOrOAmnT7f7Xm1hzRPbwmjo+PjUkoQ/s/Z9CjM8/HoJ3jwguXcR8VFo86TBMq
         k1VfMwW1iziWvesVz40o99sYv0JR1+AwA4/PVJYlKoAm95oRbAaA5NKScBgcUjPAYI
         weOe3Hc4DFG+t90rqwbzP05+T5WfOPmLxgeWyEhxM8pgwUMt8VP8q6x022zVYSvAro
         0SoFk+/p/K8aQ==
Received: by mail-qt1-f175.google.com with SMTP id o2so183583qtr.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 12:08:09 -0700 (PDT)
X-Gm-Message-State: AOAM532wpek/9ONRLaJQV/bTSbAEh+4ipFedVPmkXGUWHeZMJvSeWyqX
        lVrhTBVGZpqaE6IuJPkhQuiT+AW5BifyuOkH+A==
X-Google-Smtp-Source: ABdhPJwfRxzIlae3g/qZ0IWEoIKv89bPc97n4rJP55jI5G9y9RUqKudjjR7WtDELOE5XBV9aWngr+ZPRe6Ie5oBHUFE=
X-Received: by 2002:a05:622a:8:: with SMTP id x8mr22693772qtw.31.1618340888866;
 Tue, 13 Apr 2021 12:08:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210413171606.1825808-1-robh@kernel.org> <20210413171606.1825808-3-robh@kernel.org>
 <YHXlXMd2Bp+90851@kernel.org>
In-Reply-To: <YHXlXMd2Bp+90851@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 13 Apr 2021 14:07:57 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJfCNuvavU1xVUBxRFDopfsLW+E0kZXH8oZ2pmCDybPpA@mail.gmail.com>
Message-ID: <CAL_JsqJfCNuvavU1xVUBxRFDopfsLW+E0kZXH8oZ2pmCDybPpA@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] libperf: Add evsel mmap support
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 1:39 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Apr 13, 2021 at 12:16:04PM -0500, Rob Herring escreveu:
> > In order to support usersapce access, an event must be mmapped. While
> > there's already mmap support for evlist, the usecase is a bit different
> > than the self monitoring with userspace access. So let's add a new
> > perf_evsel__mmap() function to mmap an evsel. This allows implementing
> > userspace access as a fastpath for perf_evsel__read().
> >
> > The mmapped address is returned by perf_evsel__mmap_base() which
> > primarily for users/tests to check if userspace access is enabled.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > v7:
> >  - Add NULL fd check to perf_evsel__mmap
> > v6:
> >  - split mmap struct into it's own xyarray
> > v5:
> >  - Create an mmap for every underlying event opened. Due to this, we
> >    need a different way to get the mmap ptr, so perf_evsel__mmap_base()
> >    is introduced.
> > v4:
> >  - Change perf_evsel__mmap size to pages instead of bytes
> > v3:
> >  - New patch split out from user access patch
> > ---
> >  tools/lib/perf/Documentation/libperf.txt |  2 +
> >  tools/lib/perf/evsel.c                   | 54 ++++++++++++++++++++++++
> >  tools/lib/perf/include/internal/evsel.h  |  1 +
> >  tools/lib/perf/include/perf/evsel.h      |  2 +
> >  tools/lib/perf/libperf.map               |  2 +
> >  5 files changed, 61 insertions(+)
> >
> > diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
> > index 0c74c30ed23a..a2c73df191ca 100644
> > --- a/tools/lib/perf/Documentation/libperf.txt
> > +++ b/tools/lib/perf/Documentation/libperf.txt
> > @@ -136,6 +136,8 @@ SYNOPSIS
> >                         struct perf_thread_map *threads);
> >    void perf_evsel__close(struct perf_evsel *evsel);
> >    void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu);
> > +  int perf_evsel__mmap(struct perf_evsel *evsel, int pages);
> > +  void *perf_evsel__mmap_base(struct perf_evsel *evsel, int cpu, int thread);
> >    int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
> >                         struct perf_counts_values *count);
> >    int perf_evsel__enable(struct perf_evsel *evsel);
> > diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> > index 4dc06289f4c7..7e140763552f 100644
> > --- a/tools/lib/perf/evsel.c
> > +++ b/tools/lib/perf/evsel.c
> > @@ -11,10 +11,12 @@
> >  #include <stdlib.h>
> >  #include <internal/xyarray.h>
> >  #include <internal/cpumap.h>
> > +#include <internal/mmap.h>
> >  #include <internal/threadmap.h>
> >  #include <internal/lib.h>
> >  #include <linux/string.h>
> >  #include <sys/ioctl.h>
> > +#include <sys/mman.h>
> >
> >  void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr)
> >  {
> > @@ -38,6 +40,7 @@ void perf_evsel__delete(struct perf_evsel *evsel)
> >  }
> >
> >  #define FD(e, x, y) (*(int *) xyarray__entry(e->fd, x, y))
> > +#define MMAP(e, x, y) (e->mmap ? ((struct perf_mmap *) xyarray__entry(e->mmap, x, y)) : NULL)
> >
> >  int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads)
> >  {
> > @@ -55,6 +58,13 @@ int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads)
> >       return evsel->fd != NULL ? 0 : -ENOMEM;
> >  }
> >
> > +static int perf_evsel__alloc_mmap(struct perf_evsel *evsel, int ncpus, int nthreads)
> > +{
> > +     evsel->mmap = xyarray__new(ncpus, nthreads, sizeof(struct perf_mmap));
> > +
> > +     return evsel->mmap != NULL ? 0 : -ENOMEM;
> > +}
> > +
> >  static int
> >  sys_perf_event_open(struct perf_event_attr *attr,
> >                   pid_t pid, int cpu, int group_fd,
> > @@ -137,6 +147,8 @@ void perf_evsel__free_fd(struct perf_evsel *evsel)
> >  {
> >       xyarray__delete(evsel->fd);
> >       evsel->fd = NULL;
> > +     xyarray__delete(evsel->mmap);
> > +     evsel->mmap = NULL;
> >  }
> >
> >  void perf_evsel__close(struct perf_evsel *evsel)
> > @@ -156,6 +168,48 @@ void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu)
> >       perf_evsel__close_fd_cpu(evsel, cpu);
> >  }
> >
> > +int perf_evsel__mmap(struct perf_evsel *evsel, int pages)
> > +{
> > +     int ret, cpu, thread;
> > +     struct perf_mmap_param mp = {
> > +             .prot = PROT_READ | PROT_WRITE,
> > +             .mask = (pages * page_size) - 1,
> > +     };
> > +
> > +     if (evsel->fd == NULL)
> > +             return -EINVAL;
> > +
> > +     if (evsel->mmap == NULL &&
> > +         perf_evsel__alloc_mmap(evsel, xyarray__max_x(evsel->fd), xyarray__max_y(evsel->fd)) < 0)
> > +             return -ENOMEM;
> > +
> > +     for (cpu = 0; cpu < xyarray__max_x(evsel->fd); cpu++) {
> > +             for (thread = 0; thread < xyarray__max_y(evsel->fd); thread++) {
> > +                     int fd = FD(evsel, cpu, thread);
> > +                     struct perf_mmap *map = MMAP(evsel, cpu, thread);
> > +
> > +                     if (fd < 0)
> > +                             continue;
> > +
> > +                     perf_mmap__init(map, NULL, false, NULL);
> > +
> > +                     ret = perf_mmap__mmap(map, &mp, fd, cpu);
> > +                     if (ret)
> > +                             return -1;
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
>
> Where is the counterpart?

I was assuming implicitly unmapped when closing the fd(s), but looks
like it's when exiting the process only.

I.e. perf_evsel__munmap(), and it should be
> called if perf_evsel__mmap() fails, right?

If perf_evsel__mmap() fails, the caller shouldn't have to do anything
WRT mmap, right? But if the perf_mmap__mmap() call fails, we do need
some internal clean-up. I'll fix both.

Rob
