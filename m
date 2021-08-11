Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9323E98D0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 21:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbhHKTeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 15:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbhHKTeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 15:34:14 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC529C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 12:33:50 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id h18so4095240ilc.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 12:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lIk5pGOt6oASpnR/NcBiTI5xQIoYW7qRcOvWbZ6bFxM=;
        b=rsEtxg6IEV9kkhucftQkb/xiNWDkCk+z6aYjB20Nt8ykUKDbc7m52E2QLtyG2U6bAV
         W4E8+1ovCwV3uGvtDpNO2wBq4lDaF1PYVdIP5TB4X82az/JMLfkYz7o+PiDl9KrvYy8m
         ZQq7oOLUVIlvMVBOIsAPUYfaVZw1q5CAdPtRgFcxIG4Sw3I3acfUVXZsMIzUopZk9AH6
         EgdYihqvinUR9469gRfOF2xkd/b1Jn7SJ2AAscL838BI5TCsoRNr+Wlv1QitIrX7Gx22
         EjM53H2X4fQ1jSdcRl4YsAA57l3Jcbnp4lJVvBxfprZ0w8B105WVkyWtVP/Z2SsDX2De
         vVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lIk5pGOt6oASpnR/NcBiTI5xQIoYW7qRcOvWbZ6bFxM=;
        b=SkzUKPN1JzsLAphJaHVkFbFyhNnTYisJaP+5rq6u5z04E50TeRNNl/wSsMMWa5Szsf
         2PR71fAxci6SoxhNcVbyu0jAf7TDds109tbjjpBVrjsY0lzUS3JI24Th4rDHmv1cAvC/
         +CzhStNqXog8Nj0Bxet8XudfEGIvzm+/4GqaHOzg+Ifd1SwqoLOrhRk1dlmChuqzZv3i
         06GMZn+dYmsCLKUcvh099uDH2NSUkow9DHVP+Z836/5RnbP2B8FLkRmIduWH87kVIJ5z
         9H9Ci0IexBXk6qzRqfqmHXyQ4qUSno9/ISKEo7m2pB36tWIpoJkNSblgUMs0GIfMJ88b
         eswg==
X-Gm-Message-State: AOAM53341fnyqEJt74PcPw42sg4vySFIK5PF0Q9csHaBAiM+ggMiBpz1
        PaVAHhfb8y+uXdMu/dbb/wttFHIBY5Vrz6WcoBM6XQ==
X-Google-Smtp-Source: ABdhPJwh0PLDeYXxO0G2YVc7M2/nhlgjbjBj8dnheYU54nGvRUgWhr3b6Y39ZSdYhI+M5g4xwMrEvZyL8+CFcHMZUu4=
X-Received: by 2002:a92:d7c1:: with SMTP id g1mr73395ilq.24.1628710429953;
 Wed, 11 Aug 2021 12:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210811062135.1332927-1-namhyung@kernel.org> <YRPnCLyn9oE540gM@krava>
In-Reply-To: <YRPnCLyn9oE540gM@krava>
From:   Stephane Eranian <eranian@google.com>
Date:   Wed, 11 Aug 2021 12:33:38 -0700
Message-ID: <CABPqkBQGu5Xb=PbwjfwQxmp5nVuZZ6tg4LnZaKJConYWkPcL2g@mail.gmail.com>
Subject: Re: [RFC] perf/core: Add an ioctl to get a number of lost samples
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>, gmx@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
>
Does the read format approach succeed even when the event is in error state?

> jirka
>
> >
> >  enum perf_event_ioc_flags {
> >       PERF_IOC_FLAG_GROUP             = 1U << 0,
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 0e125ae2fa92..a4d6736b6594 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -5664,6 +5664,15 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
> >
> >               return perf_event_modify_attr(event,  &new_attr);
> >       }
> > +
> > +     case PERF_EVENT_IOC_LOST_SAMPLES: {
> > +             u64 lost = atomic_read(&event->lost_samples);
> > +
> > +             if (copy_to_user((void __user *)arg, &lost, sizeof(lost)))
> > +                     return -EFAULT;
> > +             return 0;
> > +     }
> > +
> >       default:
> >               return -ENOTTY;
> >       }
> > diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> > index 52868716ec35..06d7dacb05da 100644
> > --- a/kernel/events/ring_buffer.c
> > +++ b/kernel/events/ring_buffer.c
> > @@ -172,8 +172,10 @@ __perf_output_begin(struct perf_output_handle *handle,
> >               goto out;
> >
> >       if (unlikely(rb->paused)) {
> > -             if (rb->nr_pages)
> > +             if (rb->nr_pages) {
> >                       local_inc(&rb->lost);
> > +                     atomic_inc(&event->lost_samples);
> > +             }
> >               goto out;
> >       }
> >
> > @@ -254,6 +256,7 @@ __perf_output_begin(struct perf_output_handle *handle,
> >
> >  fail:
> >       local_inc(&rb->lost);
> > +     atomic_inc(&event->lost_samples);
> >       perf_output_put_handle(handle);
> >  out:
> >       rcu_read_unlock();
> > --
> > 2.32.0.605.g8dce9f2422-goog
> >
>
