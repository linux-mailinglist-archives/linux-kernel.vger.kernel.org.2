Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B30093E90F7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238848AbhHKM1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238565AbhHKMZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:25:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96579C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 05:23:47 -0700 (PDT)
Message-ID: <20210811121417.773195651@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628684626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=i9qzRf/Z+ZglHS2rRHSdmK+iMZ9zevDJTHrQclLJDyU=;
        b=nHnOcFOOBzaKHF3RftUdmNAP3pYC+CT1mzUIY/VHyDrSwZ/9Oo0RpFN6D9roSmljgh2szJ
        IlSKmYnvIdxFHRFU/tiea30wC97JTjVzsuRfuC4L77iAOhsfWNDkxRXSN+HJP+7biHmlI9
        ocR+f6YgWGyEMNN6p3kb5o77DhweZQD40BzqKY5abDcTfX/XV/uUdjwLvglUBLzL7PUUDH
        WYuKcqRSgo2kX9UW+Sio50OhYrU0sU4I6xc2EZykJ/szZQgHnfX3Z8RaeY0z4NWY/FiKYe
        SeS8R+xwBjPI10XG7M1SHOl4RwGYs6EJIeJpoga5vv7gr+COZd4/sqQzKkQlWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628684626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=i9qzRf/Z+ZglHS2rRHSdmK+iMZ9zevDJTHrQclLJDyU=;
        b=g9nMaLk8A68qybOM3K/tHeAyNLbeaMCGTrXeqaDxR/lYrsWDL2qEJlM7oEeW6yKvy6wnAE
        q/AlbOMZb62e58CQ==
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
Subject: [patch V4 61/68] futex: Clarify comment in futex_requeue()
References: <20210811120348.855823694@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Wed, 11 Aug 2021 14:23:46 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The comment about the restriction of the number of waiters to wake for the
REQUEUE_PI case is confusing at best. Rewrite it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/futex.c |   28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)
---
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1939,15 +1939,27 @@ static int futex_requeue(u32 __user *uad
 		 */
 		if (refill_pi_state_cache())
 			return -ENOMEM;
+
 		/*
-		 * requeue_pi must wake as many tasks as it can, up to nr_wake
-		 * + nr_requeue, since it acquires the rt_mutex prior to
-		 * returning to userspace, so as to not leave the rt_mutex with
-		 * waiters and no owner.  However, second and third wake-ups
-		 * cannot be predicted as they involve race conditions with the
-		 * first wake and a fault while looking up the pi_state.  Both
-		 * pthread_cond_signal() and pthread_cond_broadcast() should
-		 * use nr_wake=1.
+		 * futex_requeue() allows the caller to define the number
+		 * of waiters to wake up via the @nr_wake argument. With
+		 * REQUEUE_PI waking up more than one waiter is creating
+		 * more problems than it solves. Waking up a waiter makes
+		 * only sense if the PI futex @uaddr2 is uncontended as
+		 * this allows the requeue code to acquire the futex
+		 * @uaddr2 before waking the waiter. The waiter can then
+		 * return to user space without further action. A secondary
+		 * wakeup would just make the futex_wait_requeue_pi()
+		 * handling more complex because that code would have to
+		 * look up pi_state and do more or less all the handling
+		 * which the requeue code has to do for the to be requeued
+		 * waiters. So restrict the number of waiters to wake to
+		 * one and only wake it up when the PI futex is
+		 * uncontended. Otherwise requeue it and let the unlock of
+		 * the PI futex handle the wakeup.
+		 *
+		 * All REQUEUE_PI users, e.g. pthread_cond_signal() and
+		 * pthread_cond_broadcast() must use nr_wake=1.
 		 */
 		if (nr_wake != 1)
 			return -EINVAL;

