Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A283E187C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242587AbhHEPoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242414AbhHEPm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:42:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF10C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 08:42:12 -0700 (PDT)
Message-ID: <20210805153955.310862045@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628178131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=6wHGVpFR/uJnYpHUCIQ5cWEtG5BNuC7xSjnFrkX4B+g=;
        b=qjY3NY2jK7NvFOWKBrNGtjx49JWxgZ07n/1kxWoVY6D6OzmD/lMlx+AHV2Hm0vG8Sn63eL
        laVAU1OW5qTcb15/00KOt0rnw39HEv72HCnhbHPQPPr+IILSf+5YAQeKq+sIHXJXUH3Gou
        7zxq7R1CF5rN0zld2j3Flw+Dt80RltCdoaAWgjU8l+brc6g70qspCy0alUSjX2PFqpA/X2
        /2/aHIPLTxmh8G0Nep7C74d613TrZr/9mKJ27aTp9DywFKxQ7VXVVGMIK2zuUpb0loSYjz
        owvWaWz5jyFyyMdIE+p0KM/6WYWMDr1fVH/lEQ+flbfj2gNYvFnAaP7SjV4kwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628178131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=6wHGVpFR/uJnYpHUCIQ5cWEtG5BNuC7xSjnFrkX4B+g=;
        b=aIfV7QqgnOpZNzRgDJoqYM+FuWGqtMNP98KKcqodIE+2cEhqHGkRPN1Hg0cLytAbBqOR08
        m3KgfgbhFVTu5VCg==
Date:   Thu, 05 Aug 2021 17:13:43 +0200
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
Subject: [patch V3 43/64] locking/ww_mutex: Abstract waiter enqueueing
References: <20210805151300.330412127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
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

