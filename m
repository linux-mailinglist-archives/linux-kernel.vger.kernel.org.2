Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109F73ECB5D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 23:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbhHOVdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 17:33:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48804 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbhHOV3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 17:29:51 -0400
Message-ID: <20210815211305.750701219@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629062960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=B5Vm2Da7n2QoB8hkqNlFWh1fWwF2RXfOVJOTqlo2RYQ=;
        b=styup/ul+PwRSHrHfsRJrWHGRkCC5V1h/QwUYr96MBMllFPFYgQUytM2KSAgKDVetFvg1N
        vdWIMtqtXzBJuiJyLU2aAFJENYBouaTDS2kW+el8xMWmxTuy19F9uUO8LTCewmXTHenq3P
        DNO4c+C73NRAF6MNSHD2PlB1g1tfGF7K2CHLPs39XvQe8Z7iQYx6D1a6oSdZ+GqK69pNwt
        0HWSQpXe9jHZxCPT003JZk7hGq1peQiOzjOkXlZ5t5cyjBdZauMHnqFdMcl41ZVpqmHPgp
        qLrWUJ1SkMVHAaZCanAFS3wG6QBw04fqKkYUzUAT9paBNbTC53UZIrxALTBRuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629062960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=B5Vm2Da7n2QoB8hkqNlFWh1fWwF2RXfOVJOTqlo2RYQ=;
        b=M/SeuSM/KvUKfye9yzihpJAcj16FS2FS6w46EsWxxD0Vlr1UwIBrefffSeCiYZTLzgR6xY
        4RL6VvKeUW6RCxCA==
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
Subject: [patch V5 67/72] rtmutex: Prevent lockdep false positive with PI futexes
References: <20210815203225.710392609@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Sun, 15 Aug 2021 23:29:20 +0200 (CEST)
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
 

