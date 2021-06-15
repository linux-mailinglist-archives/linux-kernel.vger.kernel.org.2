Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A106D3A8818
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbhFORv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbhFORvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:51:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E90C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 10:49:50 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623779389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jxWt15QAmZLbmx/Jgo/mRfCWcLQej8sKQZwKW9m09XQ=;
        b=WEt/drxvIrzx/B0w6Zb1Pc7iF1+K5lw5XSZsKRANcLYo8bmSsK/I6JkeG2vmuJlnmx2aq8
        g/vHwVzfmOn7Ml6ZMbc3iR8w5+Mh5nxwwcNnDQTJXaiQ4I8sjfUgOARiQWey6y/FHaB99+
        SbvKNRfHd2COorKQBuMPnUy+/G4RZA5Rj5LTVI4FxbUU5WmJOrVy1odIrTgSYjBHzXij83
        ZTqwPlPjaTlceAxhslAi0Zs+Duu0bHw8roIfo5JVPJEAvtEo83lkWDU41VzlxSecB2HJKh
        4a+UmKNbwe6/qFi6WhXR3Kwa0yZkcQMc9KhTvTOd8aIEKsSJeRlFdstF9LPOzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623779389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jxWt15QAmZLbmx/Jgo/mRfCWcLQej8sKQZwKW9m09XQ=;
        b=E7yityPBWloAR+nJppFf1UJsLdezeyCzUJ+kuMsbQSs9Lgc5IVOAMaAGP45Zct04ZkT6jl
        izMXaBX9BxK/vYCA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH next v3 2/2] printk: fix cpu lock ordering
Date:   Tue, 15 Jun 2021 19:55:47 +0206
Message-Id: <20210615174947.32057-3-john.ogness@linutronix.de>
In-Reply-To: <20210615174947.32057-1-john.ogness@linutronix.de>
References: <20210615174947.32057-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpu lock implementation uses a full memory barrier to take
the lock, but no memory barriers when releasing the lock. This
means that changes performed by a lock owner may not be seen by
the next lock owner. This may have been "good enough" for use
by dump_stack() as a serialization mechanism, but it is not
enough to provide proper protection for a critical section.

Correct this problem by using acquire/release memory barriers
for lock/unlock, respectively.

Note that it is not necessary for a cpu lock to disable
interrupts. However, in upcoming work this cpu lock will be used
for emergency tasks (for example, atomic consoles during kernel
crashes) and any interruptions while holding the cpu lock should
be avoided if possible.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 53 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 3 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 5369d8f33299..e67dc510fa1b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3567,10 +3567,33 @@ int __printk_cpu_trylock(void)
 
 	cpu = smp_processor_id();
 
-	old = atomic_cmpxchg(&printk_cpulock_owner, -1, cpu);
+	/*
+	 * Guarantee loads and stores from this CPU when it is the lock owner
+	 * are _not_ visible to the previous lock owner. This pairs with
+	 * __printk_cpu_unlock:B.
+	 *
+	 * Memory barrier involvement:
+	 *
+	 * If __printk_cpu_trylock:A reads from __printk_cpu_unlock:B, then
+	 * __printk_cpu_unlock:A can never read from __printk_cpu_trylock:B.
+	 *
+	 * Relies on:
+	 *
+	 * RELEASE from __printk_cpu_unlock:A to __printk_cpu_unlock:B
+	 * of the previous CPU
+	 *    matching
+	 * ACQUIRE from __printk_cpu_trylock:A to __printk_cpu_trylock:B
+	 * of this CPU
+	 */
+	old = atomic_cmpxchg_acquire(&printk_cpulock_owner, -1,
+				     cpu); /* LMM(__printk_cpu_trylock:A) */
 	if (old == -1) {
-		/* This CPU is now the owner. */
+		/*
+		 * This CPU is now the owner and begins loading/storing
+		 * data: LMM(__printk_cpu_trylock:B)
+		 */
 		return 1;
+
 	} else if (old == cpu) {
 		/* This CPU is already the owner. */
 		printk_cpulock_nested = true;
@@ -3595,7 +3618,31 @@ void __printk_cpu_unlock(void)
 		return;
 	}
 
-	atomic_set_release(&printk_cpulock_owner, -1);
+	/*
+	 * This CPU is finished loading/storing data:
+	 * LMM(__printk_cpu_unlock:A)
+	 */
+
+	/*
+	 * Guarantee loads and stores from this CPU when it was the
+	 * lock owner are visible to the next lock owner. This pairs
+	 * with __printk_cpu_trylock:A.
+	 *
+	 * Memory barrier involvement:
+	 *
+	 * If __printk_cpu_trylock:A reads from __printk_cpu_unlock:B,
+	 * then __printk_cpu_trylock:B reads from __printk_cpu_unlock:A.
+	 *
+	 * Relies on:
+	 *
+	 * RELEASE from __printk_cpu_unlock:A to __printk_cpu_unlock:B
+	 * of this CPU
+	 *    matching
+	 * ACQUIRE from __printk_cpu_trylock:A to __printk_cpu_trylock:B
+	 * of the next CPU
+	 */
+	atomic_set_release(&printk_cpulock_owner,
+			   -1); /* LMM(__printk_cpu_unlock:B) */
 }
 EXPORT_SYMBOL(__printk_cpu_unlock);
 #endif /* CONFIG_SMP */
-- 
2.20.1

