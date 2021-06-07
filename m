Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D9A39E7F9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 22:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbhFGUEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 16:04:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43066 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhFGUE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 16:04:28 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623096155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bpPFrCt9smKItmSad0Y/rszV18a6VL+4RKyG5Pr6Zx8=;
        b=WSSrGsGqECjc4I0tQ/FpxuPkADC/RbOWMfxcqmF4qb++NCVic8jy9Mntw31CdVmNfEeQmE
        ikXzT9+4VsAD6/8mvYTOWLXC8AAhpc6zpO4ANefsgANET86TVTsePdK5jT3IT0YUlMuF+w
        70S+spJyphXq55O3+M32VhLvDIoqvtUYLTULLiyCaTBmGw4D706FMH8ladHhTALBXeNEEi
        MmW59bZupRSuw3nbqJNBP8uiSsCsG11JJaDKoU084MXf/V8Loa3oxFwyPOq9aCHevM5rK8
        Wa+HeM2yudRYjUDhSbyeYNfL/AkZH0HAb5QFnNKTYWz3Gw/AVaB+XmzRkuUOJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623096155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bpPFrCt9smKItmSad0Y/rszV18a6VL+4RKyG5Pr6Zx8=;
        b=Csrd8EJ43xdRZQuIij+l85q/uWNQ32z4q1CuDAP2gKTPTTBOWMznsC3M2vBgTo+MuFwpYF
        6xXGEErU7SA6F2CQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH next v2 2/2] printk: fix cpu lock ordering
Date:   Mon,  7 Jun 2021 22:02:32 +0200
Message-Id: <20210607200232.22211-3-john.ogness@linutronix.de>
In-Reply-To: <20210607200232.22211-1-john.ogness@linutronix.de>
References: <20210607200232.22211-1-john.ogness@linutronix.de>
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
crashes) and any interruptions should be avoided if possible.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f94babb38493..8c870581cfb4 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3560,10 +3560,29 @@ void printk_cpu_lock_irqsave(bool *lock_flag, unsigned long *irq_flags)
 
 	cpu = smp_processor_id();
 
-	old = atomic_cmpxchg(&printk_cpulock_owner, -1, cpu);
+	/*
+	 * Guarantee loads and stores from the previous lock owner are
+	 * visible to this CPU once it is the lock owner. This pairs
+	 * with cpu_unlock:B.
+	 *
+	 * Memory barrier involvement:
+	 *
+	 * If cpu_lock:A reads from cpu_unlock:B, then cpu_lock:B
+	 * reads from cpu_unlock:A.
+	 *
+	 * Relies on:
+	 *
+	 * RELEASE from cpu_unlock:A to cpu_unlock:B
+	 *    matching
+	 * ACQUIRE from cpu_lock:A to cpu_lock:B
+	 */
+	old = atomic_cmpxchg_acquire(&printk_cpulock_owner,
+				     -1, cpu); /* LMM(cpu_lock:A) */
 	if (old == -1) {
 		/* This CPU is now the owner. */
 
+		/* This CPU begins loading/storing data: LMM(cpu_lock:B) */
+
 		*lock_flag = true;
 
 	} else if (old == cpu) {
@@ -3600,7 +3619,14 @@ EXPORT_SYMBOL(printk_cpu_lock_irqsave);
 void printk_cpu_unlock_irqrestore(bool lock_flag, unsigned long irq_flags)
 {
 	if (lock_flag) {
-		atomic_set(&printk_cpulock_owner, -1);
+		/* This CPU is finished loading/storing data: LMM(cpu_unlock:A) */
+
+		/*
+		 * Guarantee loads and stores from this CPU when it was the
+		 * lock owner are visible to the next lock owner. This pairs
+		 * with cpu_lock:A.
+		 */
+		atomic_set_release(&printk_cpulock_owner, -1); /* LMM(cpu_unlock:B) */
 
 		local_irq_restore(irq_flags);
 	}
-- 
2.20.1

