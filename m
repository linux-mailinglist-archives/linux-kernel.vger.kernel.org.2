Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357353DBA75
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239246AbhG3OXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:23:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55968 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239156AbhG3OST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:18:19 -0400
Message-ID: <20210730135208.472969023@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627654694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=6i5YecZlx9PKPnWrsG1Cv3pXc+I27ufIQh0VzT5R7Qs=;
        b=kNG3KcDIJLRR/DLXt2mgJGXpQZbcw/Oq9PuSJvczxXeIxYRhqMP14QO9zMcmc/E9qDflJW
        /bIuKlM8Wg4UXoLckRBFFHrNGJbgkXgqa9PFYIqxeiKKh9zMU9A8u23T8Y6dUIqiO9eT/V
        Dc4S0ia7RyoleaDvwislWS7BTqvG429BYycSVBzaIN/QX7dTFp6j212NZ4TeYzJWZKY1ha
        RbHVJ7TOcq1m2yr2bt1iENRnO1T6keuIgsRUSI/ZbrN5vUxG6wyLXreHgq82gCbnk+m+9H
        Cu9tuoO9GaYwGdOrCRhjKD7P2BgV0o9QZqN37CQGkVfMI7WOeouRoPwrDSUipg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627654694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=6i5YecZlx9PKPnWrsG1Cv3pXc+I27ufIQh0VzT5R7Qs=;
        b=sA9AV8Jryi3E/KqHlp7M2V+AXgyaLcQ/C+wSFhTIp2e/sNhdDt47+vGWkCfRgm7n4kEDdk
        Rx8KhxG5h+4sOZAA==
Date:   Fri, 30 Jul 2021 15:51:06 +0200
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
Subject: [patch 59/63] rtmutex: Prevent lockdep false positive with PI futexes
References: <20210730135007.155909613@linutronix.de>
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
+	 * recursion. Give the futex/rtmutex wait_lock a seperate key.
+	 */
+	lockdep_set_class(&lock->wait_lock, &pi_futex_key);
 	rt_mutex_set_owner(lock, proxy_owner);
 }
 

