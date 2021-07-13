Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E63D3C7420
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbhGMQRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbhGMQQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:16:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F99C0613E9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:13:58 -0700 (PDT)
Message-Id: <20210713160749.852541474@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626192837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=bKaeEBvAW/CFGnv5Pm4dPdU8WmGX7ylDxN9mPk7Sz6Q=;
        b=jQn5lBth80FsKNRuVdmiJhpGwuuUbrrWArN6+FW6g+VzA5HOckzegrY5s3uXvPXKXXkTcS
        b0btg3Bi3XI+BCOTry5G5k2UiaBjyO5ELH0YpAcypbH0JkE5/1ADnnfHqWb3cdmvdVDaZQ
        oETbgemx+DF/h0RRFgaegy53UiopqqYX4eMgdmxCpv+4ACJJ/h7QQA1jMLVHOdjucsAANo
        atBqXK79CyGmiGMtJkLMxXYYiHG+F6lLgC59UVyuQVPnaRgo2AxIgsZZiRRKnVG0JhRaEB
        VME1TzvL1wE76md2vNHPvMO3yOvOKI9I8rkV07UNKvaUYDLmpxli36L96AotLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626192837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=bKaeEBvAW/CFGnv5Pm4dPdU8WmGX7ylDxN9mPk7Sz6Q=;
        b=30Jvi5fhAR50ptKw2XS94lsJNOZtWowY1BFQiLWxZw98JYN21mI0qlEjczzJjICQSA7liE
        kWJd9N+GMRCmXdCQ==
Date:   Tue, 13 Jul 2021 17:11:34 +0200
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
Subject: [patch 40/50] lib/test_lockup: Adapt to changed variables.
References: <20210713151054.700719949@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
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
 lib/test_lockup.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
---
diff --git a/lib/test_lockup.c b/lib/test_lockup.c
index 864554e76973..906b598740a7 100644
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

