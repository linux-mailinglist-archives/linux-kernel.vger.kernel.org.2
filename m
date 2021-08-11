Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B583A3E90D0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238049AbhHKMZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237920AbhHKMXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:23:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654B7C0613D5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 05:23:15 -0700 (PDT)
Message-ID: <20210811121416.235417139@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628684594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=aycLtfy8gfdPLlQgpHv6K2/4Mae2a+Ak76YMWhVZx6M=;
        b=mC59+oitlVKtCp2fajo++Iy+28rrqxRDhaGTVR29gSrKULAYIXYb7DUx2CwhIYno+q7gFb
        9KopmzQZOmLucKEJdSFtmzKIqYTBswqTgA4fNmqomMcXguY8VPFY0Yr2TdJWrTkkQtrTOU
        oM8Ud8r+gAhNp9CPj+mgXRvP8f04kpCgOuE08C2aVzSUXzMjI1C6caCtColqQ7Lg0qGfya
        XYF0rvcl6nWxWVs2Cet6p2yPEgvHRF5O6FFtcslwm4C+wStSt249mtoFm5DO7UIZR2ZsZQ
        l2xP3EaATHml5q8YtPuXpCoxP4VLVsoFJpcU6rJUO3vK22PUqmzmbIFARq9t+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628684594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=aycLtfy8gfdPLlQgpHv6K2/4Mae2a+Ak76YMWhVZx6M=;
        b=89dGKUn5+l+VbbIjdn1bEAfvc6+dSwQs4SiqH0mY2EAWGQiRena4MbNQSWqqng8wzSJTy7
        dFrbGAfYhLv8akDg==
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
Subject: [patch V4 35/68] locking/mutex: Move waiter to core header
References: <20210811120348.855823694@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Wed, 11 Aug 2021 14:23:13 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Move the mutex waiter declaration from the global to the core local
header. There is no reason to expose it outside of the core code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/mutex.h  |   13 -------------
 kernel/locking/mutex.h |   13 +++++++++++++
 2 files changed, 13 insertions(+), 13 deletions(-)
---
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -74,19 +74,6 @@ struct ww_mutex {
 #endif
 };
 
-/*
- * This is the control structure for tasks blocked on mutex,
- * which resides on the blocked task's kernel stack:
- */
-struct mutex_waiter {
-	struct list_head	list;
-	struct task_struct	*task;
-	struct ww_acquire_ctx	*ww_ctx;
-#ifdef CONFIG_DEBUG_MUTEXES
-	void			*magic;
-#endif
-};
-
 #ifdef CONFIG_DEBUG_MUTEXES
 
 #define __DEBUG_MUTEX_INITIALIZER(lockname)				\
--- a/kernel/locking/mutex.h
+++ b/kernel/locking/mutex.h
@@ -7,6 +7,19 @@
  *  Copyright (C) 2004, 2005, 2006 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
  */
 
+/*
+ * This is the control structure for tasks blocked on mutex, which resides
+ * on the blocked task's kernel stack:
+ */
+struct mutex_waiter {
+	struct list_head	list;
+	struct task_struct	*task;
+	struct ww_acquire_ctx	*ww_ctx;
+#ifdef CONFIG_DEBUG_MUTEXES
+	void			*magic;
+#endif
+};
+
 #ifdef CONFIG_DEBUG_MUTEXES
 extern void debug_mutex_lock_common(struct mutex *lock,
 				    struct mutex_waiter *waiter);

