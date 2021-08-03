Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0770F3DF0CC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 16:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbhHCOwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 10:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbhHCOwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 10:52:24 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAE6C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 07:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=I3HT/Dakp/zeyXelc7sNDugIMRK4Rynbb1Hu8/li6oU=; b=GIu6oJA2z6onqSv20o0MbjFFuU
        TnIMvABctYm5bg6hM17Pau+i1UTbtCcx9anbTVoLFTLWKTt/HwkqGtvTHUfWECvAJNspKxgJxtZPn
        tTJIJ88Kdb7iLp3j9j3pSwi2IyjfSXaAl+8c6l8+AaEZ0+em806d/n4bAPBdZ8XNU+CNbWDssC4NA
        gu5eJ8ZQWfbQtppeqW1SIJ9RT0LEITsgDTh3vsTcLwZ6lw3oN8ExTXuAxvjA5OCMPhwP2DWmECS/5
        3mOFS/RKk2tkSLmt96mafj/JWjtIGrzXm4w+5CHNIoaVDrlssKqxtZ8SjnQdEX0g7xEtleb6wARoJ
        3PUMpyvA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mAvlq-005R5u-3X; Tue, 03 Aug 2021 14:51:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1B20C30027E;
        Tue,  3 Aug 2021 16:51:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9E76820304063; Tue,  3 Aug 2021 16:51:51 +0200 (CEST)
Date:   Tue, 3 Aug 2021 16:51:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [patch 03/63] sched: Prepare for RT sleeping spin/rwlocks
Message-ID: <YQlYB7wE8HaDjyd7@hirez.programming.kicks-ass.net>
References: <20210730135007.155909613@linutronix.de>
 <20210730135205.317820700@linutronix.de>
 <e1fde6625113e7099ddc68f291984b8bedf5e387.camel@gmx.de>
 <20210803094832.GA8057@worktop.programming.kicks-ass.net>
 <87y29ipqug.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y29ipqug.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 04:04:07PM +0200, Thomas Gleixner wrote:
> On Tue, Aug 03 2021 at 11:48, Peter Zijlstra wrote:
> 
> > On Sun, Aug 01, 2021 at 05:30:06PM +0200, Mike Galbraith wrote:
> >> On Fri, 2021-07-30 at 15:50 +0200, Thomas Gleixner wrote:
> >> > 
> >> > --- a/include/linux/sched.h
> >> > +++ b/include/linux/sched.h
> >> > @@ -155,6 +155,27 @@ struct task_group;
> >> >                 WRITE_ONCE(current->__state, (state_value));            \
> >> >                 raw_spin_unlock_irqrestore(&current->pi_lock, flags);   \
> >> >         } while (0)
> >> > +
> >> > +
> >> > +#define current_save_and_set_rtlock_wait_state()                       \
> >> > +       do {                                                            \
> >> > +               raw_spin_lock(&current->pi_lock);                       \
> >
> > That wants to be irqsafe methinks, I realize this is PREEMPT_RT only and
> > there the _irqfoo crap is a no-op so this doesn't really matter one way
> > or the other, but still, taking PI lock without IRQ disable makes my
> > head go BUG-BUG-BUG :-)
> 
> Actually the rule to lock PI lock irqsave still persists on RT, but this
> has to be called with interrupts disabled (rtmutex::wait_lock is held),
> so adding a lockdep_assert_irqs_disable() might be good enough to spare
> the extra save/restore. Hmm?

Works for me.. and yes, duh, raw_.
