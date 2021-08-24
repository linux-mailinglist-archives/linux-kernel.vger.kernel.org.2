Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 898EA3F5FD3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 16:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237618AbhHXOGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 10:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237473AbhHXOGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 10:06:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3834C061764
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 07:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1s0LcFjh0S0+++UK3bj92uUZLqvdtOic0+opEa2Q3wE=; b=AT+63kG+Sp+Wq8TOsO0WSvbUc/
        O1g8hH2j/4KSqz+NP10+HyINRu2KvH3i+hvf4d8KC43pp0BamLXF6JCStX+YmZhFDIDJpC0WL+o/K
        UqUPRJIXsB8T45bTHFS+jRg98sIADpmZrcz7KFsqeCiJOnx3uyL/VCSIXw0harubJFQdowZLfyOKf
        oJxN0MwkSJy+RIiLHKttx7lQWWXp7sY7H9JoAPI/NiTCBhu9wn742WfC5j5YW/kVaIAAViP1+G/zd
        IxVdip2dpy8t1V+ShOSHuL4XhWSL5gHW7m+cQuAHDmAM9sKwPTijfOc44gZALIkQ8b7uGLOX74ZUt
        tq+4pWnw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIX0N-00B8YG-Qm; Tue, 24 Aug 2021 14:03:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 08448300252;
        Tue, 24 Aug 2021 16:02:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DA0772C5B4A98; Tue, 24 Aug 2021 16:02:18 +0200 (CEST)
Date:   Tue, 24 Aug 2021 16:02:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Gabriel Marin <gmx@google.com>
Subject: Re: [RFC] perf/core: Add an ioctl to get a number of lost samples
Message-ID: <YST76vy8UQRCaKtO@hirez.programming.kicks-ass.net>
References: <20210811062135.1332927-1-namhyung@kernel.org>
 <YRPnCLyn9oE540gM@krava>
 <CAM9d7ci2ZkJ-FK0R1VoYjZZ9GzB4qDrPY=JD6_eOyUFQ1DLh7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ci2ZkJ-FK0R1VoYjZZ9GzB4qDrPY=JD6_eOyUFQ1DLh7Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 01:54:09PM -0700, Namhyung Kim wrote:
> Hi Jiri,
> 
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
> 
> Oh, right... I forgot about that, sorry.
> But I think the lost count is not collected accurately.
> 
> Peter, what do you think about the interface (read vs ioctl)?

I think I'm the one that suggested PERF_FORMAT_LOST at the time :-)
