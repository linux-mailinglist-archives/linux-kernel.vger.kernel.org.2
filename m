Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6E333F7EB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 19:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbhCQSNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 14:13:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:48272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232946AbhCQSMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 14:12:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4128264F5E;
        Wed, 17 Mar 2021 18:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616004774;
        bh=u9ZmYDXBwmAWKwlpjdeLtVYcInDCHGfF6nbM3eDLYPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z4OFKXHN4xYlU4woBRcmedJgQ1fIcLN1cFXqXjM3B1KAJC9+X2wlC0N9sff6tqvt/
         oM8j5c30LqPS+JY4up/aO5I3cnoZs1dl4KdtMg8fIN6tC7EPTSaSSY2Cer2CJzRl7Q
         TLP5YcXgAZYhQFmTQiCT8PBUt1Thzy6ovlMpChEhnYgCTtpL9hXB2tG85+jDFzRU6G
         1oQYeAniWr9CQmpLi46LJUqdOdZLXtHU/d8nRwYdQg0XqM46/ascBhpnwzhYsDFpfW
         MtqP0Yo+miTF3UVRHQSgOsEU6we1Cy2FRDPH03uBmgyZ3So0lAwzuT8ih/dJ0Z1A4O
         jABqtyRAOksow==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v4 5/9] kentry: Remove enter_from/exit_to_user_mode()
Date:   Wed, 17 Mar 2021 11:12:44 -0700
Message-Id: <8c0d187da7f8a44302c16e0a7325b3179d229331.1616004689.git.luto@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616004689.git.luto@kernel.org>
References: <cover.1616004689.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

enter_from_user_mode() and exit_to_user_mode() do part, but not all, of the
entry and exit work.  Fortunately, they have no callers, so there's no need
to try to give the precise semantics.  Delete them.

This doesn't affect arm64.  arm64 has identically named functions
in arch/arm64, and kentry isn't built on arm64.  So this patch also
reduces confusion for people who grep the tree and might previously
have thought that arm64 used this code.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 include/linux/entry-common.h | 41 ------------------------------------
 kernel/entry/common.c        | 10 ---------
 2 files changed, 51 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 5287c6c15a66..ba4e8509a20f 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -97,27 +97,6 @@ static inline __must_check int arch_syscall_enter_tracehook(struct pt_regs *regs
 }
 #endif
 
-/**
- * enter_from_user_mode - Establish state when coming from user mode
- *
- * Syscall/interrupt entry disables interrupts, but user mode is traced as
- * interrupts enabled. Also with NO_HZ_FULL RCU might be idle.
- *
- * 1) Tell lockdep that interrupts are disabled
- * 2) Invoke context tracking if enabled to reactivate RCU
- * 3) Trace interrupts off state
- *
- * Invoked from architecture specific syscall entry code with interrupts
- * disabled. The calling code has to be non-instrumentable. When the
- * function returns all state is correct and interrupts are still
- * disabled. The subsequent functions can be instrumented.
- *
- * This is invoked when there is architecture specific functionality to be
- * done between establishing state and enabling interrupts. The caller must
- * enable interrupts before invoking syscall_enter_from_user_mode_work().
- */
-void enter_from_user_mode(struct pt_regs *regs);
-
 /**
  * kentry_syscall_begin - Prepare to invoke a syscall handler
  * @regs:	Pointer to currents pt_regs
@@ -261,26 +240,6 @@ static inline void arch_syscall_exit_tracehook(struct pt_regs *regs, bool step)
 }
 #endif
 
-/**
- * exit_to_user_mode - Fixup state when exiting to user mode
- *
- * Syscall/interrupt exit enables interrupts, but the kernel state is
- * interrupts disabled when this is invoked. Also tell RCU about it.
- *
- * 1) Trace interrupts on state
- * 2) Invoke context tracking if enabled to adjust RCU state
- * 3) Invoke architecture specific last minute exit code, e.g. speculation
- *    mitigations, etc.: arch_exit_to_user_mode()
- * 4) Tell lockdep that interrupts are enabled
- *
- * Invoked from architecture specific code when syscall_exit_to_user_mode()
- * is not suitable as the last step before returning to userspace. Must be
- * invoked with interrupts disabled and the caller must be
- * non-instrumentable.
- * The caller has to invoke syscall_exit_to_user_mode_work() before this.
- */
-void exit_to_user_mode(void);
-
 /**
  * kentry_syscall_end - Finish syscall processing
  * @regs:	Pointer to currents pt_regs
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 800ad406431b..6fbe1c109877 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -25,11 +25,6 @@ static __always_inline void __enter_from_user_mode(struct pt_regs *regs)
 	instrumentation_end();
 }
 
-void noinstr enter_from_user_mode(struct pt_regs *regs)
-{
-	__enter_from_user_mode(regs);
-}
-
 static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
 {
 	if (unlikely(audit_context())) {
@@ -106,11 +101,6 @@ static __always_inline void __exit_to_user_mode(void)
 	lockdep_hardirqs_on(CALLER_ADDR0);
 }
 
-void noinstr exit_to_user_mode(void)
-{
-	__exit_to_user_mode();
-}
-
 /* Workaround to allow gradual conversion of architecture code */
 void __weak arch_do_signal_or_restart(struct pt_regs *regs, bool has_signal) { }
 
-- 
2.30.2

