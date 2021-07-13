Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B693C7418
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbhGMQRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:17:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54526 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbhGMQQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:16:39 -0400
Message-Id: <20210713160749.161666350@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626192828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=IiGR7KFfPPYyNIkSwFeSsUhfqtNPAVXD3EML4m2TpQw=;
        b=rJPmgZ7pOtlLG9wlVvWYxcIWlR2Suw84VunjDvK1p5heSdzRdsJDMypWkQwdz//ThK7GzS
        LMqZfAu8Q/9rQuVNg1TB+bnLFCzdbDqJSH1Fb1OzLNZ9sOLIfYJaICL6Gp20bIyypl7d0h
        SHqo+PVJAC83StzdtZ5qv+qkezdIIbrUOXUqjPJgbaRHCVr7QkYxhmREOYhR5yvtz6KTWO
        NHyVhtE5fh8QFyGRnNyPsF1YGZ7IauLJiztUKBGGy7Z/FkuXFAGmQ4wtmUzt8PHeQ+3Sz8
        QYdJ5hcvRfAse4jZKEL4kO2o5l2z1IKNOZzrQFUkRth1z3JrMCqX6Ej3BqaP3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626192828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=IiGR7KFfPPYyNIkSwFeSsUhfqtNPAVXD3EML4m2TpQw=;
        b=AxJ9jFUQ/g/ZVugijf43dUSxifZYOm/UVKg8iCU78loUeHuS/ZWWPHir65M8NktJumenuv
        y2hR7jNSbPo3eUCQ==
Date:   Tue, 13 Jul 2021 17:11:27 +0200
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
Subject: [patch 33/50] locking/mutex: Introduce _mutex_t
References: <20210713151054.700719949@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

PREEMPT_RT replaces 'struct mutex' with a rtmutex based variant so all
mutex operations are included into the priority inheritance scheme.

But a complete replacement of the mutex implementation would require to
reimplement ww_mutex on top of the rtmutex based variant. That has been
tried, but the outcome was suboptimal.

As ww_mutex is mostly used in DRM and the code pathes are not really
relevant to typical RT applications, it's also hard to argue for a full
reimplementation which can't even share code with the regular ww_mutex code
adding the risk of diversion and different bugs in both code bases.

The alternative solution is to make it possible to compile the ww_mutex
specific part of the regular mutex implementation as is on RT and have a
rtmutex based 'struct mutex' variant.

As the regular mutex and ww_mutex implementation are tightly coupled
(ww_mutex has a 'struct mutex' inside) and share a lot of code (ww_mutex is
mostly an extension) a simple replacement of 'struct mutex' does not work.

To solve this attach a typedef to 'struct mutex': _mutex_t

This new type is then used to replace 'struct mutex' in 'struct ww_mutex',
in a few helper functions and in the actual regular mutex code. None of the
actual usage sites of mutexes are affected.

That allows in the final step to have a RT specific 'struct mutex' and the
regular _mutex_t type.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/mutex.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)
---
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 0bbc872ba72b..87dafe179ed2 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -48,7 +48,13 @@
  * - detects multi-task circular deadlocks and prints out all affected
  *   locks and tasks (and only those tasks)
  */
-struct mutex {
+
+/*
+ * Typedef _mutex_t for ww_mutex and core code to allow ww_mutex being
+ * built on the regular mutex code in RT kernels while mutex itself is
+ * substituted by a rt_mutex.
+ */
+typedef struct mutex {
 	atomic_long_t		owner;
 	raw_spinlock_t		wait_lock;
 #ifdef CONFIG_MUTEX_SPIN_ON_OWNER
@@ -61,7 +67,7 @@ struct mutex {
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map	dep_map;
 #endif
-};
+} _mutex_t;
 
 #ifdef CONFIG_DEBUG_MUTEXES
 

