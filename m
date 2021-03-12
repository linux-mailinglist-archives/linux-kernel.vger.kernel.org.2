Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB16333901F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 15:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhCLOfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 09:35:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:34756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229959AbhCLOey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 09:34:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3EF664F23
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 14:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615559694;
        bh=L+vIlV/agm+Y36Vfdw7/F5SkJZPDHB3Vs6EXYx4Bj2k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jZ1X2NRhsDUW1GlhHciFxm6eAqpOL45+qNK9KcUxiae0eqdasrc43PlcZ4KhNjggh
         45ZXI8tNC2an3Q35h9th6SeTdZMAc2oINIraEZwHWUosyuto8eMPoknkwUv5NcNqpd
         pkiOdNGyLOd2b9HWC6X+tvV3MiF4TZAjSvFFP8POHg+47osOxALpcKNIj8sLwhn859
         ScnzukpPKaEnD/ssu4K7SmZCYqHeiNChBVzk9G040aHA/RMsVJ4e5YRxI5BizLdqfL
         z2l9zMTovHl/Bj0D99N9YmsEhEtHdr9mBhhCR6Hu9PdodOuud25EHDVx412bFs7V/P
         +8kr68uSrF+1w==
Received: by mail-ej1-f46.google.com with SMTP id k16so232102ejx.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 06:34:53 -0800 (PST)
X-Gm-Message-State: AOAM531BqphWOzborXSewPzrLRyt4BWeDTI3hehPCQBvzufvW6nMdmp7
        kdjTt1u69SBFe24M+65bGf80uxAsco0OOLCHiw==
X-Google-Smtp-Source: ABdhPJydJdts2afhRCK8ep/AJsnZcQOl4g9AawP6BZ9hsjbVGEH1Y5VtSm8XHshzur+pzfZ8W+Saf5Ne3S8gRAYKol4=
X-Received: by 2002:a17:906:1d44:: with SMTP id o4mr8252548ejh.130.1615559692308;
 Fri, 12 Mar 2021 06:34:52 -0800 (PST)
MIME-Version: 1.0
References: <20210311000837.3630499-1-robh@kernel.org> <20210311000837.3630499-5-robh@kernel.org>
 <YEtzl5c1m7jxWkEw@krava>
In-Reply-To: <YEtzl5c1m7jxWkEw@krava>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 12 Mar 2021 07:34:39 -0700
X-Gmail-Original-Message-ID: <CAL_JsqLMDLRN2OvMt7cBb1tPWmsupCzQ7DOs_P8nbpjirP4Hwg@mail.gmail.com>
Message-ID: <CAL_JsqLMDLRN2OvMt7cBb1tPWmsupCzQ7DOs_P8nbpjirP4Hwg@mail.gmail.com>
Subject: Re: [PATCH v6 04/10] libperf: Add evsel mmap support
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
        Zachary.Leaf@arm.com, Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 6:59 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Mar 10, 2021 at 05:08:31PM -0700, Rob Herring wrote:
>
> SNIP
>
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
> > @@ -156,6 +168,45 @@ void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu)
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
>
> I don't mind using evsel->fd for dimensions below,
> but we need to check in here that it's defined,
> that perf_evsel__open was called

Right, so I'll add this here:

if (evsel->fd == NULL)
    return -EINVAL;

Note that struct evsel has dimensions in it, but they are only set in
the evlist code. I couldn't tell if that was by design or mistake.

BTW, I just noticed perf_evsel__open is leaking memory on most of its
error paths.

>
> jirka
>
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
> > +
>
> SNIP
>
