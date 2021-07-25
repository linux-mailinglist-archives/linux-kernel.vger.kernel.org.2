Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625C53D4F0D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 19:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbhGYQly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 12:41:54 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:46066 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhGYQlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 12:41:53 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m7hnR-003rxN-PU; Sun, 25 Jul 2021 17:20:13 +0000
Date:   Sun, 25 Jul 2021 17:20:13 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-m68k@lists.linux-m68k.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] m68k: leave stack mangling to asm wrapper of sigreturn()
Message-ID: <YP2dTQPm1wGPWFgD@zeniv-ca.linux.org.uk>
References: <YP2c1xk9LJ0zE3KW@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YP2c1xk9LJ0zE3KW@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sigreturn has to deal with an unpleasant problem - exception stack frames
have different sizes, depending upon the exception (and processor model, as
well) and variable-sized part of exception frame may contain information
needed for instruction restart.  So when signal handler terminates and calls
sigreturn to resume the execution at the place where we'd been when we caught
the signal, it has to rearrange the frame at the bottom of kernel stack.
Worse, it might need to open a gap in the kernel stack, shifting pt_regs
towards lower addresses.

Doing that from C is insane - we'd need to shift stack frames (return addresses,
local variables, etc.) of C call chain, right under the nose of compiler and
hope it won't fall apart horribly.  What had been actually done is only slightly
less insane - an inline asm in mangle_kernel_stack() moved the stuff around,
then reset stack pointer and jumped to label in asm glue.

However, we can avoid all that mess if the asm wrapper we have to use anyway
would reserve some space on the stack between switch_stack and the C stack
frame of do_{rt_,}sigreturn().   Then C part can simply memmove() pt_regs +
switch_stack, memcpy() the variable part of exception frame into the opened
gap - all of that without inline asm, buggering C call chain, magical jumps
to asm labels, etc.

Asm wrapper would need to know where the moved switch_stack has ended up -
it might have been shifted into the gap we'd reserved before do_rt_sigreturn()
call.  That's where it needs to set the stack pointer to.  So let the C part
return just that and be done with that.

While we are at it, the call of berr_040cleanup() we need to do when
returning via 68040 bus error exception frame can be moved into C part
as well.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/m68k/68000/entry.S       |   3 --
 arch/m68k/coldfire/entry.S    |   3 --
 arch/m68k/include/asm/traps.h |   4 ++
 arch/m68k/kernel/entry.S      |  55 ++++++++++-----------
 arch/m68k/kernel/signal.c     | 111 ++++++++++++++++--------------------------
 5 files changed, 71 insertions(+), 105 deletions(-)

diff --git a/arch/m68k/68000/entry.S b/arch/m68k/68000/entry.S
index 259b3661b614..cce465e850fe 100644
--- a/arch/m68k/68000/entry.S
+++ b/arch/m68k/68000/entry.S
@@ -25,7 +25,6 @@
 .globl system_call
 .globl resume
 .globl ret_from_exception
-.globl ret_from_signal
 .globl sys_call_table
 .globl bad_interrupt
 .globl inthandler1
@@ -59,8 +58,6 @@ do_trace:
 	subql	#4,%sp			/* dummy return address */
 	SAVE_SWITCH_STACK
 	jbsr	syscall_trace_leave
-
-ret_from_signal:
 	RESTORE_SWITCH_STACK
 	addql	#4,%sp
 	jra	ret_from_exception
diff --git a/arch/m68k/coldfire/entry.S b/arch/m68k/coldfire/entry.S
index d43a02795a4a..68adb7b5b296 100644
--- a/arch/m68k/coldfire/entry.S
+++ b/arch/m68k/coldfire/entry.S
@@ -51,7 +51,6 @@ sw_usp:
 .globl system_call
 .globl resume
 .globl ret_from_exception
-.globl ret_from_signal
 .globl sys_call_table
 .globl inthandler
 
@@ -98,8 +97,6 @@ ENTRY(system_call)
 	subql	#4,%sp			/* dummy return address */
 	SAVE_SWITCH_STACK
 	jbsr	syscall_trace_leave
-
-ret_from_signal:
 	RESTORE_SWITCH_STACK
 	addql	#4,%sp
 
diff --git a/arch/m68k/include/asm/traps.h b/arch/m68k/include/asm/traps.h
index 4aff3358fbaf..a9d5c1c870d3 100644
--- a/arch/m68k/include/asm/traps.h
+++ b/arch/m68k/include/asm/traps.h
@@ -267,6 +267,10 @@ struct frame {
     } un;
 };
 
+#ifdef CONFIG_M68040
+asmlinkage void berr_040cleanup(struct frame *fp);
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _M68K_TRAPS_H */
diff --git a/arch/m68k/kernel/entry.S b/arch/m68k/kernel/entry.S
index ff9e842cec0f..8fa9822b5922 100644
--- a/arch/m68k/kernel/entry.S
+++ b/arch/m68k/kernel/entry.S
@@ -78,20 +78,38 @@ ENTRY(__sys_clone3)
 
 ENTRY(sys_sigreturn)
 	SAVE_SWITCH_STACK
-	movel	%sp,%sp@-		  | switch_stack pointer
-	pea	%sp@(SWITCH_STACK_SIZE+4) | pt_regs pointer
+	movel	%sp,%a1			  	| switch_stack pointer
+	lea	%sp@(SWITCH_STACK_SIZE),%a0	| pt_regs pointer
+	lea     %sp@(-84),%sp			| leave a gap
+	movel	%a1,%sp@-
+	movel	%a0,%sp@-
 	jbsr	do_sigreturn
-	addql	#8,%sp
-	RESTORE_SWITCH_STACK
-	rts
+	jra	1f				| shared with rt_sigreturn()
 
 ENTRY(sys_rt_sigreturn)
 	SAVE_SWITCH_STACK
-	movel	%sp,%sp@-		  | switch_stack pointer
-	pea	%sp@(SWITCH_STACK_SIZE+4) | pt_regs pointer
+	movel	%sp,%a1			  	| switch_stack pointer
+	lea	%sp@(SWITCH_STACK_SIZE),%a0	| pt_regs pointer
+	lea     %sp@(-84),%sp			| leave a gap
+	movel	%a1,%sp@-
+	movel	%a0,%sp@-
+	| stack contents:
+	|   [original pt_regs address] [original switch_stack address]
+	|   [gap] [switch_stack] [pt_regs] [exception frame]
 	jbsr	do_rt_sigreturn
-	addql	#8,%sp
+
+1:
+	| stack contents now:
+	|   [original pt_regs address] [original switch_stack address]
+	|   [unused part of the gap] [moved switch_stack] [moved pt_regs]
+	|   [replacement exception frame]
+	| return value of do_{rt_,}sigreturn() points to moved switch_stack.
+
+	movel	%d0,%sp				| discard the leftover junk
 	RESTORE_SWITCH_STACK
+	| stack contents now is just [syscall return address] [pt_regs] [frame]
+	| return pt_regs.d0
+	movel	%sp@(PT_OFF_D0+4),%d0
 	rts
 
 ENTRY(buserr)
@@ -182,27 +200,6 @@ do_trace_exit:
 	addql	#4,%sp
 	jra	.Lret_from_exception
 
-ENTRY(ret_from_signal)
-	movel	%curptr@(TASK_STACK),%a1
-	tstb	%a1@(TINFO_FLAGS+2)
-	jge	1f
-	lea	%sp@(SWITCH_STACK_SIZE),%a1
-	movel	%a1,%curptr@(TASK_THREAD+THREAD_ESP0)
-	jbsr	syscall_trace
-1:	RESTORE_SWITCH_STACK
-	addql	#4,%sp
-/* on 68040 complete pending writebacks if any */
-#ifdef CONFIG_M68040
-	bfextu	%sp@(PT_OFF_FORMATVEC){#0,#4},%d0
-	subql	#7,%d0				| bus error frame ?
-	jbne	1f
-	movel	%sp,%sp@-
-	jbsr	berr_040cleanup
-	addql	#4,%sp
-1:
-#endif
-	jra	.Lret_from_exception
-
 ENTRY(system_call)
 	SAVE_ALL_SYS
 
diff --git a/arch/m68k/kernel/signal.c b/arch/m68k/kernel/signal.c
index cd11eb101eac..338817d0cb3f 100644
--- a/arch/m68k/kernel/signal.c
+++ b/arch/m68k/kernel/signal.c
@@ -641,56 +641,35 @@ static inline void siginfo_build_tests(void)
 static int mangle_kernel_stack(struct pt_regs *regs, int formatvec,
 			       void __user *fp)
 {
-	int fsize = frame_extra_sizes(formatvec >> 12);
-	if (fsize < 0) {
+	int extra = frame_extra_sizes(formatvec >> 12);
+	char buf[sizeof_field(struct frame, un)];
+
+	if (extra < 0) {
 		/*
 		 * user process trying to return with weird frame format
 		 */
 		pr_debug("user process returning with weird frame format\n");
-		return 1;
+		return -1;
 	}
-	if (!fsize) {
-		regs->format = formatvec >> 12;
-		regs->vector = formatvec & 0xfff;
-	} else {
-		struct switch_stack *sw = (struct switch_stack *)regs - 1;
-		/* yes, twice as much as max(sizeof(frame.un.fmt<x>)) */
-		unsigned long buf[sizeof_field(struct frame, un) / 2];
-
-		/* that'll make sure that expansion won't crap over data */
-		if (copy_from_user(buf + fsize / 4, fp, fsize))
-			return 1;
-
-		/* point of no return */
-		regs->format = formatvec >> 12;
-		regs->vector = formatvec & 0xfff;
-#define frame_offset (sizeof(struct pt_regs)+sizeof(struct switch_stack))
-		__asm__ __volatile__ (
-#ifdef CONFIG_COLDFIRE
-			 "   movel %0,%/sp\n\t"
-			 "   bra ret_from_signal\n"
-#else
-			 "   movel %0,%/a0\n\t"
-			 "   subl %1,%/a0\n\t"     /* make room on stack */
-			 "   movel %/a0,%/sp\n\t"  /* set stack pointer */
-			 /* move switch_stack and pt_regs */
-			 "1: movel %0@+,%/a0@+\n\t"
-			 "   dbra %2,1b\n\t"
-			 "   lea %/sp@(%c3),%/a0\n\t" /* add offset of fmt */
-			 "   lsrl  #2,%1\n\t"
-			 "   subql #1,%1\n\t"
-			 /* copy to the gap we'd made */
-			 "2: movel %4@+,%/a0@+\n\t"
-			 "   dbra %1,2b\n\t"
-			 "   bral ret_from_signal\n"
+	if (extra && copy_from_user(buf, fp, extra))
+		return -1;
+	regs->format = formatvec >> 12;
+	regs->vector = formatvec & 0xfff;
+	if (extra) {
+		void *p = (struct switch_stack *)regs - 1;
+		struct frame *new = (void *)regs - extra;
+		int size = sizeof(struct pt_regs)+sizeof(struct switch_stack);
+
+		memmove(p - extra, p, size);
+		memcpy(p - extra + size, buf, extra);
+		current->thread.esp0 = (unsigned long)&new->ptregs;
+#ifdef CONFIG_M68040
+		/* on 68040 complete pending writebacks if any */
+		if (new->ptregs.format == 7) // bus error frame
+			berr_040cleanup(new);
 #endif
-			 : /* no outputs, it doesn't ever return */
-			 : "a" (sw), "d" (fsize), "d" (frame_offset/4-1),
-			   "n" (frame_offset), "a" (buf + fsize/4)
-			 : "a0");
-#undef frame_offset
 	}
-	return 0;
+	return extra;
 }
 
 static inline int
@@ -698,7 +677,6 @@ restore_sigcontext(struct pt_regs *regs, struct sigcontext __user *usc, void __u
 {
 	int formatvec;
 	struct sigcontext context;
-	int err = 0;
 
 	siginfo_build_tests();
 
@@ -707,7 +685,7 @@ restore_sigcontext(struct pt_regs *regs, struct sigcontext __user *usc, void __u
 
 	/* get previous context */
 	if (copy_from_user(&context, usc, sizeof(context)))
-		goto badframe;
+		return -1;
 
 	/* restore passed registers */
 	regs->d0 = context.sc_d0;
@@ -720,15 +698,10 @@ restore_sigcontext(struct pt_regs *regs, struct sigcontext __user *usc, void __u
 	wrusp(context.sc_usp);
 	formatvec = context.sc_formatvec;
 
-	err = restore_fpu_state(&context);
-
-	if (err || mangle_kernel_stack(regs, formatvec, fp))
-		goto badframe;
-
-	return 0;
+	if (restore_fpu_state(&context))
+		return -1;
 
-badframe:
-	return 1;
+	return mangle_kernel_stack(regs, formatvec, fp);
 }
 
 static inline int
@@ -745,7 +718,7 @@ rt_restore_ucontext(struct pt_regs *regs, struct switch_stack *sw,
 
 	err = __get_user(temp, &uc->uc_mcontext.version);
 	if (temp != MCONTEXT_VERSION)
-		goto badframe;
+		return -1;
 	/* restore passed registers */
 	err |= __get_user(regs->d0, &gregs[0]);
 	err |= __get_user(regs->d1, &gregs[1]);
@@ -774,22 +747,17 @@ rt_restore_ucontext(struct pt_regs *regs, struct switch_stack *sw,
 	err |= restore_altstack(&uc->uc_stack);
 
 	if (err)
-		goto badframe;
-
-	if (mangle_kernel_stack(regs, temp, &uc->uc_extra))
-		goto badframe;
+		return -1;
 
-	return 0;
-
-badframe:
-	return 1;
+	return mangle_kernel_stack(regs, temp, &uc->uc_extra);
 }
 
-asmlinkage int do_sigreturn(struct pt_regs *regs, struct switch_stack *sw)
+asmlinkage void *do_sigreturn(struct pt_regs *regs, struct switch_stack *sw)
 {
 	unsigned long usp = rdusp();
 	struct sigframe __user *frame = (struct sigframe __user *)(usp - 4);
 	sigset_t set;
+	int size;
 
 	if (!access_ok(frame, sizeof(*frame)))
 		goto badframe;
@@ -801,20 +769,22 @@ asmlinkage int do_sigreturn(struct pt_regs *regs, struct switch_stack *sw)
 
 	set_current_blocked(&set);
 
-	if (restore_sigcontext(regs, &frame->sc, frame + 1))
+	size = restore_sigcontext(regs, &frame->sc, frame + 1);
+	if (size < 0)
 		goto badframe;
-	return regs->d0;
+	return (void *)sw - size;
 
 badframe:
 	force_sig(SIGSEGV);
-	return 0;
+	return sw;
 }
 
-asmlinkage int do_rt_sigreturn(struct pt_regs *regs, struct switch_stack *sw)
+asmlinkage void *do_rt_sigreturn(struct pt_regs *regs, struct switch_stack *sw)
 {
 	unsigned long usp = rdusp();
 	struct rt_sigframe __user *frame = (struct rt_sigframe __user *)(usp - 4);
 	sigset_t set;
+	int size;
 
 	if (!access_ok(frame, sizeof(*frame)))
 		goto badframe;
@@ -823,13 +793,14 @@ asmlinkage int do_rt_sigreturn(struct pt_regs *regs, struct switch_stack *sw)
 
 	set_current_blocked(&set);
 
-	if (rt_restore_ucontext(regs, sw, &frame->uc))
+	size = rt_restore_ucontext(regs, sw, &frame->uc);
+	if (size < 0)
 		goto badframe;
-	return regs->d0;
+	return (void *)sw - size;
 
 badframe:
 	force_sig(SIGSEGV);
-	return 0;
+	return sw;
 }
 
 static inline struct pt_regs *rte_regs(struct pt_regs *regs)
-- 
2.11.0

