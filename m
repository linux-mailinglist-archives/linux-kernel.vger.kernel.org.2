Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1653532D96E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 19:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbhCDS0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 13:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234236AbhCDS0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 13:26:00 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B418C061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 10:25:20 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id k2so25726109ili.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 10:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=7HgUeD5bwOAzWP+7Vvt95HJxa5oED3iD/QXXgkxTfuw=;
        b=Lw9zWDpzVQL6diXW1yWmA1qg8USl85oru0diHvjwbksPBzyuZcLx6kFL6baPA1LwLj
         LFnS1+7mzUdVzMhq8ZrGUrtsttJC2H+usnC3ogBZX9eW3H8pL4B43KMO/82uJ7RcKmA+
         Bai662H7nONhiylejAJgzYWH5ME+6I7/t/nMGimipsBLvVq97D3bP0ohF98P4KRGc4ov
         15js4LV5Uaovz13vI+ETN6tAo3zjE04lgRti/ON+VpGU/8XPFkqErgqIs7CcttMSrCII
         5UnAcM1wb1bZNtxGvYeVp0p9YF1oaIEMyLdvO/I2yL1IO3QukHCq88LPuMin3lgMRZcn
         lOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=7HgUeD5bwOAzWP+7Vvt95HJxa5oED3iD/QXXgkxTfuw=;
        b=Tl9Ak88uhsOgJ0zBaTrLcjAqXbhvkyhMe4bliM2q5TsB8N+vmXTSB/0Z0jWDYkS8u+
         p+HxDlwouoKgefSdfsG3mZUs2+ldQnJFV4+VrpFGDvo+Y+QzgzCJCRe9G6e0zL72ozez
         tQsb+6XufBBqF5a4Mh5XypRd7KXOuydPR99P4NWZZsY/gQDJNHA5YZlyVNmlImADhMhn
         Iy3eOg8ID8oawk4Nx9JDWx8pyrW3Sg16WGDCNmSUxUBJk8FF7u/6VvAtZz9Cilq70tRb
         7peX0QiE5ydEY//SU0gEKYgr403bVUPqKKXRfeRtyBzWhnbHvekeBpT55jTnxLUl72jq
         orVA==
X-Gm-Message-State: AOAM533ysz4UKAZ3/PaGTky6wBTkMnQLW1r+E5JYawYrWNMl0SE1KSYY
        81Gs5BjQxRKSEl4mRjP0lwfs7Y9acKU3MmHJtvk=
X-Google-Smtp-Source: ABdhPJzhXTm9SuTeONXi/X7SWOA6c8STfxv9um06to7v2eslll3wP/8jHfyXmIPsjvMBYVQci5Mlh6ycaMwpcn6Cabg=
X-Received: by 2002:a92:444e:: with SMTP id a14mr4969120ilm.215.1614882319769;
 Thu, 04 Mar 2021 10:25:19 -0800 (PST)
MIME-Version: 1.0
References: <YD9dUkGhlRT8vvcy@hirez.programming.kicks-ass.net>
 <20210303224653.2579656-1-joshdon@google.com> <CAKwvOdmijctJfM3gNfwEVjaQyp3LZkhnAwgsT7EBhsSBJyfLAA@mail.gmail.com>
In-Reply-To: <CAKwvOdmijctJfM3gNfwEVjaQyp3LZkhnAwgsT7EBhsSBJyfLAA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 4 Mar 2021 19:24:43 +0100
Message-ID: <CA+icZUUw0T2NpTcN4witbzYr1L7dF=rHKWq14ji_426G02QoEw@mail.gmail.com>
Subject: Re: [PATCH v2] sched: Optimize __calc_delta.
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Clement Courbet <courbet@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Bill Wendling <morbo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 4, 2021 at 6:34 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> On Wed, Mar 3, 2021 at 2:48 PM Josh Don <joshdon@google.com> wrote:
> >
> > From: Clement Courbet <courbet@google.com>
> >
> > A significant portion of __calc_delta time is spent in the loop
> > shifting a u64 by 32 bits. Use `fls` instead of iterating.
> >
> > This is ~7x faster on benchmarks.
> >
> > The generic `fls` implementation (`generic_fls`) is still ~4x faster
> > than the loop.
> > Architectures that have a better implementation will make use of it. Fo=
r
> > example, on X86 we get an additional factor 2 in speed without dedicate=
d
> > implementation.
> >
> > On gcc, the asm versions of `fls` are about the same speed as the
> > builtin. On clang, the versions that use fls are more than twice as
> > slow as the builtin. This is because the way the `fls` function is
> > written, clang puts the value in memory:
> > https://godbolt.org/z/EfMbYe. This bug is filed at
> > https://bugs.llvm.org/show_bug.cgi?id=3D49406.
>
> Hi Josh, Thanks for helping get this patch across the finish line.
> Would you mind updating the commit message to point to
> https://bugs.llvm.org/show_bug.cgi?id=3D20197?
>
> >
> > ```
> > name                                   cpu/op
> > BM_Calc<__calc_delta_loop>             9.57ms =C2=B112%
> > BM_Calc<__calc_delta_generic_fls>      2.36ms =C2=B113%
> > BM_Calc<__calc_delta_asm_fls>          2.45ms =C2=B113%
> > BM_Calc<__calc_delta_asm_fls_nomem>    1.66ms =C2=B112%
> > BM_Calc<__calc_delta_asm_fls64>        2.46ms =C2=B113%
> > BM_Calc<__calc_delta_asm_fls64_nomem>  1.34ms =C2=B115%
> > BM_Calc<__calc_delta_builtin>          1.32ms =C2=B111%
> > ```
> >
> > Signed-off-by: Clement Courbet <courbet@google.com>
> > Signed-off-by: Josh Don <joshdon@google.com>
> > ---
> >  kernel/sched/fair.c  | 19 +++++++++++--------
> >  kernel/sched/sched.h |  1 +
> >  2 files changed, 12 insertions(+), 8 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 8a8bd7b13634..a691371960ae 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -229,22 +229,25 @@ static void __update_inv_weight(struct load_weigh=
t *lw)
> >  static u64 __calc_delta(u64 delta_exec, unsigned long weight, struct l=
oad_weight *lw)
> >  {
> >         u64 fact =3D scale_load_down(weight);
> > +       u32 fact_hi =3D (u32)(fact >> 32);
> >         int shift =3D WMULT_SHIFT;
> > +       int fs;
> >
> >         __update_inv_weight(lw);
> >
> > -       if (unlikely(fact >> 32)) {
> > -               while (fact >> 32) {
> > -                       fact >>=3D 1;
> > -                       shift--;
> > -               }
> > +       if (unlikely(fact_hi)) {
> > +               fs =3D fls(fact_hi);
> > +               shift -=3D fs;
> > +               fact >>=3D fs;
> >         }
> >
> >         fact =3D mul_u32_u32(fact, lw->inv_weight);
> >
> > -       while (fact >> 32) {
> > -               fact >>=3D 1;
> > -               shift--;
> > +       fact_hi =3D (u32)(fact >> 32);
> > +       if (fact_hi) {
> > +               fs =3D fls(fact_hi);
> > +               shift -=3D fs;
> > +               fact >>=3D fs;
> >         }
> >
> >         return mul_u64_u32_shr(delta_exec, fact, shift);
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 10a1522b1e30..714af71cf983 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -36,6 +36,7 @@
> >  #include <uapi/linux/sched/types.h>
> >
> >  #include <linux/binfmts.h>
> > +#include <linux/bitops.h>
>
> This hunk of the patch is curious.  I assume that bitops.h is needed
> for fls(); if so, why not #include it in kernel/sched/fair.c?
> Otherwise this potentially hurts compile time for all TUs that include
> kernel/sched/sched.h.
>

I have v2 as-is in my custom patchset and booted right now on bare metal.

As Nick points out moving the include makes sense to me.
We have a lot of include at the wrong places increasing build-time.

- Sedat -

> >  #include <linux/blkdev.h>
> >  #include <linux/compat.h>
> >  #include <linux/context_tracking.h>
> > --
> > 2.30.1.766.gb4fecdf3b7-goog
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers
>
> --
> You received this message because you are subscribed to the Google Groups=
 "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/clang-built-linux/CAKwvOdmijctJfM3gNfwEVjaQyp3LZkhnAwgsT7EBhsSBJyfLAA%40m=
ail.gmail.com.
