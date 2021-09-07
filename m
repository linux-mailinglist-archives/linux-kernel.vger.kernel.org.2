Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB8E402745
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 12:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343513AbhIGKgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 06:36:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42230 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbhIGKgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 06:36:07 -0400
Date:   Tue, 7 Sep 2021 12:34:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631010900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q2O3xBRPSpZvuwe8J7LUG/eAnxJY+qj+EtbjaQbBByM=;
        b=CD/JhMJfDqM4JiuizVDdqhr3O/8jGI5ApYdCXnYJucnKaYyN9MmFKlnLBpzdSpXXmZZLro
        D857b78poTeCcocWaAXKd5juAErgf4beX+FIMwSJRaYPTrXGuo0H1fsI5cE615sskD7qqz
        23PwhS6GaEYQ66tGhcqq8d5HevcnuDj9ljZeGP5KPa+5rg+FTAHKO1FFD5Z2VjrnN4PxO5
        oLoiVzQqmZjgy1ESvzt62F42B863a1rMcuKgOIclelBbIckTm8r6JSJOQreRb9xiNnXHJL
        ZekBD0oJIUSvAUU8ySXG59hSFFodhCezKjBpvzGABhwCt0+PhafBM1eHkNiyMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631010900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q2O3xBRPSpZvuwe8J7LUG/eAnxJY+qj+EtbjaQbBByM=;
        b=tlnBigMboBrkHCxxoRA5pGy3iLm4TVFxtzCtlGKDzIYFkp0nixRr+caBIueetlJ4tPVnyB
        bwAUYdNHrfuxLNAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] locking: Remove rt_rwlock_is_contended()
Message-ID: <20210907103458.l2iyvjps5bjwnzng@linutronix.de>
References: <20210906143004.2259141-1-bigeasy@linutronix.de>
 <20210907100944.7qu3frjuuty3oi3d@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210907100944.7qu3frjuuty3oi3d@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rt_rwlock_is_contended() has not users. It makes no sense to use it as
rwlock_is_contended() because it is a sleeping lock on RT and preemption
is possible. It reports always != 0 if used by a writer and even if
there is a waiter then the lock might not be handed over if the
current owner has the highest priority.

Remove rt_rwlock_is_contended().

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 8282947f67345 ("locking/rwlock: Provide RT variant")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/locking/spinlock_rt.c |    6 ------
 1 file changed, 6 deletions(-)

--- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -246,12 +246,6 @@ void __sched rt_write_unlock(rwlock_t *r
 }
 EXPORT_SYMBOL(rt_write_unlock);
 
-int __sched rt_rwlock_is_contended(rwlock_t *rwlock)
-{
-	return rw_base_is_contended(&rwlock->rwbase);
-}
-EXPORT_SYMBOL(rt_rwlock_is_contended);
-
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 void __rt_rwlock_init(rwlock_t *rwlock, const char *name,
 		      struct lock_class_key *key)
