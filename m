Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA8A415C33
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 12:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240439AbhIWKtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 06:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240400AbhIWKto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 06:49:44 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB341C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 03:48:12 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id r18-20020a056214069200b0037a291a6081so18995356qvz.18
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 03:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=T9tewya8iK1bzbkFhOsP6uZciKvGiqobRhQCuQcyJJA=;
        b=rz5x5gdFAfKsoOzOeKiiiw9rsoxpiAT/+SfjAaRlku3ENBJ6Sv0bng2d3pu+fdqZIO
         6h9mMsK4wjmjPVPWDdN42QwiYm/VAkRWB/wDHQ7BFkGCSB5Q+mgGnNuAYMzXckFFJ++v
         CCpGy9XMb/VnOu8LDath5dmTQrSEzUjTcqeEpaioullCZ7Wl5gc4wIc6yVpNdhgXEV0G
         SUOhnGc+j9tGco+Y98HL0n70SkvSP4gCKhOXf/7TqjWz1kAEDNIGxk9Dq3ZSsK7OaBsf
         mt0yhfYMwV7cHsUD5TG1G+7vKd0RK6U+43SAEHj0vmYvVUIjNj+yfsuZG/hzu5x4aDZX
         e6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=T9tewya8iK1bzbkFhOsP6uZciKvGiqobRhQCuQcyJJA=;
        b=V7naPjbA5CEFFxWxz54sLWAA6IYP6fjI/bGfOqBNyrew7vd/H9Y6ViznDOwJZMp9i6
         Esxgt/mzZnwOSymsMcfy/114RS57KKHiEhus1kl4Vzjl5Mc+cp00tWa/Eq3LT8tcm3mF
         OzKNJmI9Am1907thkhdQiSeoMCAbRFJjqt94IwfD8JRU6JWWx97d929ZRXN99cNKohqV
         BFssIjdFLHS6jpIzdal0WcZ0DXNO7HObqggUNouNRYXAZ1m8cX4l1QrH6kjRUGfBjmZM
         AeW35geaCFBdbIaRmh+X05AG74QSHAvgZiXQ3tJOF6mCQAAKM0hCxoqAMgnTxBhJ/Xv3
         H2Sg==
X-Gm-Message-State: AOAM530buLharawPYB4g924cO8Pjh1SanvjMe61pQ1j1cK7gRBB1ZwOC
        Wgrd2BkdRN4qhQ7wq+PHGKxSFAe0Jg==
X-Google-Smtp-Source: ABdhPJyhS9WtvLwD9LcVlaSbGlll/fGP2M2LJrAHSg0KxHef3g2hDkeZjXjFmpCG748ujbqPd5iOXPnIqw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:bd72:fd35:a085:c2e3])
 (user=elver job=sendgmr) by 2002:a05:6214:4c9:: with SMTP id
 ck9mr3692117qvb.52.1632394091933; Thu, 23 Sep 2021 03:48:11 -0700 (PDT)
Date:   Thu, 23 Sep 2021 12:47:59 +0200
Message-Id: <20210923104803.2620285-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v3 1/5] stacktrace: move filter_irq_stacks() to kernel/stacktrace.c
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
Acked-by: Dmitry Vyukov <dvyukov@google.com>
---
v3:
* Rebase to -next due to conflicting stackdepot changes.

v2:
* New patch.
---
 include/linux/stackdepot.h |  2 --
 include/linux/stacktrace.h |  1 +
 kernel/stacktrace.c        | 30 ++++++++++++++++++++++++++++++
 lib/stackdepot.c           | 24 ------------------------
 4 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index ee03f11bb51a..c34b55a6e554 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -30,8 +30,6 @@ int stack_depot_snprint(depot_stack_handle_t handle, char *buf, size_t size,
 
 void stack_depot_print(depot_stack_handle_t stack);
 
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
index 69c8c9b0d8d7..b437ae79aca1 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -20,7 +20,6 @@
  */
 
 #include <linux/gfp.h>
-#include <linux/interrupt.h>
 #include <linux/jhash.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
@@ -417,26 +416,3 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
 	return __stack_depot_save(entries, nr_entries, alloc_flags, true);
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

