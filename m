Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32CCA3B2804
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 08:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhFXG5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 02:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbhFXG5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 02:57:03 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38E2C061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 23:54:44 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u11so5310758wrw.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 23:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=lG8eedvJmtIzWwS/Ng8FLvzMYk8gGszLmsC9XGniDTY=;
        b=Iho8EV1B3lZTS8LOXiGcC3xWqBNgYHlO7kZlVQKq8cAOrd9SNKivnxMx6GeLoedj93
         6Q0w5R4ZJNxwQkkXPvcU3PYKR6N0nu6VJtmkoHZDbfHkvphqkcYZPdQYqQlMo8ueFlOx
         kS9MCfuVzXhL27fd+6NHYkRy4kKWXZSQrxiSjPt29GM+qDmtWswRUhtkcQvPIMG436D/
         nlK2L8MSGBbWCaqyUZBEFwQ/Ij9UdJ6wR/Pfd7+ROqTGzghUvU0Q+jkmTATarcYUwuFm
         8iPuGi1xWtLsPny7rCNKwkPJDezUPCRx9REnzJqJJrzC7JuQRE+Vc3GwHkbSKp3drP5o
         pnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=lG8eedvJmtIzWwS/Ng8FLvzMYk8gGszLmsC9XGniDTY=;
        b=lwEKHs4MQebRRtSGZDahdTvBSepDo2ThO3mR7JqHw5/s8V2yKNPXoNEE/WnDKRGTNb
         58pJvx/IREUWYkq7uKDvZuk+e1XqeQ4atp9d7+zXvo9y7+ognhFyeSQAW+YZoaxxFZEo
         St2BlkSt+ssIGz0j8REbOKQrCIFecXanyoH37rT8R7GBEZOdMEj+xjR1nt8A5olQ8CQ2
         XlC+J0vP91k2M4tEg96uGx/fxBqesk5CenQ1kYTFFOyCgJc8Ly1yL7YJWyi9aa0//K1U
         PB6UZglI6jCfdITnO7RWHERoF5PPV490IbPcIgRfAOsCiFe0HFJqm8uOlpuDDws7T8uq
         vo7g==
X-Gm-Message-State: AOAM530QmPPcGfFOoQ/Jjm4yWmYRirUJ9NFY/ELcYotksHs4xnamSt8Z
        Ba2bMqWLXQCvCSmDVXgIyLBmAo09o28=
X-Google-Smtp-Source: ABdhPJxgnxpHZaxbtDFQBhwj//zHa0rlb+nMZcgi/5jm+RDVbhYar16QQTksSMvCqAi52IHs9bYdyQ==
X-Received: by 2002:adf:b34c:: with SMTP id k12mr2511623wrd.272.1624517683619;
        Wed, 23 Jun 2021 23:54:43 -0700 (PDT)
Received: from gmail.com (0526E2ED.dsl.pool.telekom.hu. [5.38.226.237])
        by smtp.gmail.com with ESMTPSA id l18sm2379216wms.14.2021.06.23.23.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 23:54:43 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 24 Jun 2021 08:54:41 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] objtool fixes
Message-ID: <YNQsMTPceyDuvtPf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest objtool/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-urgent-2021-06-24

   # HEAD: 49faa77759b211fff344898edc23bb780707fff5 locking/lockdep: Improve noinstr vs errors

Address a number of objtool warnings that got reported.

No change in behavior intended, but code generation might be
impacted by:

   1f008d46f124: ("x86: Always inline task_size_max()")

 Thanks,

	Ingo

------------------>
Peter Zijlstra (6):
      objtool/x86: Ignore __x86_indirect_alt_* symbols
      x86/entry: Fix noinstr fail in __do_fast_syscall_32()
      x86/xen: Fix noinstr fail in xen_pv_evtchn_do_upcall()
      x86/xen: Fix noinstr fail in exc_xen_unknown_trap()
      x86: Always inline task_size_max()
      locking/lockdep: Improve noinstr vs errors


 arch/x86/entry/common.c        | 5 +++--
 arch/x86/include/asm/page_64.h | 2 +-
 arch/x86/lib/retpoline.S       | 4 ++++
 arch/x86/xen/enlighten_pv.c    | 2 ++
 include/linux/debug_locks.h    | 2 ++
 kernel/locking/lockdep.c       | 4 +++-
 lib/debug_locks.c              | 2 +-
 7 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 7b2542b13ebd..04bce95bc7e3 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -130,8 +130,8 @@ static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
 		/* User code screwed up. */
 		regs->ax = -EFAULT;
 
-		instrumentation_end();
 		local_irq_disable();
+		instrumentation_end();
 		irqentry_exit_to_user_mode(regs);
 		return false;
 	}
@@ -269,15 +269,16 @@ __visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
 	irqentry_state_t state = irqentry_enter(regs);
 	bool inhcall;
 
+	instrumentation_begin();
 	run_sysvec_on_irqstack_cond(__xen_pv_evtchn_do_upcall, regs);
 
 	inhcall = get_and_clear_inhcall();
 	if (inhcall && !WARN_ON_ONCE(state.exit_rcu)) {
-		instrumentation_begin();
 		irqentry_exit_cond_resched();
 		instrumentation_end();
 		restore_inhcall(inhcall);
 	} else {
+		instrumentation_end();
 		irqentry_exit(regs, state);
 	}
 }
diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index ca840fec7776..4bde0dc66100 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -75,7 +75,7 @@ void copy_page(void *to, void *from);
  *
  * With page table isolation enabled, we map the LDT in ... [stay tuned]
  */
-static inline unsigned long task_size_max(void)
+static __always_inline unsigned long task_size_max(void)
 {
 	unsigned long ret;
 
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 4d32cb06ffd5..ec9922cba30a 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -58,12 +58,16 @@ SYM_FUNC_START_NOALIGN(__x86_indirect_alt_call_\reg)
 2:	.skip	5-(2b-1b), 0x90
 SYM_FUNC_END(__x86_indirect_alt_call_\reg)
 
+STACK_FRAME_NON_STANDARD(__x86_indirect_alt_call_\reg)
+
 SYM_FUNC_START_NOALIGN(__x86_indirect_alt_jmp_\reg)
 	ANNOTATE_RETPOLINE_SAFE
 1:	jmp	*%\reg
 2:	.skip	5-(2b-1b), 0x90
 SYM_FUNC_END(__x86_indirect_alt_jmp_\reg)
 
+STACK_FRAME_NON_STANDARD(__x86_indirect_alt_jmp_\reg)
+
 .endm
 
 /*
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index e87699aa2dc8..03149422dce2 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -592,8 +592,10 @@ DEFINE_IDTENTRY_RAW(xenpv_exc_debug)
 DEFINE_IDTENTRY_RAW(exc_xen_unknown_trap)
 {
 	/* This should never happen and there is no way to handle it. */
+	instrumentation_begin();
 	pr_err("Unknown trap in Xen PV mode.");
 	BUG();
+	instrumentation_end();
 }
 
 #ifdef CONFIG_X86_MCE
diff --git a/include/linux/debug_locks.h b/include/linux/debug_locks.h
index 2915f56ad421..edb5c186b0b7 100644
--- a/include/linux/debug_locks.h
+++ b/include/linux/debug_locks.h
@@ -27,8 +27,10 @@ extern int debug_locks_off(void);
 	int __ret = 0;							\
 									\
 	if (!oops_in_progress && unlikely(c)) {				\
+		instrumentation_begin();				\
 		if (debug_locks_off() && !debug_locks_silent)		\
 			WARN(1, "DEBUG_LOCKS_WARN_ON(%s)", #c);		\
+		instrumentation_end();					\
 		__ret = 1;						\
 	}								\
 	__ret;								\
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 7641bd407239..e32313072506 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -843,7 +843,7 @@ static int count_matching_names(struct lock_class *new_class)
 }
 
 /* used from NMI context -- must be lockless */
-static __always_inline struct lock_class *
+static noinstr struct lock_class *
 look_up_lock_class(const struct lockdep_map *lock, unsigned int subclass)
 {
 	struct lockdep_subclass_key *key;
@@ -851,12 +851,14 @@ look_up_lock_class(const struct lockdep_map *lock, unsigned int subclass)
 	struct lock_class *class;
 
 	if (unlikely(subclass >= MAX_LOCKDEP_SUBCLASSES)) {
+		instrumentation_begin();
 		debug_locks_off();
 		printk(KERN_ERR
 			"BUG: looking up invalid subclass: %u\n", subclass);
 		printk(KERN_ERR
 			"turning off the locking correctness validator.\n");
 		dump_stack();
+		instrumentation_end();
 		return NULL;
 	}
 
diff --git a/lib/debug_locks.c b/lib/debug_locks.c
index 06d3135bd184..a75ee30b77cb 100644
--- a/lib/debug_locks.c
+++ b/lib/debug_locks.c
@@ -36,7 +36,7 @@ EXPORT_SYMBOL_GPL(debug_locks_silent);
 /*
  * Generic 'turn off all lock debugging' function:
  */
-noinstr int debug_locks_off(void)
+int debug_locks_off(void)
 {
 	if (debug_locks && __debug_locks_off()) {
 		if (!debug_locks_silent) {
