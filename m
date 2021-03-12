Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB79339688
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbhCLSaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:30:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33710 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233087AbhCLS3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:29:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615573789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sOSxvjAqkNARupZvLwz7lg1cG/dMG1l8R8/qYQHbrPQ=;
        b=Kz4lMGPwTUJMXIGnmOeS0Xlesr3k6OtuecvH+K0jBxXfUdcFlIu1Z7N+4u6B90QXmuIk++
        qTCTqw6wZRsY20hBMr5+YqThVK1EnG0izvaIbDR63oc2Hhwi1HN0rD6ua0EMThqdrw9EFk
        6tezIbSNcmEHYOmyKiQuXrARmJBnSFs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-YBdJOXq0NlmuU1NFlQemVg-1; Fri, 12 Mar 2021 13:29:47 -0500
X-MC-Unique: YBdJOXq0NlmuU1NFlQemVg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BEFA1B18BC0;
        Fri, 12 Mar 2021 18:29:45 +0000 (UTC)
Received: from krava (unknown [10.40.192.54])
        by smtp.corp.redhat.com (Postfix) with SMTP id 918C65D6BA;
        Fri, 12 Mar 2021 18:29:41 +0000 (UTC)
Date:   Fri, 12 Mar 2021 19:29:40 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Rob Herring <robh@kernel.org>
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
Subject: Re: [PATCH v6 04/10] libperf: Add evsel mmap support
Message-ID: <YEuzFHyjubILDA5h@krava>
References: <20210311000837.3630499-1-robh@kernel.org>
 <20210311000837.3630499-5-robh@kernel.org>
 <YEtzl5c1m7jxWkEw@krava>
 <CAL_JsqLMDLRN2OvMt7cBb1tPWmsupCzQ7DOs_P8nbpjirP4Hwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLMDLRN2OvMt7cBb1tPWmsupCzQ7DOs_P8nbpjirP4Hwg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 07:34:39AM -0700, Rob Herring wrote:
> On Fri, Mar 12, 2021 at 6:59 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Wed, Mar 10, 2021 at 05:08:31PM -0700, Rob Herring wrote:
> >
> > SNIP
> >
> > > +
> > >  static int
> > >  sys_perf_event_open(struct perf_event_attr *attr,
> > >                   pid_t pid, int cpu, int group_fd,
> > > @@ -137,6 +147,8 @@ void perf_evsel__free_fd(struct perf_evsel *evsel)
> > >  {
> > >       xyarray__delete(evsel->fd);
> > >       evsel->fd = NULL;
> > > +     xyarray__delete(evsel->mmap);
> > > +     evsel->mmap = NULL;
> > >  }
> > >
> > >  void perf_evsel__close(struct perf_evsel *evsel)
> > > @@ -156,6 +168,45 @@ void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu)
> > >       perf_evsel__close_fd_cpu(evsel, cpu);
> > >  }
> > >
> > > +int perf_evsel__mmap(struct perf_evsel *evsel, int pages)
> > > +{
> > > +     int ret, cpu, thread;
> > > +     struct perf_mmap_param mp = {
> > > +             .prot = PROT_READ | PROT_WRITE,
> > > +             .mask = (pages * page_size) - 1,
> > > +     };
> >
> > I don't mind using evsel->fd for dimensions below,
> > but we need to check in here that it's defined,
> > that perf_evsel__open was called
> 
> Right, so I'll add this here:
> 
> if (evsel->fd == NULL)
>     return -EINVAL;
> 
> Note that struct evsel has dimensions in it, but they are only set in
> the evlist code. I couldn't tell if that was by design or mistake.

we do? we have the cpus and threads in perf_evsel no?
also you'd need perf_evsel not evsel, right?

> 
> BTW, I just noticed perf_evsel__open is leaking memory on most of its
> error paths.

nice.. let's fix it ;-)

thanks,
jirka

> 
> >
> > jirka
> >
> > > +
> > > +     if (evsel->mmap == NULL &&
> > > +         perf_evsel__alloc_mmap(evsel, xyarray__max_x(evsel->fd), xyarray__max_y(evsel->fd)) < 0)
> > > +             return -ENOMEM;
> > > +
> > > +     for (cpu = 0; cpu < xyarray__max_x(evsel->fd); cpu++) {
> > > +             for (thread = 0; thread < xyarray__max_y(evsel->fd); thread++) {
> > > +                     int fd = FD(evsel, cpu, thread);
> > > +                     struct perf_mmap *map = MMAP(evsel, cpu, thread);
> > > +
> > > +                     if (fd < 0)
> > > +                             continue;
> > > +
> > > +                     perf_mmap__init(map, NULL, false, NULL);
> > > +
> > > +                     ret = perf_mmap__mmap(map, &mp, fd, cpu);
> > > +                     if (ret)
> > > +                             return -1;
> > > +             }
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> >
> > SNIP
> >
> 

