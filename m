Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB033E1871
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242623AbhHEPoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:44:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43940 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242435AbhHEPmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:42:11 -0400
Message-ID: <20210805153954.793531767@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628178116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=aycLtfy8gfdPLlQgpHv6K2/4Mae2a+Ak76YMWhVZx6M=;
        b=LBqrAeOBpEE0cKnGTfrPNE9weYVEgkgoFl4Ojak29dQeaRVslZ329JNsQYi1ar7HLnXplF
        4OuqWM3XKqdoVH4ZX8TWwBHXp2dl+5+FkwemB088m/p5DN5rqF1IUXwsdu75Rlz7GO9Ehp
        YpzFRbU4MwngXwgp23c51v18j6hwoqW0SSHhsnrpuO+mCmHDUMkrcFc/rq7iHNsgEHud/s
        m0AXrA9Tolx5mXURwjk4+JZVnw1ndpgXeGzav9aFK+HadRc7GxvTqKwqcj5QIiBAru4bMG
        /WTZtMeLWcPUsME379BIKHkqv3PFR2cwf2L0zKVnVSB86XLsCf7W8eJQFRwqYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628178116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=aycLtfy8gfdPLlQgpHv6K2/4Mae2a+Ak76YMWhVZx6M=;
        b=r4nUmhZ8ql8NSbApii7rzia1jZ+WaB4/OqW/lNgchd1kyjL/SoiGpLYmgyiD4qDDjVaTo+
        HdqYUD9y+LWbdQAg==
Date:   Thu, 05 Aug 2021 17:13:34 +0200
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
Subject: [patch V3 34/64] locking/mutex: Move waiter to core header
References: <20210805151300.330412127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
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

