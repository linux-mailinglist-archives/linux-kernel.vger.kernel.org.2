Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928DA407B6F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 06:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhILEAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 00:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhILEAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 00:00:18 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5DCC061574
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 20:59:05 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id m11so7605397ioo.6
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 20:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HhLg5DITdMaoXGUKwt3y/aLN8E5bLmiGQtimHz9p9Ro=;
        b=k+WexDFwFNZ3aYJO7L4G8uJ9XHOMfxt6XUwgXRdf9NN4LiM+2RKlv4Wjy6vhqQ2UGC
         GcisGwKhk1QRlwwUkeF5ZS70szYZAl5V61aEAXP3Y1CF7kqsTsIPEeZR5Ukp86/DYS8R
         adqYcovxdF+R3PFrJdGkP0RyT46Cpngu5hp9c6/iy21Hg3AvPMiARpWMTiTSaUgo3wHE
         0iq50of0XdDtZfykYnbe1VbS/Xn/QkUBrFC6b/7CDEWNIaX1PZgDjvfwQPxxCbBhpOKu
         8iMvtYkAXv+9yTFWviOaM6TxzGybvpURxWyM1rmVkyl98D6UOKcjAjdp/W5hl3LJIO0u
         iRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HhLg5DITdMaoXGUKwt3y/aLN8E5bLmiGQtimHz9p9Ro=;
        b=7xx0wgPSeTYv3odZFayRajKIzZF5GihmlsAhT1BmelAQQf4uD9NIYK8k2IiCuKGuoS
         H4fEUMiVtF5kLLZXrqie0BxMx3zLH1E/3zl8ebd1H4XgfpivubjAtpk06JZqUTB2QUTo
         rU6J3pKS3ussus4hkz2/2t7iOJjNm+URLMl/E575iitPwMXlI3n6fdN5e6EpIOijl/Tq
         tsLGgrJp1KGe7asksvvv5e+7jaMRXn3EZuL3/wKR2zm3df3l3HpgiDRaMqMVr+K5X6In
         nUr/R4xtYPrjQifda4QAVGD/+c43/l1SQY4YGWMmgarmZRQw0pnjzx1u5n2157UYa1M0
         bezQ==
X-Gm-Message-State: AOAM531dCxpkwvfXCUzuO3f3oL9UXkjpbMo5k+68X8iISxLsGxZ0vQwM
        RWsqy9/2F19ujEFIfgvRl6S1GydR21DdrA==
X-Google-Smtp-Source: ABdhPJyYbKz6UXDpuYZ0HcIkHqmvc6UNKsZ+wyFnmMukIMnhem4b0L+kIwxunwIqQb7eyZ62UKplDQ==
X-Received: by 2002:a6b:14f:: with SMTP id 76mr3962238iob.211.1631419144036;
        Sat, 11 Sep 2021 20:59:04 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id 12sm2106076ilq.37.2021.09.11.20.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 20:59:03 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id ABB9A27C0054;
        Sat, 11 Sep 2021 23:59:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 11 Sep 2021 23:59:02 -0400
X-ME-Sender: <xms:BXs9YTbsxrelFjpQyALQ7xLmU9jMShgfOcEV8syCGJ239Be9gIu4Tw>
    <xme:BXs9YSYzqdXPCK4a99PST2dgyzjDwL58bfu3MVNxx03YEoow9GGeng84h5GjCU84v
    Oh8Y80vMdkKwbgL5w>
X-ME-Received: <xmr:BXs9YV9DZw_UW7cY8cxaDm2wchgR5EXbPhkqPwKt7xMZdf5sileqpzrqJVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeggedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:BXs9YZp19hc_u_rDXvzGq7DVeYGIy-FswyHawXdFoYGxpnLw2VM4oA>
    <xmx:BXs9Yeoy1NPwM_pPILUxpa3JMX8fLY4y3X9TJ4COgNOGFo-pF2lG2w>
    <xmx:BXs9YfSFtjNHo2QKgPoUjJCULm7zy3mIO7n_PEL2FfHxrtl2vTes5g>
    <xmx:Bns9YbT9if8l3i3hR6MvvmXX0NgLDOgt11o3-19oW1EuWhGXdPPgKTbyMl8>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Sep 2021 23:59:00 -0400 (EDT)
Date:   Sun, 12 Sep 2021 11:57:22 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 1/4] sched/wakeup: Strengthen
 current_save_and_set_rtlock_wait_state()
Message-ID: <YT16ognizWI6xROs@boqun-archlinux>
References: <20210909105915.757320973@infradead.org>
 <20210909110203.767330253@infradead.org>
 <20210909134524.GB9722@willie-the-truck>
 <YToZ4h/nfsrD3JfY@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YToZ4h/nfsrD3JfY@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 04:27:46PM +0200, Peter Zijlstra wrote:
> On Thu, Sep 09, 2021 at 02:45:24PM +0100, Will Deacon wrote:
> > On Thu, Sep 09, 2021 at 12:59:16PM +0200, Peter Zijlstra wrote:
> > > While looking at current_save_and_set_rtlock_wait_state() I'm thinking
> > > it really ought to use smp_store_mb(), because something like:
> > > 
> > > 	current_save_and_set_rtlock_wait_state();
> > > 	for (;;) {
> > > 		if (try_lock())
> > > 			break;
> > > 
> > > 		raw_spin_unlock_irq(&lock->wait_lock);
> > > 		schedule();
> > > 		raw_spin_lock_irq(&lock->wait_lock);
> > > 
> > > 		set_current_state(TASK_RTLOCK_WAIT);
> > > 	}
> > > 	current_restore_rtlock_saved_state();
> > > 
> > > which is the advertised usage in the comment, is actually broken,
> > > since trylock() will only need a load-acquire in general and that
> > > could be re-ordered against the state store, which could lead to a
> > > missed wakeup -> BAD (tm).
> > 
> > Why doesn't the UNLOCK of pi_lock in current_save_and_set_rtlock_wait_state()
> > order the state change before the successful try_lock? I'm just struggling
> > to envisage how this actually goes wrong.
> 
> Moo yes, so the earlier changelog I wrote was something like:
> 
> 	current_save_and_set_rtlock_wait_state();
> 	for (;;) {
> 		if (try_lock())
> 			break;
> 
> 		raw_spin_unlock_irq(&lock->wait_lock);
> 		if (!cond)
> 			schedule();
> 		raw_spin_lock_irq(&lock->wait_lock);
> 
> 		set_current_state(TASK_RTLOCK_WAIT);
> 	}
> 	current_restore_rtlock_saved_state();
> 
> which is more what the code looks like before these patches, and in that
> case the @cond load can be lifted before __state.
> 
> It all sorta works in the current application because most things are
> serialized by ->wait_lock, but given the 'normal' wait pattern I got
> highly suspicious of there not being a full barrier around.

Hmm.. I think ->pi_lock actually protects us here. IIUC, a mising
wake-up would happen if try_to_wake_up() failed to observe the __state
change by the about-to-wait task, and the about-to-wait task didn't
observe the condition set by the waker task, for example:

	TASK 0				TASK 1
	======				======
					cond = 1;
					...
					try_to_wake_up(t0, TASK_RTLOCK_WAIT, ..):
					  ttwu_state_match(...)
					    if (t0->__state & TASK_RTLOCK_WAIT) // false
					      ..
					    return false; // don't wake up
	...
	current->__state = TASK_RTLOCK_WAIT
	...
	if (!cond) // !cond is true because of memory reordering
	  schedule(); // sleep, and may not be waken up again.

But let's add ->pi_lock critical sections into the example:

	TASK 0				TASK 1
	======				======
					cond = 1;
					...
					try_to_wake_up(t0, TASK_RTLOCK_WAIT, ..):
					  raw_spin_lock_irqsave(->pi_lock,...);
					  ttwu_state_match(...)
					    if (t0->__state & TASK_RTLOCK_WAIT) // false
					      ..
					    return false; // don't wake up
					  raw_spin_unlock_irqrestore(->pi_lock,...); // A
	...
	raw_spin_lock_irqsave(->pi_lock, ...); // B
	current->__state = TASK_RTLOCK_WAIT
	raw_spin_unlock_irqrestore(->pi_lock, ...);
	if (!cond)
	  schedule();

Now the read of cond on TASK0 must observe the store of cond on TASK1,
because accesses to __state is serialized by ->pi_lock, so if TASK1's
read to __state didn't observe the write of TASK0 to __state, then the
lock B must read from the unlock A (or another unlock co-after A),
then we have a release-acquire pair to guarantee that the read of cond
on TASK0 sees the write of cond on TASK1. Simplify this by a litmus
test below:

	C unlock-lock
	{
	}

	P0(spinlock_t *s, int *cond, int *state)
	{
		int r1;

		spin_lock(s);
		WRITE_ONCE(*state, 1);
		spin_unlock(s);
		r1 = READ_ONCE(*cond);
	}

	P1(spinlock_t *s, int *cond, int *state)
	{
		int r1;

		WRITE_ONCE(*cond, 1);
		spin_lock(s);
		r1 = READ_ONCE(*state);
		spin_unlock(s);
	}

	exists (0:r1=0 /\ 1:r1=0)

and result is:

	Test unlock-lock Allowed
	States 3
	0:r1=0; 1:r1=1;
	0:r1=1; 1:r1=0;
	0:r1=1; 1:r1=1;
	No
	Witnesses
	Positive: 0 Negative: 3
	Condition exists (0:r1=0 /\ 1:r1=0)
	Observation unlock-lock Never 0 3
	Time unlock-lock 0.01
	Hash=e1f914505f07e380405f65d3b0fb6940

In short, since we write to the __state with ->pi_lock held, I don't
think we need to smp_store_mb() for __state. But maybe I'm missing
something subtle here ;-)

Regards,
Boqun
