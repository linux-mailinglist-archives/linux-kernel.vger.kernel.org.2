Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734233C741B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbhGMQR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbhGMQQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:16:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD903C0613EF
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:13:52 -0700 (PDT)
Message-Id: <20210713160749.361904766@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626192831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Zc4gJ2XC09fgfmp1nBCiDZ6TtWrfLURPoxMf1HZ3O3U=;
        b=K9806UHyRw8im9UnHlo7EMXq4heifr49ieoCIT9ovUmm5xi1SEz9qGTYFhC13tA9fWdupC
        fwWy6UcnXn5MctUW/TGJbTYKXXBUzTat/QoZTjyKJWJ/YoN3B1IxPEymA8vtR3o1zvnrnz
        xkCKVBMCkdR2pjG8iHWg9KNPC6VTeqgYk5aMFal2tnjcmjwgJcLMwjIwWc7TRWYrl2weHR
        jMnp3Emmw/I666ISSAs3RxophcJlXQg4EjtsVODqL68Egq2FpjsCpJbPcObOf7SuG+Thvq
        OkiOjoqvJXy26Emtil7JUXUUURByN36Vos6S1GVQdsdHEDhCUbXBBQUX8SKLcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626192831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Zc4gJ2XC09fgfmp1nBCiDZ6TtWrfLURPoxMf1HZ3O3U=;
        b=T27jpEeQOKp+MW6LKJ9hRkqQlZxjbt2ucRkB5HmxKWXgGodhs2tpGyPNsTqPXmXtzXcmI2
        FOOee9EgrAjxoODg==
Date:   Tue, 13 Jul 2021 17:11:29 +0200
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
Subject: [patch 35/50] locking/ww_mutex: Switch to _mutex_t
References: <20210713151054.700719949@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

PREEMPT_RT replaces 'struct mutex' with a rtmutex based variant so all
mutex operations are included into the priority inheritance scheme, but
wants to utilize the ww_mutex specific part of the regular mutex
implementation as is.

As the regular mutex and ww_mutex implementation are tightly coupled
(ww_mutex has a 'struct mutex' inside) and share a lot of code (ww_mutex is
mostly an extension) a simple replacement of 'struct mutex' does not work.

'struct mutex' has a typedef '_mutex_t' associated. Replace all 'struct
mutex' references in ww_mutex with '_mutex_t' which allows to have a RT
specific 'struct mutex' in the final step.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/ww_mutex.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
---
diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
index 455542a42123..4f56ec47c698 100644
--- a/include/linux/ww_mutex.h
+++ b/include/linux/ww_mutex.h
@@ -29,7 +29,7 @@ struct ww_class {
 };
 
 struct ww_mutex {
-	struct mutex base;
+	_mutex_t base;
 	struct ww_acquire_ctx *ctx;
 #ifdef CONFIG_DEBUG_MUTEXES
 	struct ww_class *ww_class;
@@ -330,7 +330,7 @@ extern void ww_mutex_unlock(struct ww_mutex *lock);
  */
 static inline int __must_check ww_mutex_trylock(struct ww_mutex *lock)
 {
-	return mutex_trylock(&lock->base);
+	return _mutex_t_trylock(&lock->base);
 }
 
 /***
@@ -343,7 +343,7 @@ static inline int __must_check ww_mutex_trylock(struct ww_mutex *lock)
  */
 static inline void ww_mutex_destroy(struct ww_mutex *lock)
 {
-	mutex_destroy(&lock->base);
+	_mutex_t_destroy(&lock->base);
 }
 
 /**
@@ -354,7 +354,7 @@ static inline void ww_mutex_destroy(struct ww_mutex *lock)
  */
 static inline bool ww_mutex_is_locked(struct ww_mutex *lock)
 {
-	return mutex_is_locked(&lock->base);
+	return _mutex_t_is_locked(&lock->base);
 }
 
 #endif

