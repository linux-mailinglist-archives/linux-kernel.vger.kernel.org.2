Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F933ECB55
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 23:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbhHOVcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 17:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbhHOV3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 17:29:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED52C061764
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 14:29:04 -0700 (PDT)
Message-ID: <20210815211305.137982730@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629062943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=050tNCinaLUdQNXcoguk6eMn+NPBp94IeU5KyABcng4=;
        b=ndeboZ1LYiLo/qzZcyg0xPepojF54JPTYBCOU+JmZGbIz6gc1Y8MnIPTBpWiQyWeQ647YJ
        8NuzE3U1Di0ru0kT+y9mKgXPjYITstsriWIUi3TfFC4Y/dfVFaTxsN+O8hfNE9Loi7jqIC
        hYA8d2GUohBoBBvUwQSkc/FHtVsqGjNELM5q45PzQcBMFyheYPVmPSiVwYHaVY/YQIFep8
        7D8ZHYs+M381/tjtxJeVzTQMOkMB9TrGlDvRCgiuGc2ehjHU6ZiiLf7D9TI6IYABmYZqY+
        BxSPEE9GzODuRFJqmofSc9bsbIa3jWssoXwolKTMq3foC5xuGB/gb9E9Z8968Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629062943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=050tNCinaLUdQNXcoguk6eMn+NPBp94IeU5KyABcng4=;
        b=rAfTJvZn/LckPTCZe4PruSsnq1b1XQR79IyLeQ7ONYt/hgVBCo8EnXL2ELCmr3jo+6gYR8
        JOG2+TGdfFt9XYCg==
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
Subject: [patch V5 56/72] lib/test_lockup: Adapt to changed variables.
References: <20210815203225.710392609@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Sun, 15 Aug 2021 23:29:03 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The inner parts of certain locks (mutex, rwlocks) changed due to a rework for
RT and non RT code. Most users remain unaffected, but those who fiddle around
in the inner parts need to be updated.

Match the struct names to the new layout.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 lib/test_lockup.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
---
--- a/lib/test_lockup.c
+++ b/lib/test_lockup.c
@@ -485,13 +485,13 @@ static int __init test_lockup_init(void)
 		       offsetof(spinlock_t, lock.wait_lock.magic),
 		       SPINLOCK_MAGIC) ||
 	    test_magic(lock_rwlock_ptr,
-		       offsetof(rwlock_t, rtmutex.wait_lock.magic),
+		       offsetof(rwlock_t, rwbase.rtmutex.wait_lock.magic),
 		       SPINLOCK_MAGIC) ||
 	    test_magic(lock_mutex_ptr,
-		       offsetof(struct mutex, lock.wait_lock.magic),
+		       offsetof(struct mutex, rtmutex.wait_lock.magic),
 		       SPINLOCK_MAGIC) ||
 	    test_magic(lock_rwsem_ptr,
-		       offsetof(struct rw_semaphore, rtmutex.wait_lock.magic),
+		       offsetof(struct rw_semaphore, rwbase.rtmutex.wait_lock.magic),
 		       SPINLOCK_MAGIC))
 		return -EINVAL;
 #else
@@ -502,7 +502,7 @@ static int __init test_lockup_init(void)
 		       offsetof(rwlock_t, magic),
 		       RWLOCK_MAGIC) ||
 	    test_magic(lock_mutex_ptr,
-		       offsetof(struct mutex, wait_lock.rlock.magic),
+		       offsetof(struct mutex, wait_lock.magic),
 		       SPINLOCK_MAGIC) ||
 	    test_magic(lock_rwsem_ptr,
 		       offsetof(struct rw_semaphore, wait_lock.magic),

