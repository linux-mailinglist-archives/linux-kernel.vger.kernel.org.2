Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4953726A0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 09:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhEDHj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 03:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhEDHj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 03:39:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138C3C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 00:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0lbdYBbkecAfVhKtoKKQJCexg9woq7Y5uLlxNo7Q9Ag=; b=RAL1KJ3XjK9jGccbsj3Ms8QFlq
        DHZ1TSjJTOg3aK2BjndDkv72z2a7Emsdthx3dnXYN918Q5vRXxiG/N8uEZwK9w0MK5SWDj3i47ugr
        IsFb+IXN1+8Nwgg4rDUfVLSVsF39tT7QbyhR1TQtZDz3m5WelRK+IswnSAMzWmnqYStFawntRpmM/
        1P174HfyX62jglN5yxtdTzaWrZdSW3IrY0Kr3/JANMETNAO+dYSpp/uBpTSAHBbbJ4CvOgRa58lrB
        mtvW/6hiHhd7svFFnLIx4PsV+ps14z/zU5GZluQVveaH3np4bnU9tRBRfLvv+rcATruA3w0mBTbLa
        V/TfhzMg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1ldpdN-00FcyK-W8; Tue, 04 May 2021 07:38:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AC1D83001D0;
        Tue,  4 May 2021 09:38:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 699D228B31306; Tue,  4 May 2021 09:38:18 +0200 (CEST)
Date:   Tue, 4 May 2021 09:38:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Aubrey Li <aubrey.intel@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Don Hiatt <dhiatt@digitalocean.com>
Subject: Re: [PATCH 04/19] sched: Prepare for Core-wide rq->lock
Message-ID: <YJD56sBCGviSDOTK@hirez.programming.kicks-ass.net>
References: <20210422120459.447350175@infradead.org>
 <20210422123308.196692074@infradead.org>
 <CAERHkrsC9rC4Jrkz8r-7kp4SFPM6aU+EHN+Y+uQiTuPG5S72bA@mail.gmail.com>
 <CABk29NuS-B3n4sbmavo0NDA1OCCsz6Zf2VDjjFQvAxBMQoJ_Lg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29NuS-B3n4sbmavo0NDA1OCCsz6Zf2VDjjFQvAxBMQoJ_Lg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 01:39:54PM -0700, Josh Don wrote:

> > > +void double_rq_lock(struct rq *rq1, struct rq *rq2)
> > > +{
> > > +       lockdep_assert_irqs_disabled();
> > > +
> > > +       if (rq1->cpu > rq2->cpu)
> >
> > It's still a bit hard for me to digest this function, I guess using (rq->cpu)
> > can't guarantee the sequence of locking when coresched is enabled.
> >
> > - cpu1 and cpu7 shares lockA
> > - cpu2 and cpu8 shares lockB
> >
> > double_rq_lock(1,8) leads to lock(A) and lock(B)
> > double_rq_lock(7,2) leads to lock(B) and lock(A)

Good one!

> > change to below to avoid ABBA?
> > +       if (__rq_lockp(rq1) > __rq_lockp(rq2))

This, however, is broken badly, not only does it suffer the problem Josh
pointed out, it also breaks the rq->__lock ordering vs
__sched_core_flip(), which was the whole reason the ordering needed
changing in the first place.

> I'd propose an alternative but
> similar idea: order by core, then break ties by ordering on cpu.
> 
> +#ifdef CONFIG_SCHED_CORE
> +       if (rq1->core->cpu > rq2->core->cpu)
> +               swap(rq1, rq2);
> +       else if (rq1->core->cpu == rq2->core->cpu && rq1->cpu > rq2->cpu)
> +               swap(rq1, rq2);
> +#else
>         if (rq1->cpu > rq2->cpu)
>                 swap(rq1, rq2);
> +#endif

I've written it like so:

static inline bool rq_order_less(struct rq *rq1, struct rq *rq2)
{
#ifdef CONFIG_SCHED_CORE
	if (rq1->core->cpu < rq2->core->cpu)
		return true;
	if (rq1->core->cpu > rq2->core->cpu)
		return false;
#endif
	return rq1->cpu < rq2->cpu;
}

/*
 * double_rq_lock - safely lock two runqueues
 */
void double_rq_lock(struct rq *rq1, struct rq *rq2)
{
	lockdep_assert_irqs_disabled();

	if (rq_order_less(rq2, rq1))
		swap(rq1, rq2);

	raw_spin_rq_lock(rq1);
	if (rq_lockp(rq1) == rq_lockp(rq2))
		return;

	raw_spin_rq_lock_nested(rq2, SINGLE_DEPTH_NESTING);
}
