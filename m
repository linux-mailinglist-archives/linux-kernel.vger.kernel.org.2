Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B103432D16
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 07:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbhJSFUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 01:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbhJSFTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 01:19:55 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDA8C061769
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 22:17:43 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id gn3so8279879pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 22:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wbg7uV+cW0A59EJbVTzt5Hc4G1KnO4URFF3gCK0IyT4=;
        b=Naxyjb+JmaF+4iTcN1jwLFOkZkB483ts/2SbTveLLxzTu1mf72sfdlC05NZohvfpsc
         VQ1s8GMscZmNIkn9SkRmBR1knEiIRTW8RG6podjITDMmYFCMRJWoWuqfAcZ77AAdoH8S
         e1LKQXs4boTKtzwXCK9svLukatRkwr6qjBlIemjNWB4z0ZCVLHl9e9UaAYqq7d+rzAKV
         9xnPrqrSir/yrtZ/+dupqcv7T0Xb/k0LTt6L97yc0Zr/SqsvkydDR5kCF3O2SogD3M2D
         t3zlqdPieeBjYhdt+/V6CUPvhuhwqdtICvQ6TSJR7FG8GuJ3puRUCBkMCVQO2gCOek1b
         ymbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wbg7uV+cW0A59EJbVTzt5Hc4G1KnO4URFF3gCK0IyT4=;
        b=WwmkFepVyQyA5lmSlbDhPq/4uVoscCxbRzY4GZl3S6amrRTEDzHYHSvRY4tbKWRWC/
         bDCOOD9dgzdYzLHCWaXdvO/4e07h/sCKCTadv2dt3EIFY3sljbDzgtsHIf/hZQskXifP
         tr1Gp9C5FBIcvwWdITMmYzlKBjRZZMAfZqrkQ/MYFZc9AcaTuZ5/czaEU+lD6s6At4Je
         bGY/J0BHYSsjl0ejuJ2bwmkk8QYF5IUeUfxz/wA1k3uJhwfZKjnjisqcyrjf1TCctztO
         B3CM1aJH1H77sV3y4/xJRA/wo0m0ZJgqQdCAHgyyn7zjcFwJ5sFiwnFFudBDcgddbngg
         keig==
X-Gm-Message-State: AOAM530WvuruOx1FtMwRuBoBxD9pRGwPjrtIgHlwR9v2qfPqM7jBiN0w
        qAxcw4G14zFSnt3tNyO2j5n7geV5GBs=
X-Google-Smtp-Source: ABdhPJx/mK+VJBodbJGLHzl8w0ye9XfWCVVnyw3p7kEB37TNkUpuuuGUyBjMZfQyLSlTTCxfWt1n2g==
X-Received: by 2002:a17:90a:384a:: with SMTP id l10mr3973547pjf.168.1634620662783;
        Mon, 18 Oct 2021 22:17:42 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:4171:83c2:8384:24c5])
        by smtp.gmail.com with ESMTPSA id me12sm1168844pjb.27.2021.10.18.22.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 22:17:42 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 06/10] xtensa: implement call0 ABI support in assembly
Date:   Mon, 18 Oct 2021 22:17:12 -0700
Message-Id: <20211019051716.4173-7-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211019051716.4173-1-jcmvbkbc@gmail.com>
References: <20211019051716.4173-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace hardcoded register and opcode names with ABI-agnostic macros.
Add register save/restore code where necessary. Conditionalize windowed
only or call0 only code. Add stack initialization matching _switch_to
epilogue to copy_thread.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/boot/boot-redboot/bootstrap.S |  68 +++----
 arch/xtensa/kernel/entry.S                | 209 ++++++++++++++--------
 arch/xtensa/kernel/head.S                 |  22 +--
 arch/xtensa/kernel/mcount.S               |  38 +++-
 arch/xtensa/kernel/process.c              |  27 ++-
 5 files changed, 243 insertions(+), 121 deletions(-)

diff --git a/arch/xtensa/boot/boot-redboot/bootstrap.S b/arch/xtensa/boot/boot-redboot/bootstrap.S
index 48ba5a232d94..51e8f3b88e82 100644
--- a/arch/xtensa/boot/boot-redboot/bootstrap.S
+++ b/arch/xtensa/boot/boot-redboot/bootstrap.S
@@ -3,6 +3,7 @@
 #include <asm/regs.h>
 #include <asm/asmmacro.h>
 #include <asm/cacheasm.h>
+#include <asm/processor.h>
 	/*
 	 * RB-Data: RedBoot data/bss
 	 * P:	    Boot-Parameters
@@ -36,7 +37,7 @@
 	.globl __start
 	/* this must be the first byte of the loader! */
 __start:
-	entry	sp, 32		# we do not intend to return
+	abi_entry(32)		# we do not intend to return
 	_call0	_start
 __start_a0:
 	.align 4
@@ -62,10 +63,12 @@ _start:
 	wsr	a4, windowstart
 	rsync
 
-	movi	a4, 0x00040000
+	movi	a4, KERNEL_PS_WOE_MASK
 	wsr	a4, ps
 	rsync
 
+KABI_C0	mov	abi_saved0, abi_arg0
+
 	/* copy the loader to its address
 	 * Note: The loader itself is a very small piece, so we assume we
 	 *       don't partially overlap. We also assume (even more important)
@@ -168,52 +171,52 @@ _reloc:
 
 	movi	a3, __image_load
 	sub	a4, a3, a4
-	add	a8, a0, a4
+	add	abi_arg2, a0, a4
 
 	# a1  Stack
 	# a8(a4)  Load address of the image
 
-	movi	a6, _image_start
-	movi	a10, _image_end
-	movi	a7, 0x1000000
-	sub	a11, a10, a6
-	movi	a9, complen
-	s32i	a11, a9, 0
+	movi	abi_arg0, _image_start
+	movi	abi_arg4, _image_end
+	movi	abi_arg1, 0x1000000
+	sub	abi_tmp0, abi_arg4, abi_arg0
+	movi	abi_arg3, complen
+	s32i	abi_tmp0, abi_arg3, 0
 
 	movi	a0, 0
 
-	# a6 destination
-	# a7 maximum size of destination
-	# a8 source
-	# a9 ptr to length
+	# abi_arg0 destination
+	# abi_arg1 maximum size of destination
+	# abi_arg2 source
+	# abi_arg3 ptr to length
 
 	.extern gunzip
-	movi	a4, gunzip
-	beqz	a4, 1f
+	movi	abi_tmp0, gunzip
+	beqz	abi_tmp0, 1f
 
-	callx4	a4
+	abi_callx	abi_tmp0
 
 	j	2f
 
 
-	# a6 destination start
-	# a7 maximum size of destination
-	# a8 source start
-	# a9 ptr to length
-	# a10 destination end
+	# abi_arg0 destination start
+	# abi_arg1 maximum size of destination
+	# abi_arg2 source start
+	# abi_arg3 ptr to length
+	# abi_arg4 destination end
 
 1:
-        l32i    a9, a8, 0
-        l32i    a11, a8, 4
-        s32i    a9, a6, 0
-        s32i    a11, a6, 4
-        l32i    a9, a8, 8
-        l32i    a11, a8, 12
-        s32i    a9, a6, 8
-        s32i    a11, a6, 12
-        addi    a6, a6, 16
-        addi    a8, a8, 16
-        blt     a6, a10, 1b
+        l32i    abi_tmp0, abi_arg2, 0
+        l32i    abi_tmp1, abi_arg2, 4
+        s32i    abi_tmp0, abi_arg0, 0
+        s32i    abi_tmp1, abi_arg0, 4
+        l32i    abi_tmp0, abi_arg2, 8
+        l32i    abi_tmp1, abi_arg2, 12
+        s32i    abi_tmp0, abi_arg0, 8
+        s32i    abi_tmp1, abi_arg0, 12
+        addi    abi_arg0, abi_arg0, 16
+        addi    abi_arg2, abi_arg2, 16
+        blt     abi_arg0, abi_arg4, 1b
 
 
 	/* jump to the kernel */
@@ -230,6 +233,7 @@ _reloc:
 
 	# a2  Boot parameter list
 
+KABI_C0	mov	abi_arg0, abi_saved0
 	movi	a0, _image_start
 	jx	a0
 
diff --git a/arch/xtensa/kernel/entry.S b/arch/xtensa/kernel/entry.S
index 647b162f959b..a144b467c3fd 100644
--- a/arch/xtensa/kernel/entry.S
+++ b/arch/xtensa/kernel/entry.S
@@ -158,6 +158,7 @@ _user_exception:
 	/* Rotate ws so that the current windowbase is at bit0. */
 	/* Assume ws = xxwww1yyyy. Rotate ws right, so that a2 = yyyyxxwww1 */
 
+#if defined(USER_SUPPORT_WINDOWED)
 	rsr	a2, windowbase
 	rsr	a3, windowstart
 	ssr	a2
@@ -167,24 +168,33 @@ _user_exception:
 	src	a2, a3, a2
 	srli	a2, a2, 32-WSBITS
 	s32i	a2, a1, PT_WMASK	# needed for restoring registers
+#else
+	movi	a2, 0
+	movi	a3, 1
+	s32i	a2, a1, PT_WINDOWBASE
+	s32i	a3, a1, PT_WINDOWSTART
+	s32i	a3, a1, PT_WMASK
+#endif
 
 	/* Save only live registers. */
 
-	_bbsi.l	a2, 1, 1f
+UABI_W	_bbsi.l	a2, 1, 1f
 	s32i	a4, a1, PT_AREG4
 	s32i	a5, a1, PT_AREG5
 	s32i	a6, a1, PT_AREG6
 	s32i	a7, a1, PT_AREG7
-	_bbsi.l	a2, 2, 1f
+UABI_W	_bbsi.l	a2, 2, 1f
 	s32i	a8, a1, PT_AREG8
 	s32i	a9, a1, PT_AREG9
 	s32i	a10, a1, PT_AREG10
 	s32i	a11, a1, PT_AREG11
-	_bbsi.l	a2, 3, 1f
+UABI_W	_bbsi.l	a2, 3, 1f
 	s32i	a12, a1, PT_AREG12
 	s32i	a13, a1, PT_AREG13
 	s32i	a14, a1, PT_AREG14
 	s32i	a15, a1, PT_AREG15
+
+#if defined(USER_SUPPORT_WINDOWED)
 	_bnei	a2, 1, 1f		# only one valid frame?
 
 	/* Only one valid frame, skip saving regs. */
@@ -239,7 +249,7 @@ _user_exception:
 	rsync
 
 	/* We are back to the original stack pointer (a1) */
-
+#endif
 2:	/* Now, jump to the common exception handler. */
 
 	j	common_exception
@@ -295,6 +305,7 @@ _kernel_exception:
 	s32i	a3, a1, PT_SAR
 	s32i	a2, a1, PT_ICOUNTLEVEL
 
+#if defined(__XTENSA_WINDOWED_ABI__)
 	/* Rotate ws so that the current windowbase is at bit0. */
 	/* Assume ws = xxwww1yyyy. Rotate ws right, so that a2 = yyyyxxwww1 */
 
@@ -305,27 +316,28 @@ _kernel_exception:
 	src	a2, a3, a2
 	srli	a2, a2, 32-WSBITS
 	s32i	a2, a1, PT_WMASK	# needed for kernel_exception_exit
+#endif
 
 	/* Save only the live window-frame */
 
-	_bbsi.l	a2, 1, 1f
+KABI_W	_bbsi.l	a2, 1, 1f
 	s32i	a4, a1, PT_AREG4
 	s32i	a5, a1, PT_AREG5
 	s32i	a6, a1, PT_AREG6
 	s32i	a7, a1, PT_AREG7
-	_bbsi.l	a2, 2, 1f
+KABI_W	_bbsi.l	a2, 2, 1f
 	s32i	a8, a1, PT_AREG8
 	s32i	a9, a1, PT_AREG9
 	s32i	a10, a1, PT_AREG10
 	s32i	a11, a1, PT_AREG11
-	_bbsi.l	a2, 3, 1f
+KABI_W	_bbsi.l	a2, 3, 1f
 	s32i	a12, a1, PT_AREG12
 	s32i	a13, a1, PT_AREG13
 	s32i	a14, a1, PT_AREG14
 	s32i	a15, a1, PT_AREG15
 
+#ifdef __XTENSA_WINDOWED_ABI__
 	_bnei	a2, 1, 1f
-
 	/* Copy spill slots of a0 and a1 to imitate movsp
 	 * in order to keep exception stack continuous
 	 */
@@ -333,6 +345,7 @@ _kernel_exception:
 	l32i	a0, a1, PT_SIZE + 4
 	s32e	a3, a1, -16
 	s32e	a0, a1, -12
+#endif
 1:
 	l32i	a0, a1, PT_AREG0	# restore saved a0
 	wsr	a0, depc
@@ -419,16 +432,16 @@ common_exception:
 	movi	a3, LOCKLEVEL
 
 .Lexception:
-	movi	a0, PS_WOE_MASK
-	or	a3, a3, a0
+KABI_W	movi	a0, PS_WOE_MASK
+KABI_W	or	a3, a3, a0
 #else
 	addi	a2, a2, -EXCCAUSE_LEVEL1_INTERRUPT
 	movi	a0, LOCKLEVEL
 	extui	a3, a3, PS_INTLEVEL_SHIFT, PS_INTLEVEL_WIDTH
 					# a3 = PS.INTLEVEL
 	moveqz	a3, a0, a2		# a3 = LOCKLEVEL iff interrupt
-	movi	a2, PS_WOE_MASK
-	or	a3, a3, a2
+KABI_W	movi	a2, PS_WOE_MASK
+KABI_W	or	a3, a3, a2
 	rsr	a2, exccause
 #endif
 
@@ -461,14 +474,14 @@ common_exception:
 	 */
 
 	rsr	a4, excsave1
-	mov	a6, a1			# pass stack frame
-	mov	a7, a2			# pass EXCCAUSE
 	addx4	a4, a2, a4
 	l32i	a4, a4, EXC_TABLE_DEFAULT		# load handler
+	mov	abi_arg1, a2			# pass EXCCAUSE
+	mov	abi_arg0, a1			# pass stack frame
 
 	/* Call the second-level handler */
 
-	callx4	a4
+	abi_callx	a4
 
 	/* Jump here for exception exit */
 	.global common_exception_return
@@ -482,15 +495,15 @@ common_exception_return:
 1:
 	irq_save a2, a3
 #ifdef CONFIG_TRACE_IRQFLAGS
-	call4	trace_hardirqs_off
+	abi_call	trace_hardirqs_off
 #endif
 
 	/* Jump if we are returning from kernel exceptions. */
 
-	l32i	a3, a1, PT_PS
+	l32i	abi_saved1, a1, PT_PS
 	GET_THREAD_INFO(a2, a1)
 	l32i	a4, a2, TI_FLAGS
-	_bbci.l	a3, PS_UM_BIT, 6f
+	_bbci.l	abi_saved1, PS_UM_BIT, 6f
 
 	/* Specific to a user exception exit:
 	 * We need to check some flags for signal handling and rescheduling,
@@ -509,20 +522,20 @@ common_exception_return:
 	/* Call do_signal() */
 
 #ifdef CONFIG_TRACE_IRQFLAGS
-	call4	trace_hardirqs_on
+	abi_call	trace_hardirqs_on
 #endif
 	rsil	a2, 0
-	mov	a6, a1
-	call4	do_notify_resume	# int do_notify_resume(struct pt_regs*)
+	mov	abi_arg0, a1
+	abi_call	do_notify_resume	# int do_notify_resume(struct pt_regs*)
 	j	1b
 
 3:	/* Reschedule */
 
 #ifdef CONFIG_TRACE_IRQFLAGS
-	call4	trace_hardirqs_on
+	abi_call	trace_hardirqs_on
 #endif
 	rsil	a2, 0
-	call4	schedule	# void schedule (void)
+	abi_call	schedule	# void schedule (void)
 	j	1b
 
 #ifdef CONFIG_PREEMPTION
@@ -533,33 +546,33 @@ common_exception_return:
 
 	l32i	a4, a2, TI_PRE_COUNT
 	bnez	a4, 4f
-	call4	preempt_schedule_irq
+	abi_call	preempt_schedule_irq
 	j	4f
 #endif
 
 #if XTENSA_FAKE_NMI
 .LNMIexit:
-	l32i	a3, a1, PT_PS
-	_bbci.l	a3, PS_UM_BIT, 4f
+	l32i	abi_saved1, a1, PT_PS
+	_bbci.l	abi_saved1, PS_UM_BIT, 4f
 #endif
 
 5:
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 	_bbci.l	a4, TIF_DB_DISABLED, 7f
-	call4	restore_dbreak
+	abi_call	restore_dbreak
 7:
 #endif
 #ifdef CONFIG_DEBUG_TLB_SANITY
 	l32i	a4, a1, PT_DEPC
 	bgeui	a4, VALID_DOUBLE_EXCEPTION_ADDRESS, 4f
-	call4	check_tlb_sanity
+	abi_call	check_tlb_sanity
 #endif
 6:
 4:
 #ifdef CONFIG_TRACE_IRQFLAGS
-	extui	a4, a3, PS_INTLEVEL_SHIFT, PS_INTLEVEL_WIDTH
+	extui	a4, abi_saved1, PS_INTLEVEL_SHIFT, PS_INTLEVEL_WIDTH
 	bgei	a4, LOCKLEVEL, 1f
-	call4	trace_hardirqs_on
+	abi_call	trace_hardirqs_on
 1:
 #endif
 	/* Restore optional registers. */
@@ -572,14 +585,15 @@ common_exception_return:
 	l32i    a2, a1, PT_SCOMPARE1
 	wsr     a2, scompare1
 #endif
-	wsr	a3, ps		/* disable interrupts */
+	wsr	abi_saved1, ps		/* disable interrupts */
 
-	_bbci.l	a3, PS_UM_BIT, kernel_exception_exit
+	_bbci.l	abi_saved1, PS_UM_BIT, kernel_exception_exit
 
 user_exception_exit:
 
 	/* Restore the state of the task and return from the exception. */
 
+#if defined(USER_SUPPORT_WINDOWED)
 	/* Switch to the user thread WINDOWBASE. Save SP temporarily in DEPC */
 
 	l32i	a2, a1, PT_WINDOWBASE
@@ -634,8 +648,10 @@ user_exception_exit:
 	 *	 frame where we had loaded a2), or at least the lower 4 bits
 	 *	 (if we have restored WSBITS-1 frames).
 	 */
-
 2:
+#else
+	movi	a2, 1
+#endif
 #if XCHAL_HAVE_THREADPTR
 	l32i	a3, a1, PT_THREADPTR
 	wur	a3, threadptr
@@ -650,6 +666,7 @@ user_exception_exit:
 
 kernel_exception_exit:
 
+#if defined(__XTENSA_WINDOWED_ABI__)
 	/* Check if we have to do a movsp.
 	 *
 	 * We only have to do a movsp if the previous window-frame has
@@ -702,6 +719,9 @@ kernel_exception_exit:
 	 *
 	 * Note: We expect a2 to hold PT_WMASK
 	 */
+#else
+	movi	a2, 1
+#endif
 
 common_exception_exit:
 
@@ -927,7 +947,7 @@ ENTRY(unrecoverable_exception)
 	wsr	a1, windowbase
 	rsync
 
-	movi	a1, PS_WOE_MASK | LOCKLEVEL
+	movi	a1, KERNEL_PS_WOE_MASK | LOCKLEVEL
 	wsr	a1, ps
 	rsync
 
@@ -935,8 +955,8 @@ ENTRY(unrecoverable_exception)
 	movi	a0, 0
 	addi	a1, a1, PT_REGS_OFFSET
 
-	movi	a6, unrecoverable_text
-	call4	panic
+	movi	abi_arg0, unrecoverable_text
+	abi_call	panic
 
 1:	j	1b
 
@@ -1403,12 +1423,12 @@ ENTRY(fast_syscall_spill_registers)
 	rsr	a3, excsave1
 	l32i	a1, a3, EXC_TABLE_KSTK
 
-	movi	a4, PS_WOE_MASK | LOCKLEVEL
+	movi	a4, KERNEL_PS_WOE_MASK | LOCKLEVEL
 	wsr	a4, ps
 	rsync
 
-	movi	a6, SIGSEGV
-	call4	do_exit
+	movi	abi_arg0, SIGSEGV
+	abi_call	do_exit
 
 	/* shouldn't return, so panic */
 
@@ -1887,57 +1907,77 @@ ENDPROC(fast_store_prohibited)
 
 ENTRY(system_call)
 
+#if defined(__XTENSA_WINDOWED_ABI__)
 	abi_entry_default
+#elif defined(__XTENSA_CALL0_ABI__)
+	abi_entry(12)
+
+	s32i	a0, sp, 0
+	s32i	abi_saved0, sp, 4
+	s32i	abi_saved1, sp, 8
+	mov	abi_saved0, a2
+#else
+#error Unsupported Xtensa ABI
+#endif
 
 	/* regs->syscall = regs->areg[2] */
 
-	l32i	a7, a2, PT_AREG2
-	s32i	a7, a2, PT_SYSCALL
+	l32i	a7, abi_saved0, PT_AREG2
+	s32i	a7, abi_saved0, PT_SYSCALL
 
 	GET_THREAD_INFO(a4, a1)
-	l32i	a3, a4, TI_FLAGS
+	l32i	abi_saved1, a4, TI_FLAGS
 	movi	a4, _TIF_WORK_MASK
-	and	a3, a3, a4
-	beqz	a3, 1f
+	and	abi_saved1, abi_saved1, a4
+	beqz	abi_saved1, 1f
 
-	mov	a6, a2
-	call4	do_syscall_trace_enter
-	beqz	a6, .Lsyscall_exit
-	l32i	a7, a2, PT_SYSCALL
+	mov	abi_arg0, abi_saved0
+	abi_call	do_syscall_trace_enter
+	beqz	abi_rv, .Lsyscall_exit
+	l32i	a7, abi_saved0, PT_SYSCALL
 
 1:
 	/* syscall = sys_call_table[syscall_nr] */
 
 	movi	a4, sys_call_table
 	movi	a5, __NR_syscalls
-	movi	a6, -ENOSYS
+	movi	abi_rv, -ENOSYS
 	bgeu	a7, a5, 1f
 
 	addx4	a4, a7, a4
-	l32i	a4, a4, 0
+	l32i	abi_tmp0, a4, 0
 
 	/* Load args: arg0 - arg5 are passed via regs. */
 
-	l32i	a6, a2, PT_AREG6
-	l32i	a7, a2, PT_AREG3
-	l32i	a8, a2, PT_AREG4
-	l32i	a9, a2, PT_AREG5
-	l32i	a10, a2, PT_AREG8
-	l32i	a11, a2, PT_AREG9
+	l32i	abi_arg0, abi_saved0, PT_AREG6
+	l32i	abi_arg1, abi_saved0, PT_AREG3
+	l32i	abi_arg2, abi_saved0, PT_AREG4
+	l32i	abi_arg3, abi_saved0, PT_AREG5
+	l32i	abi_arg4, abi_saved0, PT_AREG8
+	l32i	abi_arg5, abi_saved0, PT_AREG9
 
-	callx4	a4
+	abi_callx	abi_tmp0
 
 1:	/* regs->areg[2] = return_value */
 
-	s32i	a6, a2, PT_AREG2
-	bnez	a3, 1f
+	s32i	abi_rv, abi_saved0, PT_AREG2
+	bnez	abi_saved1, 1f
 .Lsyscall_exit:
+#if defined(__XTENSA_WINDOWED_ABI__)
 	abi_ret_default
+#elif defined(__XTENSA_CALL0_ABI__)
+	l32i	a0, sp, 0
+	l32i	abi_saved0, sp, 4
+	l32i	abi_saved1, sp, 8
+	abi_ret(12)
+#else
+#error Unsupported Xtensa ABI
+#endif
 
 1:
-	mov	a6, a2
-	call4	do_syscall_trace_leave
-	abi_ret_default
+	mov	abi_arg0, abi_saved0
+	abi_call	do_syscall_trace_leave
+	j	.Lsyscall_exit
 
 ENDPROC(system_call)
 
@@ -1988,8 +2028,18 @@ ENDPROC(system_call)
 
 ENTRY(_switch_to)
 
+#if defined(__XTENSA_WINDOWED_ABI__)
 	abi_entry(XTENSA_SPILL_STACK_RESERVE)
+#elif defined(__XTENSA_CALL0_ABI__)
+	abi_entry(16)
 
+	s32i	a12, sp, 0
+	s32i	a13, sp, 4
+	s32i	a14, sp, 8
+	s32i	a15, sp, 12
+#else
+#error Unsupported Xtensa ABI
+#endif
 	mov	a11, a3			# and 'next' (a3)
 
 	l32i	a4, a2, TASK_THREAD_INFO
@@ -2033,7 +2083,9 @@ ENTRY(_switch_to)
 
 	/* Flush register file. */
 
+#if defined(__XTENSA_WINDOWED_ABI__)
 	spill_registers_kernel
+#endif
 
 	/* Set kernel stack (and leave critical section)
 	 * Note: It's save to set it here. The stack will not be overwritten
@@ -2055,34 +2107,43 @@ ENTRY(_switch_to)
 	wsr	a14, ps
 	rsync
 
+#if defined(__XTENSA_WINDOWED_ABI__)
 	abi_ret(XTENSA_SPILL_STACK_RESERVE)
+#elif defined(__XTENSA_CALL0_ABI__)
+	l32i	a12, sp, 0
+	l32i	a13, sp, 4
+	l32i	a14, sp, 8
+	l32i	a15, sp, 12
+	abi_ret(16)
+#else
+#error Unsupported Xtensa ABI
+#endif
 
 ENDPROC(_switch_to)
 
 ENTRY(ret_from_fork)
 
 	/* void schedule_tail (struct task_struct *prev)
-	 * Note: prev is still in a6 (return value from fake call4 frame)
+	 * Note: prev is still in abi_arg0 (return value from fake call frame)
 	 */
-	call4	schedule_tail
-
-	mov	a6, a1
-	call4	do_syscall_trace_leave
+	abi_call	schedule_tail
 
-	j	common_exception_return
+	mov		abi_arg0, a1
+	abi_call	do_syscall_trace_leave
+	j		common_exception_return
 
 ENDPROC(ret_from_fork)
 
 /*
  * Kernel thread creation helper
- * On entry, set up by copy_thread: a2 = thread_fn, a3 = thread_fn arg
- *           left from _switch_to: a6 = prev
+ * On entry, set up by copy_thread: abi_saved0 = thread_fn,
+ * abi_saved1 = thread_fn arg. Left from _switch_to: abi_arg0 = prev
  */
 ENTRY(ret_from_kernel_thread)
 
-	call4	schedule_tail
-	mov	a6, a3
-	callx4	a2
-	j	common_exception_return
+	abi_call	schedule_tail
+	mov		abi_arg0, abi_saved1
+	abi_callx	abi_saved0
+	j		common_exception_return
 
 ENDPROC(ret_from_kernel_thread)
diff --git a/arch/xtensa/kernel/head.S b/arch/xtensa/kernel/head.S
index b9b81e76beea..8972d64e0b86 100644
--- a/arch/xtensa/kernel/head.S
+++ b/arch/xtensa/kernel/head.S
@@ -15,6 +15,7 @@
  * Kevin Chea
  */
 
+#include <asm/asmmacro.h>
 #include <asm/processor.h>
 #include <asm/page.h>
 #include <asm/cacheasm.h>
@@ -193,9 +194,10 @@ ENTRY(_startup)
 	movi	a1, start_info
 	l32i	a1, a1, 0
 
-	movi	a2, PS_WOE_MASK | LOCKLEVEL
-					# WOE=1, INTLEVEL=LOCKLEVEL, UM=0
-	wsr	a2, ps			# (enable reg-windows; progmode stack)
+	/* Disable interrupts. */
+	/* Enable window exceptions if kernel is built with windowed ABI. */
+	movi	a2, KERNEL_PS_WOE_MASK | LOCKLEVEL
+	wsr	a2, ps
 	rsync
 
 #ifdef CONFIG_SMP
@@ -267,13 +269,13 @@ ENTRY(_startup)
 	l32i	a1, a1, 0
 #endif
 
-	movi	a6, 0
-	xsr	a6, excsave1
+	movi	abi_arg0, 0
+	xsr	abi_arg0, excsave1
 
 	/* init_arch kick-starts the linux kernel */
 
-	call4	init_arch
-	call4	start_kernel
+	abi_call	init_arch
+	abi_call	start_kernel
 
 should_never_return:
 	j	should_never_return
@@ -297,10 +299,10 @@ should_never_return:
 	s32i	a3, a2, 0
 	memw
 
-	movi	a6, 0
-	wsr	a6, excsave1
+	movi	abi_arg0, 0
+	wsr	abi_arg0, excsave1
 
-	call4	secondary_start_kernel
+	abi_call	secondary_start_kernel
 	j	should_never_return
 
 #endif  /* CONFIG_SMP */
diff --git a/arch/xtensa/kernel/mcount.S b/arch/xtensa/kernel/mcount.S
index 5e4619f52858..51daaf4e0b82 100644
--- a/arch/xtensa/kernel/mcount.S
+++ b/arch/xtensa/kernel/mcount.S
@@ -17,11 +17,16 @@
 /*
  * Entry condition:
  *
- *   a2:	a0 of the caller
+ *   a2:	a0 of the caller in windowed ABI
+ *   a10:	a0 of the caller in call0 ABI
+ *
+ * In call0 ABI the function _mcount is called with the special ABI:
+ * its argument is in a10 and all the usual argument registers (a2 - a7)
+ * must be preserved in addition to callee-saved a12 - a15.
  */
 
 ENTRY(_mcount)
-
+#if defined(__XTENSA_WINDOWED_ABI__)
 	abi_entry_default
 
 	movi	a4, ftrace_trace_function
@@ -42,7 +47,36 @@ ENTRY(_mcount)
 	callx4	a4
 
 	abi_ret_default
+#elif defined(__XTENSA_CALL0_ABI__)
+	abi_entry_default
+
+	movi	a9, ftrace_trace_function
+	l32i	a9, a9, 0
+	movi	a11, ftrace_stub
+	bne	a9, a11, 1f
+	abi_ret_default
 
+1:	abi_entry(28)
+	s32i	a0, sp, 0
+	s32i	a2, sp, 4
+	s32i	a3, sp, 8
+	s32i	a4, sp, 12
+	s32i	a5, sp, 16
+	s32i	a6, sp, 20
+	s32i	a7, sp, 24
+	addi	a2, a10, -MCOUNT_INSN_SIZE
+	callx0	a9
+	l32i	a0, sp, 0
+	l32i	a2, sp, 4
+	l32i	a3, sp, 8
+	l32i	a4, sp, 12
+	l32i	a5, sp, 16
+	l32i	a6, sp, 20
+	l32i	a7, sp, 24
+	abi_ret(28)
+#else
+#error Unsupported Xtensa ABI
+#endif
 ENDPROC(_mcount)
 
 ENTRY(ftrace_stub)
diff --git a/arch/xtensa/kernel/process.c b/arch/xtensa/kernel/process.c
index 060165340612..de6eb9ddea44 100644
--- a/arch/xtensa/kernel/process.c
+++ b/arch/xtensa/kernel/process.c
@@ -211,11 +211,18 @@ int copy_thread(unsigned long clone_flags, unsigned long usp_thread_fn,
 	struct thread_info *ti;
 #endif
 
+#if defined(__XTENSA_WINDOWED_ABI__)
 	/* Create a call4 dummy-frame: a0 = 0, a1 = childregs. */
 	SPILL_SLOT(childregs, 1) = (unsigned long)childregs;
 	SPILL_SLOT(childregs, 0) = 0;
 
 	p->thread.sp = (unsigned long)childregs;
+#elif defined(__XTENSA_CALL0_ABI__)
+	/* Reserve 16 bytes for the _switch_to stack frame. */
+	p->thread.sp = (unsigned long)childregs - 16;
+#else
+#error Unsupported Xtensa ABI
+#endif
 
 	if (!(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
 		struct pt_regs *regs = current_pt_regs();
@@ -272,11 +279,25 @@ int copy_thread(unsigned long clone_flags, unsigned long usp_thread_fn,
 		p->thread.ra = MAKE_RA_FOR_CALL(
 				(unsigned long)ret_from_kernel_thread, 1);
 
-		/* pass parameters to ret_from_kernel_thread:
-		 * a2 = thread_fn, a3 = thread_fn arg
+		/* pass parameters to ret_from_kernel_thread: */
+#if defined(__XTENSA_WINDOWED_ABI__)
+		/*
+		 * a2 = thread_fn, a3 = thread_fn arg.
+		 * Window underflow will load registers from the
+		 * spill slots on the stack on return from _switch_to.
 		 */
-		SPILL_SLOT(childregs, 3) = thread_fn_arg;
 		SPILL_SLOT(childregs, 2) = usp_thread_fn;
+		SPILL_SLOT(childregs, 3) = thread_fn_arg;
+#elif defined(__XTENSA_CALL0_ABI__)
+		/*
+		 * a12 = thread_fn, a13 = thread_fn arg.
+		 * _switch_to epilogue will load registers from the stack.
+		 */
+		((unsigned long *)p->thread.sp)[0] = usp_thread_fn;
+		((unsigned long *)p->thread.sp)[1] = thread_fn_arg;
+#else
+#error Unsupported Xtensa ABI
+#endif
 
 		/* Childregs are only used when we're going to userspace
 		 * in which case start_thread will set them up.
-- 
2.20.1

