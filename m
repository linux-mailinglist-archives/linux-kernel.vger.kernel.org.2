Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9673E90BF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238230AbhHKMZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:25:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50590 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237703AbhHKMX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:23:27 -0400
Message-ID: <20210811121415.701396428@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628684582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=dGBThjxXnhFfezTIvdezCpwkyjcmdDxXQJxwz9iU5J0=;
        b=ejpAwfKBruiNROxtEZhzwLlYlLIWCh7auy2036fStHQ3/fJYX8OU/kDsoyo/I29Getk2nN
        2qwLumK+72WOzn8efGdAlNPZDUmXfxk8MRLI+VuOL+W6CXDNGdvSGRplF7gRtwUtmXcHTQ
        ZFJ27ArSVdIkqXv+5RrwV83tDWYyIypyK3umK10QGb1/49CDi76nn3RRaEXMg7B/YBaga+
        qkpAYA2k6Cy5NDheAVKqSlxdYfObsuiRtMdrbV3t87JEiwO0lsp0SOCkfcsGRQ0R6wScHz
        jxMRStoqsyT+B46zQgqbGbb/QYYd7cZa+UQ/o79GS/2I7S40GoZl9sig1gmZzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628684582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=dGBThjxXnhFfezTIvdezCpwkyjcmdDxXQJxwz9iU5J0=;
        b=igSKRw7breDI8Phjb88BgGHSxndhYCnMHsIosQj8/CFl0TxvhSafrFVF+oMHsne4OBT1lm
        R6aU8b1KUxQwR8DA==
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
Subject: [patch V4 26/68] rbtree: Split out the rbtree type definitions
References: <20210811120348.855823694@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Wed, 11 Aug 2021 14:23:02 +0200 (CEST)
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
 include/linux/rbtree.h       |   30 +-----------------------------
 include/linux/rbtree_types.h |   34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 29 deletions(-)
 create mode 100644 include/linux/rbtree_types.h
---
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
@@ -112,23 +101,6 @@ static inline void rb_link_node_rcu(stru
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

