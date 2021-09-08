Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68D8403F25
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 20:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350072AbhIHSgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 14:36:08 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56886 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235730AbhIHSgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 14:36:07 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 71DE220175;
        Wed,  8 Sep 2021 18:34:58 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 43AFC13A5C;
        Wed,  8 Sep 2021 18:34:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WdxsBk8COWHoVQAAMHmgww
        (envelope-from <dave@stgolabs.net>); Wed, 08 Sep 2021 18:34:55 +0000
Date:   Wed, 8 Sep 2021 11:34:49 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <20210908183449.hidfjw4rm65eesww@offworld>
References: <20210901150627.620830-1-boqun.feng@gmail.com>
 <YTijvI3BpBxkWcTd@hirez.programming.kicks-ass.net>
 <YTi15PNcExiJRZoa@boqun-archlinux>
 <YTjLhnvDxwkE9Kky@hirez.programming.kicks-ass.net>
 <YTjNcD7nyLiChTIJ@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YTjNcD7nyLiChTIJ@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Sep 2021, Peter Zijlstra wrote:
>Subject: lockin/rwbase: Take care of ordering guarantee for fastpath reader

locking

>From: Boqun Feng <boqun.feng@gmail.com>
>Date: Wed, 1 Sep 2021 23:06:27 +0800
>
>From: Boqun Feng <boqun.feng@gmail.com>
>
>Readers of rwbase can lock and unlock without taking any inner lock, if
>that happens, we need the ordering provided by atomic operations to
>satisfy the ordering semantics of lock/unlock. Without that, considering
>the follow case:
>
>	{ X = 0 initially }
>
>	CPU 0			CPU 1
>	=====			=====
>				rt_write_lock();
>				X = 1
>				rt_write_unlock():
>				  atomic_add(READER_BIAS - WRITER_BIAS, ->readers);
>				  // ->readers is READER_BIAS.
>	rt_read_lock():
>	  if ((r = atomic_read(->readers)) < 0) // True
>	    atomic_try_cmpxchg(->readers, r, r + 1); // succeed.
>	  <acquire the read lock via fast path>
>
>	r1 = X;	// r1 may be 0, because nothing prevent the reordering
>		// of "X=1" and atomic_add() on CPU 1.
>
>Therefore audit every usage of atomic operations that may happen in a
>fast path, and add necessary barriers.
>
>Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
>Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>Link: https://lkml.kernel.org/r/20210901150627.620830-1-boqun.feng@gmail.com

With a few comments below, feel free to add my:

Reviewed-by: Davidlohr Bueso <dbueso@suse.de>

>---
> kernel/locking/rwbase_rt.c |   41 ++++++++++++++++++++++++++++++++++++-----
> 1 file changed, 36 insertions(+), 5 deletions(-)
>
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

This last part reads funky. Guarantees must be acquire/release or stronger, not
necessarily stronger than.

...
>@@ -210,14 +224,23 @@ static int __sched rwbase_write_lock(str
>	atomic_sub(READER_BIAS, &rwb->readers);
>
>	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
>+
>+	/* The below set_*_state() thingy implies smp_mb() to provide ACQUIRE */
>+	readers = atomic_read(&rwb->readers);
>	/*
>	 * set_current_state() for rw_semaphore
>	 * current_save_and_set_rtlock_wait_state() for rwlock
>	 */
>	rwbase_set_and_save_current_state(state);
>
>-	/* Block until all readers have left the critical section. */
>-	for (; atomic_read(&rwb->readers);) {
>+	/*
>+	 * Block until all readers have left the critical section.
>+	 *
>+	 * _acqurie() is needed in case that the reader side runs in the fast
	   ^acquire

Thanks,
Davidlohr
