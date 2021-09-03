Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA86340018A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 16:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349476AbhICOxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 10:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbhICOxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 10:53:16 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8D0C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 07:52:16 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id y18so7089557ioc.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 07:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3udFRxofKZfXAVfj0Vy1bL0zZn5CBEQ0+qj9/ataYlc=;
        b=QdozeIshGA7sxkdc/vcTuNDjWfebXr7Ir8rVLiuOelk9XRqXTCImRMf6zf1U5QBa57
         a6SM0UsM9nLsHCHoMdnDSdw05/Vs78HxTxqI6zFLn2rU+2WNwV7C628ybB/CXnQowtkG
         kyD0wGydATFcGqXqMAqdX3t3KgUgKnhKimrdOr86DNBz1k+agA1S4HqO0stgZRLn09vq
         ayTvBEVobghURDLw9t+s+BE+reEciBHbw55G/1TSmBItz8+LVjg4pPmTzArDSBzQIl7i
         8XmScioM7PwcWrhMA2TdsKkdvZ7wynv0wSsjTRAY62WNHHu1uuekSdlNBXXDPVj2JUb+
         UV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3udFRxofKZfXAVfj0Vy1bL0zZn5CBEQ0+qj9/ataYlc=;
        b=UgxTKC9p87IdEmpK4WZdLUdnRU8IFrf5DegfIFBPDRkqLO0dTfnxnHFHHR2VgeHc/4
         DDWhCASD1a+xjwp3gnjzRzQPenEFO8YNHRU70k8VmMTCl3O1xvpJNNJPgUobuDDck76F
         abdkx43PX/9V7oIyS9eFT8V0zUvgbjPnD/QYdIkEiptQnsWktbtwRgYXSJ5vz7KV0kXn
         PA3xUFFvNjr0L5odVIVncWEo7fqs9wX6K6x+My58Svji8n2kyDHxZZIVrgtNivMk8JY7
         nS8ZsnFtZFo5n1l912AxDykdoQpHwvBEpg3tvf04oHgpjMku0O8pgqGvAHombSHp+PYX
         t1YQ==
X-Gm-Message-State: AOAM533BfcROjDIOTOSN5heCIkA5rYZRWOvx5tqvZOOf7KPqQ+tqdHrU
        rQ13SVCrwRGZrP+8EDmodxp7TtmcRRRNNZNS
X-Google-Smtp-Source: ABdhPJweV7aCvvTRLSu7V1VkaEYo6ab61z57EeSFq0bNlbPJMJGsYdDIdJm2ELrC3jPrsQHNjMgtOQ==
X-Received: by 2002:a05:6638:cd:: with SMTP id w13mr3026234jao.42.1630680735548;
        Fri, 03 Sep 2021 07:52:15 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id i6sm2665858ilb.30.2021.09.03.07.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 07:52:15 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id 3DE1E27C005C;
        Fri,  3 Sep 2021 10:52:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 03 Sep 2021 10:52:14 -0400
X-ME-Sender: <xms:nTYyYfEEexTj3DCDsB8mEucPm0tjXqgYPnFSzNRoE8tluSc8ZKZ9hQ>
    <xme:nTYyYcW88xKWTDzGsfe-Aqm-llMh7vDJKafQiVDkMo1SR9t0ZXDkx3QHKUYpEiTmU
    areehj16ao7bOUP9A>
X-ME-Received: <xmr:nTYyYRK2XODtOq682YEHyZ2D31jaEshg542sUtvBiyCm_w1luTEV5dLHJOU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvjedgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:nTYyYdEdiYwnAG_kCVtEsE_4iw-qmX8MlfQZ06bxTw7529QnIV-FXA>
    <xmx:nTYyYVU8G_67mQUIuzQcx98ZvyAFX4r4QNK3ukD02pqz4GkmfSGvLQ>
    <xmx:nTYyYYOqD3-Xqgbp3ss5lh1de54JJtgWyG5yy1RbZhpDSAFDYRED8g>
    <xmx:njYyYQNkQQTjwQf6JwRhhBXjJyILpOb4usDpNXqZq85PtFdkBgnvHopcxaw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Sep 2021 10:52:13 -0400 (EDT)
Date:   Fri, 3 Sep 2021 22:50:58 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] locking: rwbase: Take care of ordering guarantee for
 fastpath reader
Message-ID: <YTI2UjKy+C7LeIf+@boqun-archlinux>
References: <20210901150627.620830-1-boqun.feng@gmail.com>
 <YTC7sariSyBW48nh@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTC7sariSyBW48nh@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 01:55:29PM +0200, Peter Zijlstra wrote:
[...]
> >  	raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
> >  	rwbase_rtmutex_unlock(rtm);
> >  }
> > @@ -216,8 +229,14 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
> >  	 */
> >  	rwbase_set_and_save_current_state(state);
> >  
> > -	/* Block until all readers have left the critical section. */
> > -	for (; atomic_read(&rwb->readers);) {
> > +	/*
> > +	 * Block until all readers have left the critical section.
> > +	 *
> > +	 * _acqurie() is needed in case that the reader side runs in the fast
> > +	 * path, pairing with the atomic_dec_and_test() in rwbase_read_unlock(),
> > +	 * provides ACQUIRE.
> > +	 */
> > +	for (; atomic_read_acquire(&rwb->readers);) {
> >  		/* Optimized out for rwlocks */
> >  		if (rwbase_signal_pending_state(state, current)) {
> >  			__set_current_state(TASK_RUNNING);
> 
> I think we can restructure things to avoid this one, but yes. Suppose we
> do:
> 
> 	readers = atomic_sub_return_relaxed(READER_BIAS, &rwb->readers);
> 
> 	/*
> 	 * These two provide either an smp_mb() or an UNLOCK+LOCK

By "UNLOCK+LOCK", you mean unlock(->pi_lock) + lock(->wait_lock), right?
This may be unrelated, but in our memory model only unlock+lock pairs on
the same lock provide TSO-like ordering ;-) IOW, unlock(->pi_lock) +
lock(->wait_lock) on the same CPU doesn't order reads before and after.
Consider the following litmus:


	C unlock-lock
	{
	}

	P0(spinlock_t *s, spinlock_t *p, int *x, int *y)
	{
		int r1;
		int r2;

		spin_lock(s);
		r1 = READ_ONCE(*x);
		spin_unlock(s);
		spin_lock(p);
		r2 = READ_ONCE(*y);
		spin_unlock(p);
	}

	P1(int *x, int *y)
	{
		WRITE_ONCE(*y, 1);
		smp_wmb();
		WRITE_ONCE(*x, 1);
	}

	exists (0:r1=1 /\ 0:r2=0)

herd result:

	Test unlock-lock Allowed
	States 4
	0:r1=0; 0:r2=0;
	0:r1=0; 0:r2=1;
	0:r1=1; 0:r2=0;
	0:r1=1; 0:r2=1;
	Ok
	Witnesses
	Positive: 1 Negative: 3
	Condition exists (0:r1=1 /\ 0:r2=0)
	Observation unlock-lock Sometimes 1 3
	Time unlock-lock 0.01
	Hash=a8b772fd25f963f73a0d8e70e36ee255


> 	 * ordering, either is strong enough to provide ACQUIRE order
> 	 * for the above load of @readers.
> 	 */
> 	rwbase_set_and_save_current_state(state);
> 	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
> 
> 	while (readers) {
> 		...
> 		readers = atomic_read(&rwb->readers);

The above should be _acquire(), right? Pairs with the last reader
exiting the critical section and dec ->readers to 0. If so, it
undermines the necessity of the restructure?

Regards,
Boqun

> 		if (readers)
> 			rwbase_schedule();
> 		...
> 	}
> 
> 
> > @@ -229,6 +248,9 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
> >  		/*
> >  		 * Schedule and wait for the readers to leave the critical
> >  		 * section. The last reader leaving it wakes the waiter.
> > +		 *
> > +		 * _acquire() is not needed, because we can rely on the smp_mb()
> > +		 * in set_current_state() to provide ACQUIRE.
> >  		 */
> >  		if (atomic_read(&rwb->readers) != 0)
> >  			rwbase_schedule();
> > @@ -253,7 +275,11 @@ static inline int rwbase_write_trylock(struct rwbase_rt *rwb)
> >  	atomic_sub(READER_BIAS, &rwb->readers);
> >  
> >  	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
> > -	if (!atomic_read(&rwb->readers)) {
> > +	/*
> > +	 * _acquire() is needed in case reader is in the fast path, pairing with
> > +	 * rwbase_read_unlock(), provides ACQUIRE.
> > +	 */
> > +	if (!atomic_read_acquire(&rwb->readers)) {
> 
> Moo; the alternative is using dec_and_lock instead of dec_and_test, but
> that's not going to be worth it.
> 
> >  		atomic_set(&rwb->readers, WRITER_BIAS);
> >  		raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
> >  		return 1;
> > -- 
> > 2.32.0
> > 
