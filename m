Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43D737FDC1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 21:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbhEMTDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 15:03:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232006AbhEMTDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 15:03:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0614E61177;
        Thu, 13 May 2021 19:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620932522;
        bh=9guKlJigLYp8p4HCEIDQk0OVbR3mviGu5v3NaidJa1Q=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=jrrQTre9rYtC27ESJTnknT/gJeG6Hh1fJaFSHy8noAzCITwu7dF0UefSJCtgELHgH
         fEYmHCV3E4RweM3REQO2pcztVmA+bs9Rebu5deEoCQTzXSdsl08cuP6o21IZYQmoE0
         XQTYAT0sYgD+1GAgHtOMqdtuSJq5ly9grTvjEW9oA0xn0erA2Dn7G9XD6io/laiHRE
         qXNcwiGie0vYVgUmhUT+eUG34rDTlWf31z6QOxsr7b4eszYly0/orP57y2DLAM0j+B
         UCVqzUHQCFH4V+i/TBHf1xUWGWYTdMjr+A3eYK1PBbdP9Y7AOCIJNrVOSXxhrfULCU
         Qk1pHLaRTFhdQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C42415C036A; Thu, 13 May 2021 12:02:01 -0700 (PDT)
Date:   Thu, 13 May 2021 12:02:01 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     kasan-dev <kasan-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>, 1vier1@web.de
Subject: Re: ipc/sem, ipc/msg, ipc/mqueue.c kcsan questions
Message-ID: <20210513190201.GE975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <a9b36c77-dc42-4ab2-9740-f27b191dd403@colorfullife.com>
 <20210512201743.GW975577@paulmck-ThinkPad-P17-Gen-1>
 <343390da-2307-442e-8073-d1e779c85eeb@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <343390da-2307-442e-8073-d1e779c85eeb@colorfullife.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 08:10:51AM +0200, Manfred Spraul wrote:
> Hi Paul,
> 
> On 5/12/21 10:17 PM, Paul E. McKenney wrote:
> > On Wed, May 12, 2021 at 09:58:18PM +0200, Manfred Spraul wrote:
> > > [...]
> > > sma->use_global_lock is evaluated in sem_lock() twice:
> > > 
> > > >         /*
> > > >           * Initial check for use_global_lock. Just an optimization,
> > > >           * no locking, no memory barrier.
> > > >           */
> > > >          if (!sma->use_global_lock) {
> > > Both sides of the if-clause handle possible data races.
> > > 
> > > Is
> > > 
> > >      if (!data_race(sma->use_global_lock)) {
> > > 
> > > the correct thing to suppress the warning?
> > Most likely READ_ONCE() rather than data_race(), but please see
> > the end of this message.
> 
> Based on the document, I would say data_race() is sufficient:
> 
> I have replaced the code with "if (jiffies %2)", and it runs fine.

OK, but please note that "jiffies" is marked volatile, which prevents the
compiler from fusing loads.  You just happen to be OK in this particular
case, as described below.  Use of the "jiffies_64" non-volatile synonym
for "jiffies" is better for this sort of checking.  But even so, just
because a particular version of a particular compiler refrains from
fusing loads in a particular situation does not mean that all future
versions of all future compilers will behave so nicely.

Again, you are OK in this particular situation, as described below.

> Thus I don't see which evil things a compiler could do, ... .

Fair enough, and your example is covered by the section "Reads Feeding
Into Error-Tolerant Heuristics".  The worst that the compiler can do is
to force an unnecessary acquisition of the global lock.

This cannot cause incorrect execution, but could results in poor
scalability.  This could be a problem is load fusing were possible, that
is, if successes calls to this function were inlined and the compiler
just reused the value initially loaded.

The reason that load fusing cannot happen in this case is that the
load is immediately followed by a lock acquisition, which implies a
barrier(), which prevents the compiler from fusing loads on opposite
sides of that barrier().

> [...]
> 
> Does tools/memory-model/Documentation/access-marking.txt, shown below,
> > help?
> > 
> [...]
> > 	int foo;
> > 	DEFINE_RWLOCK(foo_rwlock);
> > 
> > 	void update_foo(int newval)
> > 	{
> > 		write_lock(&foo_rwlock);
> > 		foo = newval;
> > 		do_something(newval);
> > 		write_unlock(&foo_rwlock);
> > 	}
> > 
> > 	int read_foo(void)
> > 	{
> > 		int ret;
> > 
> > 		read_lock(&foo_rwlock);
> > 		do_something_else();
> > 		ret = foo;
> > 		read_unlock(&foo_rwlock);
> > 		return ret;
> > 	}
> > 
> > 	int read_foo_diagnostic(void)
> > 	{
> > 		return data_race(foo);
> > 	}
> 
> The text didn't help, the example has helped:
> 
> It was not clear to me if I have to use data_race() both on the read and the
> write side, or only on one side.
> 
> Based on this example: plain C may be paired with data_race(), there is no
> need to mark both sides.

Actually, you just demonstrated that this example is quite misleading.
That data_race() works only because the read is for diagnostic
purposes.  I am queuing a commit with your Reported-by that makes
read_foo_diagnostic() just do a pr_info(), like this:

	void read_foo_diagnostic(void)
	{
		pr_info("Current value of foo: %d\n", data_race(foo));
	}

So thank you for that!

> Attached is a dummy change to ipc/sem.c, where I have added comments to
> every access.

Please see below.

> If data_race() is sufficient, then I think I have understood the rules, and
> I would recheck ipc/*.c and the netfilter code.
> 
> --
> 
>     Manfred
> 
> 

> diff --git a/ipc/sem.c b/ipc/sem.c
> index bf534c74293e..6026187f79f8 100644
> --- a/ipc/sem.c
> +++ b/ipc/sem.c
> @@ -87,6 +87,7 @@
>  #include <linux/sched/wake_q.h>
>  #include <linux/nospec.h>
>  #include <linux/rhashtable.h>
> +#include <linux/jiffies.h>
>  
>  #include <linux/uaccess.h>
>  #include "util.h"
> @@ -336,20 +337,43 @@ static void complexmode_enter(struct sem_array *sma)
>  	int i;
>  	struct sem *sem;
>  
> +	/* caller owns sem_perm.lock -> plain C access */
>  	if (sma->use_global_lock > 0)  {
>  		/*
>  		 * We are already in global lock mode.
>  		 * Nothing to do, just reset the
>  		 * counter until we return to simple mode.
>  		 */
> +		/* a change from a non-zero value to another
> +		 * non-zero value. Plain C is sufficient, as all
> +		 * readers either own sem_perm.lock or are using
> +		 * data_race() or smp_load_acquire().

This is OK, but only because all of the bits are confined to a byte.
If (say) 0x10000 and 0x0ffff were legal values, then store tearing could
result in a momentary zero when switching between them.  There has
been a claim that compilers should not tear stores, but there was
recently one that would do so when storing certain 32-bit constants.
And the standard does not prohibit tearing unmarked loads and stores,
even if all the value are confined to a single byte.  (But a compiler
that tore stores bit-at-a-time would be of questionable value on any of
the architectures that the Linux kernel support.)

> +		 */
>  		sma->use_global_lock = USE_GLOBAL_LOCK_HYSTERESIS;
>  		return;
>  	}
> +	/* Question: This pairs with the smp_load_acquire
> +	 * in sem_lock(), in a racy way:
> +	 * The reader in sem_lock() may see the new value
> +	 * immediately, ...
> +	 */
>  	sma->use_global_lock = USE_GLOBAL_LOCK_HYSTERESIS;

In my code, I would make this use WRITE_ONCE().  One fewer set of compiler
tricks to worry about.

>  	for (i = 0; i < sma->sem_nsems; i++) {
>  		sem = &sma->sems[i];
>  		spin_lock(&sem->lock);
> +		/* ..., or much later.
> +		 * But this is the latest possible time:
> +		 * sem_lock() owns one of the sem->lock locks
> +		 * when using smp_load_acquire(). Thus one of the
> +		 * spin_unlock()s in this loop is the _release for
> +		 * the plain C write above.
> +		 * My current understanding: Plain C is correct,
> +		 * as the reader is either using data_race() or
> +		 * smp_load_acquire(), or it is a trivial case
> +		 * of the reader owns sem_perm.lock - and we own
> +		 * that lock all the time.

Yes, once we release a given sem->lock, any future acquisitions of that
lock must see the new value of sma->use_global_lock.  If they get to
their sem->lock before we do, then the above spin_lock() acquisition
will wait for them.  This use of locks is an unusual form of RCU.  ;-)

(Grace-period latencies might be a bit long for actual RCU here.)

> +		 */
>  		spin_unlock(&sem->lock);
>  	}
>  }
> @@ -366,11 +390,21 @@ static void complexmode_tryleave(struct sem_array *sma)
>  		 */
>  		return;
>  	}
> +	/* sem_perm.lock owned, and all writes to sma->use_global_lock
> +	 * happen under that lock -> plain C

Other than the smp_store_release()?

> +	 */
>  	if (sma->use_global_lock == 1) {
>  
>  		/* See SEM_BARRIER_1 for purpose/pairing */
>  		smp_store_release(&sma->use_global_lock, 0);
>  	} else {
> +		/* the read side is maked -> plain C.

s/maked/marked/?

> +		 * Question: Old value 4, new value 3.
> +		 * If it might happen that the actual
> +		 * change is 4 -> 0 -> 3 (i.e. first:
> +		 * clear bit 2, then set bits 0&1, then
> +		 * this would break the algorithm.
> +		 * Is therefore WRITE_ONCE() required? */
>  		sma->use_global_lock--;

In my code, I would use WRITE_ONCE() here.

>  	}
>  }
> @@ -412,7 +446,20 @@ static inline int sem_lock(struct sem_array *sma, struct sembuf *sops,
>  	 * Initial check for use_global_lock. Just an optimization,
>  	 * no locking, no memory barrier.
>  	 */
> -	if (!sma->use_global_lock) {
> +#if 1
> +	/* the code works fine regardless of the returned value
> +	 * -> data_race().
> +	 */
> +	if (!data_race(sma->use_global_lock)) {
> +#else
> +	/* proof of the claim that the code always works:
> +	 * My benchmarks ran fine with this implementation :-)
> +	 */
> +	if (jiffies%2) {

As noted above, use of jiffies_64 would be more convincing because
jiffies is immune from load fusing and jiffies_64 is not.  But this
still does not constitute a proof.  You have instead only shown that a
given version of a given compiler does what you want.  ;-)

> +		pr_info("jiffies mod 2 is 1.\n");
> +	} else {
> +		pr_info("jiffies mod 2 is 0.\n");
> +#endif
>  		/*
>  		 * It appears that no complex operation is around.
>  		 * Acquire the per-semaphore lock.
> @@ -420,6 +467,11 @@ static inline int sem_lock(struct sem_array *sma, struct sembuf *sops,
>  		spin_lock(&sem->lock);
>  
>  		/* see SEM_BARRIER_1 for purpose/pairing */
> +		/* sma->use_global_lock is written to with plain C
> +		 * within a spinlock protected region (but: another
> +		 * lock, not the sem->lock that we own). No need
> +		 * for data_race(), as we use smp_load_acquire().
> +		 */
>  		if (!smp_load_acquire(&sma->use_global_lock)) {
>  			/* fast path successful! */
>  			return sops->sem_num;
> @@ -430,6 +482,10 @@ static inline int sem_lock(struct sem_array *sma, struct sembuf *sops,
>  	/* slow path: acquire the full lock */
>  	ipc_lock_object(&sma->sem_perm);
>  
> +	/* Trivial case: All writes to sma->use_global_lock happen under
> +	 * sma->sem_perm.lock. We own that lock, thus plain C access is
> +	 * correct.
> +	 */
>  	if (sma->use_global_lock == 0) {
>  		/*
>  		 * The use_global_lock mode ended while we waited for

