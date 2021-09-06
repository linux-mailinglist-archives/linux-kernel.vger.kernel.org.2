Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31753401CFF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 16:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243332AbhIFObU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 10:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239556AbhIFObP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 10:31:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF9FC061757
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 07:30:10 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630938607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l0KK4nfyy8V/1Yiq8fva2AAyUfuSISHEkX8ykCOo+Cg=;
        b=vYqfLLMrI36E3KcI9CAKhMBFSvY5CoPvZCbSoaXFaNT/WApsQA8y88asCaEZ3bXwVtDegH
        WjxXRvNQmnmUhzZWCuu85ZxBrVp4MXxhEUx2/WRLPq+Q41hik1nQJh8jREecFGntVS1Qan
        dKk/CRJuVzco2ik6Ezjxp/gbiVJEsHk7MjfCHIeBFpLqIRaFeVnAbxRsQATIR5yB+4tGMx
        43j4GGGzEJA+SQc/uKF6j0Q7GzRiArcP098HcSOyG71qey8X+JEVi7gH3e9CImpu0Pj2wa
        XhHT6iDFB6tedt2lft61cIOBL1fuWJFyaF8toAk/gMxnbjXrCEoLFE3yjf6vnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630938607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l0KK4nfyy8V/1Yiq8fva2AAyUfuSISHEkX8ykCOo+Cg=;
        b=qZZHbzeb+ZxDn+xeCMfwsc2VmvW+9m9EHHVi687DKQylWJ7ZcqM6IGsuSY481AqTlwRjEQ
        Fd8wE2K6LQnMm6DQ==
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/2] locking: Provide spin_is_contended() on PREEMPT_RT
Date:   Mon,  6 Sep 2021 16:30:04 +0200
Message-Id: <20210906143004.2259141-3-bigeasy@linutronix.de>
In-Reply-To: <20210906143004.2259141-1-bigeasy@linutronix.de>
References: <20210906143004.2259141-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

spin_is_contended() should return !=3D 0 if there is a waiter pending on
the lock. This can be checked on PREEMPT_RT's spin lock implementation
by checking if the lock as any waiters pending.

Provide spin_is_contended() on PREEMPT_RT by checking if there are any
waiters.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/spinlock_rt.h  | 3 ++-
 kernel/locking/spinlock_rt.c | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
index 835aedaf68acd..844bc8f9cf091 100644
--- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -39,6 +39,7 @@ extern void rt_spin_unlock(spinlock_t *lock);
 extern void rt_spin_lock_unlock(spinlock_t *lock);
 extern int rt_spin_trylock_bh(spinlock_t *lock);
 extern int rt_spin_trylock(spinlock_t *lock);
+extern int rt_spin_is_contended(spinlock_t *lock);
=20
 static __always_inline void spin_lock(spinlock_t *lock)
 {
@@ -145,7 +146,7 @@ static __always_inline void spin_unlock_irqrestore(spin=
lock_t *lock,
 #define spin_trylock_irqsave(lock, flags)		\
 	__cond_lock(lock, __spin_trylock_irqsave(lock, flags))
=20
-#define spin_is_contended(lock)		(((void)(lock), 0))
+#define spin_is_contended(lock)		rt_spin_is_contended(lock)
=20
 static inline int spin_is_locked(spinlock_t *lock)
 {
diff --git a/kernel/locking/spinlock_rt.c b/kernel/locking/spinlock_rt.c
index d2912e44d61fd..c9acb665277ff 100644
--- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -118,6 +118,12 @@ int __sched rt_spin_trylock_bh(spinlock_t *lock)
 }
 EXPORT_SYMBOL(rt_spin_trylock_bh);
=20
+int __sched rt_spin_is_contended(spinlock_t *lock)
+{
+	return rt_mutex_has_waiters(&lock->lock);
+}
+EXPORT_SYMBOL(rt_spin_is_contended);
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 void __rt_spin_lock_init(spinlock_t *lock, const char *name,
 			 struct lock_class_key *key, bool percpu)
--=20
2.33.0

