Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D843AB045
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 11:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbhFQJxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 05:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbhFQJxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 05:53:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79136C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 02:50:56 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623923454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kggqLOJ7OeJ9+GobtMsHvckm3RGRYbvpUfCsSZ3c1K8=;
        b=MMKs/xVjf5JxNKSlkWZbFqFJlnG1zo/cnW7JJ4xgUy/ghW33YTpWqKovAZhzAyBdQ9dsaf
        ZzduhXFZxmqYlHVMN4P9s4uyZLGbcbXkJlLoPTvvrOLFZbfEBMfKgDRKzfS+s/tPfYwQpS
        oGqxypfU7g1LtJWGVRv6RS1wsBH80jfewVGftJV4YuVh/z1hQ0uFSHxUQbXuF/PWROuwvX
        +R5tqs2k/yhQU4nJMqR2mv6/YeNj+2a6R1gPFZPkhIGivxmNxGEQtziiNpvobot6QVyMlX
        9ydW/7aQECsIppHSWsI/lw6ajbvzWMJQ4fZixvLo3/SJj8p2fhjDYJXJ6k7DaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623923454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kggqLOJ7OeJ9+GobtMsHvckm3RGRYbvpUfCsSZ3c1K8=;
        b=IfKM3rtW0BmscaKGDIqI6vVpAPGEdiOQiT7rMkzcdhmEAm9OeqN+GAa/DuHHoS0hG4R+aH
        VqVWKhCsQk7mxJDg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH next v4 2/2] printk: fix cpu lock ordering
Date:   Thu, 17 Jun 2021 11:56:51 +0206
Message-Id: <20210617095051.4808-3-john.ogness@linutronix.de>
In-Reply-To: <20210617095051.4808-1-john.ogness@linutronix.de>
References: <20210617095051.4808-1-john.ogness@linutronix.de>
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

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 53 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 3 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 08e14a67c44e..5376216e4f3d 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3569,10 +3569,33 @@ int __printk_cpu_trylock(void)
 
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
 		atomic_inc(&printk_cpulock_nested);
@@ -3597,7 +3620,31 @@ void __printk_cpu_unlock(void)
 		return;
 	}
 
-	atomic_set(&printk_cpulock_owner, -1);
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

