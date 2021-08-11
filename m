Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A0A3E9946
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 21:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbhHKT55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 15:57:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53796 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229991AbhHKT5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 15:57:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628711850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a8CdrLYaScW3g1zgCUeylW9y3VU78MKEKlY7JTX+NVc=;
        b=RolYUSm5OwYK5zK2ouiS+qhkopDGiz7T4cHEIVmyEn3KvNtzigX+Zrm6y+4uQH1/8QRCDS
        hsGoVICizVCTRT+v1ofKBS1YFF3wRr+q7AqkMZ7ZWuX9daprThzGPI1Qddfk0MO4IhRXhT
        +yVhhwvZMnZsXe41U3k6VXUC3FfokkU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-i7JjN190MFi4LeAbVciFag-1; Wed, 11 Aug 2021 15:57:29 -0400
X-MC-Unique: i7JjN190MFi4LeAbVciFag-1
Received: by mail-ej1-f70.google.com with SMTP id kf21-20020a17090776d5b02905af6ad96f02so1123327ejc.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 12:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a8CdrLYaScW3g1zgCUeylW9y3VU78MKEKlY7JTX+NVc=;
        b=GbegmIq39FkEaoEsV/v8P09WZ6Q4f8cdKrTgGsfnVlO7F2M3J/1aGs/g76tHQ8ELAb
         xwTR0jbHSg4CKOEfJ0dtorR3g80obibXhQf9VwiuDVx1pp8aCUd12bqJxPHwm2X40T25
         0w18QaNoCszhuMdVkWw/fHWU5tNV33FYBU6eNJWtnaCGewm3UQPy9cLBKmJ4pi0Pvx7w
         hjNzHaNMaJsZG6/qW3E4ZDeUD60hl01lAiOaUvP6ewpt7EXvXPOCL0r2YdxudoZYQl95
         yXDwJ9221VwLG0h7/7do8IuqD7J9oStNQhrrFDt3QUW26/9Oa6+cuFd0x61LUPfkfMni
         yuKg==
X-Gm-Message-State: AOAM532peqVSbYNZFakM9Yc90L3KMvZyc0tUbIZsi75ZxhcwaQt0SViz
        cbAl2upIZXtECCO1XsaMkJa11BQDV0G6ZhM4vvBcUmnOY6SY6/hAZi2OZGsBkWJNqHiJ7mzmzLn
        fzaAtVdX5RLv9qQE53QoMEuqG
X-Received: by 2002:a17:906:eb06:: with SMTP id mb6mr230349ejb.50.1628711847853;
        Wed, 11 Aug 2021 12:57:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMJm0MMozqlG2NGnCnoaOANvZ79H3EYGGIQ9hpOTtXCU4DwGFHZthhruLDn6IqoXtjuyTtYg==
X-Received: by 2002:a17:906:eb06:: with SMTP id mb6mr230338ejb.50.1628711847679;
        Wed, 11 Aug 2021 12:57:27 -0700 (PDT)
Received: from krava ([83.240.61.5])
        by smtp.gmail.com with ESMTPSA id q21sm124012eji.59.2021.08.11.12.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 12:57:27 -0700 (PDT)
Date:   Wed, 11 Aug 2021 21:57:25 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Stephane Eranian <eranian@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>, gmx@google.com
Subject: Re: [RFC] perf/core: Add an ioctl to get a number of lost samples
Message-ID: <YRQrpcssx9kLHrAh@krava>
References: <20210811062135.1332927-1-namhyung@kernel.org>
 <YRPnCLyn9oE540gM@krava>
 <CABPqkBQGu5Xb=PbwjfwQxmp5nVuZZ6tg4LnZaKJConYWkPcL2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBQGu5Xb=PbwjfwQxmp5nVuZZ6tg4LnZaKJConYWkPcL2g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 12:33:38PM -0700, Stephane Eranian wrote:
> On Wed, Aug 11, 2021 at 8:04 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Tue, Aug 10, 2021 at 11:21:35PM -0700, Namhyung Kim wrote:
> > > Sometimes we want to know an accurate number of samples even if it's
> > > lost.  Currenlty PERF_RECORD_LOST is generated for a ring-buffer which
> > > might be shared with other events.  So it's hard to know per-event
> > > lost count.
> > >
> > > Add event->lost_samples field and PERF_EVENT_IOC_LOST_SAMPLES to
> > > retrieve it from userspace.
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  include/linux/perf_event.h      | 2 ++
> > >  include/uapi/linux/perf_event.h | 1 +
> > >  kernel/events/core.c            | 9 +++++++++
> > >  kernel/events/ring_buffer.c     | 5 ++++-
> > >  4 files changed, 16 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > > index f5a6a2f069ed..44d72079c77a 100644
> > > --- a/include/linux/perf_event.h
> > > +++ b/include/linux/perf_event.h
> > > @@ -756,6 +756,8 @@ struct perf_event {
> > >       struct pid_namespace            *ns;
> > >       u64                             id;
> > >
> > > +     atomic_t                        lost_samples;
> > > +
> > >       u64                             (*clock)(void);
> > >       perf_overflow_handler_t         overflow_handler;
> > >       void                            *overflow_handler_context;
> > > diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> > > index bf8143505c49..24397799127d 100644
> > > --- a/include/uapi/linux/perf_event.h
> > > +++ b/include/uapi/linux/perf_event.h
> > > @@ -505,6 +505,7 @@ struct perf_event_query_bpf {
> > >  #define PERF_EVENT_IOC_PAUSE_OUTPUT          _IOW('$', 9, __u32)
> > >  #define PERF_EVENT_IOC_QUERY_BPF             _IOWR('$', 10, struct perf_event_query_bpf *)
> > >  #define PERF_EVENT_IOC_MODIFY_ATTRIBUTES     _IOW('$', 11, struct perf_event_attr *)
> > > +#define PERF_EVENT_IOC_LOST_SAMPLES          _IOR('$', 12, __u64 *)
> >
> > would it be better to use the read syscall for that?
> >   https://lore.kernel.org/lkml/20210622153918.688500-5-jolsa@kernel.org/
> >
> > that patchset ended up on me not having a way to reproduce the
> > issue you guys wanted the fix for ;-) the lost count is there
> > as well
> >
> Does the read format approach succeed even when the event is in error state?

nope..

        /*
         * Return end-of-file for a read on an event that is in
         * error state (i.e. because it was pinned but it couldn't be
         * scheduled on to the CPU at some point).
         */
        if (event->state == PERF_EVENT_STATE_ERROR)
                return 0;

jirka

