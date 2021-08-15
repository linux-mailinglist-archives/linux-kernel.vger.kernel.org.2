Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78223ECB49
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 23:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbhHOVcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 17:32:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48458 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbhHOV3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 17:29:19 -0400
Message-ID: <20210815211304.566318143@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629062927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=6wHGVpFR/uJnYpHUCIQ5cWEtG5BNuC7xSjnFrkX4B+g=;
        b=REjLWz4up3WzvAQwB0L90RSpUQYO3F65fi0LpNjfmKCP+xZYk/aoaFyKjsVAExPkwdHcPK
        Op7XDKXbwfWbUAHbG3fhV3Ss5E800kYiPIm7OohQsK4LmWwCBEnugGWk2Daf3J0fysP5/t
        6f7zREiwU27Q2CAsEZCfb7hYHe014QyTkW3hksJDx6+6DGwpo9WAc2yjr/OLKMxvab5HwZ
        JbTy2D04p+QbhOPPkHXESzpY3xIoiOccuqF4ny1QHBlcm18U/306IGFtdnCd7KVCLTdbsp
        Xy2d3EU3KMpm+cytHsiAhFduGFwDDwduusma6ekO7wpBd8/fPfODTVtbo5Mzww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629062927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=6wHGVpFR/uJnYpHUCIQ5cWEtG5BNuC7xSjnFrkX4B+g=;
        b=SCZzyqqmPPozkmgZzqdu8Ix8Vc1fXJKeNqVCstIV4x2b+UAaig1S5RdtsbDHJm724CsO/p
        Irg2CE3P/blRtlBA==
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
Subject: [patch V5 46/72] locking/ww_mutex: Abstract waiter enqueueing
References: <20210815203225.710392609@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Sun, 15 Aug 2021 23:28:47 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

The upcoming rtmutex based ww_mutex needs a different handling for
enqueueing a waiter. Split it out into a helper function.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/locking/ww_mutex.h |   19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)
---
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -44,6 +44,15 @@ static inline struct mutex_waiter *
 	return w;
 }
 
+static inline void
+__ww_waiter_add(struct mutex *lock, struct mutex_waiter *waiter, struct mutex_waiter *pos)
+{
+	struct list_head *p = &lock->wait_list;
+	if (pos)
+		p = &pos->list;
+	__mutex_add_waiter(lock, waiter, p);
+}
+
 /*
  * Wait-Die:
  *   The newer transactions are killed when:
@@ -337,12 +346,11 @@ static inline int
 		      struct mutex *lock,
 		      struct ww_acquire_ctx *ww_ctx)
 {
-	struct mutex_waiter *cur;
-	struct list_head *pos;
+	struct mutex_waiter *cur, *pos = NULL;
 	bool is_wait_die;
 
 	if (!ww_ctx) {
-		__mutex_add_waiter(lock, waiter, &lock->wait_list);
+		__ww_waiter_add(lock, waiter, NULL);
 		return 0;
 	}
 
@@ -355,7 +363,6 @@ static inline int
 	 * never die here, but they are sorted in stamp order and
 	 * may wound the lock holder.
 	 */
-	pos = &lock->wait_list;
 	for (cur = __ww_waiter_last(lock); cur;
 	     cur = __ww_waiter_prev(lock, cur)) {
 
@@ -378,13 +385,13 @@ static inline int
 			break;
 		}
 
-		pos = &cur->list;
+		pos = cur;
 
 		/* Wait-Die: ensure younger waiters die. */
 		__ww_mutex_die(lock, cur, ww_ctx);
 	}
 
-	__mutex_add_waiter(lock, waiter, pos);
+	__ww_waiter_add(lock, waiter, pos);
 
 	/*
 	 * Wound-Wait: if we're blocking on a mutex owned by a younger context,

