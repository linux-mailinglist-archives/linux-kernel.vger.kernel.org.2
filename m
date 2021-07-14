Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98513C83DB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 13:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238969AbhGNL3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 07:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbhGNL33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 07:29:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D7EC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 04:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jAmBXMulwel/6QKJkbTCkyzNR4cRqgN3axEfLABI0/0=; b=LJ0sPL9UaOKPUmvYnnaKhoYi6B
        mRvo2Cp9F3xyW4vId5rpOYCqKA/3s0xch8cwSZiO6l55tpckp+pObtQx069+IjwwJloVi88p8sUZ1
        nzAKLKmVKmC1hGqzu3ScqPKlEiihRq2RxiLD61aIhyUtnQ7z34po/LKFaNF9orv9UEHt6FwFdZ/g7
        kPlwmGppOMnAuz10o4D7+C09nIF1FZSmKcLs47QeG3iVpCjCZ0CujxR9JTQQdLbbWZLEKI+BgneL/
        1BiwDAOiK7N8Fi7f/zsl3K31L8WoO9m1AokWL9P7zHnQqB9edSTh05EP1X8IeYUyU1rXWQOxiftcl
        pkpzH93A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3d19-0029er-Gh; Wed, 14 Jul 2021 11:25:38 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A036998689D; Wed, 14 Jul 2021 13:25:30 +0200 (CEST)
Date:   Wed, 14 Jul 2021 13:25:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [patch 27/50] locking/spinlock: Provide RT variant
Message-ID: <20210714112530.GE2591@worktop.programming.kicks-ass.net>
References: <20210713151054.700719949@linutronix.de>
 <20210713160748.585453340@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713160748.585453340@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 05:11:21PM +0200, Thomas Gleixner wrote:

> + * - Non RT spin/rw_locks disable preemption and evtl. interrupts.
> + *   Disabling preemption has the side effect of disabling migration and
> + *   preventing RCU grace periods.
> + *
> + *   The RT substitutions explicitly disable migration and take
> + *   rcu_read_lock() across the lock held section.

> +static __always_inline void __rt_spin_lock(spinlock_t *lock)
> +{
> +	rtlock_lock(&lock->lock);
> +	rcu_read_lock();
> +	migrate_disable();
> +}

One notable difference is that regular spinlocks disable preemption (and
hence imply the other things) *before* they acquire the lock, while this
thing does the implied semantics *after* it acquires the lock.

The difference is of course that the acquisition period is not covered
and I don't think anybody actually relies on that, nor do I readily see
how one could.
