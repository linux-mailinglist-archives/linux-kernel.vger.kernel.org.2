Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7A73E90F2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238031AbhHKM1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:27:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50738 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238094AbhHKMXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:23:39 -0400
Message-ID: <20210811121416.294033780@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628684595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=wqEUqv+RphsTuvMw8kU+H6ptt5k3u1F1Mg8Q6pYcvDU=;
        b=BYrV9lL5oWOxNwccXVjY7gq7FsqAmyU05nm04KpI6OZNLSJDdc7RMvmar3WOHNg7WMhcSI
        EzBJS8JMh8hL7SDYKSKiJQesU/1tEh9lzaLTJgVx2sbRh1Q1mSxW2WqeqLmCSLVXF4IZMs
        cmmaNb69BavbSVgF2rFpYes1xhJh/sgFDeX1pBS4Opr5cckWp3UCzNaoeTC2rAvdACVHSv
        HKSTlQSS1zr3CZ2ihpYhAhmB6FLzoh+dQ4YK2Rib8Bmxl7iqJ6gcyzmC6eYPzHk+c9C2NY
        LwiZejNnEPnTawG1IGDTL1jeBAmUb1YydW/qKZNrBqLYkEd01oVtXs0Nd9AvhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628684595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=wqEUqv+RphsTuvMw8kU+H6ptt5k3u1F1Mg8Q6pYcvDU=;
        b=VgnuoVEbvd5GCRkSMVDdnHiDdoj8jRJlz09jpQpsPmNbZEVQ2VOMNHJ5V1YoAYJmmX2Hcw
        2eEanFCgnlhDKPCw==
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
Subject: [patch V4 36/68] locking/ww_mutex: Move ww_mutex declarations into ww_mutex.h
References: <20210811120348.855823694@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Wed, 11 Aug 2021 14:23:15 +0200 (CEST)
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

