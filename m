Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D334A4163AB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 18:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242165AbhIWQ4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 12:56:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35980 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbhIWQ4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 12:56:11 -0400
Message-ID: <20210923165358.054321586@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632416079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=0anKzO8a5auLHfFJ7QaKvJpyensAQe8+/0Dvw1RkbUo=;
        b=VZzCPnQewvGhB/dOy+2wl71iWWQSy0FQE9fApDMUQFbvUW1q8XecuG5yC7CRDQApP9cdR6
        R6BxQZns7gWkH6+p8rFIdU1ZP0J5GacokQr8wcbSeC3PI5DtEb+TqRD0fexcdFBor4fROE
        wJdQnoNYuW/E7zZn+UVuV1197rxiKtrKVqdsoDPxOcj7hb7jrwPNr5PWo1JTn7EkPWCtfG
        4q9CW9npiyELD5rOTpdbGbSFHy6+YIsYyWnhTG28SSG0WoaItM0vxrG0oVMzZCWIj+6JU+
        g0eY/Dh5jzunAmlPQRSaDEenAcJwR6SgkfobM65IY01p+H3WsbzFcd0yT2sRQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632416079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=0anKzO8a5auLHfFJ7QaKvJpyensAQe8+/0Dvw1RkbUo=;
        b=7SD2Uk9H/iL7yRHrlkY6Bz258HcZuzbfm4sxxOuQziU8iLt6oSKL6svEJkVrzmQ67g10pw
        n5uPpIhzLSHN6QBA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Sebastian Siewior <bigeasy@linutronix.de>
Subject: [patch 3/8] sched: Remove preempt_offset argument from __might_sleep()
References: <20210923164145.466686140@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 23 Sep 2021 18:54:38 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All callers hand in 0 and never will hand in anything else.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/kernel.h |    7 +++----
 kernel/sched/core.c    |    4 ++--
 mm/memory.c            |    2 +-
 3 files changed, 6 insertions(+), 7 deletions(-)

--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -112,7 +112,7 @@ static __always_inline void might_resche
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 extern void __might_resched(const char *file, int line, int preempt_offset);
-extern void __might_sleep(const char *file, int line, int preempt_offset);
+extern void __might_sleep(const char *file, int line);
 extern void __cant_sleep(const char *file, int line, int preempt_offset);
 extern void __cant_migrate(const char *file, int line);
 
@@ -129,7 +129,7 @@ extern void __cant_migrate(const char *f
  * supposed to.
  */
 # define might_sleep() \
-	do { __might_sleep(__FILE__, __LINE__, 0); might_resched(); } while (0)
+	do { __might_sleep(__FILE__, __LINE__); might_resched(); } while (0)
 /**
  * cant_sleep - annotation for functions that cannot sleep
  *
@@ -170,8 +170,7 @@ extern void __cant_migrate(const char *f
 #else
   static inline void __might_resched(const char *file, int line,
 				     int preempt_offset) { }
-  static inline void __might_sleep(const char *file, int line,
-				   int preempt_offset) { }
+static inline void __might_sleep(const char *file, int line) { }
 # define might_sleep() do { might_resched(); } while (0)
 # define cant_sleep() do { } while (0)
 # define cant_migrate()		do { } while (0)
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9432,7 +9432,7 @@ static inline int preempt_count_equals(i
 	return (nested == preempt_offset);
 }
 
-void __might_sleep(const char *file, int line, int preempt_offset)
+void __might_sleep(const char *file, int line)
 {
 	unsigned int state = get_current_state();
 	/*
@@ -9446,7 +9446,7 @@ void __might_sleep(const char *file, int
 			(void *)current->task_state_change,
 			(void *)current->task_state_change);
 
-	__might_resched(file, line, preempt_offset);
+	__might_resched(file, line, 0);
 }
 EXPORT_SYMBOL(__might_sleep);
 
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5255,7 +5255,7 @@ void __might_fault(const char *file, int
 		return;
 	if (pagefault_disabled())
 		return;
-	__might_sleep(file, line, 0);
+	__might_sleep(file, line);
 #if defined(CONFIG_DEBUG_ATOMIC_SLEEP)
 	if (current->mm)
 		might_lock_read(&current->mm->mmap_lock);

