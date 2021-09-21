Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 004C4413153
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 12:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhIUKMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 06:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbhIUKLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 06:11:54 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5C1C0613D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 03:10:22 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id h9-20020a05621413a900b0037a2d3eaf8fso212947338qvz.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 03:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5N9Nfc2PvxnVX00ioD06NDULEqZan2ouEAVATALDM/U=;
        b=re1MeyZD4441wN+l0v9OO/U4fqURpUvI2RpDEHeFN3hdbo/USuNsEaCZ0cLijsB8U5
         COFjC4fXuvReQMBjNdF2tW+Ruw7giKzv05JpGkMObQY/3aFvxjzLh1ATERUSlzZC4mdG
         9/457Fs+MssoO6tUNOrwJVHTiiHsfIOfdI1Yc3yOW/2D/yBxOtC5zN210YghPexjGRA8
         Et/pA5inMv0QoXyoDfVohlgF+x9yfHuJh/9AjdjlYPeeHR6ce4nvakK2m12XxtsFgJRM
         jpNNPjZn3ZWw0x1BhcL3o/71jlesZOCRKzC2maIrS7BlucGmLlSQqjz4qp8JJq4AIGRU
         VGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5N9Nfc2PvxnVX00ioD06NDULEqZan2ouEAVATALDM/U=;
        b=G5BHgSxtR/5ndw+zEIq0ocF6FH4UDprYvD3EVO0e1hbY900g/98896q6eBM7lZKpYt
         HtImXcWpSmcMcvzgiV3Y1BZRVgUi028wCXcCuMD8Baxq9nKkjWobeglzI7ANhGLk67C2
         D4AxKWEhBBrXciwwB1HkMKpl3eatM8rElBnAAj52T50CYYO4fXnzQ2XCN3mSWagxZZHb
         Y7vYWqr3XDmzDepu/9azUXgcgn7SZZL+BKwNW4M+kcamktJYW8Wzb9F82z6LyDie5BnF
         xWn7849rdk9ymyM7G/Ox3wXX+E/7pGyZDFxSnSJP/1KFMWc9mSm3Nsu1qYcVAHulbuT1
         zzUA==
X-Gm-Message-State: AOAM531Be/6twexO9FiNX4tLtGmgULQMez6omHj5h7tB77bgwwI7xhev
        wJTtH5Y9LhRyQRQdRFaZ8NpBID8n7w==
X-Google-Smtp-Source: ABdhPJw9K0h/Lxwq8gDPZCrvBxtJlDkV0TFyKit97kyILId+bErwqAKAwWm+rn+bPumqtf/fbZqQIAPJtQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:dd03:c280:4625:60db])
 (user=elver job=sendgmr) by 2002:a05:6214:490:: with SMTP id
 ay16mr30085392qvb.25.1632219021369; Tue, 21 Sep 2021 03:10:21 -0700 (PDT)
Date:   Tue, 21 Sep 2021 12:10:10 +0200
Message-Id: <20210921101014.1938382-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v2 1/5] stacktrace: move filter_irq_stacks() to kernel/stacktrace.c
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Taras Madan <tarasmadan@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

filter_irq_stacks() has little to do with the stackdepot implementation,
except that it is usually used by users (such as KASAN) of stackdepot to
reduce the stack trace.

However, filter_irq_stacks() itself is not useful without a stack trace
as obtained by stack_trace_save() and friends.

Therefore, move filter_irq_stacks() to kernel/stacktrace.c, so that new
users of filter_irq_stacks() do not have to start depending on
STACKDEPOT only for filter_irq_stacks().

Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* New patch.
---
 include/linux/stackdepot.h |  2 --
 include/linux/stacktrace.h |  1 +
 kernel/stacktrace.c        | 30 ++++++++++++++++++++++++++++++
 lib/stackdepot.c           | 24 ------------------------
 4 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index 6bb4bc1a5f54..22919a94ca19 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -19,8 +19,6 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
 unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 			       unsigned long **entries);
 
-unsigned int filter_irq_stacks(unsigned long *entries, unsigned int nr_entries);
-
 #ifdef CONFIG_STACKDEPOT
 int stack_depot_init(void);
 #else
diff --git a/include/linux/stacktrace.h b/include/linux/stacktrace.h
index 9edecb494e9e..bef158815e83 100644
--- a/include/linux/stacktrace.h
+++ b/include/linux/stacktrace.h
@@ -21,6 +21,7 @@ unsigned int stack_trace_save_tsk(struct task_struct *task,
 unsigned int stack_trace_save_regs(struct pt_regs *regs, unsigned long *store,
 				   unsigned int size, unsigned int skipnr);
 unsigned int stack_trace_save_user(unsigned long *store, unsigned int size);
+unsigned int filter_irq_stacks(unsigned long *entries, unsigned int nr_entries);
 
 /* Internal interfaces. Do not use in generic code */
 #ifdef CONFIG_ARCH_STACKWALK
diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index 9f8117c7cfdd..9c625257023d 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -13,6 +13,7 @@
 #include <linux/export.h>
 #include <linux/kallsyms.h>
 #include <linux/stacktrace.h>
+#include <linux/interrupt.h>
 
 /**
  * stack_trace_print - Print the entries in the stack trace
@@ -373,3 +374,32 @@ unsigned int stack_trace_save_user(unsigned long *store, unsigned int size)
 #endif /* CONFIG_USER_STACKTRACE_SUPPORT */
 
 #endif /* !CONFIG_ARCH_STACKWALK */
+
+static inline bool in_irqentry_text(unsigned long ptr)
+{
+	return (ptr >= (unsigned long)&__irqentry_text_start &&
+		ptr < (unsigned long)&__irqentry_text_end) ||
+		(ptr >= (unsigned long)&__softirqentry_text_start &&
+		 ptr < (unsigned long)&__softirqentry_text_end);
+}
+
+/**
+ * filter_irq_stacks - Find first IRQ stack entry in trace
+ * @entries:	Pointer to stack trace array
+ * @nr_entries:	Number of entries in the storage array
+ *
+ * Return: Number of trace entries until IRQ stack starts.
+ */
+unsigned int filter_irq_stacks(unsigned long *entries, unsigned int nr_entries)
+{
+	unsigned int i;
+
+	for (i = 0; i < nr_entries; i++) {
+		if (in_irqentry_text(entries[i])) {
+			/* Include the irqentry function into the stack. */
+			return i + 1;
+		}
+	}
+	return nr_entries;
+}
+EXPORT_SYMBOL_GPL(filter_irq_stacks);
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 0a2e417f83cb..e90f0f19e77f 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -20,7 +20,6 @@
  */
 
 #include <linux/gfp.h>
-#include <linux/interrupt.h>
 #include <linux/jhash.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
@@ -341,26 +340,3 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
 	return retval;
 }
 EXPORT_SYMBOL_GPL(stack_depot_save);
-
-static inline int in_irqentry_text(unsigned long ptr)
-{
-	return (ptr >= (unsigned long)&__irqentry_text_start &&
-		ptr < (unsigned long)&__irqentry_text_end) ||
-		(ptr >= (unsigned long)&__softirqentry_text_start &&
-		 ptr < (unsigned long)&__softirqentry_text_end);
-}
-
-unsigned int filter_irq_stacks(unsigned long *entries,
-					     unsigned int nr_entries)
-{
-	unsigned int i;
-
-	for (i = 0; i < nr_entries; i++) {
-		if (in_irqentry_text(entries[i])) {
-			/* Include the irqentry function into the stack. */
-			return i + 1;
-		}
-	}
-	return nr_entries;
-}
-EXPORT_SYMBOL_GPL(filter_irq_stacks);
-- 
2.33.0.464.g1972c5931b-goog

