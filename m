Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBAA33C7417
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbhGMQRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbhGMQQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:16:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9CDC061786
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:13:47 -0700 (PDT)
Message-Id: <20210713160748.976800694@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626192826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=tsBaskijRYNDUxX6NfDiuLjF2dz0Rv/0p2pUQ1IXE+g=;
        b=JKHCOTngakUYODGTlYTKzOV/+VRZTu7JqAFgQ+2UFfF6d/VxORns57VEtT3BMZbw6Fy7Gf
        yHoOV2Ze2EL6P7u1b9c4Amf66TY0gK76ZUl179J4xa281rCZtnsiWprlK/Fg+x+Z15mJEQ
        19+cIBO4VfE7PHZ95E84U9Fx7KoRXQ7FmvMhurF0yZJXLQiIOlmY+9GJSin9SELFv88glL
        uTYCVlxDBy6BAdgTZhyd1EP6Tc7DrSkUNN/bP/tTESTbt59Dht2lnxYRRWB1+PYjz9v8uT
        xitHYE2q6908pB+yMeDWY+qxSOm1kRNbvP0gtIWFHHsGU0kwfsfMiItywJTtfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626192826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=tsBaskijRYNDUxX6NfDiuLjF2dz0Rv/0p2pUQ1IXE+g=;
        b=G4Iw+YroC6q3vGzdidJfOiVSN8UyrYMaP5QfE1eIT6jJ2hz0PrFcqJ8f6p3xSxWk4h+FrJ
        XSylkAiW60ob7hCg==
Date:   Tue, 13 Jul 2021 17:11:25 +0200
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
Subject: [patch 31/50] locking/ww_mutex: Move ww_mutex declarations into ww_mutex.h
References: <20210713151054.700719949@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Move the ww_mutex declarations into the ww_mutex specific header where they
belong.

Preperatory change to allow compiling ww_mutex standalone.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/mutex.h    | 11 -----------
 include/linux/ww_mutex.h |  8 ++++++++
 2 files changed, 8 insertions(+), 11 deletions(-)
---
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 62bafee747e9..db3367586a06 100644
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
diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
index b77f39f319ad..590aaa207757 100644
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

