Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E397C3E9B6E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 01:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbhHKX6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 19:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbhHKX6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 19:58:01 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5303AC061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 16:57:37 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id a13so5921834iol.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 16:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wgn/XOEZSHXBTS0n02rl8r0RWKOfzVqP/qa7vWvXX9I=;
        b=aGKdJem0hH3vDMH7+fz/6YNkhQn+Dz1CmX6C7yaAmEdiKmSddK9wr/D/7vIMdpu4oA
         fGubaCGp9d+If/IDk+hmqvvgtDOXujsgcQoRbBGmjUnR55oVre3BENNA9/p/7LZzc3zh
         NCB6ROWKUD1491LqDOVFDpuT4Zk9suMTBeLtnsi6/6DYA28XFPYqBs4di3DDfdrNG9t6
         IlhTc0T7wj1zx8zQqWZ5Z7QvYMay+R65Tejeq+waY4ciFaXv6/bpf0QCLQLKV1uoWSN5
         NuUFL8tzTL8ElNJZhyoKevdcqgWX51wJLwVAs7/mtBOTrO3DOo54OScCL7FX5kMTnoOO
         0FcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wgn/XOEZSHXBTS0n02rl8r0RWKOfzVqP/qa7vWvXX9I=;
        b=eEv3u43hKI/aLBI81pwjATonhepYzlRc93LAZ/6u9qsjY0tS4V3cHY9juLmCtAAyHx
         KAagjcam9RYKpdRhvaaS1ghJS46Tjm8RaWKyJ5USSN4r3RKa0thMlZRMiO3jXHifrAFU
         8DafzHQghseFmWqfQSe35hEZHzVWJLAu9IP6z/tJK/95Uh5m8BsBcMsU/UxAtLD7Gj7u
         M90wGfzJrBCUcpgv48zXDgAHiLYZz7o2KnyATfgEUmT7pP9P+AE5W+KjSPVKoEJgHYE+
         dtMWIk5hZHT48coa6OdXm/jC3sZV6/uXsKvIIzLIptoz6iIqRbqt6i8P4ZoYkgtEuiU/
         LQvg==
X-Gm-Message-State: AOAM531HosMxIBeW+GK40ftxUesE8eFfKGq3L/BkNLdzAL2zpyf+S12d
        RBx7IWJLlLk5MYowu8htQJf5OmmV3GCyn4fTGby/YQ==
X-Google-Smtp-Source: ABdhPJw9VCCVk6OxaczdEwet+vtY6KxK1pPvJ4+oGduxsxFDZZVnHnkEFsTeW8g8jQhGQhSRIiEjTN9pa+tcpQ+ofwQ=
X-Received: by 2002:a5e:d80e:: with SMTP id l14mr853389iok.79.1628726256654;
 Wed, 11 Aug 2021 16:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210811062135.1332927-1-namhyung@kernel.org> <YRPnCLyn9oE540gM@krava>
 <CABPqkBQGu5Xb=PbwjfwQxmp5nVuZZ6tg4LnZaKJConYWkPcL2g@mail.gmail.com>
 <YRQrpcssx9kLHrAh@krava> <CAM9d7cjJKFZUQkYW2U6eBmdQJdSOrVDe0FiojhNBbknsKoEyTQ@mail.gmail.com>
In-Reply-To: <CAM9d7cjJKFZUQkYW2U6eBmdQJdSOrVDe0FiojhNBbknsKoEyTQ@mail.gmail.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Wed, 11 Aug 2021 16:57:25 -0700
Message-ID: <CABPqkBT3qqDC7cU+XwNcpST66+X6PMmsfwo96_0fTGVKn19ycw@mail.gmail.com>
Subject: Re: [RFC] perf/core: Add an ioctl to get a number of lost samples
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
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

On Wed, Aug 11, 2021 at 1:57 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Wed, Aug 11, 2021 at 12:57 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Wed, Aug 11, 2021 at 12:33:38PM -0700, Stephane Eranian wrote:
> > > On Wed, Aug 11, 2021 at 8:04 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > > >
> > > > On Tue, Aug 10, 2021 at 11:21:35PM -0700, Namhyung Kim wrote:
> > > > > Sometimes we want to know an accurate number of samples even if it's
> > > > > lost.  Currenlty PERF_RECORD_LOST is generated for a ring-buffer which
> > > > > might be shared with other events.  So it's hard to know per-event
> > > > > lost count.
> > > > >
> > > > > Add event->lost_samples field and PERF_EVENT_IOC_LOST_SAMPLES to
> > > > > retrieve it from userspace.
> > > > >
> > > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > > ---
> > > > >  include/linux/perf_event.h      | 2 ++
> > > > >  include/uapi/linux/perf_event.h | 1 +
> > > > >  kernel/events/core.c            | 9 +++++++++
> > > > >  kernel/events/ring_buffer.c     | 5 ++++-
> > > > >  4 files changed, 16 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > > > > index f5a6a2f069ed..44d72079c77a 100644
> > > > > --- a/include/linux/perf_event.h
> > > > > +++ b/include/linux/perf_event.h
> > > > > @@ -756,6 +756,8 @@ struct perf_event {
> > > > >       struct pid_namespace            *ns;
> > > > >       u64                             id;
> > > > >
> > > > > +     atomic_t                        lost_samples;
> > > > > +
> > > > >       u64                             (*clock)(void);
> > > > >       perf_overflow_handler_t         overflow_handler;
> > > > >       void                            *overflow_handler_context;
> > > > > diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> > > > > index bf8143505c49..24397799127d 100644
> > > > > --- a/include/uapi/linux/perf_event.h
> > > > > +++ b/include/uapi/linux/perf_event.h
> > > > > @@ -505,6 +505,7 @@ struct perf_event_query_bpf {
> > > > >  #define PERF_EVENT_IOC_PAUSE_OUTPUT          _IOW('$', 9, __u32)
> > > > >  #define PERF_EVENT_IOC_QUERY_BPF             _IOWR('$', 10, struct perf_event_query_bpf *)
> > > > >  #define PERF_EVENT_IOC_MODIFY_ATTRIBUTES     _IOW('$', 11, struct perf_event_attr *)
> > > > > +#define PERF_EVENT_IOC_LOST_SAMPLES          _IOR('$', 12, __u64 *)
> > > >
> > > > would it be better to use the read syscall for that?
> > > >   https://lore.kernel.org/lkml/20210622153918.688500-5-jolsa@kernel.org/
> > > >
> > > > that patchset ended up on me not having a way to reproduce the
> > > > issue you guys wanted the fix for ;-) the lost count is there
> > > > as well
> > > >
> > > Does the read format approach succeed even when the event is in error state?
> >
> > nope..
> >
> >         /*
> >          * Return end-of-file for a read on an event that is in
> >          * error state (i.e. because it was pinned but it couldn't be
> >          * scheduled on to the CPU at some point).
> >          */
> >         if (event->state == PERF_EVENT_STATE_ERROR)
> >                 return 0;
> >
>
> By the way, it'd be nice if the kernel would provide a way for
> better error reporting.  There are many cases return -EINVAL
> and it's hard to know what's the problem exactly.
>
+1. If the kernel has more precise error reporting, then the tool
could be more helpful in its error reporting and not try to guess with
heuristics.
