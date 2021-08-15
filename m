Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A972C3ECB48
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 23:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbhHOVcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 17:32:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48444 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbhHOV3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 17:29:17 -0400
Message-ID: <20210815211304.509186185@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629062926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=/O2vRlgWt2h6zx9U9kb1PnD3u84r4EBg9NX0SVErgnM=;
        b=rf7FZIaZxkM3jJ829EiR1bhqLEQiOK78ATSQ+gjp8eWKKBxJxHRa4q62AiBxpC72NDJktr
        IaILlEr+1v8nPS4f5D0i3XtEt9Jrb+jCKOds/Hl38DA71XQebjpxsnrhSxsSz3rEYRCn8l
        sL5wh4K6oePHsze3VVXoyaMCQl7L4HPm7P49FKQ+VuDkkoY88S0zp7vct0D1q9z2koHUEr
        X+omjmT9CPvEeM9dNjKt5ICMtO4mfplatQ68ab5w3qunHWnredc7cuNJfemNHOneJTgVdi
        eaRx9/dIDcC0ekvHMbSp6zcsOchQwrsifoOSzlwvBzmCD2+7MCs0nXE43GnxTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629062926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=/O2vRlgWt2h6zx9U9kb1PnD3u84r4EBg9NX0SVErgnM=;
        b=5jT+TXKF15ihytayEq7/RL+gFUqhPr6p7RjmBKV8e81YTOuqX0Lav/8IVAcOlOXa2EpHPM
        Q5di4aKf8mwKnBCg==
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
Subject: [patch V5 45/72] locking/ww_mutex: Abstract waiter iteration
References: <20210815203225.710392609@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Sun, 15 Aug 2021 23:28:45 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Split out the waiter iteration functions so they can be substituted for a
rtmutex based ww_mutex later.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/locking/ww_mutex.h |   57 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 4 deletions(-)
---
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -1,5 +1,49 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 
+static inline struct mutex_waiter *
+__ww_waiter_first(struct mutex *lock)
+{
+	struct mutex_waiter *w;
+
+	w = list_first_entry(&lock->wait_list, struct mutex_waiter, list);
+	if (list_entry_is_head(w, &lock->wait_list, list))
+		return NULL;
+
+	return w;
+}
+
+static inline struct mutex_waiter *
+__ww_waiter_next(struct mutex *lock, struct mutex_waiter *w)
+{
+	w = list_next_entry(w, list);
+	if (list_entry_is_head(w, &lock->wait_list, list))
+		return NULL;
+
+	return w;
+}
+
+static inline struct mutex_waiter *
+__ww_waiter_prev(struct mutex *lock, struct mutex_waiter *w)
+{
+	w = list_prev_entry(w, list);
+	if (list_entry_is_head(w, &lock->wait_list, list))
+		return NULL;
+
+	return w;
+}
+
+static inline struct mutex_waiter *
+__ww_waiter_last(struct mutex *lock)
+{
+	struct mutex_waiter *w;
+
+	w = list_last_entry(&lock->wait_list, struct mutex_waiter, list);
+	if (list_entry_is_head(w, &lock->wait_list, list))
+		return NULL;
+
+	return w;
+}
+
 /*
  * Wait-Die:
  *   The newer transactions are killed when:
@@ -161,7 +205,9 @@ static void
 
 	lockdep_assert_held(&lock->wait_lock);
 
-	list_for_each_entry(cur, &lock->wait_list, list) {
+	for (cur = __ww_waiter_first(lock); cur;
+	     cur = __ww_waiter_next(lock, cur)) {
+
 		if (!cur->ww_ctx)
 			continue;
 
@@ -263,8 +309,9 @@ static inline int
 	 * If there is a waiter in front of us that has a context, then its
 	 * stamp is earlier than ours and we must kill ourself.
 	 */
-	cur = waiter;
-	list_for_each_entry_continue_reverse(cur, &lock->wait_list, list) {
+	for (cur = __ww_waiter_prev(lock, waiter); cur;
+	     cur = __ww_waiter_prev(lock, cur)) {
+
 		if (!cur->ww_ctx)
 			continue;
 
@@ -309,7 +356,9 @@ static inline int
 	 * may wound the lock holder.
 	 */
 	pos = &lock->wait_list;
-	list_for_each_entry_reverse(cur, &lock->wait_list, list) {
+	for (cur = __ww_waiter_last(lock); cur;
+	     cur = __ww_waiter_prev(lock, cur)) {
+
 		if (!cur->ww_ctx)
 			continue;
 

