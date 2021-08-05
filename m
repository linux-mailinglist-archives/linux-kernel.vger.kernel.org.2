Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEA63E187B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242692AbhHEPot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:44:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43924 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242413AbhHEPm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:42:27 -0400
Message-ID: <20210805153955.367232736@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628178132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=nrX5zHyTQKua8S1wHg9eh/FmYPW4+RDYg8qTFJk/Xu8=;
        b=ekVtZNpeJE8YTWuUEZpM7+46MKfCA/3yAbMR0ApSxa6CxUBzcq04uWNvO/605i/cG01OnS
        4awr6JrgAkPEOjjuEtixoVLUYzFaZD/QBPkoRjfDOm2TCD5Sgam7hy5IRltCaYP4IUnRpB
        C+k8K/YwPytcD3CR99MR7Foy9KEsD7dgoORjdFyg/oXgp8PiKGfXubag8A7isouT2uU7Ud
        Hn3S+rIDp3Rg9fHk0lH1DnWGrZ0IpFDNpykDwHBTGORgcxGo0ZMKmNwEx1k+FN3cD8YC+h
        OY/7ZgTwgf7Lz6D5gbhLjCEJivc5geRHUv8dWPqs3QmWq25OvJrcsu6vAmAG/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628178132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=nrX5zHyTQKua8S1wHg9eh/FmYPW4+RDYg8qTFJk/Xu8=;
        b=E7nX10Q28b9HUz4h+viEO3l1lOh31tgHUC04EruNtGSXU8pCS+u4ArihicZnHYMEwn+G2U
        jRYzrN9IXW+e8zCw==
Date:   Thu, 05 Aug 2021 17:13:44 +0200
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
Subject: [patch V3 44/64] locking/ww_mutex: Abstract mutex accessors
References: <20210805151300.330412127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Move the mutex related access from various ww_mutex functions into helper
functions so they can be substituted for rtmutex based ww_mutex later.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/locking/ww_mutex.h |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)
---
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -53,6 +53,18 @@ static inline void
 	__mutex_add_waiter(lock, waiter, p);
 }
 
+static inline struct task_struct *
+__ww_mutex_owner(struct mutex *lock)
+{
+	return __mutex_owner(lock);
+}
+
+static inline bool
+__ww_mutex_has_waiters(struct mutex *lock)
+{
+	return atomic_long_read(&lock->owner) & MUTEX_FLAG_WAITERS;
+}
+
 /*
  * Wait-Die:
  *   The newer transactions are killed when:
@@ -157,7 +169,7 @@ static bool __ww_mutex_wound(struct mute
 			     struct ww_acquire_ctx *ww_ctx,
 			     struct ww_acquire_ctx *hold_ctx)
 {
-	struct task_struct *owner = __mutex_owner(lock);
+	struct task_struct *owner = __ww_mutex_owner(lock);
 
 	lockdep_assert_held(&lock->wait_lock);
 
@@ -253,7 +265,7 @@ ww_mutex_set_context_fastpath(struct ww_
 	 * __ww_mutex_add_waiter() and makes sure we either observe ww->ctx
 	 * and/or !empty list.
 	 */
-	if (likely(!(atomic_long_read(&lock->base.owner) & MUTEX_FLAG_WAITERS)))
+	if (likely(!__ww_mutex_has_waiters(&lock->base)))
 		return;
 
 	/*

