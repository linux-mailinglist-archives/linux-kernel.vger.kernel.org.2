Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6343C7416
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbhGMQRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:17:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54372 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbhGMQQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:16:35 -0400
Message-Id: <20210713160748.881918412@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626192825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=kfaza58aB2+BAOTwDmtVwXlCofzchuJZV6mfs2kfRlQ=;
        b=esJBN2rfSXnW7dyT3DWHcv7elO+PR2P+d0kFVrlbvTXF1GyFhpG82aZw9fDtubfB2TxZBV
        vyE0nN+HX5rqkvi0nOKzC1s1Ifu9jI0ZAu3yaevxBwz1cSPZi9RWa3PvfeMmTvcmHgxUax
        6idYtBLM5+RDRngnShRdOMx0PZe+S4UhdUoA7E6xh3oObsnb+9+5AtEUgMM9MRBfILYM56
        Wk2kLU9X0g1GBsIRoo+13ZC/BlOTItkAFjQXNdJaXr8tM5AlTyCwOferyAwkg29ScDfFfF
        s8MxtAQJ5T+HAs2IZlXxb+/XUCAhRrlNBLrDjJK5OETMPCTXls62iCkYkty0wQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626192825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=kfaza58aB2+BAOTwDmtVwXlCofzchuJZV6mfs2kfRlQ=;
        b=2db4ZkCdBsBAMT0Lcgq1jmE+vnVp9WP9wc7b4lhKlSyrPbPqeiCijtb0T8MRFyep7o9Vn3
        HWQdJcfNMSRCE0Aw==
Date:   Tue, 13 Jul 2021 17:11:24 +0200
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
Subject: [patch 30/50] locking/mutex: Move waiter to core header
References: <20210713151054.700719949@linutronix.de>
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
 include/linux/mutex.h  | 13 -------------
 kernel/locking/mutex.h | 13 +++++++++++++
 2 files changed, 13 insertions(+), 13 deletions(-)
---
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index e19323521f9c..62bafee747e9 100644
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
diff --git a/kernel/locking/mutex.h b/kernel/locking/mutex.h
index 183965942cde..8d1b0ee49062 100644
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

