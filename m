Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0A033C6BC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 20:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbhCOTXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 15:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbhCOTWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 15:22:39 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F07C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 12:22:39 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id w18so18704027edc.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 12:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VN2QmRBHk/YVrYYtE6i8DWZ5kx35s2uQPi/cXaUiXgQ=;
        b=Vp5kqbATEHGH4mw9HI+4INYb82mtWw+2HS73rAo3MNyB/FnPeP29zLqLZGbCxxPUyO
         y+b8O+tQUKevLm3p6CJOA6h/ZwiQmJUm8LKxtco8UMWETYT3PNdlkbO37KzdK34QpDsO
         fHEl2isfRn0YrytxkU/z+tKkLhelm99awsyhhgSEnrblLJGUpHWd5eM6LttqJkgs5qlt
         LlX+47oLoR0LvML8mEJsMz0dip31J19A3QLRDImPC32RBqY2is7pQVDzG8wrjV9VYPHE
         udI+3+e3gRv51Rp06185TW9TQtZsGxa0KmjomixkCToZxx82dc6NN8KOf7jmbb7zkHFm
         rphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VN2QmRBHk/YVrYYtE6i8DWZ5kx35s2uQPi/cXaUiXgQ=;
        b=qMTL526H/Oi4SXQWuzMezUS3whCficdkejg4/USy7aCwbA44Y7HdFIlNDFRSlIifWO
         kZLR45iNNfLQJN4Wj7K4cqgDHRGj50fkJtCS1BDh+Z2Vb1/ZhQgQGJ7J07HH1ilBKdKs
         kb4VJYSwhLeT1R23v+SQiHQOWD9vEg4Vl68upwKCEgVG9qQIkm+pCdhpX10ehGPbeowD
         LJU4HbqWffHgSAVdPW60vOv1RGxJIIfpOZP2WHkJXOq/Ce4Sl6ALZtMSfuv0G8eHRMyF
         Jv9Cvsvb8DuSazyrX92hla4ePt1UVEH/PRQ3Nkfo9tkcN6F3OyJIIv37y0Pv6d6q/W8O
         Q11g==
X-Gm-Message-State: AOAM531D8mUjTZiwcZA+PikcAYC45HBBxspPXkS6CY5BJM4hBXNg/pWI
        FCd7VCIoS9OjwY5WNrMQ5b9bUf4OYVT44s2zrHQ=
X-Google-Smtp-Source: ABdhPJzwr7yryQPUN4DOmOqs5fZRX8T7Bff8U6hjPQV/YJ91cnOIyROU65PTDH2aATMDeor+7YEg8Oj7ccZpx3Tz6kQ=
X-Received: by 2002:a05:6402:518d:: with SMTP id q13mr31885055edd.313.1615836157714;
 Mon, 15 Mar 2021 12:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <1615303512-35058-1-git-send-email-xlpang@linux.alibaba.com>
 <793c884a-9d60-baaf-fab8-3e5f4a024124@suse.cz> <YE+wBMuX1Q0rhPQj@carbon.dhcp.thefacebook.com>
In-Reply-To: <YE+wBMuX1Q0rhPQj@carbon.dhcp.thefacebook.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 15 Mar 2021 12:22:25 -0700
Message-ID: <CAHbLzkqXpWWYmzGhTBALAQFx5KEWVdT2rz8GW836WOdWHuWAWA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] mm/slub: Fix count_partial() problem
To:     Roman Gushchin <guro@fb.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Xunlei Pang <xlpang@linux.alibaba.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shu Ming <sming56@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Wen Yang <wenyang@linux.alibaba.com>,
        James Wang <jnwang@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 12:15 PM Roman Gushchin <guro@fb.com> wrote:
>
>
> On Mon, Mar 15, 2021 at 07:49:57PM +0100, Vlastimil Babka wrote:
> > On 3/9/21 4:25 PM, Xunlei Pang wrote:
> > > count_partial() can hold n->list_lock spinlock for quite long, which
> > > makes much trouble to the system. This series eliminate this problem.
> >
> > Before I check the details, I have two high-level comments:
> >
> > - patch 1 introduces some counting scheme that patch 4 then changes, could we do
> > this in one step to avoid the churn?
> >
> > - the series addresses the concern that spinlock is being held, but doesn't
> > address the fact that counting partial per-node slabs is not nearly enough if we
> > want accurate <active_objs> in /proc/slabinfo because there are also percpu
> > slabs and per-cpu partial slabs, where we don't track the free objects at all.
> > So after this series while the readers of /proc/slabinfo won't block the
> > spinlock, they will get the same garbage data as before. So Christoph is not
> > wrong to say that we can just report active_objs == num_objs and it won't
> > actually break any ABI.
> > At the same time somebody might actually want accurate object statistics at the
> > expense of peak performance, and it would be nice to give them such option in
> > SLUB. Right now we don't provide this accuracy even with CONFIG_SLUB_STATS,
> > although that option provides many additional tuning stats, with additional
> > overhead.
> > So my proposal would be a new config for "accurate active objects" (or just tie
> > it to CONFIG_SLUB_DEBUG?) that would extend the approach of percpu counters in
> > patch 4 to all alloc/free, so that it includes percpu slabs. Without this config
> > enabled, let's just report active_objs == num_objs.
>
> It sounds really good to me! The only thing, I'd avoid introducing a new option
> and use CONFIG_SLUB_STATS instead.
>
> It seems like CONFIG_SLUB_DEBUG is a more popular option than CONFIG_SLUB_STATS.
> CONFIG_SLUB_DEBUG is enabled on my Fedora workstation, CONFIG_SLUB_STATS is off.
> I doubt an average user needs this data, so I'd go with CONFIG_SLUB_STATS.

I think CONFIG_SLUB_DEBUG is enabled by default on most distros since
it is supposed not incur too much overhead unless specific debug (i.e.
red_zone) is turned on on demand.

>
> Thanks!
>
> >
> > Vlastimil
> >
> > > v1->v2:
> > > - Improved changelog and variable naming for PATCH 1~2.
> > > - PATCH3 adds per-cpu counter to avoid performance regression
> > >   in concurrent __slab_free().
> > >
> > > v2->v3:
> > > - Changed "page->inuse" to the safe "new.inuse", etc.
> > > - Used CONFIG_SLUB_DEBUG and CONFIG_SYSFS condition for new counters.
> > > - atomic_long_t -> unsigned long
> > >
> > > [Testing]
> > > There seems might be a little performance impact under extreme
> > > __slab_free() concurrent calls according to my tests.
> > >
> > > On my 32-cpu 2-socket physical machine:
> > > Intel(R) Xeon(R) CPU E5-2650 v2 @ 2.60GHz
> > >
> > > 1) perf stat --null --repeat 10 -- hackbench 20 thread 20000
> > >
> > > == original, no patched
> > > Performance counter stats for 'hackbench 20 thread 20000' (10 runs):
> > >
> > >       24.536050899 seconds time elapsed                                          ( +-  0.24% )
> > >
> > >
> > > Performance counter stats for 'hackbench 20 thread 20000' (10 runs):
> > >
> > >       24.588049142 seconds time elapsed                                          ( +-  0.35% )
> > >
> > >
> > > == patched with patch1~4
> > > Performance counter stats for 'hackbench 20 thread 20000' (10 runs):
> > >
> > >       24.670892273 seconds time elapsed                                          ( +-  0.29% )
> > >
> > >
> > > Performance counter stats for 'hackbench 20 thread 20000' (10 runs):
> > >
> > >       24.746755689 seconds time elapsed                                          ( +-  0.21% )
> > >
> > >
> > > 2) perf stat --null --repeat 10 -- hackbench 32 thread 20000
> > >
> > > == original, no patched
> > >  Performance counter stats for 'hackbench 32 thread 20000' (10 runs):
> > >
> > >       39.784911855 seconds time elapsed                                          ( +-  0.14% )
> > >
> > >  Performance counter stats for 'hackbench 32 thread 20000' (10 runs):
> > >
> > >       39.868687608 seconds time elapsed                                          ( +-  0.19% )
> > >
> > > == patched with patch1~4
> > >  Performance counter stats for 'hackbench 32 thread 20000' (10 runs):
> > >
> > >       39.681273015 seconds time elapsed                                          ( +-  0.21% )
> > >
> > >  Performance counter stats for 'hackbench 32 thread 20000' (10 runs):
> > >
> > >       39.681238459 seconds time elapsed                                          ( +-  0.09% )
> > >
> > >
> > > Xunlei Pang (4):
> > >   mm/slub: Introduce two counters for partial objects
> > >   mm/slub: Get rid of count_partial()
> > >   percpu: Export per_cpu_sum()
> > >   mm/slub: Use percpu partial free counter
> > >
> > >  include/linux/percpu-defs.h   |  10 ++++
> > >  kernel/locking/percpu-rwsem.c |  10 ----
> > >  mm/slab.h                     |   4 ++
> > >  mm/slub.c                     | 120 +++++++++++++++++++++++++++++-------------
> > >  4 files changed, 97 insertions(+), 47 deletions(-)
> > >
> >
>
