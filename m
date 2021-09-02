Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1ABA3FE8A7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 07:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhIBFEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 01:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhIBFEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 01:04:14 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FFFC061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 22:03:16 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id a1so542205ilj.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 22:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=03DUozIjnGa1/TSc9TP5KtjMwxy2FvrFi5tMBcRbf9c=;
        b=CdvHnb1hrFoKsSsoCnWFCJeNR3R7FrvJSe8f4gZQeQmYcFUP2RXAAKtishqRDzlNOh
         yfIsMrtmjwIBzlOlMbPaRqk3YeQZ3a8XLBojQV87W9NFsfCY7Ejx4ihOEaHW+8tAjNMu
         9CqkjsXA0CrcDSLW938q6gaB0HOA1ik1IK2lJgdZ3Ww8hbZgqbtckV5XrLfUwt6fOrNS
         3qNte2dcgUZpJdJmbMeynEg1GSB5eSd50gKdPl+8XB/kzwmhYuyAFLbFJaZ4pUD5lj3H
         y6dtoX1A5NpORf5fV3CauAhfhN5AaIVz3Wal/eLn0hIXHILz3uDHQm9uQVnhMaJoaFFq
         cAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=03DUozIjnGa1/TSc9TP5KtjMwxy2FvrFi5tMBcRbf9c=;
        b=UNKidyB0DachQiFxLChm2zwvrvVIxo/K/Et6JZTkZ7A9/J0mm673AI+sgk0LosSznN
         lE3iPqd9v2ViyIGKhHLD75eAo4Z58ABNSSC4Uz/P02+9uPz8FKgRaDo87TER+4RIJx3S
         RI0T78irBY4O8Wc6C4SS1lb1Aq3WnDoaLjPhqYT9ZLmn6Mn3tots3sQu6mQK1SoF5txj
         hAltv37FggTYUCpTwdov3M+1YsTz5iT60Ph6zwDDZOsQ/J6KkV2MpGflCpAJZC9ISa0f
         ByRGARplPRz9kR38TouUXbHjbltS48ZQGspDl5wh3hZoTZCMJdrec2/F7vStVjOvDgbf
         TGgg==
X-Gm-Message-State: AOAM531CyZrZB1iU1OCkHYiy7FyE9jdc3ywf7kCe/nceWR0MbvyoRwHV
        NqB0FdCT5EJcWKMH5kk43JKYZScTRoVsyw==
X-Google-Smtp-Source: ABdhPJw2d/ccfWVab0xI3ALkjqnuq550iCbTlCMK0eii/S/M1PL27tt+7xBIwVnCnE/tkN2Ejk5mdA==
X-Received: by 2002:a92:c20e:: with SMTP id j14mr935985ilo.83.1630558995775;
        Wed, 01 Sep 2021 22:03:15 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id p15sm392574ilc.12.2021.09.01.22.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 22:03:15 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 764AB27C0054;
        Thu,  2 Sep 2021 01:03:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 02 Sep 2021 01:03:14 -0400
X-ME-Sender: <xms:EFswYd08V230DBlc4hS8JU729O3AyaphHggtXeTWa080XGg3GQkk5g>
    <xme:EFswYUGUhfjBv3S2f3KF2v_LWolLv9Ag1pR-wWRZAhv6oVpXZTOFr0Bka1zP_z_3Q
    -f3b1_1ZwCg5-0meA>
X-ME-Received: <xmr:EFswYd7dXtVPkHHJ82ncTsOQ4JyXXqpKUJEHmC87PdYMoKYdPCJ9JKyEONM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvgedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:EFswYa1XRWaW2N5X2auuhMRBEjFLJOv8vLSMhn3Hfv2rlgDyjzF2HQ>
    <xmx:EFswYQGHC-6AlHZ6W0wmc5wdZooF7XsTXTOdEilsAR9VbrLyCCXSTg>
    <xmx:EFswYb_9BYrkNsCJrhfhHY_upGfoX7GT31CgK2T_67kJ4HfBxWSy-g>
    <xmx:EVswYT_-ovBVZuMrJ01iC4TsLsr0KcRh7o0LRnZDan5rkvSohpl_OPN0r3Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Sep 2021 01:03:11 -0400 (EDT)
Date:   Thu, 2 Sep 2021 13:02:01 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] locking: rwbase: Take care of ordering guarantee for
 fastpath reader
Message-ID: <YTBayYS1KPGlgl6c@boqun-archlinux>
References: <20210901150627.620830-1-boqun.feng@gmail.com>
 <20210901202242.2bzb6fbwyorfux3f@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901202242.2bzb6fbwyorfux3f@offworld>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 01:22:42PM -0700, Davidlohr Bueso wrote:
> On Wed, 01 Sep 2021, Boqun Feng wrote:
> > diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
> > index 4ba15088e640..a1886fd8bde6 100644
> > --- a/kernel/locking/rwbase_rt.c
> > +++ b/kernel/locking/rwbase_rt.c
> > @@ -41,6 +41,12 @@
> >  * The risk of writer starvation is there, but the pathological use cases
> >  * which trigger it are not necessarily the typical RT workloads.
> >  *
> > + * Fast-path orderings:
> > + * The lock/unlock of readers can run in fast paths: lock and unlock are only
> > + * atomic ops, and there is no inner lock to provide ACQUIRE and RELEASE
> > + * semantics of rwbase_rt. Atomic ops then should be stronger than _acquire()
> > + * and _release() to provide necessary ordering guarantee.
> 
> Perhaps the following instead?
> 

Thanks.

> + * Ordering guarantees: As with any locking primitive, (load)-ACQUIRE and
> + * (store)-RELEASE semantics are guaranteed for lock and unlock operations,
> + * respectively; such that nothing leaks out of the critical region. When
> + * writers are involved this is provided through the rtmutex. However, for
> + * reader fast-paths, the atomics provide at least such guarantees.
> 

However, this is a bit inaccurate, yes, writers always acquire the lock
(->readers) in the critical sections of ->wait_lock. But if readers run
the fast-paths, the atomics of the writers have to provide the ordering,
because we can rely on rtmutex orderings only if both sides run in
slow-paths.

> Also, I think you could remove most of the comments wrt _acquire or _release
> in the fastpath for each ->readers atomic op, unless it isn't obvious.
> 
> > + *
> >  * Common code shared between RT rw_semaphore and rwlock
> >  */
> > 
> > @@ -53,6 +59,7 @@ static __always_inline int rwbase_read_trylock(struct rwbase_rt *rwb)
> > 	 * set.
> > 	 */
> > 	for (r = atomic_read(&rwb->readers); r < 0;) {
> 
> Unrelated, but we probably wanna get rid of these abusing for-loops throughout.
> 

Agreed, let me see what I can do.

> > +		/* Fully-ordered if cmpxchg() succeeds, provides ACQUIRE */
> > 		if (likely(atomic_try_cmpxchg(&rwb->readers, &r, r + 1)))
> 
> As Waiman suggested, this can be _acquire() - albeit we're only missing
> an L->L for acquire semantics upon returning, per the control dependency
> already guaranteeing L->S. That way we would loop with _relaxed().
> 

_acquire() is fine, I think. But probably a separate patch. We should be
careful when relaxing the ordering, and perhaps, with some performance
numbers showing the benefits.

> > 			return 1;
> > 	}
> > @@ -162,6 +169,8 @@ static __always_inline void rwbase_read_unlock(struct rwbase_rt *rwb,
> > 	/*
> > 	 * rwb->readers can only hit 0 when a writer is waiting for the
> > 	 * active readers to leave the critical section.
> > +	 *
> > +	 * dec_and_test() is fully ordered, provides RELEASE.
> > 	 */
> > 	if (unlikely(atomic_dec_and_test(&rwb->readers)))
> > 		__rwbase_read_unlock(rwb, state);
> > @@ -172,7 +181,11 @@ static inline void __rwbase_write_unlock(struct rwbase_rt *rwb, int bias,
> > {
> > 	struct rt_mutex_base *rtm = &rwb->rtmutex;
> > 
> > -	atomic_add(READER_BIAS - bias, &rwb->readers);
> > +	/*
> > +	 * _release() is needed in case that reader is in fast path, pairing
> > +	 * with atomic_try_cmpxchg() in rwbase_read_trylock(), provides RELEASE
> > +	 */
> > +	(void)atomic_add_return_release(READER_BIAS - bias, &rwb->readers);
> 
> Hmmm while defined, there are no users atomic_add_return_release (yet?). I think

There is a usage of atomic_sub_return_release() in queued_spin_unlock()
;-)

> this is because the following is preferred when the return value is not really
> wanted, but only the Rmw ordering it provides:
> 
> +       smp_mb__before_atomic(); /* provide RELEASE semantics */
> 	atomic_add(READER_BIAS - bias, &rwb->readers);
> 	raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
> 	rwbase_rtmutex_unlock(rtm);
> 

smp_mb__before_atomic() + atomic will be a smp_mb() + atomic on weakly
ordered archs (e.g. ARM64 and PowerPC), while atomic_*_return_release()
will be a release atomic operation (e.g. ldxr/stxlr on ARM64), the
latter is considered more cheap.

Regards,
Boqun

> > 	raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
> > 	rwbase_rtmutex_unlock(rtm);
> > }
> 
> Thanks,
> Davidlohr
