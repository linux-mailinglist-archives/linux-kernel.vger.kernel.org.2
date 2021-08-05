Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21AE83E188B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242689AbhHEPoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:44:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44092 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242441AbhHEPmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:42:13 -0400
Message-ID: <20210805153954.849972718@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628178118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=wqEUqv+RphsTuvMw8kU+H6ptt5k3u1F1Mg8Q6pYcvDU=;
        b=0/0oE99s6RNNtrIp7YZnTdY6d4/1mbU6Voj02aOXvCEwxNGUqWPwbyLCt8otz32rlsT/hE
        bYop47w8L05Ug7872uWERlahjRYMjEn6+Pzkxheqlt8j64Df6UlXonvlXAiTy967t/W52P
        mWB/XgoTIqTXjWSqeAZnZ/C17SMGD96Bvnnh1OsZL5mHe+Aj5Mu64r+nnClpbW5R+Coj7v
        Kmnsud0MitkXwmKyrBHhQSBbfz5lwLbb4DeJHVxSWJphMejzLqycNgJxNmu3jTZldjZ56f
        WSMJIA6kE6yC7Kqgei0IucntqLRfIOILXfQvy2Vv4M4kIrCrGirtcbs0GT2ieg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628178118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=wqEUqv+RphsTuvMw8kU+H6ptt5k3u1F1Mg8Q6pYcvDU=;
        b=iCeo76QB4J7t7TAXYmvis04d+ngmefLeJ0c5vZw5sTC068knDkmRC/kSga//KV4XqHkg/a
        4H3jXymmrOl2ExBg==
Date:   Thu, 05 Aug 2021 17:13:35 +0200
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
Subject: [patch V3 35/64] locking/ww_mutex: Move ww_mutex declarations into ww_mutex.h
References: <20210805151300.330412127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Move the ww_mutex declarations into the ww_mutex specific header where they
belong.

Preparatory change to allow compiling ww_mutex standalone.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/mutex.h    |   11 -----------
 include/linux/ww_mutex.h |    8 ++++++++
 2 files changed, 8 insertions(+), 11 deletions(-)
---
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -20,9 +20,6 @@
 #include <linux/osq_lock.h>
 #include <linux/debug_locks.h>
 
-struct ww_class;
-struct ww_acquire_ctx;
-
 /*
  * Simple, straightforward mutexes with strict semantics:
  *
@@ -66,14 +63,6 @@ struct mutex {
 #endif
 };
 
-struct ww_mutex {
-	struct mutex base;
-	struct ww_acquire_ctx *ctx;
-#ifdef CONFIG_DEBUG_MUTEXES
-	struct ww_class *ww_class;
-#endif
-};
-
 #ifdef CONFIG_DEBUG_MUTEXES
 
 #define __DEBUG_MUTEX_INITIALIZER(lockname)				\
--- a/include/linux/ww_mutex.h
+++ b/include/linux/ww_mutex.h
@@ -28,6 +28,14 @@ struct ww_class {
 	unsigned int is_wait_die;
 };
 
+struct ww_mutex {
+	struct mutex base;
+	struct ww_acquire_ctx *ctx;
+#ifdef CONFIG_DEBUG_MUTEXES
+	struct ww_class *ww_class;
+#endif
+};
+
 struct ww_acquire_ctx {
 	struct task_struct *task;
 	unsigned long stamp;

