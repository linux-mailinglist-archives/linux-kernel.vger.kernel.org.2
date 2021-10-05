Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B0542241D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 13:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbhJELBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 07:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234310AbhJELBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 07:01:41 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1584C061760
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 03:59:50 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 81-20020a251254000000b005b6220d81efso27605462ybs.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 03:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kUUBsv4TZ+s6mxdftD0CD4qwCQSHLXZlKlhseQGR4HI=;
        b=rEZQ6gHEpvFmnU3JJ2KadwYQcU/JSBtWD9kFPefHUesYhWgD+zWgArmWGmRaRUoRtk
         VDKK8Clkd1IXKKUXE7uGOCQiR/a8VLzgq14e4z3yFqsyEMB8J+yA2fLfPmDZ1cgwu7IA
         hxWJQYHsv0nxh98TCmcq99vXZHi81m/dePuKk+O8qPlob0rH4fJEMk6xuMnX/JJw3dJK
         w+/HEGUet8yHVB4XffG2TDeLzpNjvUlMe1PO08esWDxORp5yjfb6ZGwfrmryknbMGoVf
         IweJBPgmp5Gr9RwWgQoSzOGRDC7O4CUXO3DyTZtoWRfCwGXfU1t0hBdbgyv0icSZytvz
         vwrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kUUBsv4TZ+s6mxdftD0CD4qwCQSHLXZlKlhseQGR4HI=;
        b=1Oy9wI6ehHLwrckIttAL7zCIGKBUmByS5KpgU6PNnISJ8H80NW6D+HJWaxEuib3ofP
         T9JgP6ryUKfm3p2LMQ1wbMYI/BQlhRdxq29bRUuEo5+KF1Af5RpeMzUBJqyj2dceKeH9
         2LttvR9P/gr4k5FH0vl5GlMK2EyHOWp1IKCZGsmSdBpOShBSwp8/ttw7VxHCZWBaWJ/7
         PTNOCDD21pc9vNDwsA91ENf0HB7SIZ/6f2pUKH6ulznAqfpKFnbqu4LiFaVAIERJvl5k
         ZP38tY1XrilQz8dqNxacw3R1R3mIbpF+c3naul3P3SJc4B8hKLbHrjyS5AudeMClukck
         eWFg==
X-Gm-Message-State: AOAM5313KKOHKM9xCyYeT3gpYzX6itqs1EDXJFjOgUE5P6EedhX20u2s
        xWTH+qJawcYfyqBa1wCsaot2Ts6gAA==
X-Google-Smtp-Source: ABdhPJxRi+Ql2gxjFY5+cYUsl3wIa8YCDZUdUIEKXnqibIFEFifviy3RA6gYeFrxOW2C0fskgkXzwtNlZw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:e44f:5054:55f8:fcb8])
 (user=elver job=sendgmr) by 2002:a5b:f03:: with SMTP id x3mr20807187ybr.546.1633431589883;
 Tue, 05 Oct 2021 03:59:49 -0700 (PDT)
Date:   Tue,  5 Oct 2021 12:58:45 +0200
In-Reply-To: <20211005105905.1994700-1-elver@google.com>
Message-Id: <20211005105905.1994700-4-elver@google.com>
Mime-Version: 1.0
References: <20211005105905.1994700-1-elver@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH -rcu/kcsan 03/23] kcsan: Avoid checking scoped accesses from
 nested contexts
From:   Marco Elver <elver@google.com>
To:     elver@google.com, "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid checking scoped accesses from nested contexts (such as nested
interrupts or in scheduler code) which share the same kcsan_ctx.

This is to avoid detecting false positive races of accesses in the same
thread with currently scoped accesses: consider setting up a watchpoint
for a non-scoped (normal) access that also "conflicts" with a current
scoped access. In a nested interrupt (or in the scheduler), which shares
the same kcsan_ctx, we cannot check scoped accesses set up in the parent
context -- simply ignore them in this case.

With the introduction of kcsan_ctx::disable_scoped, we can also clean up
kcsan_check_scoped_accesses()'s recursion guard, and do not need to
modify the list's prev pointer.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/kcsan.h |  1 +
 kernel/kcsan/core.c   | 18 +++++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/linux/kcsan.h b/include/linux/kcsan.h
index fc266ecb2a4d..13cef3458fed 100644
--- a/include/linux/kcsan.h
+++ b/include/linux/kcsan.h
@@ -21,6 +21,7 @@
  */
 struct kcsan_ctx {
 	int disable_count; /* disable counter */
+	int disable_scoped; /* disable scoped access counter */
 	int atomic_next; /* number of following atomic ops */
 
 	/*
diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index e34a1710b7bc..bd359f8ee63a 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -204,15 +204,17 @@ check_access(const volatile void *ptr, size_t size, int type, unsigned long ip);
 static noinline void kcsan_check_scoped_accesses(void)
 {
 	struct kcsan_ctx *ctx = get_ctx();
-	struct list_head *prev_save = ctx->scoped_accesses.prev;
 	struct kcsan_scoped_access *scoped_access;
 
-	ctx->scoped_accesses.prev = NULL;  /* Avoid recursion. */
+	if (ctx->disable_scoped)
+		return;
+
+	ctx->disable_scoped++;
 	list_for_each_entry(scoped_access, &ctx->scoped_accesses, list) {
 		check_access(scoped_access->ptr, scoped_access->size,
 			     scoped_access->type, scoped_access->ip);
 	}
-	ctx->scoped_accesses.prev = prev_save;
+	ctx->disable_scoped--;
 }
 
 /* Rules for generic atomic accesses. Called from fast-path. */
@@ -465,6 +467,15 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type, unsigned
 		goto out;
 	}
 
+	/*
+	 * Avoid races of scoped accesses from nested interrupts (or scheduler).
+	 * Assume setting up a watchpoint for a non-scoped (normal) access that
+	 * also conflicts with a current scoped access. In a nested interrupt,
+	 * which shares the context, it would check a conflicting scoped access.
+	 * To avoid, disable scoped access checking.
+	 */
+	ctx->disable_scoped++;
+
 	/*
 	 * Save and restore the IRQ state trace touched by KCSAN, since KCSAN's
 	 * runtime is entered for every memory access, and potentially useful
@@ -578,6 +589,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type, unsigned
 	if (!kcsan_interrupt_watcher)
 		local_irq_restore(irq_flags);
 	kcsan_restore_irqtrace(current);
+	ctx->disable_scoped--;
 out:
 	user_access_restore(ua_flags);
 }
-- 
2.33.0.800.g4c38ced690-goog

