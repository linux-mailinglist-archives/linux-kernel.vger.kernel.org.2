Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB663F1FC7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 20:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbhHSSTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 14:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhHSSTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 14:19:03 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73E2C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 11:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8tzDI9cxc/sCidFQ4eZc8A4YJSYpA9x2E49ZxMz67q0=; b=nu1Y+IYvq7qTfrrLpM+tISXoWD
        DoSorChPG7GvFYTx0Pclh71Q3BLsT0uCP2B1qWqCiUXH95s3AIubKHkFzlBRcy6f96n0XS8MSipHQ
        dJF8h4RX7QKyPNJl6SFLxo2NqCO0SbRUiqFgJi0IqdwinRsSYbSfAOf2vbwr8JVFa/saAuJ51kDBK
        k+zzI4tuwJ9ry8zTzg8LeiB05es39r3x5tDWXVg92BBY60l0XJjXTDLlWYndqbiHsi23aeUcz0Kj5
        414d3Dil0gRegWaNCae+prjJLQNkYZjYcynzdkI8byMzoFQJ88nessCqSq1vNXR9oa2e+4nHnQ4HD
        tjqPwx9w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGmbz-00BAjG-D2; Thu, 19 Aug 2021 18:17:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1AD1C300103;
        Thu, 19 Aug 2021 20:17:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EFE0C2D186D21; Thu, 19 Aug 2021 20:17:53 +0200 (CEST)
Date:   Thu, 19 Aug 2021 20:17:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Mike Galbraith <efault@gmx.de>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [patch V5 41/72] locking/ww_mutex: Gather mutex_waiter
 initialization
Message-ID: <YR6gUaz2QMeNkPXp@hirez.programming.kicks-ass.net>
References: <20210815203225.710392609@linutronix.de>
 <20210815211304.281927514@linutronix.de>
 <20210819175110.w7lxq5w3gdj5vhwf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819175110.w7lxq5w3gdj5vhwf@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 07:51:10PM +0200, Sebastian Andrzej Siewior wrote:
> On 2021-08-15 23:28:39 [+0200], Thomas Gleixner wrote:
> > --- a/kernel/locking/mutex-debug.c
> > +++ b/kernel/locking/mutex-debug.c
> > @@ -30,6 +30,7 @@ void debug_mutex_lock_common(struct mute
> >  	memset(waiter, MUTEX_DEBUG_INIT, sizeof(*waiter));
> >  	waiter->magic = waiter;
> >  	INIT_LIST_HEAD(&waiter->list);
> > +	waiter->ww_ctx = MUTEX_POISON_WW_CTX;
> >  }
> >  
> >  void debug_mutex_wake_waiter(struct mutex *lock, struct mutex_waiter *waiter)
> > --- a/kernel/locking/mutex.c
> > +++ b/kernel/locking/mutex.c
> > @@ -980,17 +980,15 @@ static __always_inline int __sched
> >  	}
> >  
> >  	debug_mutex_lock_common(lock, &waiter);
> > +	waiter.task = current;
> > +	if (ww_ctx)
> > +		waiter.ww_ctx = ww_ctx;
> >  
> >  	lock_contended(&lock->dep_map, ip);
> >  
> >  	if (!use_ww_ctx) {
> >  		/* add waiting tasks to the end of the waitqueue (FIFO): */
> >  		__mutex_add_waiter(lock, &waiter, &lock->wait_list);
> > -
> > -
> > -#ifdef CONFIG_DEBUG_MUTEXES
> > -		waiter.ww_ctx = MUTEX_POISON_WW_CTX;
> > -#endif
> 
> The crash, Guenter Roeck reported, is because now waiter.ww_ctx is
> always initialized to poisen.
> Previously in the ww-mutex case without a context it was set to NULL
> in the next hunk.
> Keeping the ww_ctx assigment in the next hunk seems to work.

You mean the 'use_ww_ctx && !ww_ctx' case?

Would not the below also help with that?

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 3a65bf4bacfd..d456579d0952 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -618,7 +618,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 
 	debug_mutex_lock_common(lock, &waiter);
 	waiter.task = current;
-	if (ww_ctx)
+	if (use_ww_ctx)
 		waiter.ww_ctx = ww_ctx;
 
 	lock_contended(&lock->dep_map, ip);
