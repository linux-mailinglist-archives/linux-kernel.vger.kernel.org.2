Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715B53DBA4C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239323AbhG3OVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:21:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55584 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239210AbhG3ORt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:17:49 -0400
Message-ID: <20210730135207.091568049@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627654663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=SCGuJjssLx5VrFwVIGcIOK758a2UqWWbbDEKzmgJPms=;
        b=qL8QCmjDtwmiI0xw6c727qHQue93v1Okv9vmknMHe1oxYLbBLnC1mB6y/f6qx5Jp2g/DmB
        NR4kMmlQTBMniaZbMGPeByKYLnyXyVTBKxrrDKqUVyfEu4mF4hm3hmgwOE1qkst3IpjIw/
        MFzR+WkCvdTaAR86R0lp7dLPBx61cacEnExW31CnTenAp8KaAjg0t7eoH8szacR8pYq4sR
        kz9Ntow72/nb4DP85Sk+A33FZlU5eGYseySP9VPnbISD0CbtuMN9/sBBNBMqYGSyOtst/C
        oGtPEqTHM+kf4EuWjxVQ7C0fZrN+nzkrqguhzbqaLAN+qH3YS9OvmRoqLKLWUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627654663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=SCGuJjssLx5VrFwVIGcIOK758a2UqWWbbDEKzmgJPms=;
        b=2K032RzLVwt6+5uq3Eotj6Cud6kUBB+A+x0Ok6PnRDLz+CKxSrKPwmYtw6nfSgKxXalRn3
        RZeLuTRTml+rhTAg==
Date:   Fri, 30 Jul 2021 15:50:41 +0200
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
Subject: [patch 34/63] locking/ww_mutex: Move ww_mutex declarations into ww_mutex.h
References: <20210730135007.155909613@linutronix.de>
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

