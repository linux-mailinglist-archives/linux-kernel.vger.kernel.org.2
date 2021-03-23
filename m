Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2110346B44
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 22:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbhCWVlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 17:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbhCWVjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 17:39:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870F4C061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 14:39:48 -0700 (PDT)
Message-Id: <20210323213708.096477462@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616535587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=hZngBOF/WMIAjvOPxKkDELflT8GbZQDWBYrZa3xDuVo=;
        b=y7mXghTiwjRt47N+AZvuGiFnzTh/QlSMcm/bVidWMBEXiTWNQ64iCTsRQsZ5MjBszTNZvF
        PJHP+bBklZq24mtnKZ3PJx5MbsdjtnWCzvrzXZ5a0NkvWNDQg0ZHN/bd9HjyBkh6TbbR++
        0fOqpUZQPq0b3DgSKmtfmrPfbs7BG4IoPlxlMfKlv+6Qy/eu9wy65rl4gfggt1ynHHhVgj
        Dsq7na2e/PXkUTejBJBCwCOa3X9+HN8RRpLUMHo/WUDg/XjqWsRqvNDcgykDOKMEB528mD
        crHdVs/+CEB8pyPYln9rfiSWsMzRRm1RJL78CYS9+3k44VTxLQTNVu0fBlBPrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616535587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=hZngBOF/WMIAjvOPxKkDELflT8GbZQDWBYrZa3xDuVo=;
        b=dIJF0rBilL66wzi2Iqay1vVLbN39UVfguyR/aPY/hECY59om+IKbj6GMUs7Y0SrW9rEPoX
        CLgRHNWSctk59zAQ==
Date:   Tue, 23 Mar 2021 22:30:25 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch 06/14] locking/rtmutex: Move rt_mutex_debug_task_free() to rtmutex.c
References: <20210323213019.217008708@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for removing the header maze.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/locking/rtmutex-debug.c |    6 ------
 kernel/locking/rtmutex.c       |    8 ++++++++
 2 files changed, 8 insertions(+), 6 deletions(-)

--- a/kernel/locking/rtmutex-debug.c
+++ b/kernel/locking/rtmutex-debug.c
@@ -32,12 +32,6 @@
 
 #include "rtmutex_common.h"
 
-void rt_mutex_debug_task_free(struct task_struct *task)
-{
-	DEBUG_LOCKS_WARN_ON(!RB_EMPTY_ROOT(&task->pi_waiters.rb_root));
-	DEBUG_LOCKS_WARN_ON(task->pi_blocked_on);
-}
-
 void debug_rt_mutex_unlock(struct rt_mutex *lock)
 {
 	DEBUG_LOCKS_WARN_ON(rt_mutex_owner(lock) != current);
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1828,3 +1828,11 @@ bool rt_mutex_cleanup_proxy_lock(struct
 
 	return cleanup;
 }
+
+#ifdef CONFIG_DEBUG_RT_MUTEXES
+void rt_mutex_debug_task_free(struct task_struct *task)
+{
+	DEBUG_LOCKS_WARN_ON(!RB_EMPTY_ROOT(&task->pi_waiters.rb_root));
+	DEBUG_LOCKS_WARN_ON(task->pi_blocked_on);
+}
+#endif

