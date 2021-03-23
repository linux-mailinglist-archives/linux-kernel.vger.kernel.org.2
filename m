Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D057E346B4C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 22:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbhCWVlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 17:41:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35940 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbhCWVj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 17:39:58 -0400
Message-Id: <20210323213708.908341972@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616535597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=1c5beaAL/JVIrLgryQn+ja8j9gDPsV6qzH5vEsM2Lv4=;
        b=tE81ARApzKuhEnK/vAts6S4N/c+vh5Yx7qgmcyajTLe5Yql2K7DvXlN1S9ffYlhLQi4qEk
        T6BMTh5GDZpfE2oiNVeHHKk9iwKvRAxVsQXLitqgtfs5t8cXnBwEqVa+4JblqulLIaIyc4
        xVsiKfNq0XmY/6hvkbuXFeRw+RRxexro427RkilJ5PlOB9L7srhteoSQYeZzJkJ368LH+X
        Gcf99RGzYBuE+mReDC3ECNp1YpYC6aeqB3NtWeuvQzNOUD5d/6eIh2wNxBYum0RdlN+r3K
        eLMUK+STM9kaF95BQSoObqMFBYTKEDL+K7gfqOrfvMT5oroMQ1LHNEf4CpKeeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616535597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=1c5beaAL/JVIrLgryQn+ja8j9gDPsV6qzH5vEsM2Lv4=;
        b=+nes0REdQyk6brN/i+A0BFWFnP2ouKwsPuYPixE5XiIC5OdzU7QHfRPrNwAaX5sdMytFak
        zC8c83Fn5eOYyNCQ==
Date:   Tue, 23 Mar 2021 22:30:33 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch 14/14] locking/rtmutex: Restrict the trylock WARN_ON() to debug
References: <20210323213019.217008708@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The warning as written is expensive and not really required for a
production kernel. Make it depend on rt mutex debugging and use !in_task()
for the condition which generates far better code and gives the same
answer.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/locking/rtmutex.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1445,9 +1445,8 @@ EXPORT_SYMBOL_GPL(rt_mutex_lock_interrup
  *
  * @lock:	the rt_mutex to be locked
  *
- * This function can only be called in thread context. It's safe to
- * call it from atomic regions, but not from hard interrupt or soft
- * interrupt context.
+ * This function can only be called in thread context. It's safe to call it
+ * from atomic regions, but not from hard or soft interrupt context.
  *
  * Returns 1 on success and 0 on contention
  */
@@ -1455,7 +1454,7 @@ int __sched rt_mutex_trylock(struct rt_m
 {
 	int ret;
 
-	if (WARN_ON_ONCE(in_irq() || in_nmi() || in_serving_softirq()))
+	if (IS_ENABLED(CONFIG_RT_MUTEX_DEBUG) && WARN_ON_ONCE(!in_task()))
 		return 0;
 
 	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))

