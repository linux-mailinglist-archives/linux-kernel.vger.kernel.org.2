Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED443C742A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235127AbhGMQSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:18:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54702 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbhGMQQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:16:57 -0400
Message-Id: <20210713160750.564432923@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626192845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=JN6sOwkSzGbTK7vxSf/WJ4VYhfWsi0+fBs8+6sDgMB4=;
        b=YyPXlAkrZqg6aCghfdlek/NWRNy5iVjLciunpCLWm2PLMFl4f4X5CH8++r91l3zjMC6k/h
        71nqujat0PcgmrgpH+WjGeARUdYQWaw/26W5/JjMlaMtr9CbdAwo6cEsp3Til1RKLc+sFD
        9yjtImRlZ73/F40k9jh8xhU3klXVfM9K5NzDVm8LQrjI1y0RvD4EuDKLSnAh7gDSZTsED2
        FPkY+40lq6F+cZoKTNCt6I0U+xha2tHkWXJSMEK1QHY5H6g99zJJjJaI+dWGXgyAB0JuS6
        SCgbvO3qb/IanT6aUdnbuHAfTUQGQj/59l8Ny1e+xBJ1x09d+T4wZxV56Bs6Yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626192845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=JN6sOwkSzGbTK7vxSf/WJ4VYhfWsi0+fBs8+6sDgMB4=;
        b=m5T4blNHCNofvnzSLtabpGXKAhUTP0ND+Dadd+lHFFfjN0vOmHhZT1EQLTCaFGxeiZGo+y
        36psQLcRtezEV9Bg==
Date:   Tue, 13 Jul 2021 17:11:41 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [patch 47/50] rtmutex: Prevent lockdep false positive with PI futexes
References: <20210713151054.700719949@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

On PREEMPT_RT the futex hashbucket spinlock becomes 'sleeping' and rtmutex
based. That causes a lockdep false positive because some of the futex
functions invoke spin_unlock(&hb->lock) with the wait_lock of the rtmutex
associated to the pi_futex held.  spin_unlock() in turn takes wait_lock of
the rtmutex on which the spinlock is based which makes lockdep notice a
lock recursion.

Give the futex/rtmutex wait_lock a seperate key.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/locking/rtmutex_api.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)
---
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -209,7 +209,19 @@ EXPORT_SYMBOL_GPL(__rt_mutex_init);
 void __sched rt_mutex_init_proxy_locked(struct rt_mutex *lock,
 					struct task_struct *proxy_owner)
 {
+	static struct lock_class_key pi_futex_key;
+
 	__rt_mutex_basic_init(lock);
+	/*
+	 * On PREEMPT_RT the futex hashbucket spinlock becomes 'sleeping'
+	 * and rtmutex based. That causes a lockdep false positive because
+	 * some of the futex functions invoke spin_unlock(&hb->lock) with
+	 * the wait_lock of the rtmutex associated to the pi_futex held.
+	 * spin_unlock() in turn takes wait_lock of the rtmutex on which
+	 * the spinlock is based which makes lockdep notice a lock
+	 * recursion. Give the futex/rtmutex wait_lock a seperate key.
+	 */
+	lockdep_set_class(&lock->wait_lock, &pi_futex_key);
 	rt_mutex_set_owner(lock, proxy_owner);
 }
 

