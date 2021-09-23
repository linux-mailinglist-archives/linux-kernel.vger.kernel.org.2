Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7F9416037
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 15:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241399AbhIWNp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 09:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbhIWNpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:45:55 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFFFC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 06:44:23 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id r43-20020a05683044ab00b0054716b40005so1652608otv.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 06:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ukweXmx4e+IJqf+FzCzZ1AIpQAkTlQYs/+7Ou4M2RuM=;
        b=LWu70/eBRthTIh5GFov772F4fU78omk/jrtYzccJDts2L3v6z45e9R8fa6TWFStLlT
         H9NQNyXZupj9iyNJU4NZ77BgPDnkO+rSZevzj7EmhqnRKc8KaKaL6CHOsBxRSX1mx9nL
         1YBQbU+bZ+mQIjHDGvXO2H2jJ6jm9opzjTdljCM1DWCfmGDtAlq20lA/fgOV7D/nwPZI
         iqc2a2MPxIFqjg7WfT4axP0laaCXL8RZdlfK0wga+f5GD4SmNcUSg5gNYuYc17hsR8lJ
         vg7FiVDTJSteH5skcV+IQrTpoNwglbaShCzWqE/OWBS/iT/9peRKgmU6+/LCEx7N4SIT
         C4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ukweXmx4e+IJqf+FzCzZ1AIpQAkTlQYs/+7Ou4M2RuM=;
        b=k9FL6ECChTXEmCb3zTwe0YEVry9gvziee2OID9WIdQwZogebiVG0UWWXqhilzB2Sqv
         Rea3H7ALoNac5gAKp9faeZwP8EIBrVAuiWLkymHnHmfknmkq3nyAzM81Q4X1x1L60v0g
         3c+WsX0HRkCiZovZMOeHRODETCdda27RS3h6t1edkDfWbD5DSRHoB5CfdnuZPkHZLAop
         jJ4tgyl0IgqGVwsocX+zDO2mLO0ABtdqkLspfcvCQulIrkhlrudF7rCOmOjUdE4ymLQE
         /Wsk45FNh6k7Zfrf0nVVgtLbC/VE8U48RhUAYcZu4xCLf+ojW656diwY6pTewimpbz0j
         eFxQ==
X-Gm-Message-State: AOAM530nirWmCwYez88hzDjA0ZUhkP801CR8OvTrV83vxwVMDflo2v9Q
        jB24nHJID8FBMV/SPVW5dX8JqDg3jz0PI7uDeQgIhpjrKN8=
X-Google-Smtp-Source: ABdhPJz7A7mj76WwxWLRUzJpIE7zjjLzwH2R6qA8BU/QVQF/dJNOTN8h/i+ha3SU7ymLGaQ3bAY/yJJc+V76JXDKGJ4=
X-Received: by 2002:a9d:135:: with SMTP id 50mr4326659otu.295.1632404662778;
 Thu, 23 Sep 2021 06:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210923104803.2620285-1-elver@google.com> <20210923104803.2620285-4-elver@google.com>
 <CACT4Y+Zvm4dXQY2tCuypso9aU97_6U2dLhfg2NNA8GTvcQoCLQ@mail.gmail.com> <CAG_fn=V31jEBeEVh0H2+uPAd2AhV9y6hYJmcP0P_i05UJ+MiTg@mail.gmail.com>
In-Reply-To: <CAG_fn=V31jEBeEVh0H2+uPAd2AhV9y6hYJmcP0P_i05UJ+MiTg@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 23 Sep 2021 15:44:10 +0200
Message-ID: <CANpmjNOh0ugPq90cVRPAbR-6qr=Q4CsQ_R1Qxk_Bi4TocgwUQA@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] kfence: limit currently covered allocations when
 pool nearly full
To:     Alexander Potapenko <glider@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Taras Madan <tarasmadan@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sept 2021 at 15:24, Alexander Potapenko <glider@google.com> wrote:
>
> On Thu, Sep 23, 2021 at 1:19 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Thu, 23 Sept 2021 at 12:48, Marco Elver <elver@google.com> wrote:
> > >
> > > One of KFENCE's main design principles is that with increasing uptime,
> > > allocation coverage increases sufficiently to detect previously
> > > undetected bugs.
> > >
> > > We have observed that frequent long-lived allocations of the same
> > > source (e.g. pagecache) tend to permanently fill up the KFENCE pool
> > > with increasing system uptime, thus breaking the above requirement.
> > > The workaround thus far had been increasing the sample interval and/or
> > > increasing the KFENCE pool size, but is no reliable solution.
> > >
> > > To ensure diverse coverage of allocations, limit currently covered
> > > allocations of the same source once pool utilization reaches 75%
> > > (configurable via `kfence.skip_covered_thresh`) or above. The effect is
> > > retaining reasonable allocation coverage when the pool is close to full.
> > >
> > > A side-effect is that this also limits frequent long-lived allocations
> > > of the same source filling up the pool permanently.
> > >
> > > Uniqueness of an allocation for coverage purposes is based on its
> > > (partial) allocation stack trace (the source). A Counting Bloom filter
> > > is used to check if an allocation is covered; if the allocation is
> > > currently covered, the allocation is skipped by KFENCE.
> > >
> > > Testing was done using:
> > >
> > >         (a) a synthetic workload that performs frequent long-lived
> > >             allocations (default config values; sample_interval=1;
> > >             num_objects=63), and
> > >
> > >         (b) normal desktop workloads on an otherwise idle machine where
> > >             the problem was first reported after a few days of uptime
> > >             (default config values).
> > >
> > > In both test cases the sampled allocation rate no longer drops to zero
> > > at any point. In the case of (b) we observe (after 2 days uptime) 15%
> > > unique allocations in the pool, 77% pool utilization, with 20% "skipped
> > > allocations (covered)".
> > >
> > > Signed-off-by: Marco Elver <elver@google.com>
> >
> > Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> Acked-by: Alexander Potapenko <glider@google.com>

Thank you both!

> > > ---
> > > v3:
> > > * Remove unneeded !alloc_stack_hash checks.
> > > * Remove unneeded meta->alloc_stack_hash=0 in kfence_guarded_free().
> > >
> > > v2:
> > > * Switch to counting bloom filter to guarantee currently covered
> > >   allocations being skipped.
> > > * Use a module param for skip_covered threshold.
> > > * Use kfence pool address as hash entropy.
> > > * Use filter_irq_stacks().
> > > ---
> > >  mm/kfence/core.c   | 103 ++++++++++++++++++++++++++++++++++++++++++++-
> > >  mm/kfence/kfence.h |   2 +
> > >  2 files changed, 103 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> > > index db01814f8ff0..58a0f6f1acc5 100644
> > > --- a/mm/kfence/core.c
> > > +++ b/mm/kfence/core.c
> > > @@ -11,11 +11,13 @@
> > >  #include <linux/bug.h>
> > >  #include <linux/debugfs.h>
> > >  #include <linux/irq_work.h>
> > > +#include <linux/jhash.h>
> > >  #include <linux/kcsan-checks.h>
> > >  #include <linux/kfence.h>
> > >  #include <linux/kmemleak.h>
> > >  #include <linux/list.h>
> > >  #include <linux/lockdep.h>
> > > +#include <linux/log2.h>
> > >  #include <linux/memblock.h>
> > >  #include <linux/moduleparam.h>
> > >  #include <linux/random.h>
> > > @@ -82,6 +84,10 @@ static const struct kernel_param_ops sample_interval_param_ops = {
> > >  };
> > >  module_param_cb(sample_interval, &sample_interval_param_ops, &kfence_sample_interval, 0600);
> > >
> > > +/* Pool usage% threshold when currently covered allocations are skipped. */
> > > +static unsigned long kfence_skip_covered_thresh __read_mostly = 75;
> > > +module_param_named(skip_covered_thresh, kfence_skip_covered_thresh, ulong, 0644);
> > > +
> > >  /* The pool of pages used for guard pages and objects. */
> > >  char *__kfence_pool __ro_after_init;
> > >  EXPORT_SYMBOL(__kfence_pool); /* Export for test modules. */
> > > @@ -105,6 +111,25 @@ DEFINE_STATIC_KEY_FALSE(kfence_allocation_key);
> > >  /* Gates the allocation, ensuring only one succeeds in a given period. */
> > >  atomic_t kfence_allocation_gate = ATOMIC_INIT(1);
> > >
> > > +/*
> > > + * A Counting Bloom filter of allocation coverage: limits currently covered
> > > + * allocations of the same source filling up the pool.
> > > + *
> > > + * Assuming a range of 15%-85% unique allocations in the pool at any point in
>
> Where do these 85% come from?

An imaginary worst case, just to illustrate the range of the false
positive probabilities (in the case of 85% it'd be 0.33). I expect
unique allocations to be around 10-15% on a freshly booted system (on
my real-system-experiment it stayed below 15%), but other workloads
may produce other unique allocations%.

> > > + * time, the below parameters provide a probablity of 0.02-0.33 for false
> > > + * positive hits respectively:
> > > + *
> > > + *     P(alloc_traces) = (1 - e^(-HNUM * (alloc_traces / SIZE)) ^ HNUM
> > > + */
> > > +#define ALLOC_COVERED_HNUM     2
> > > +#define ALLOC_COVERED_SIZE     (1 << (const_ilog2(CONFIG_KFENCE_NUM_OBJECTS) + 2))
> > > +#define ALLOC_COVERED_HNEXT(h) (1664525 * (h) + 1013904223)
>
> Unless we are planning to change these primes, can you use
> next_pseudo_random32() instead?

I'm worried about next_pseudo_random32() changing their implementation
to longer be deterministic or change in other ways that break our
usecase. In this case we want pseudorandomness, but we're not
implementing a PRNG.

Open-coding the constants (given they are from "Numerical Recipes") is
more reliable and doesn't introduce unwanted reliance on
next_pseudo_random32()'s behaviour.

Thanks,
-- Marco
