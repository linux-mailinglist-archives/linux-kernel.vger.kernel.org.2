Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF03400AC3
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 13:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350923AbhIDKOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 06:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbhIDKOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 06:14:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A67DC061575
        for <linux-kernel@vger.kernel.org>; Sat,  4 Sep 2021 03:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OB5HdZvx/nOS2cjp67kQaOB5vNQ3TrwUlY3m7+JM1Qc=; b=mOStzBo+5IeEd5K3eqHi+ZOFAO
        Q56Dg3nnIXmpgAhKWiKjUo89lCK6ArGEO+xdPsE1yntt/19UgNcEBw1FY/V4DuX26cCaJAfEn4LJs
        8LHIlfubaeDL948FdwCVihKTDf1IdQW7Bu0idzy+P0kbhOHOjtK12c8HwzrIqu3L+FxfFpqwkjbuM
        SMYFdgwoG2ioBbo+8JyaRWKB/HasoqneG2Cx7eAJmHOgad95219cA7xOaXiRl6TfeRUvdwJGdz2ma
        TszZ1WAJrNKU48138K8Y0/N799JwPRf3yH7D5v8uFhStTnMpgZD2kqH4a7TkCLvpXG1/WcduMHJf5
        p4mG0LGg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mMSer-005E9e-Jw; Sat, 04 Sep 2021 10:12:25 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A811B986283; Sat,  4 Sep 2021 12:12:19 +0200 (CEST)
Date:   Sat, 4 Sep 2021 12:12:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>
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
Message-ID: <20210904101219.GA4323@worktop.programming.kicks-ass.net>
References: <20210901150627.620830-1-boqun.feng@gmail.com>
 <YTC7sariSyBW48nh@hirez.programming.kicks-ass.net>
 <YTI2UjKy+C7LeIf+@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTI2UjKy+C7LeIf+@boqun-archlinux>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2021 at 10:50:58PM +0800, Boqun Feng wrote:
> On Thu, Sep 02, 2021 at 01:55:29PM +0200, Peter Zijlstra wrote:
> [...]
> > >  	raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
> > >  	rwbase_rtmutex_unlock(rtm);
> > >  }
> > > @@ -216,8 +229,14 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
> > >  	 */
> > >  	rwbase_set_and_save_current_state(state);
> > >  
> > > -	/* Block until all readers have left the critical section. */
> > > -	for (; atomic_read(&rwb->readers);) {
> > > +	/*
> > > +	 * Block until all readers have left the critical section.
> > > +	 *
> > > +	 * _acqurie() is needed in case that the reader side runs in the fast
> > > +	 * path, pairing with the atomic_dec_and_test() in rwbase_read_unlock(),
> > > +	 * provides ACQUIRE.
> > > +	 */
> > > +	for (; atomic_read_acquire(&rwb->readers);) {
> > >  		/* Optimized out for rwlocks */
> > >  		if (rwbase_signal_pending_state(state, current)) {
> > >  			__set_current_state(TASK_RUNNING);
> > 
> > I think we can restructure things to avoid this one, but yes. Suppose we
> > do:
> > 
> > 	readers = atomic_sub_return_relaxed(READER_BIAS, &rwb->readers);
> > 
> > 	/*
> > 	 * These two provide either an smp_mb() or an UNLOCK+LOCK
> 
> By "UNLOCK+LOCK", you mean unlock(->pi_lock) + lock(->wait_lock), right?
> This may be unrelated, but in our memory model only unlock+lock pairs on
> the same lock provide TSO-like ordering ;-) IOW, unlock(->pi_lock) +
> lock(->wait_lock) on the same CPU doesn't order reads before and after.

Hurpm.. what actual hardware does that? PPC uses LWSYNC for
ACQUIRE/RELEASE, and ARM64 has RCsc RELEASE+ACQUIRE ordering.

Both should provide RC-TSO (or stronger) for UNLOCK-A + LOCK-B.
