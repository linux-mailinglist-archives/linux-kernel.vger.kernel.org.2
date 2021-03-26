Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96FB034AC37
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 17:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbhCZQCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 12:02:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55964 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbhCZQBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 12:01:48 -0400
Message-Id: <20210326153944.533811987@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616774507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=kwXvduz9A1j/SMH2e5liaCiD63swa5ezJ9mHUtX4Azo=;
        b=YvWJ1qcY89KJuu48oGSFEcjl6WPeYko6UX29wLmqBdsxdLoEGbllv9hvURJGFE0wAtGbiX
        5XObblt7POr32GG7ZJHD7X3smeQ/jJNARKkkNKVpcgAC1qG6LSS/XgtdJ1mjKlE7kvd6nK
        iLjRhRMtUvWIiDwkvDX9TEF4dcRJaA3OGr/5Zu86L4rrJTdJTXVKMM4wTTkP9IuPlQ9Hbf
        PSt5NW6aAZiZVOiXdmMHofQLD3iGgVmSwp7KNXU1X82aQelMdHyRY+c2BWv7K9QhnxTX7X
        OgYM+AgfCkoF6n9hziA2uwcXqlkDiIpk86MMmj4vOl4vUdmB9zF2k0L1FACsqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616774507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=kwXvduz9A1j/SMH2e5liaCiD63swa5ezJ9mHUtX4Azo=;
        b=MhOeGUXWKpwETRzX/kShku/R64yijCpYVodD3k54FbOMOLz+uNmfIJuJfqqwEGP0SVZzEn
        v6lJtsVUNOMpQ2AQ==
Date:   Fri, 26 Mar 2021 16:29:44 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch V2 15/15] locking/rtmutex: Cleanup signal handling in
 __rt_mutex_slowlock()
References: <20210326152929.709289883@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The signal handling in __rt_mutex_slowlock() is open coded.

Use signal_pending_state() instead.

Aside of the cleanup this also prepares for the RT lock substituions which
require support for TASK_KILLABLE.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/locking/rtmutex.c |   19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1146,18 +1146,13 @@ static int __sched __rt_mutex_slowlock(s
 		if (try_to_take_rt_mutex(lock, current, waiter))
 			break;
 
-		/*
-		 * TASK_INTERRUPTIBLE checks for signals and
-		 * timeout. Ignored otherwise.
-		 */
-		if (likely(state == TASK_INTERRUPTIBLE)) {
-			/* Signal pending? */
-			if (signal_pending(current))
-				ret = -EINTR;
-			if (timeout && !timeout->task)
-				ret = -ETIMEDOUT;
-			if (ret)
-				break;
+		if (timeout && !timeout->task) {
+			ret = -ETIMEDOUT;
+			break;
+		}
+		if (signal_pending_state(state, current)) {
+			ret = -EINTR;
+			break;
 		}
 
 		raw_spin_unlock_irq(&lock->wait_lock);

