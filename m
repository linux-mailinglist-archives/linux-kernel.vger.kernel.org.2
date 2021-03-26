Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7FC34AC2E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 17:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhCZQCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 12:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbhCZQBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 12:01:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06744C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 09:01:38 -0700 (PDT)
Message-Id: <20210326153943.646359691@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616774496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=VApx+qoBTb+CbTc9K9ziJfIL+hkRiBdy/Ofb1AlzAnY=;
        b=qRNeb6keoQ8e83rAQ6jO7u5Z6/t8IFujFsja7hPe/EcgFSua5JDv7RKzYsB5va+5dg2MCy
        L/lWe3zVMSv8ka4MWq+8hsbZOQkfT0s1ufEsT9TjkD+o/7n1tGhZ0VTDGRJe83TvAjFAaD
        up1vCtRIfM0eWyzN0mumflI1x+pEG12lFenF86TcF+yvjdDaM5aYtWTKaN8FB8AAm6s3J3
        +0gOit4u3iUaPJbB77CWRZ/pLeC9NGRY8CqdDFTRDV/eRS5xqlRm8y/QhFop83K7LhweZx
        5iTGipys3FTZwu8o/8uuw7ReVNCSspPmYuM9jTnXgXJ1aJsXy338P8u758PqWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616774496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=VApx+qoBTb+CbTc9K9ziJfIL+hkRiBdy/Ofb1AlzAnY=;
        b=o7nq4YGZ8MLbcO7BWfZQxDu95E3YMusOjDgaUtdCqyL3w1451J5dC8gL4dxZhFgYMZTcy1
        y4Zk/d7WXvi9y1BA==
Date:   Fri, 26 Mar 2021 16:29:35 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch V2 06/15] locking/rtmutex: Move rt_mutex_debug_task_free() to
 rtmutex.c
References: <20210326152929.709289883@linutronix.de>
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
@@ -1813,3 +1813,11 @@ bool rt_mutex_cleanup_proxy_lock(struct
 
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

