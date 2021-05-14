Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41CAB38124A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 23:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbhENVCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 17:02:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231476AbhENVBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 17:01:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 925CB613EB;
        Fri, 14 May 2021 21:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621026027;
        bh=EJSSCj8OOVI3N65uFjlEgbTTHDyMjowlET81oNMQdRU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=l7LqZu1JIys3LK0PBkqOenWYaEK3ySNAQurzGAG5Wy3QkoiqFqQA4DMT8AUsK9m+p
         MoTYmE1XutoMc46hqGR0LmieHX96F1noR7MkO4YRGFQBBk4jsl/tEDd+vCW4+Qamod
         5Mf/HUie27GOYbrJ/oSkOWzUh/WMrnlZ+nXOPsXBQubK0IZU5/BeV/CQ1Z/LIj3rev
         hGTRhn2jBeNF2bh9MnqD+e8B1FZViz7iR5Qrb1TM+VPiv1lXKZ8mctUcWc/DwqSCrv
         StpHOEDtPWdck+KE7TTnaAveaQFnGYfu5I+5V/Zyvfr6/U/0lr1PHG5yosbtMc+hZB
         yodPq6U+Mo83g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5C96E5C02A5; Fri, 14 May 2021 14:00:27 -0700 (PDT)
Date:   Fri, 14 May 2021 14:00:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>, 1vier1@web.de
Subject: Re: [PATCH] ipc/sem.c: use READ_ONCE()/WRITE_ONCE() for
 use_global_lock
Message-ID: <20210514210027.GP975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210514175319.12195-1-manfred@colorfullife.com>
 <20210514194407.GN975577@paulmck-ThinkPad-P17-Gen-1>
 <c3a1f1a3-8fc1-29b5-92e0-bf45e1cc438f@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3a1f1a3-8fc1-29b5-92e0-bf45e1cc438f@colorfullife.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 10:25:17PM +0200, Manfred Spraul wrote:
> Hi Paul,
> 
> On 5/14/21 9:44 PM, Paul E. McKenney wrote:
> > On Fri, May 14, 2021 at 07:53:19PM +0200, Manfred Spraul wrote:
> > > The patch solves two weaknesses in ipc/sem.c:
> > > 
> > > 1) The initial read of use_global_lock in sem_lock() is an
> > > intentional race. KCSAN detects these accesses and prints
> > > a warning.
> > > 
> > > 2) The code assumes that plain C read/writes are not
> > > mangled by the CPU or the compiler.
> > > 
> > > To solve both issues, use READ_ONCE()/WRITE_ONCE().
> > > Plain C reads are used in code that owns sma->sem_perm.lock.
> > > 
> > > Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
> > Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > One follow-up question: If I am reading the code correctly, there is
> > a call to complexmode_enter() from sysvipc_sem_proc_show() that does
> > not hold the global lock.  Does this mean that the first check of
> > ->use_global_lock in complexmode_enter() should be marked?
> 
> Now you made me nervous, usually I do not test the proc interface.
> According to the documentation in sysvipc_sem_proc_show(),
> sysvipc_find_ipc() acquires the global lock.

"It is a service that I provide."  ;-)

> >         /*
> >          * The proc interface isn't aware of sem_lock(), it calls
> >          * ipc_lock_object() directly (in sysvipc_find_ipc).
> >          * In order to stay compatible with sem_lock(), we must
> >          * enter / leave complex_mode.
> >          */
> I have just tested it again: Yes, this is still true.

OK, so the sequence of events is as follow?

o	sysvipc_proc_start() is invoked to start, as the name implies.

o	sysvipc_proc_start() invokes sysvipc_find_ipc(), which
	scans the IDs and invokes ipc_lock_object() on the one
	at pos.

o	ipc_lock_object() acquires the corresponding lock, which
	seems unlikely to be sem_perm.lock, though I freely admit
	that I do not know this code very well.

Ah, I see it now.  The kernel_ipc_perm that sysvipc_find_ipc is looking
at is the first member of the sem_array structure, and that member is
named sem_perm.

> Perhaps, as future improvement: The rest of ipc/sem.c speaks about
> "sem_perm.lock", and here we suddenly use a function name instead of the
> structure member name.
> 
> > "it calls ipc_lock_object() (i.e.: spin_lock(&sma->sem_perm.lock)).

As usual, it seems obvious once you know the trick.  ;-)

							Thanx, Paul

> > > ---
> > >   ipc/sem.c | 11 +++++++----
> > >   1 file changed, 7 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/ipc/sem.c b/ipc/sem.c
> > > index bf534c74293e..a0ad3a3edde2 100644
> > > --- a/ipc/sem.c
> > > +++ b/ipc/sem.c
> > > @@ -217,6 +217,8 @@ static int sysvipc_sem_proc_show(struct seq_file *s, void *it);
> > >    * this smp_load_acquire(), this is guaranteed because the smp_load_acquire()
> > >    * is inside a spin_lock() and after a write from 0 to non-zero a
> > >    * spin_lock()+spin_unlock() is done.
> > > + * To prevent the compiler/cpu temporarily writing 0 to use_global_lock,
> > > + * READ_ONCE()/WRITE_ONCE() is used.
> > >    *
> > >    * 2) queue.status: (SEM_BARRIER_2)
> > >    * Initialization is done while holding sem_lock(), so no further barrier is
> > > @@ -342,10 +344,10 @@ static void complexmode_enter(struct sem_array *sma)
> > >   		 * Nothing to do, just reset the
> > >   		 * counter until we return to simple mode.
> > >   		 */
> > > -		sma->use_global_lock = USE_GLOBAL_LOCK_HYSTERESIS;
> > > +		WRITE_ONCE(sma->use_global_lock, USE_GLOBAL_LOCK_HYSTERESIS);
> > >   		return;
> > >   	}
> > > -	sma->use_global_lock = USE_GLOBAL_LOCK_HYSTERESIS;
> > > +	WRITE_ONCE(sma->use_global_lock, USE_GLOBAL_LOCK_HYSTERESIS);
> > >   	for (i = 0; i < sma->sem_nsems; i++) {
> > >   		sem = &sma->sems[i];
> > > @@ -371,7 +373,8 @@ static void complexmode_tryleave(struct sem_array *sma)
> > >   		/* See SEM_BARRIER_1 for purpose/pairing */
> > >   		smp_store_release(&sma->use_global_lock, 0);
> > >   	} else {
> > > -		sma->use_global_lock--;
> > > +		WRITE_ONCE(sma->use_global_lock,
> > > +				sma->use_global_lock-1);
> > >   	}
> > >   }
> > > @@ -412,7 +415,7 @@ static inline int sem_lock(struct sem_array *sma, struct sembuf *sops,
> > >   	 * Initial check for use_global_lock. Just an optimization,
> > >   	 * no locking, no memory barrier.
> > >   	 */
> > > -	if (!sma->use_global_lock) {
> > > +	if (!READ_ONCE(sma->use_global_lock)) {
> > >   		/*
> > >   		 * It appears that no complex operation is around.
> > >   		 * Acquire the per-semaphore lock.
> > > -- 
> > > 2.31.1
> > > 
> 
