Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2443509F2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 00:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbhCaWHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 18:07:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:45314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232655AbhCaWHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 18:07:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E6656108D
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 22:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617228420;
        bh=ewnEV2u+9OfHU1RtVtv1pWSjFZhmQ1lVFRdpH4p+CNI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jnfHAJ/P2KKzZKxod/gPFNRyZ38N8tTDBf9vH6CzCMuFauFnmsx5kWadY9+FcrIwI
         xOGnG/yG5xgIIo2vofd0t9d5a54ao+BmR9iY5ufYIUqYPAnOzWaddso3KJAIK/2psx
         TXViI1UUpvC5AXpnYYQqV4OFC7XLrjI3NR+9J8ZLMcbazuggqDHdYCMP9mIuzYOjOJ
         ZVYI+uzAWJCevzECkMJLgs4ABQ+eAKSBgwaXKsQ9Pl97lZnqpQlv1jiV/CeBPCZo44
         +KnncrSpa+PevYkW8QDVpH/h69uhk36YAbFX837puR7QEY2D4MukNWQXIZI7Q1+K0u
         78bfbub1QKtUw==
Received: by mail-ej1-f47.google.com with SMTP id kt15so32293997ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 15:07:00 -0700 (PDT)
X-Gm-Message-State: AOAM533uq9XZIf6Sz6UAkpoDzXtGJmYW+rvR2Zq8W80stsgH85xCq6sP
        hKbYiV1X7L31pYnppOrF2BMkotN951wxe8R7dg==
X-Google-Smtp-Source: ABdhPJwrN3REAzz1OFnLicmVPUk5n1+yxRC0vvnXdJFX4tBIzONHIoaDA5yrbSrYr/JFf8dREgK9I8MOVvtnzjaBbz4=
X-Received: by 2002:a17:906:2312:: with SMTP id l18mr6123769eja.468.1617228418909;
 Wed, 31 Mar 2021 15:06:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210311000837.3630499-1-robh@kernel.org> <20210311000837.3630499-5-robh@kernel.org>
 <YEtzl5c1m7jxWkEw@krava> <CAL_JsqLMDLRN2OvMt7cBb1tPWmsupCzQ7DOs_P8nbpjirP4Hwg@mail.gmail.com>
 <YEuzFHyjubILDA5h@krava>
In-Reply-To: <YEuzFHyjubILDA5h@krava>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 31 Mar 2021 17:06:46 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+c2suLcGUuXZ-a4UG-Bte-+uVfYjB-+BYXDbAYEf2Jyg@mail.gmail.com>
Message-ID: <CAL_Jsq+c2suLcGUuXZ-a4UG-Bte-+uVfYjB-+BYXDbAYEf2Jyg@mail.gmail.com>
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

On Fri, Mar 12, 2021 at 12:29 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Mar 12, 2021 at 07:34:39AM -0700, Rob Herring wrote:
> > On Fri, Mar 12, 2021 at 6:59 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Wed, Mar 10, 2021 at 05:08:31PM -0700, Rob Herring wrote:
> > >
> > > SNIP
> > >
> > > > +
> > > >  static int
> > > >  sys_perf_event_open(struct perf_event_attr *attr,
> > > >                   pid_t pid, int cpu, int group_fd,
> > > > @@ -137,6 +147,8 @@ void perf_evsel__free_fd(struct perf_evsel *evsel)
> > > >  {
> > > >       xyarray__delete(evsel->fd);
> > > >       evsel->fd = NULL;
> > > > +     xyarray__delete(evsel->mmap);
> > > > +     evsel->mmap = NULL;
> > > >  }
> > > >
> > > >  void perf_evsel__close(struct perf_evsel *evsel)
> > > > @@ -156,6 +168,45 @@ void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu)
> > > >       perf_evsel__close_fd_cpu(evsel, cpu);
> > > >  }
> > > >
> > > > +int perf_evsel__mmap(struct perf_evsel *evsel, int pages)
> > > > +{
> > > > +     int ret, cpu, thread;
> > > > +     struct perf_mmap_param mp = {
> > > > +             .prot = PROT_READ | PROT_WRITE,
> > > > +             .mask = (pages * page_size) - 1,
> > > > +     };
> > >
> > > I don't mind using evsel->fd for dimensions below,
> > > but we need to check in here that it's defined,
> > > that perf_evsel__open was called
> >
> > Right, so I'll add this here:
> >
> > if (evsel->fd == NULL)
> >     return -EINVAL;

Actually, pretty much none of the API checks this.
perf_evsel__run_ioctl(), perf_evsel__enable(), perf_evsel__disable(),
perf_evsel__read() will all just deference evsel->fd. So fix all of
these or follow existing behavior?


> > Note that struct evsel has dimensions in it, but they are only set in
> > the evlist code. I couldn't tell if that was by design or mistake.
>
> we do? we have the cpus and threads in perf_evsel no?

Right, perf_evsel has cpus and threads pointers which in turn have the
sizes, but those pointers are not set within the evsel code.

> also you'd need perf_evsel not evsel, right?
>
> >
> > BTW, I just noticed perf_evsel__open is leaking memory on most of its
> > error paths.
>
> nice.. let's fix it ;-)

NM, I missed that they are static...

Rob
