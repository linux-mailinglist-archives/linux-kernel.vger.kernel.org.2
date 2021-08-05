Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC4C3E1891
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237388AbhHEPqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:46:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44274 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242273AbhHEPmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:42:54 -0400
Message-ID: <20210805153956.332344429@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628178159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=B5Vm2Da7n2QoB8hkqNlFWh1fWwF2RXfOVJOTqlo2RYQ=;
        b=D60AT1miw/CHSy9V2fm/i2TR0dIthq516OrW4AehJS5B1K/F2e8u3CuRNohVCPFrcBPhAF
        W2o5TPpu5/tZFx2TFbeLi/Dgi3Q+ZihPV4Sp/2YE8IX8WpFQPSjUtbEu2dmgeGodlO1a2P
        pkNwOGg0L7DhJNUmArYaN8XdbJVdi0hausEX4hSV2VtcC1uCw+De9CP7PrjGCN6LnrUrjo
        SuCIu+ru7UDF+siWsYvqEn/cRbeKhn0SQVTeHcy7qK6INmz5Kj6PDuJYpiqGI6AJOY5Kc3
        SCTTJTx2vUVtPIiNJz2tYmr8exWPVuwhkYjT4GAxoxIkrPrlHvMBP2ECR7QB2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628178159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=B5Vm2Da7n2QoB8hkqNlFWh1fWwF2RXfOVJOTqlo2RYQ=;
        b=4A8VvLSd88bIvkoXr9Qz1S7bIVjQao5Q03utQuMpgHshrcmpUFw9hjQpeINbJjDboPbQQs
        /QQjLWiIhnoVC9Bw==
Date:   Thu, 05 Aug 2021 17:14:01 +0200
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
        Davidlohr Bueso <dave@stgolabs.net>,
        Mike Galbraith <efault@gmx.de>
Subject: [patch V3 61/64] rtmutex: Prevent lockdep false positive with PI futexes
References: <20210805151300.330412127@linutronix.de>
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

Give the futex/rtmutex wait_lock a separate key.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/locking/rtmutex_api.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)
---
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -214,7 +214,19 @@ EXPORT_SYMBOL_GPL(__rt_mutex_init);
 void __sched rt_mutex_init_proxy_locked(struct rt_mutex_base *lock,
 					struct task_struct *proxy_owner)
 {
+	static struct lock_class_key pi_futex_key;
+
 	__rt_mutex_base_init(lock);
+	/*
+	 * On PREEMPT_RT the futex hashbucket spinlock becomes 'sleeping'
+	 * and rtmutex based. That causes a lockdep false positive because
+	 * some of the futex functions invoke spin_unlock(&hb->lock) with
+	 * the wait_lock of the rtmutex associated to the pi_futex held.
+	 * spin_unlock() in turn takes wait_lock of the rtmutex on which
+	 * the spinlock is based which makes lockdep notice a lock
+	 * recursion. Give the futex/rtmutex wait_lock a separate key.
+	 */
+	lockdep_set_class(&lock->wait_lock, &pi_futex_key);
 	rt_mutex_set_owner(lock, proxy_owner);
 }
 

