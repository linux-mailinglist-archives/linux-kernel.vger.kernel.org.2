Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213A43E9A20
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 22:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbhHKU5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 16:57:52 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:43694 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbhHKU5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 16:57:50 -0400
Received: by mail-lf1-f52.google.com with SMTP id w1so8420471lfq.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 13:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MBNG6My/3Hw+iJytvnz3n/T6GikN/dkTfd2SK1ZCsiU=;
        b=UaF4hFGjiM26+5crkrIBJZSTl6aETgn1SxmAVRnftrKwDGbXnbjYHQQwg7xMGXdveo
         T5iTqx8hyfi4kMFL0G0MZUt0q8GXl5RwfCEH+E3hRUezTBHOX+l9LZ3+DNnwZ6nVYOZ7
         jk+UyddFzRaZgcpTtUpY2tcoJWnauABJ7Zu+6H0MrRoD4BPVrgBrjRRDtWun8VP96Hnp
         EqAIezOuiLQ2gg8I/2D7QBOnXZXfZIMf5QvLxOc9sNXGUinIe3hAHipo2McLcEgOdhy1
         d3OkfRSgPxT3n6qeVycoqkCOqRDnoer5rcFqdg/G4JoZsQN0k2a+FuZzJPsPIV0bCiBv
         OPpg==
X-Gm-Message-State: AOAM531oj6A2Q7sOlgO30Fi6LQ6n0vsJNYT28zdw3Brg7qYwBKeyjIyt
        NFFxCBVvc/dQIQot18kePJ2+t0D9kalG5jACtLU=
X-Google-Smtp-Source: ABdhPJxQT/j5cKw98ZvKWHqEp+XBXuFsGznX42Mqrat8xT/tpIIdkY/8Hh0jIX/fIpJo/O3shKNOs8FZEeAyU+oZH/0=
X-Received: by 2002:a05:6512:4019:: with SMTP id br25mr52047lfb.494.1628715444957;
 Wed, 11 Aug 2021 13:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210811062135.1332927-1-namhyung@kernel.org> <YRPnCLyn9oE540gM@krava>
 <CABPqkBQGu5Xb=PbwjfwQxmp5nVuZZ6tg4LnZaKJConYWkPcL2g@mail.gmail.com> <YRQrpcssx9kLHrAh@krava>
In-Reply-To: <YRQrpcssx9kLHrAh@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 11 Aug 2021 13:57:13 -0700
Message-ID: <CAM9d7cjJKFZUQkYW2U6eBmdQJdSOrVDe0FiojhNBbknsKoEyTQ@mail.gmail.com>
Subject: Re: [RFC] perf/core: Add an ioctl to get a number of lost samples
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Gabriel Marin <gmx@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 12:57 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Aug 11, 2021 at 12:33:38PM -0700, Stephane Eranian wrote:
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
> > >
> > Does the read format approach succeed even when the event is in error state?
>
> nope..
>
>         /*
>          * Return end-of-file for a read on an event that is in
>          * error state (i.e. because it was pinned but it couldn't be
>          * scheduled on to the CPU at some point).
>          */
>         if (event->state == PERF_EVENT_STATE_ERROR)
>                 return 0;
>

By the way, it'd be nice if the kernel would provide a way for
better error reporting.  There are many cases return -EINVAL
and it's hard to know what's the problem exactly.

Thanks,
Namhyung
