Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F17E3A9904
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 13:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbhFPLXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 07:23:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229502AbhFPLXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 07:23:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9DB4C60FD9;
        Wed, 16 Jun 2021 11:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623842474;
        bh=YdjgUjBaT0kve1VcxN31dA7LhzfhUzdoudAHkw5AaqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HA9Ms00cnU8pXS7QUZCj+uoeHyHjhftHber6nYSPZH1UCO5+UuoFljikN2VfjyDne
         bmXYXWPnKqjKzobwz9whZ0MNgMncvOlHofInWZMSNFTBilwJP/I87NdnDhUDFGrdAj
         o3SI64rHJQUvjtu4QjlAWjEPG8bD9fzPPn+SZNFpp81AXY02+Y4c77TNSn3MBF+0C4
         o78jUVvR8nwBumdS/97TZEL1iPwtdnX8ZhPqxXoS7HV8oUx6+8kmIMmoikXznDG0v1
         e3D8JzpvmHYD6H+GFYAWJhVNx28lUPHxlng0sYs+oS5c/pAKxUPQ9OrTeOgrF8qsOS
         heI7L6JOs8srw==
Date:   Wed, 16 Jun 2021 13:21:11 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 4/6] posix-cpu-timers: Force next_expiration recalc after
 timer reset
Message-ID: <20210616112111.GB801071@lothringen>
References: <20210604113159.26177-1-frederic@kernel.org>
 <20210604113159.26177-5-frederic@kernel.org>
 <YMnDFQ9bvVPHu/kJ@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMnDFQ9bvVPHu/kJ@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 11:23:33AM +0200, Peter Zijlstra wrote:
> On Fri, Jun 04, 2021 at 01:31:57PM +0200, Frederic Weisbecker wrote:
> 
> > @@ -647,8 +651,6 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
> >  	if (unlikely(timer->it.cpu.firing)) {
> >  		timer->it.cpu.firing = -1;
> >  		ret = TIMER_RETRY;
> > -	} else {
> > -		cpu_timer_dequeue(ctmr);
> >  	}
> >  
> >  	/*
> > @@ -713,9 +715,13 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
> >  	 * For a timer with no notification action, we don't actually
> >  	 * arm the timer (we'll just fake it for timer_gettime).
> >  	 */
> > -	cpu_timer_setexpires(ctmr, new_expires);
> > -	if (new_expires != 0 && val < new_expires) {
> > -		arm_timer(timer, p);
> > +	if (new_expires != 0) {
> > +		cpu_timer_dequeue(ctmr);
> > +		cpu_timer_setexpires(ctmr, new_expires);
> > +		if (val < new_expires)
> > +			arm_timer(timer, p);
> > +	} else {
> > +		disarm_timer(timer, p);
> >  	}
> >  
> >  	unlock_task_sighand(p, &flags);
> 
> AFAICT there's an error path in between where you've removed
> cpu_timer_dequeue() and added it back. This error path will now leave
> the timer enqueued.

Ah that's the case where the timer is firing. In this case it can't be queued
anyway. Also it's a retry path so we'll eventually dequeue it in any case
(should it be concurrently requeued after firing).

Thanks.
