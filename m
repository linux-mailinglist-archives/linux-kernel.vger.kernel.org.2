Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B923FE41E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 22:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbhIAUd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 16:33:27 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57236 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhIAUdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 16:33:23 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 781EB202E1;
        Wed,  1 Sep 2021 20:22:53 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 25A0113B03;
        Wed,  1 Sep 2021 20:22:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QYQbOxrhL2HtBQAAMHmgww
        (envelope-from <dave@stgolabs.net>); Wed, 01 Sep 2021 20:22:50 +0000
Date:   Wed, 1 Sep 2021 13:22:42 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Boqun Feng <boqun.feng@gmail.com>
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
Message-ID: <20210901202242.2bzb6fbwyorfux3f@offworld>
References: <20210901150627.620830-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210901150627.620830-1-boqun.feng@gmail.com>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Sep 2021, Boqun Feng wrote:
>diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
>index 4ba15088e640..a1886fd8bde6 100644
>--- a/kernel/locking/rwbase_rt.c
>+++ b/kernel/locking/rwbase_rt.c
>@@ -41,6 +41,12 @@
>  * The risk of writer starvation is there, but the pathological use cases
>  * which trigger it are not necessarily the typical RT workloads.
>  *
>+ * Fast-path orderings:
>+ * The lock/unlock of readers can run in fast paths: lock and unlock are only
>+ * atomic ops, and there is no inner lock to provide ACQUIRE and RELEASE
>+ * semantics of rwbase_rt. Atomic ops then should be stronger than _acquire()
>+ * and _release() to provide necessary ordering guarantee.

Perhaps the following instead?

+ * Ordering guarantees: As with any locking primitive, (load)-ACQUIRE and
+ * (store)-RELEASE semantics are guaranteed for lock and unlock operations,
+ * respectively; such that nothing leaks out of the critical region. When
+ * writers are involved this is provided through the rtmutex. However, for
+ * reader fast-paths, the atomics provide at least such guarantees.

Also, I think you could remove most of the comments wrt _acquire or _release
in the fastpath for each ->readers atomic op, unless it isn't obvious.

>+ *
>  * Common code shared between RT rw_semaphore and rwlock
>  */
>
>@@ -53,6 +59,7 @@ static __always_inline int rwbase_read_trylock(struct rwbase_rt *rwb)
>	 * set.
>	 */
>	for (r = atomic_read(&rwb->readers); r < 0;) {

Unrelated, but we probably wanna get rid of these abusing for-loops throughout.

>+		/* Fully-ordered if cmpxchg() succeeds, provides ACQUIRE */
>		if (likely(atomic_try_cmpxchg(&rwb->readers, &r, r + 1)))

As Waiman suggested, this can be _acquire() - albeit we're only missing
an L->L for acquire semantics upon returning, per the control dependency
already guaranteeing L->S. That way we would loop with _relaxed().

>			return 1;
>	}
>@@ -162,6 +169,8 @@ static __always_inline void rwbase_read_unlock(struct rwbase_rt *rwb,
>	/*
>	 * rwb->readers can only hit 0 when a writer is waiting for the
>	 * active readers to leave the critical section.
>+	 *
>+	 * dec_and_test() is fully ordered, provides RELEASE.
>	 */
>	if (unlikely(atomic_dec_and_test(&rwb->readers)))
>		__rwbase_read_unlock(rwb, state);
>@@ -172,7 +181,11 @@ static inline void __rwbase_write_unlock(struct rwbase_rt *rwb, int bias,
> {
>	struct rt_mutex_base *rtm = &rwb->rtmutex;
>
>-	atomic_add(READER_BIAS - bias, &rwb->readers);
>+	/*
>+	 * _release() is needed in case that reader is in fast path, pairing
>+	 * with atomic_try_cmpxchg() in rwbase_read_trylock(), provides RELEASE
>+	 */
>+	(void)atomic_add_return_release(READER_BIAS - bias, &rwb->readers);

Hmmm while defined, there are no users atomic_add_return_release (yet?). I think
this is because the following is preferred when the return value is not really
wanted, but only the Rmw ordering it provides:

+       smp_mb__before_atomic(); /* provide RELEASE semantics */
	atomic_add(READER_BIAS - bias, &rwb->readers);
	raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
	rwbase_rtmutex_unlock(rtm);

>	raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
>	rwbase_rtmutex_unlock(rtm);
> }

Thanks,
Davidlohr
