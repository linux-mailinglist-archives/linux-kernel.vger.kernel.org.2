Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC713E9A1B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 22:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhHKUyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 16:54:47 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:42609 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbhHKUyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 16:54:46 -0400
Received: by mail-lj1-f176.google.com with SMTP id n6so6767806ljp.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 13:54:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6+5dbommHsnb9SUXBqvLlSeCXfGE5VHfxBjnse90n78=;
        b=KmbsjrXbJOdm9fARuIhF+fpUQdkOl4oqRid6GtKcEnO7kvWlXYitcLWiuaWFaYokII
         pzKg/jfw+xVp4hJd88mOpjfzEcZ25roaLTuUMW8KEAJBMonTmPNKXKk6gC86wexWvy+T
         FPGnSf4xmWuWgodKgFknb9+Zzrtj4s1EWl2bBIhhLRkD/wXEderp1BQCTlOLWukB5tt+
         r0gtldt7AjbPT1zNCMOyhinmDlmGThkyWB2hG5/5k8h2MfCedWFaMNbYWuHC7zzuQz1w
         rORgYKXR6xjkCXxtLGoBTWiuqNJn8lJe00NwAUa2MP/5kWx/kH6LSYhTlHd+9tBiowZx
         Tvrw==
X-Gm-Message-State: AOAM530UQjEg+gW2ZkdX2uNUF3uJtyPZFW/htwUwU+6m8YSl+Rn6Zzzl
        jhzt3v3tNaupHblJq2b10AiZ0rWzSJSKpAkrPz0=
X-Google-Smtp-Source: ABdhPJzkewVU0K0KwkPNRw1TaeN3CzbcFqcGZmJgix46d9tZVWgZkB75HacmTdbtHyXVh9S9dRaC9suwY4n9GADsoxk=
X-Received: by 2002:a2e:89c4:: with SMTP id c4mr390283ljk.275.1628715260975;
 Wed, 11 Aug 2021 13:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210811062135.1332927-1-namhyung@kernel.org> <YRPnCLyn9oE540gM@krava>
In-Reply-To: <YRPnCLyn9oE540gM@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 11 Aug 2021 13:54:09 -0700
Message-ID: <CAM9d7ci2ZkJ-FK0R1VoYjZZ9GzB4qDrPY=JD6_eOyUFQ1DLh7Q@mail.gmail.com>
Subject: Re: [RFC] perf/core: Add an ioctl to get a number of lost samples
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
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

Hi Jiri,

On Wed, Aug 11, 2021 at 8:04 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Aug 10, 2021 at 11:21:35PM -0700, Namhyung Kim wrote:
> > Sometimes we want to know an accurate number of samples even if it's
> > lost.  Currenlty PERF_RECORD_LOST is generated for a ring-buffer which
> > might be shared with other events.  So it's hard to know per-event
> > lost count.
> >
> > Add event->lost_samples field and PERF_EVENT_IOC_LOST_SAMPLES to
> > retrieve it from userspace.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  include/linux/perf_event.h      | 2 ++
> >  include/uapi/linux/perf_event.h | 1 +
> >  kernel/events/core.c            | 9 +++++++++
> >  kernel/events/ring_buffer.c     | 5 ++++-
> >  4 files changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > index f5a6a2f069ed..44d72079c77a 100644
> > --- a/include/linux/perf_event.h
> > +++ b/include/linux/perf_event.h
> > @@ -756,6 +756,8 @@ struct perf_event {
> >       struct pid_namespace            *ns;
> >       u64                             id;
> >
> > +     atomic_t                        lost_samples;
> > +
> >       u64                             (*clock)(void);
> >       perf_overflow_handler_t         overflow_handler;
> >       void                            *overflow_handler_context;
> > diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> > index bf8143505c49..24397799127d 100644
> > --- a/include/uapi/linux/perf_event.h
> > +++ b/include/uapi/linux/perf_event.h
> > @@ -505,6 +505,7 @@ struct perf_event_query_bpf {
> >  #define PERF_EVENT_IOC_PAUSE_OUTPUT          _IOW('$', 9, __u32)
> >  #define PERF_EVENT_IOC_QUERY_BPF             _IOWR('$', 10, struct perf_event_query_bpf *)
> >  #define PERF_EVENT_IOC_MODIFY_ATTRIBUTES     _IOW('$', 11, struct perf_event_attr *)
> > +#define PERF_EVENT_IOC_LOST_SAMPLES          _IOR('$', 12, __u64 *)
>
> would it be better to use the read syscall for that?
>   https://lore.kernel.org/lkml/20210622153918.688500-5-jolsa@kernel.org/
>
> that patchset ended up on me not having a way to reproduce the
> issue you guys wanted the fix for ;-) the lost count is there
> as well

Oh, right... I forgot about that, sorry.
But I think the lost count is not collected accurately.

Peter, what do you think about the interface (read vs ioctl)?

Thanks,
Namhyung
