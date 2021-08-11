Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BECD13E90DE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238291AbhHKM0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:26:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50646 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238276AbhHKMYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:24:01 -0400
Message-ID: <20210811121417.360052679@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628684617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=050tNCinaLUdQNXcoguk6eMn+NPBp94IeU5KyABcng4=;
        b=1yd5UN2b4G02ua5973d30c7cAGtWonrGdecpGLCuaCA+YssmZcPIefw/YARWYJGRYrPlYc
        +aEWvKifXAK1MKuMaLoqHX8bvxMd2o9BCY6oYsVv41khELBiWSPWNJ784JHBL2APGl80G9
        u0ScGJbA8VRTOo5V5qfhmFG/GIYaz5ghk74abj6pDVlAE8JGpbnGs5MC6YgwRpRqoXAtOq
        DV+fCsVY+bQg/qBYg7UoRYXfJL441qNjDyhpEaOoj9tvGbqjbxnrgu/29aEU5wBNjfjDtf
        RqVrUFnXBtH9OtdZ2yWxtsq+BAMNiqQQI2W+9W8DufdyQ4/X/w9eM1fZXrQucw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628684617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=050tNCinaLUdQNXcoguk6eMn+NPBp94IeU5KyABcng4=;
        b=H3uSQSOW5Qpx1p7SaKYq0J1UuTe5xoJLxvoUrgmWhHHZgvMfbN04nE4778C8B1hLvXI77M
        nf0k3vbL11dx9YAQ==
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
Subject: [patch V4 54/68] lib/test_lockup: Adapt to changed variables.
References: <20210811120348.855823694@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Wed, 11 Aug 2021 14:23:37 +0200 (CEST)
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

