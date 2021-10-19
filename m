Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB819432D18
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 07:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbhJSFUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 01:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbhJSFT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 01:19:57 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B42C061745
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 22:17:45 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id kk10so13832145pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 22:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pk18CcO3FwJ+jxwU/8wrB3vX5AdEu+FmqIsAHVxmMyA=;
        b=kvchL/nhrZAALJ7A/iBRUYPB5rjnIroxJkZUpe1Zn+2+jglLy9i39zNrlLRfMlop1F
         rqhVqkBj67YOqHCrAKgu4INp2+g8nn3vE0nUSMqBvxi3xR0gZZh2iHnTZkwrT1YCZ+D0
         5pmmc8RMO95hxVwRXwz4JeVCPnmhwDmZMLcbx+wj6hioktGikgklpw51PJ4JAAG8GV5Q
         VS+IQDyhoOdrg7Yh4dfz+xrVgbgyPTNtqVknKjgozy49wrXDnB5t5dSgmikQKLwUzbgA
         CJ57VVTQsF9QN6rzdLJHZ9uHsgPXTBT8QstyrBtPdBfeGMokBhBr72ai8KTq7Q6AQXH3
         mW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pk18CcO3FwJ+jxwU/8wrB3vX5AdEu+FmqIsAHVxmMyA=;
        b=AQJekeAiSdY/wclZUkBiKUmWm5nht6hNu1AHAHrRmL2ahDnH9LN3GGiZRPJH1SY/tG
         wENVv5jrwSABX2y9BYdhM0lMW8hBY42CUSx3liTEXT0juJHXNlLi0ZUp1JMH0d68esQA
         e8T/ee/wcSaYbR2vi4B5vFlZfN0j+QV9xlMWinT9UaW3FoecdjWeBQwEQ7DUqbPii/XX
         tXXwD/uCsnaO0EYeOSZLIvVJ/X5bmVuVbYaivr8aas/E4wDEaqxPDmntmK8pgI3roZeJ
         Cr4wYpZueEBnpbbd2o1MSB3qbDIQA/q0ENz1PGJUPXqyRgsFxNNuDLIsauz7VRB0jNFS
         tCow==
X-Gm-Message-State: AOAM533l5t8MsCAXdvLUaWuYioqS+l7n84NVQNV088YpNXWlR8Wg6fB/
        /QXUWS2+LGgSWsmHH3pInDw=
X-Google-Smtp-Source: ABdhPJx7mS2vMdrKnUmMc+OyNfQr+OXcKK6N9vB/xjFnP0d9mngpGwW44ImrFKaPD0FOp7fSZxFrvg==
X-Received: by 2002:a17:902:d885:b0:13f:c50f:9ac with SMTP id b5-20020a170902d88500b0013fc50f09acmr7267500plz.53.1634620665152;
        Mon, 18 Oct 2021 22:17:45 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:4171:83c2:8384:24c5])
        by smtp.gmail.com with ESMTPSA id me12sm1168844pjb.27.2021.10.18.22.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 22:17:44 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 08/10] xtensa: only build windowed register support code when needed
Date:   Mon, 18 Oct 2021 22:17:14 -0700
Message-Id: <20211019051716.4173-9-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211019051716.4173-1-jcmvbkbc@gmail.com>
References: <20211019051716.4173-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need in window overflow/underflow/alloca exception handlers
or window spill code when neither kernel nor userspace support windowed
registers. Don't build or link it.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/traps.h  |  2 ++
 arch/xtensa/kernel/entry.S       |  5 ++++-
 arch/xtensa/kernel/setup.c       |  2 ++
 arch/xtensa/kernel/signal.c      | 12 ++++++++++--
 arch/xtensa/kernel/traps.c       |  2 ++
 arch/xtensa/kernel/vectors.S     | 15 +++++++++++++++
 arch/xtensa/kernel/vmlinux.lds.S | 12 ++++++++++--
 7 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/arch/xtensa/include/asm/traps.h b/arch/xtensa/include/asm/traps.h
index f720a57d0a5b..6fa47cd8e02d 100644
--- a/arch/xtensa/include/asm/traps.h
+++ b/arch/xtensa/include/asm/traps.h
@@ -56,6 +56,7 @@ void secondary_trap_init(void);
 
 static inline void spill_registers(void)
 {
+#if defined(__XTENSA_WINDOWED_ABI__)
 #if XCHAL_NUM_AREGS > 16
 	__asm__ __volatile__ (
 		"	call8	1f\n"
@@ -96,6 +97,7 @@ static inline void spill_registers(void)
 		"	mov	a12, a12\n"
 		: : : "memory");
 #endif
+#endif
 }
 
 struct debug_table {
diff --git a/arch/xtensa/kernel/entry.S b/arch/xtensa/kernel/entry.S
index 8029ce24af92..99ab3c1a3387 100644
--- a/arch/xtensa/kernel/entry.S
+++ b/arch/xtensa/kernel/entry.S
@@ -969,6 +969,7 @@ ENDPROC(unrecoverable_exception)
 	__XTENSA_HANDLER
 	.literal_position
 
+#ifdef SUPPORT_WINDOWED
 /*
  * Fast-handler for alloca exceptions
  *
@@ -1032,6 +1033,7 @@ ENTRY(fast_alloca)
 8:	j	_WindowUnderflow8
 4:	j	_WindowUnderflow4
 ENDPROC(fast_alloca)
+#endif
 
 #ifdef CONFIG_USER_ABI_CALL0_PROBE
 /*
@@ -1228,7 +1230,8 @@ ENDPROC(fast_syscall_xtensa)
  * Note: We assume the stack pointer is EXC_TABLE_KSTK in the fixup handler.
  */
 
-#ifdef CONFIG_FAST_SYSCALL_SPILL_REGISTERS
+#if defined(CONFIG_FAST_SYSCALL_SPILL_REGISTERS) && \
+		defined(USER_SUPPORT_WINDOWED)
 
 ENTRY(fast_syscall_spill_registers)
 
diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
index ed184106e4cf..3638fb98a1ab 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -349,8 +349,10 @@ void __init setup_arch(char **cmdline_p)
 #endif
 
 #ifdef CONFIG_VECTORS_ADDR
+#ifdef SUPPORT_WINDOWED
 	mem_reserve(__pa(&_WindowVectors_text_start),
 		    __pa(&_WindowVectors_text_end));
+#endif
 
 	mem_reserve(__pa(&_DebugInterruptVector_text_start),
 		    __pa(&_DebugInterruptVector_text_end));
diff --git a/arch/xtensa/kernel/signal.c b/arch/xtensa/kernel/signal.c
index c4d77dbfb61a..f6c949895b3e 100644
--- a/arch/xtensa/kernel/signal.c
+++ b/arch/xtensa/kernel/signal.c
@@ -45,12 +45,13 @@ struct rt_sigframe
 	unsigned int window[4];
 };
 
-/* 
+#if defined(USER_SUPPORT_WINDOWED)
+/*
  * Flush register windows stored in pt_regs to stack.
  * Returns 1 for errors.
  */
 
-int
+static int
 flush_window_regs_user(struct pt_regs *regs)
 {
 	const unsigned long ws = regs->windowstart;
@@ -121,6 +122,13 @@ flush_window_regs_user(struct pt_regs *regs)
 errout:
 	return err;
 }
+#else
+static int
+flush_window_regs_user(struct pt_regs *regs)
+{
+	return 0;
+}
+#endif
 
 /*
  * Note: We don't copy double exception 'regs', we have to finish double exc. 
diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index 874b6efc6fb3..4418438b13e6 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -97,7 +97,9 @@ static dispatch_init_table_t __initdata dispatch_init_table[] = {
 /* EXCCAUSE_INSTRUCTION_FETCH unhandled */
 /* EXCCAUSE_LOAD_STORE_ERROR unhandled*/
 { EXCCAUSE_LEVEL1_INTERRUPT,	0,	   do_interrupt },
+#ifdef SUPPORT_WINDOWED
 { EXCCAUSE_ALLOCA,		USER|KRNL, fast_alloca },
+#endif
 /* EXCCAUSE_INTEGER_DIVIDE_BY_ZERO unhandled */
 /* EXCCAUSE_PRIVILEGED unhandled */
 #if XCHAL_UNALIGNED_LOAD_EXCEPTION || XCHAL_UNALIGNED_STORE_EXCEPTION
diff --git a/arch/xtensa/kernel/vectors.S b/arch/xtensa/kernel/vectors.S
index 0eed5aa82914..407ece204e7c 100644
--- a/arch/xtensa/kernel/vectors.S
+++ b/arch/xtensa/kernel/vectors.S
@@ -226,6 +226,7 @@ ENTRY(_DoubleExceptionVector)
 
 	xsr	a0, depc		# get DEPC, save a0
 
+#ifdef SUPPORT_WINDOWED
 	movi	a2, WINDOW_VECTORS_VADDR
 	_bltu	a0, a2, .Lfixup
 	addi	a2, a2, WINDOW_VECTORS_SIZE
@@ -275,6 +276,10 @@ _DoubleExceptionVector_WindowUnderflow:
 	l32i	a0, a0, EXC_TABLE_FAST_USER
 	jx	a0
 
+#else
+	j	.Lfixup
+#endif
+
 	/*
 	 * We only allow the ITLB miss exception if we are in kernel space.
 	 * All other exceptions are unexpected and thus unrecoverable!
@@ -343,6 +348,7 @@ _DoubleExceptionVector_WindowUnderflow:
 	l32i	a0, a0, EXC_TABLE_FAST_USER
 	jx	a0
 
+#ifdef SUPPORT_WINDOWED
 	/*
 	 * Restart window OVERFLOW exception.
 	 * Currently:
@@ -475,9 +481,12 @@ _DoubleExceptionVector_handle_exception:
 	rsr	a0, depc
 	rotw	-3
 	j	1b
+#endif
 
 ENDPROC(_DoubleExceptionVector)
 
+#ifdef SUPPORT_WINDOWED
+
 /*
  * Fixup handler for TLB miss in double exception handler for window owerflow.
  * We get here with windowbase set to the window that was being spilled and
@@ -590,6 +599,8 @@ ENTRY(window_overflow_restore_a0_fixup)
 
 ENDPROC(window_overflow_restore_a0_fixup)
 
+#endif
+
 /*
  * Debug interrupt vector
  *
@@ -687,6 +698,8 @@ _SimulateUserKernelVectorException:
 	.section		.WindowVectors.text, "ax"
 
 
+#ifdef SUPPORT_WINDOWED
+
 /* 4-Register Window Overflow Vector (Handler) */
 
 ENTRY_ALIGN64(_WindowOverflow4)
@@ -787,4 +800,6 @@ ENTRY_ALIGN64(_WindowUnderflow12)
 
 ENDPROC(_WindowUnderflow12)
 
+#endif
+
 	.text
diff --git a/arch/xtensa/kernel/vmlinux.lds.S b/arch/xtensa/kernel/vmlinux.lds.S
index d23a6e38f062..eee270a039a4 100644
--- a/arch/xtensa/kernel/vmlinux.lds.S
+++ b/arch/xtensa/kernel/vmlinux.lds.S
@@ -94,7 +94,9 @@ SECTIONS
     . = ALIGN(PAGE_SIZE);
     _vecbase = .;
 
+#ifdef SUPPORT_WINDOWED
     SECTION_VECTOR2 (.WindowVectors.text, WINDOW_VECTORS_VADDR)
+#endif
 #if XCHAL_EXCM_LEVEL >= 2
     SECTION_VECTOR2 (.Level2InterruptVector.text, INTLEVEL2_VECTOR_VADDR)
 #endif
@@ -166,8 +168,10 @@ SECTIONS
     __boot_reloc_table_start = ABSOLUTE(.);
 
 #if !MERGED_VECTORS
+#ifdef SUPPORT_WINDOWED
     RELOCATE_ENTRY(_WindowVectors_text,
 		   .WindowVectors.text);
+#endif
 #if XCHAL_EXCM_LEVEL >= 2
     RELOCATE_ENTRY(_Level2InterruptVector_text,
 		   .Level2InterruptVector.text);
@@ -229,14 +233,18 @@ SECTIONS
 #if !MERGED_VECTORS
   /* The vectors are relocated to the real position at startup time */
 
+#ifdef SUPPORT_WINDOWED
   SECTION_VECTOR4 (_WindowVectors_text,
 		  .WindowVectors.text,
 		  WINDOW_VECTORS_VADDR,
-		  .dummy)
+		  LAST)
+#undef LAST
+#define LAST	.WindowVectors.text
+#endif
   SECTION_VECTOR4 (_DebugInterruptVector_text,
 		  .DebugInterruptVector.text,
 		  DEBUG_VECTOR_VADDR,
-		  .WindowVectors.text)
+		  LAST)
 #undef LAST
 #define LAST	.DebugInterruptVector.text
 #if XCHAL_EXCM_LEVEL >= 2
-- 
2.20.1

