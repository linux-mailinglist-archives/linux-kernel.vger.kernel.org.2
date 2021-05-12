Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9C037B8E1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 11:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhELJJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 05:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhELJJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 05:09:09 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED77DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 02:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Grgb//N/lCPeK7sJQo/JIeouZ0dY42fB6qihCoLIo8c=; b=UWdODZ+3hIheUJWXjqDbq4mfTW
        homSj6CT1obAGXGb9Qh43G8nTHS2sdfgjyfDHYilmHhQt8iIbzkMw3Zw8aYvPwjXdgDZFhxMim6OD
        JMk3tubYX4Rub4qkfsJZSCnBdPYaH5G5GuRe3TJiBqF4hnreLjFfPuq0Y3adfIhj01PtNb3Cfkc47
        3Byf3DGxULDQzTjr1D2OnXj3Pb16HPCUKww3HvC57fSeDXWzaScC6rl4tsgZ2PYjxOUJT3Snf18GM
        ehKgzvc4qz8PIIHJBLl0lTGMrlHOnOZfKKdc1Juciyc0IuHPNbkY4JFLS+ezFBUn1nfknFtmoyR1S
        9mjFmxhw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lgkqR-002Obs-EJ; Wed, 12 May 2021 09:07:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0BAEB300242;
        Wed, 12 May 2021 11:07:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E3CEE2BA8A557; Wed, 12 May 2021 11:07:54 +0200 (CEST)
Date:   Wed, 12 May 2021 11:07:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Aubrey Li <aubrey.intel@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Josh Don <joshdon@google.com>, Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 04/19] sched: Prepare for Core-wide rq->lock
Message-ID: <YJua6gu8IqSSkDmp@hirez.programming.kicks-ass.net>
References: <20210422120459.447350175@infradead.org>
 <20210422123308.196692074@infradead.org>
 <YJUNY0dmrJMD/BIm@hirez.programming.kicks-ass.net>
 <CAERHkrvBdFHWxXu=iHAPMe=1dB0qtG_HTMtUbvVviv7_7kc97Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAERHkrvBdFHWxXu=iHAPMe=1dB0qtG_HTMtUbvVviv7_7kc97Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 08, 2021 at 04:07:35PM +0800, Aubrey Li wrote:
> > +#ifdef CONFIG_SMP
> > +/*
> > + * double_rq_lock - safely lock two runqueues
> > + */
> > +void double_rq_lock(struct rq *rq1, struct rq *rq2)
> 
> Do we need the static lock checking here?
>         __acquires(rq1->lock)
>         __acquires(rq2->lock)
> 
> > +{
> > +       lockdep_assert_irqs_disabled();
> > +
> > +       if (rq_order_less(rq2, rq1))
> > +               swap(rq1, rq2);
> > +
> > +       raw_spin_rq_lock(rq1);
> > +       if (rq_lockp(rq1) == rq_lockp(rq2)) {
> 
> And here?
>                 __acquire(rq2->lock);
> 
> > +               return;
> }
> > +
> > +       raw_spin_rq_lock_nested(rq2, SINGLE_DEPTH_NESTING);
> > +}
> > +#endif

I'd as soon rip out all that sparse annotation crud; I don't think I've
ever had any benefit from it.


> > @@ -2368,11 +2354,11 @@ static inline void double_rq_unlock(stru
> >         __releases(rq1->lock)
> >         __releases(rq2->lock)
> >  {
> > -       raw_spin_rq_unlock(rq1);
> >         if (rq_lockp(rq1) != rq_lockp(rq2))
> >                 raw_spin_rq_unlock(rq2);
> >         else
> >                 __release(rq2->lock);
> > +       raw_spin_rq_unlock(rq1);
> 
> This change seems not necessary, as the softlockup root cause is not
> the misorder lock release.

No, it really is needed; rq_lockp() is not stable if we don't hold a
lock.
