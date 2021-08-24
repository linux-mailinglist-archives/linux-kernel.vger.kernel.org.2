Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051ED3F6872
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 19:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240884AbhHXR4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 13:56:22 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:38904 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240599AbhHXR4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 13:56:16 -0400
Received: by mail-lf1-f50.google.com with SMTP id x27so47248028lfu.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 10:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=chVnKEDwYYQUQViETp6uuKG3BZcPCB1twrqyI4/+WD8=;
        b=rfRr7InwUCR8yo6SE4hc/icBTXpqN004PBk9YAWkgdPrjpKuL9PrLe6x5il0Ttx6om
         ZxXo2mxCEtwrt0qvPcnTn4QMIpfuMOFIEE5V1R3k0p/noidzF+iz4wEeIJ9XBLW05IxM
         UPyWaOD71AEV5Ny7N1ATC0Dku2Oh1MjlR76K/jGat5Gcw7WI1/utm1ocjrHaFFUWOgxr
         smKjSxvhJX4hN2gj1jBrb2hT3SigHZyUBKIzV0bptHtiOATn/k2ZBk7GRsAzcjNaVgTK
         KF5k/7YGEJs2MAw8IzjsIdKG7JOLQOvcaEaNUVmaFNPgnzbpcJaM4jjZz3ss+qSOcs6K
         HwUQ==
X-Gm-Message-State: AOAM532gBxzcE67i50XCaYQPlfCSdGR1WACOjc/OKMEAkFQF12nXS2JI
        +GbE6dpzlK195St8TLQyZMm4Oo2kKDPrkm39Xqk=
X-Google-Smtp-Source: ABdhPJxXE65om8PmTqnutTnSnbVlwB1KkeIFPkk9rJnLBWKoKOD6sF4LboRND/6Vaz6L7WP9sVPOBrr3UyoW/nVr6uA=
X-Received: by 2002:a19:6d02:: with SMTP id i2mr10098374lfc.112.1629827731064;
 Tue, 24 Aug 2021 10:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210811062135.1332927-1-namhyung@kernel.org> <YRPnCLyn9oE540gM@krava>
 <CAM9d7ci2ZkJ-FK0R1VoYjZZ9GzB4qDrPY=JD6_eOyUFQ1DLh7Q@mail.gmail.com> <YST76vy8UQRCaKtO@hirez.programming.kicks-ass.net>
In-Reply-To: <YST76vy8UQRCaKtO@hirez.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 24 Aug 2021 10:55:19 -0700
Message-ID: <CAM9d7cgHXVh50Bimmgn=XqRGBJMKyezTD0zdqDoPLheuLhZh8A@mail.gmail.com>
Subject: Re: [RFC] perf/core: Add an ioctl to get a number of lost samples
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Gabriel Marin <gmx@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Tue, Aug 24, 2021 at 7:05 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Aug 11, 2021 at 01:54:09PM -0700, Namhyung Kim wrote:
> > Hi Jiri,
> >
> > On Wed, Aug 11, 2021 at 8:04 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Tue, Aug 10, 2021 at 11:21:35PM -0700, Namhyung Kim wrote:
> > > > Sometimes we want to know an accurate number of samples even if it's
> > > > lost.  Currenlty PERF_RECORD_LOST is generated for a ring-buffer which
> > > > might be shared with other events.  So it's hard to know per-event
> > > > lost count.
> > > >
> > > > Add event->lost_samples field and PERF_EVENT_IOC_LOST_SAMPLES to
> > > > retrieve it from userspace.
> > > >
> > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > ---
> > > >  include/linux/perf_event.h      | 2 ++
> > > >  include/uapi/linux/perf_event.h | 1 +
> > > >  kernel/events/core.c            | 9 +++++++++
> > > >  kernel/events/ring_buffer.c     | 5 ++++-
> > > >  4 files changed, 16 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > > > index f5a6a2f069ed..44d72079c77a 100644
> > > > --- a/include/linux/perf_event.h
> > > > +++ b/include/linux/perf_event.h
> > > > @@ -756,6 +756,8 @@ struct perf_event {
> > > >       struct pid_namespace            *ns;
> > > >       u64                             id;
> > > >
> > > > +     atomic_t                        lost_samples;
> > > > +
> > > >       u64                             (*clock)(void);
> > > >       perf_overflow_handler_t         overflow_handler;
> > > >       void                            *overflow_handler_context;
> > > > diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> > > > index bf8143505c49..24397799127d 100644
> > > > --- a/include/uapi/linux/perf_event.h
> > > > +++ b/include/uapi/linux/perf_event.h
> > > > @@ -505,6 +505,7 @@ struct perf_event_query_bpf {
> > > >  #define PERF_EVENT_IOC_PAUSE_OUTPUT          _IOW('$', 9, __u32)
> > > >  #define PERF_EVENT_IOC_QUERY_BPF             _IOWR('$', 10, struct perf_event_query_bpf *)
> > > >  #define PERF_EVENT_IOC_MODIFY_ATTRIBUTES     _IOW('$', 11, struct perf_event_attr *)
> > > > +#define PERF_EVENT_IOC_LOST_SAMPLES          _IOR('$', 12, __u64 *)
> > >
> > > would it be better to use the read syscall for that?
> > >   https://lore.kernel.org/lkml/20210622153918.688500-5-jolsa@kernel.org/
> > >
> > > that patchset ended up on me not having a way to reproduce the
> > > issue you guys wanted the fix for ;-) the lost count is there
> > > as well
> >
> > Oh, right... I forgot about that, sorry.
> > But I think the lost count is not collected accurately.
> >
> > Peter, what do you think about the interface (read vs ioctl)?
>
> I think I'm the one that suggested PERF_FORMAT_LOST at the time :-)

Ah, ok.  I'm fine with the read format then.

Thanks,
Namhyung
