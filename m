Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB47405968
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 16:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239043AbhIIOpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 10:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240915AbhIIOp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 10:45:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6725C0617AB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 07:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QHDSNli7RKCrbt6ymGIACQkzBg5TAqwcFrAqbTxxIRo=; b=PsN03UhST2OVUWkEDs2AtHJBU2
        TBY+x5o83x+C4+aeaExrm/5xhzQGuHbPzt8EY5QUy601u5SZQnS4PUMqICqegQMAcv+KyEUoK/OnN
        Jt6pGcbZFZOZ5prW16viNoK/E9vJC9Pj0CXmJI+3iNlZVuIDRMk8ytMduOWFmPqR5WHgnj9JQkDEk
        lFE9IVj/sZtRN1Lcrzg4wIgejixMGl7pAPLJqPcc24F3gLbpWkga0afM7jTs2VOsLydRUmp75dS7l
        ExSnneCJeYQNgCtO0OolLZU2cOe49Er9ciIyO/73K1AkIwHP9pGqIUHh1bbTy5oqsFs3h2Ko5gN2y
        tMsJtG2Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOL1p-001swp-Bk; Thu, 09 Sep 2021 14:27:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0F0D3300094;
        Thu,  9 Sep 2021 16:27:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F245620D13710; Thu,  9 Sep 2021 16:27:46 +0200 (CEST)
Date:   Thu, 9 Sep 2021 16:27:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     tglx@linutronix.de, boqun.feng@gmail.com,
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
Message-ID: <YToZ4h/nfsrD3JfY@hirez.programming.kicks-ass.net>
References: <20210909105915.757320973@infradead.org>
 <20210909110203.767330253@infradead.org>
 <20210909134524.GB9722@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909134524.GB9722@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 02:45:24PM +0100, Will Deacon wrote:
> On Thu, Sep 09, 2021 at 12:59:16PM +0200, Peter Zijlstra wrote:
> > While looking at current_save_and_set_rtlock_wait_state() I'm thinking
> > it really ought to use smp_store_mb(), because something like:
> > 
> > 	current_save_and_set_rtlock_wait_state();
> > 	for (;;) {
> > 		if (try_lock())
> > 			break;
> > 
> > 		raw_spin_unlock_irq(&lock->wait_lock);
> > 		schedule();
> > 		raw_spin_lock_irq(&lock->wait_lock);
> > 
> > 		set_current_state(TASK_RTLOCK_WAIT);
> > 	}
> > 	current_restore_rtlock_saved_state();
> > 
> > which is the advertised usage in the comment, is actually broken,
> > since trylock() will only need a load-acquire in general and that
> > could be re-ordered against the state store, which could lead to a
> > missed wakeup -> BAD (tm).
> 
> Why doesn't the UNLOCK of pi_lock in current_save_and_set_rtlock_wait_state()
> order the state change before the successful try_lock? I'm just struggling
> to envisage how this actually goes wrong.

Moo yes, so the earlier changelog I wrote was something like:

	current_save_and_set_rtlock_wait_state();
	for (;;) {
		if (try_lock())
			break;

		raw_spin_unlock_irq(&lock->wait_lock);
		if (!cond)
			schedule();
		raw_spin_lock_irq(&lock->wait_lock);

		set_current_state(TASK_RTLOCK_WAIT);
	}
	current_restore_rtlock_saved_state();

which is more what the code looks like before these patches, and in that
case the @cond load can be lifted before __state.

It all sorta works in the current application because most things are
serialized by ->wait_lock, but given the 'normal' wait pattern I got
highly suspicious of there not being a full barrier around.
