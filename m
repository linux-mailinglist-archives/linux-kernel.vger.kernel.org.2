Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2AC23DBA73
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239364AbhG3OXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239226AbhG3OSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:18:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A554CC0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:17:53 -0700 (PDT)
Message-ID: <20210730135207.478773842@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627654672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=/O2vRlgWt2h6zx9U9kb1PnD3u84r4EBg9NX0SVErgnM=;
        b=Q0ERIcX04JtYDTSHXqQGbzuYflNlcJrZmg0OEE5XpR0YSSzU0frNPnKkype5q5UzhjycEa
        yVBQP8qNYPFnAIQCp1UoaxAgsT3GKJ39aY4wf/kKsQSBjhKIix8sv5tBUp95mKQr+av0uI
        fcmvzHAPDn2cnAyctT7GoW9t2ityC/UmS77X3CbQw5o8XykBR5iYZ4YLyHXKuA1SIC7A+j
        QeUMvIQ2gi5RGEpXpt12bdPNwNl6RbBsR2rpyEdcEdmA3iQE8DXyIeo8G4xdVHLwQZWiuF
        J6amwKAg+LoUcsgMY7nGnAk/O0MSu+lhw6lrNfKcMCePjVGzqQVqaAtJDIfpUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627654672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=/O2vRlgWt2h6zx9U9kb1PnD3u84r4EBg9NX0SVErgnM=;
        b=MV3zf0uSILeArQYxupj9fwrnEiGvwk91uwRqh59A4uHvt2anqsKSebnk9rugkKYgBkSYz/
        c5rxC8ZlBgiHPgDA==
Date:   Fri, 30 Jul 2021 15:50:48 +0200
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
Subject: [patch 41/63] locking/ww_mutex: Abstract waiter iteration
References: <20210730135007.155909613@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
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
 

