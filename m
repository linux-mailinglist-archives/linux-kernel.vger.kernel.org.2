Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D5041687E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 01:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243552AbhIWX3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 19:29:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:46778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235628AbhIWX3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 19:29:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 60AC760F43;
        Thu, 23 Sep 2021 23:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1632439692;
        bh=1MbzwBSkc1BV2l0Q1eJRZ5r/+IJZfOlfncEyBxNFNc4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QoqOFG2qw3bM46IOzMY71mwInBqJkHG8+OaD0tKjys3CTuJIyHgxVXlvJAYMas12F
         F2HEy8YxLuWFAhnHc31JAym5Ugkr3ZCQlFde6FPJ8lsV9Yc0HpPGIYxBYHz/UUrYoH
         TvCWm5q1iXTxSPSnTlHJezXskmBuR96UAL4grWhE=
Date:   Thu, 23 Sep 2021 16:28:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Marco Elver <elver@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Taras Madan <tarasmadan@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH v3 4/5] kfence: limit currently covered allocations when
 pool nearly full
Message-Id: <20210923162811.3cc8188d6a30d9eed2375468@linux-foundation.org>
In-Reply-To: <CANpmjNOh0ugPq90cVRPAbR-6qr=Q4CsQ_R1Qxk_Bi4TocgwUQA@mail.gmail.com>
References: <20210923104803.2620285-1-elver@google.com>
        <20210923104803.2620285-4-elver@google.com>
        <CACT4Y+Zvm4dXQY2tCuypso9aU97_6U2dLhfg2NNA8GTvcQoCLQ@mail.gmail.com>
        <CAG_fn=V31jEBeEVh0H2+uPAd2AhV9y6hYJmcP0P_i05UJ+MiTg@mail.gmail.com>
        <CANpmjNOh0ugPq90cVRPAbR-6qr=Q4CsQ_R1Qxk_Bi4TocgwUQA@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2021 15:44:10 +0200 Marco Elver <elver@google.com> wrote:

> > > > + * time, the below parameters provide a probablity of 0.02-0.33 for false
> > > > + * positive hits respectively:
> > > > + *
> > > > + *     P(alloc_traces) = (1 - e^(-HNUM * (alloc_traces / SIZE)) ^ HNUM
> > > > + */
> > > > +#define ALLOC_COVERED_HNUM     2
> > > > +#define ALLOC_COVERED_SIZE     (1 << (const_ilog2(CONFIG_KFENCE_NUM_OBJECTS) + 2))
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

Perhaps we could summarize this in an additional comment?

Also, this:

+static u32 get_alloc_stack_hash(unsigned long *stack_entries, size_t num_entries)
+{
+	/* Some randomness across reboots / different machines. */
+	u32 seed = (u32)((unsigned long)__kfence_pool >> (BITS_PER_LONG - 32));

seems a bit weak.  Would it be better to seed this at boot time with
a randomish number?
