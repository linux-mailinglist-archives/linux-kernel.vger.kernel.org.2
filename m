Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B8941603D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 15:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241451AbhIWNs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 09:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241360AbhIWNs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:48:27 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC1CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 06:46:55 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id e5so3895953qvq.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 06:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dR924fzJUnTOwFpFaOiKPGo+uYxMThczPIp4R0ax1KE=;
        b=hDlU7ifNIpOP2rS663/pNef0gtCG0hOWkG7oUEEGzw1T+0zDBWOgatJ9+EkiVzvGot
         6BhS5X4C3MnkFhKFgjcwEcEEVynAQ56EFzjNZHDYufAamav7tpKgxHrIzZ+bWxdm8MxH
         mAPWndGTzq+IF6rhcotsvq8bUj1ZRtBhZcl3Z3paaRwJPSG6w6q62KCGApgp6qIQGKHa
         c3Mz1qQUIU9bsNRAv7miAs58VMxqIpMwcaevWUt6AnMMkAQbO3jQW3YpcuD4xATCDQs+
         BhZ8hspmfxXQKFPnp6+9lww/KPA5GGHWMx31LiMIzIw2tMydooTjoau772tsbXKFnXbf
         aHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dR924fzJUnTOwFpFaOiKPGo+uYxMThczPIp4R0ax1KE=;
        b=p2MtLwIuwW3iQeafprrykivJ96f2Qsgg3LX4oWw8rfcEoBYwFQmN/ef6S5MpZnslSI
         s699LnHcrqZ5XNpMGktE3NyTJF42oiRPlsD/GRg6v/btsDNKkU5Ra3KXD00BwRl1QMo8
         v1StljeGLQDaInXjwdoieiLIpAG+TsLe6QlzT8vyFaCzNgSt9d/QMP/e1wIxyYhphJYL
         njVPBKEGrgHk7rsBmJUAN85jWxWPQDFCSA0kVN4SqFqEq1MA+iZzjHW8ulPvx0yBCDtY
         BN0AsS0Ky7XAO//36bCH8q7Iu2MG6J7KuuYftyJ7VEk/IijQrVkQVA5GIOZPd62yeDKC
         ttyw==
X-Gm-Message-State: AOAM531mC4ypKlN2dBcqLebnDwJjE+Xl4KHm+jx4VUu5zWRdnz3OBrww
        Rdzio2Q5AYE7VDAnKgHldeej0IQfKV7duV0hPfmFOw==
X-Google-Smtp-Source: ABdhPJwTohjf9LEMLFXIedyFjOd1m9SZlSS0qw9BodS1/jdvdzwGcxdKLafRq8zDSzhHgw+Q8Vs4jMF6KPmj5iPb7gI=
X-Received: by 2002:a05:6214:6b0:: with SMTP id s16mr4427451qvz.61.1632404814437;
 Thu, 23 Sep 2021 06:46:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210923104803.2620285-1-elver@google.com> <20210923104803.2620285-4-elver@google.com>
 <CACT4Y+Zvm4dXQY2tCuypso9aU97_6U2dLhfg2NNA8GTvcQoCLQ@mail.gmail.com>
 <CAG_fn=V31jEBeEVh0H2+uPAd2AhV9y6hYJmcP0P_i05UJ+MiTg@mail.gmail.com> <CANpmjNOh0ugPq90cVRPAbR-6qr=Q4CsQ_R1Qxk_Bi4TocgwUQA@mail.gmail.com>
In-Reply-To: <CANpmjNOh0ugPq90cVRPAbR-6qr=Q4CsQ_R1Qxk_Bi4TocgwUQA@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 23 Sep 2021 15:46:17 +0200
Message-ID: <CAG_fn=VpgmcmLg7=bh6Mf6HNr6wZYUADJZfB5AuRkedCqas6-w@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] kfence: limit currently covered allocations when
 pool nearly full
To:     Marco Elver <elver@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Taras Madan <tarasmadan@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 3:44 PM Marco Elver <elver@google.com> wrote:
>
> On Thu, 23 Sept 2021 at 15:24, Alexander Potapenko <glider@google.com> wr=
ote:
> >
> > On Thu, Sep 23, 2021 at 1:19 PM Dmitry Vyukov <dvyukov@google.com> wrot=
e:
> > >
> > > On Thu, 23 Sept 2021 at 12:48, Marco Elver <elver@google.com> wrote:
> > > >
> > > > One of KFENCE's main design principles is that with increasing upti=
me,
> > > > allocation coverage increases sufficiently to detect previously
> > > > undetected bugs.
> > > >
> > > > We have observed that frequent long-lived allocations of the same
> > > > source (e.g. pagecache) tend to permanently fill up the KFENCE pool
> > > > with increasing system uptime, thus breaking the above requirement.
> > > > The workaround thus far had been increasing the sample interval and=
/or
> > > > increasing the KFENCE pool size, but is no reliable solution.
> > > >
> > > > To ensure diverse coverage of allocations, limit currently covered
> > > > allocations of the same source once pool utilization reaches 75%
> > > > (configurable via `kfence.skip_covered_thresh`) or above. The effec=
t is
> > > > retaining reasonable allocation coverage when the pool is close to =
full.
> > > >
> > > > A side-effect is that this also limits frequent long-lived allocati=
ons
> > > > of the same source filling up the pool permanently.
> > > >
> > > > Uniqueness of an allocation for coverage purposes is based on its
> > > > (partial) allocation stack trace (the source). A Counting Bloom fil=
ter
> > > > is used to check if an allocation is covered; if the allocation is
> > > > currently covered, the allocation is skipped by KFENCE.
> > > >
> > > > Testing was done using:
> > > >
> > > >         (a) a synthetic workload that performs frequent long-lived
> > > >             allocations (default config values; sample_interval=3D1=
;
> > > >             num_objects=3D63), and
> > > >
> > > >         (b) normal desktop workloads on an otherwise idle machine w=
here
> > > >             the problem was first reported after a few days of upti=
me
> > > >             (default config values).
> > > >
> > > > In both test cases the sampled allocation rate no longer drops to z=
ero
> > > > at any point. In the case of (b) we observe (after 2 days uptime) 1=
5%
> > > > unique allocations in the pool, 77% pool utilization, with 20% "ski=
pped
> > > > allocations (covered)".
> > > >
> > > > Signed-off-by: Marco Elver <elver@google.com>
> > >
> > > Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> > Acked-by: Alexander Potapenko <glider@google.com>
>
> Thank you both!
>
> > > > ---
> > > > v3:
> > > > * Remove unneeded !alloc_stack_hash checks.
> > > > * Remove unneeded meta->alloc_stack_hash=3D0 in kfence_guarded_free=
().
> > > >
> > > > v2:
> > > > * Switch to counting bloom filter to guarantee currently covered
> > > >   allocations being skipped.
> > > > * Use a module param for skip_covered threshold.
> > > > * Use kfence pool address as hash entropy.
> > > > * Use filter_irq_stacks().
> > > > ---
> > > >  mm/kfence/core.c   | 103 +++++++++++++++++++++++++++++++++++++++++=
+++-
> > > >  mm/kfence/kfence.h |   2 +
> > > >  2 files changed, 103 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> > > > index db01814f8ff0..58a0f6f1acc5 100644
> > > > --- a/mm/kfence/core.c
> > > > +++ b/mm/kfence/core.c
> > > > @@ -11,11 +11,13 @@
> > > >  #include <linux/bug.h>
> > > >  #include <linux/debugfs.h>
> > > >  #include <linux/irq_work.h>
> > > > +#include <linux/jhash.h>
> > > >  #include <linux/kcsan-checks.h>
> > > >  #include <linux/kfence.h>
> > > >  #include <linux/kmemleak.h>
> > > >  #include <linux/list.h>
> > > >  #include <linux/lockdep.h>
> > > > +#include <linux/log2.h>
> > > >  #include <linux/memblock.h>
> > > >  #include <linux/moduleparam.h>
> > > >  #include <linux/random.h>
> > > > @@ -82,6 +84,10 @@ static const struct kernel_param_ops sample_inte=
rval_param_ops =3D {
> > > >  };
> > > >  module_param_cb(sample_interval, &sample_interval_param_ops, &kfen=
ce_sample_interval, 0600);
> > > >
> > > > +/* Pool usage% threshold when currently covered allocations are sk=
ipped. */
> > > > +static unsigned long kfence_skip_covered_thresh __read_mostly =3D =
75;
> > > > +module_param_named(skip_covered_thresh, kfence_skip_covered_thresh=
, ulong, 0644);
> > > > +
> > > >  /* The pool of pages used for guard pages and objects. */
> > > >  char *__kfence_pool __ro_after_init;
> > > >  EXPORT_SYMBOL(__kfence_pool); /* Export for test modules. */
> > > > @@ -105,6 +111,25 @@ DEFINE_STATIC_KEY_FALSE(kfence_allocation_key)=
;
> > > >  /* Gates the allocation, ensuring only one succeeds in a given per=
iod. */
> > > >  atomic_t kfence_allocation_gate =3D ATOMIC_INIT(1);
> > > >
> > > > +/*
> > > > + * A Counting Bloom filter of allocation coverage: limits currentl=
y covered
> > > > + * allocations of the same source filling up the pool.
> > > > + *
> > > > + * Assuming a range of 15%-85% unique allocations in the pool at a=
ny point in
> >
> > Where do these 85% come from?
>
> An imaginary worst case, just to illustrate the range of the false
> positive probabilities (in the case of 85% it'd be 0.33). I expect
> unique allocations to be around 10-15% on a freshly booted system (on
> my real-system-experiment it stayed below 15%), but other workloads
> may produce other unique allocations%.
>
> > > > + * time, the below parameters provide a probablity of 0.02-0.33 fo=
r false
> > > > + * positive hits respectively:
> > > > + *
> > > > + *     P(alloc_traces) =3D (1 - e^(-HNUM * (alloc_traces / SIZE)) =
^ HNUM
> > > > + */
> > > > +#define ALLOC_COVERED_HNUM     2
> > > > +#define ALLOC_COVERED_SIZE     (1 << (const_ilog2(CONFIG_KFENCE_NU=
M_OBJECTS) + 2))
> > > > +#define ALLOC_COVERED_HNEXT(h) (1664525 * (h) + 1013904223)
> >
> > Unless we are planning to change these primes, can you use
> > next_pseudo_random32() instead?
>
> I'm worried about next_pseudo_random32() changing their implementation
> to longer be deterministic or change in other ways that break our
> usecase. In this case we want pseudorandomness, but we're not
> implementing a PRNG.
>
> Open-coding the constants (given they are from "Numerical Recipes") is
> more reliable and doesn't introduce unwanted reliance on
> next_pseudo_random32()'s behaviour.

Okay, fair enough.

>
> Thanks,
> -- Marco



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
