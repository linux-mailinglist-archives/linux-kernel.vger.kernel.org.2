Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B683ECB1A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 23:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbhHOV2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 17:28:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47702 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhHOV2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 17:28:09 -0400
Message-ID: <20210815211301.969975279@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629062857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=muqbAf6+h4Yo4XQnVA5bLyL63gW9bG50eCqrGH07VTA=;
        b=s2hO8TYfhEIf//gkdfcBMLNfcPycUCU70jtrGsyT5k61sBIoG4AHYNm0GEwwVEJ+iiztFC
        ch97f7lC+L2bwBHR6rxNOiwG33hDNWe/nr027UHGC31bLq65Cw+aVPK3lsT2mchG3qVWSc
        YfKQTPheZb9uBSeX5Fh1jINNQKWyQPqGX8rH8vVyV2Halr/yapmCrAvT6nM/i2X2TYPQUS
        fxk7tEsipdrT7TCSmxqIWpObPe10zO1IRUUMV/pCgItEF3He7hSaqLaneChMR7auvVDTh4
        Wl18iYIY6rg+kpvk2XtlQBzA5Ch0Cx8PAdf/SEi5szwWU8TnnyCUEXx2pqMcoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629062857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=muqbAf6+h4Yo4XQnVA5bLyL63gW9bG50eCqrGH07VTA=;
        b=NJXWX/mn5W0iYF6Lc9ktTEyBEcYG6s6P5eLNvWdq/tmSiRDNY05CaS5BwOtoLqU9hVKYlX
        UFl8agHwEXRB4YBA==
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
Subject: [patch V5 01/72] locking/local_lock: Add missing owner initialization
References: <20210815203225.710392609@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Sun, 15 Aug 2021 23:27:37 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_DEBUG_LOCK_ALLOC is enabled then local_lock_t has a 'owner'
member which is checked for consistency, but nothing initialized it to
zero explicitly.

The static initializer does so implicit, and the run time allocated per CPU
storage is usually zero initialized as well, but relying on that is not
really good practice.

Fixes: 91710728d172 ("locking: Introduce local_lock()")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V5: New patch
---
 include/linux/local_lock_internal.h |   42 +++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 19 deletions(-)

--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -14,29 +14,14 @@ typedef struct {
 } local_lock_t;
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
-# define LL_DEP_MAP_INIT(lockname)			\
+# define LOCAL_LOCK_DEBUG_INIT(lockname)		\
 	.dep_map = {					\
 		.name = #lockname,			\
 		.wait_type_inner = LD_WAIT_CONFIG,	\
-		.lock_type = LD_LOCK_PERCPU,			\
-	}
-#else
-# define LL_DEP_MAP_INIT(lockname)
-#endif
+		.lock_type = LD_LOCK_PERCPU,		\
+	},						\
+	.owner = NULL,
 
-#define INIT_LOCAL_LOCK(lockname)	{ LL_DEP_MAP_INIT(lockname) }
-
-#define __local_lock_init(lock)					\
-do {								\
-	static struct lock_class_key __key;			\
-								\
-	debug_check_no_locks_freed((void *)lock, sizeof(*lock));\
-	lockdep_init_map_type(&(lock)->dep_map, #lock, &__key, 0, \
-			      LD_WAIT_CONFIG, LD_WAIT_INV,	\
-			      LD_LOCK_PERCPU);			\
-} while (0)
-
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
 static inline void local_lock_acquire(local_lock_t *l)
 {
 	lock_map_acquire(&l->dep_map);
@@ -51,11 +36,30 @@ static inline void local_lock_release(lo
 	lock_map_release(&l->dep_map);
 }
 
+static inline void local_lock_debug_init(local_lock_t *l)
+{
+	l->owner = NULL;
+}
 #else /* CONFIG_DEBUG_LOCK_ALLOC */
+# define LOCAL_LOCK_DEBUG_INIT(lockname)
 static inline void local_lock_acquire(local_lock_t *l) { }
 static inline void local_lock_release(local_lock_t *l) { }
+static inline void local_lock_debug_init(local_lock_t *l) { }
 #endif /* !CONFIG_DEBUG_LOCK_ALLOC */
 
+#define INIT_LOCAL_LOCK(lockname)	{ LOCAL_LOCK_DEBUG_INIT(lockname) }
+
+#define __local_lock_init(lock)					\
+do {								\
+	static struct lock_class_key __key;			\
+								\
+	debug_check_no_locks_freed((void *)lock, sizeof(*lock));\
+	lockdep_init_map_type(&(lock)->dep_map, #lock, &__key,  \
+			      0, LD_WAIT_CONFIG, LD_WAIT_INV,	\
+			      LD_LOCK_PERCPU);			\
+	local_lock_debug_init(lock);				\
+} while (0)
+
 #define __local_lock(lock)					\
 	do {							\
 		preempt_disable();				\

