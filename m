Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0583A9958
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 13:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbhFPLgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 07:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhFPLgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 07:36:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC1CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 04:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6nQMGL+1XCqXkxLtKh5enV71s7Z+HdE0jcbVftcBRPk=; b=UWkGlgfc4CIKH/xEhpmwBNak3x
        mCulX6N4bNrSYdp6Vec7Bf0db8Sk15TP8F+zGWTMbGdoiUEUaANy2m2zEilPZWjhPhXZDuMREkm6/
        8aMqJouenvH2kITG6ec7c0AKMuDYs6pihIUb/WfoYi0awRoA5PhFl9E//2eBzdIJFTgu/wJ/u+V4H
        P26GGQ5aCMdRUhz9rIlCwASoBj6AKjyvEM5IX/YxLTTrJxTEOSTow/dhhtoQaqYku0sQLEPb/P8el
        vpkq3g1m9fjbxJAlhqEpagzyCEgmpCqCFPO1VW9mJpnrWsL400goQ6LoxASn58WXXfquDhuUbDX7x
        S9TGq1bQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltTnj-007ywL-9M; Wed, 16 Jun 2021 11:33:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E16A9300204;
        Wed, 16 Jun 2021 13:33:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C616B20C169EA; Wed, 16 Jun 2021 13:33:42 +0200 (CEST)
Date:   Wed, 16 Jun 2021 13:33:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 4/6] posix-cpu-timers: Force next_expiration recalc after
 timer reset
Message-ID: <YMnhllR8fatx1MRD@hirez.programming.kicks-ass.net>
References: <20210604113159.26177-1-frederic@kernel.org>
 <20210604113159.26177-5-frederic@kernel.org>
 <YMnDFQ9bvVPHu/kJ@hirez.programming.kicks-ass.net>
 <20210616112111.GB801071@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616112111.GB801071@lothringen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 01:21:11PM +0200, Frederic Weisbecker wrote:
> On Wed, Jun 16, 2021 at 11:23:33AM +0200, Peter Zijlstra wrote:
> > On Fri, Jun 04, 2021 at 01:31:57PM +0200, Frederic Weisbecker wrote:
> > 
> > > @@ -647,8 +651,6 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
> > >  	if (unlikely(timer->it.cpu.firing)) {
> > >  		timer->it.cpu.firing = -1;
> > >  		ret = TIMER_RETRY;
> > > -	} else {
> > > -		cpu_timer_dequeue(ctmr);
> > >  	}
> > >  
> > >  	/*
> > > @@ -713,9 +715,13 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
> > >  	 * For a timer with no notification action, we don't actually
> > >  	 * arm the timer (we'll just fake it for timer_gettime).
> > >  	 */
> > > -	cpu_timer_setexpires(ctmr, new_expires);
> > > -	if (new_expires != 0 && val < new_expires) {
> > > -		arm_timer(timer, p);
> > > +	if (new_expires != 0) {
> > > +		cpu_timer_dequeue(ctmr);
> > > +		cpu_timer_setexpires(ctmr, new_expires);
> > > +		if (val < new_expires)
> > > +			arm_timer(timer, p);
> > > +	} else {
> > > +		disarm_timer(timer, p);
> > >  	}
> > >  
> > >  	unlock_task_sighand(p, &flags);
> > 
> > AFAICT there's an error path in between where you've removed
> > cpu_timer_dequeue() and added it back. This error path will now leave
> > the timer enqueued.
> 
> Ah that's the case where the timer is firing. In this case it can't be queued
> anyway. Also it's a retry path so we'll eventually dequeue it in any case
> (should it be concurrently requeued after firing).

Urgh, I see.. this code is a maze :-(
