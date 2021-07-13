Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A5C3C740F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbhGMQQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbhGMQQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:16:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D47C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:13:36 -0700 (PDT)
Message-Id: <20210713160748.090645860@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626192815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=qp+663P1V8ANdJJ2Sy0wgjaBdXQ4ULC2tiDaDzsivU0=;
        b=Otc97eYS+CYBrOu2LzqIkGiM4/jY77e+oqw4FdRJycZ9e9bWB1astR6Y055Tf2Wlk74I00
        qLVNMBoYH4r2iDANqg1v+g6RtiShMal22GAF9VU3rfGqhDFE6gyLC8Ftyq+S75kpdHyEuY
        RbUfSxxkw10ETnHPw/aYQ8G23SmU1sld/d/06vqg4qr4dTbr/y8Y7rx/5LY1Eun4c8xY6p
        BkfgRXVLhmTGo43/1ktFs01QtMOO48JVk0ZZR1z+ePQSk7opypySm845dFVQfDOi3CHMrt
        D6Z7UqrhJvlTwRQzqkSJJQJyUdmj2pGtgCTKRfQO5lV2ppB5n+G2X+4qmkPewg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626192815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=qp+663P1V8ANdJJ2Sy0wgjaBdXQ4ULC2tiDaDzsivU0=;
        b=DPBSjhyd558ExRRoFRuVtkNxMkI+amPq9pHkMwqF72hw+ACEIuXYJ7OnJU84txz51bA1V7
        zBqxJ041HEzZUSCg==
Date:   Tue, 13 Jul 2021 17:11:16 +0200
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
Subject: [patch 22/50] rbtree: Split out the rbtree type definitions
References: <20210713151054.700719949@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

rtmutex.h needs the definition of struct rb_root_cached. rbtree.h includes
kernel.h which includes spinlock.h. That works nicely for non-RT enabled
kernels, but on RT enabled kernels spinlocks are based on rtmutexes which
creates another circular header dependency as spinlocks.h will require
rtmutex.h.

Split out the type definitions and move them into their own header file so
the rtmutex header can include just those.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/rbtree.h       | 30 +-----------------------------
 include/linux/rbtree_types.h | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 29 deletions(-)
 create mode 100644 include/linux/rbtree_types.h
---
diff --git a/include/linux/rbtree.h b/include/linux/rbtree.h
index d31ecaf4fdd3..36a0e7226ec5 100644
--- a/include/linux/rbtree.h
+++ b/include/linux/rbtree.h
@@ -19,22 +19,11 @@
 
 #include <linux/kernel.h>
 #include <linux/stddef.h>
+#include <linux/rbtree_types.h>
 #include <linux/rcupdate.h>
 
-struct rb_node {
-	unsigned long  __rb_parent_color;
-	struct rb_node *rb_right;
-	struct rb_node *rb_left;
-} __attribute__((aligned(sizeof(long))));
-    /* The alignment might seem pointless, but allegedly CRIS needs it */
-
-struct rb_root {
-	struct rb_node *rb_node;
-};
-
 #define rb_parent(r)   ((struct rb_node *)((r)->__rb_parent_color & ~3))
 
-#define RB_ROOT	(struct rb_root) { NULL, }
 #define	rb_entry(ptr, type, member) container_of(ptr, type, member)
 
 #define RB_EMPTY_ROOT(root)  (READ_ONCE((root)->rb_node) == NULL)
@@ -112,23 +101,6 @@ static inline void rb_link_node_rcu(struct rb_node *node, struct rb_node *parent
 			typeof(*pos), field); 1; }); \
 	     pos = n)
 
-/*
- * Leftmost-cached rbtrees.
- *
- * We do not cache the rightmost node based on footprint
- * size vs number of potential users that could benefit
- * from O(1) rb_last(). Just not worth it, users that want
- * this feature can always implement the logic explicitly.
- * Furthermore, users that want to cache both pointers may
- * find it a bit asymmetric, but that's ok.
- */
-struct rb_root_cached {
-	struct rb_root rb_root;
-	struct rb_node *rb_leftmost;
-};
-
-#define RB_ROOT_CACHED (struct rb_root_cached) { {NULL, }, NULL }
-
 /* Same as rb_first(), but O(1) */
 #define rb_first_cached(root) (root)->rb_leftmost
 
diff --git a/include/linux/rbtree_types.h b/include/linux/rbtree_types.h
new file mode 100644
index 000000000000..45b6ecde3665
--- /dev/null
+++ b/include/linux/rbtree_types.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _LINUX_RBTREE_TYPES_H
+#define _LINUX_RBTREE_TYPES_H
+
+struct rb_node {
+	unsigned long  __rb_parent_color;
+	struct rb_node *rb_right;
+	struct rb_node *rb_left;
+} __attribute__((aligned(sizeof(long))));
+/* The alignment might seem pointless, but allegedly CRIS needs it */
+
+struct rb_root {
+	struct rb_node *rb_node;
+};
+
+/*
+ * Leftmost-cached rbtrees.
+ *
+ * We do not cache the rightmost node based on footprint
+ * size vs number of potential users that could benefit
+ * from O(1) rb_last(). Just not worth it, users that want
+ * this feature can always implement the logic explicitly.
+ * Furthermore, users that want to cache both pointers may
+ * find it a bit asymmetric, but that's ok.
+ */
+struct rb_root_cached {
+	struct rb_root rb_root;
+	struct rb_node *rb_leftmost;
+};
+
+#define RB_ROOT (struct rb_root) { NULL, }
+#define RB_ROOT_CACHED (struct rb_root_cached) { {NULL, }, NULL }
+
+#endif

