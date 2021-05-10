Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3AE379732
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 20:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbhEJSyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 14:54:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57273 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230229AbhEJSyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 14:54:45 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14AIrNld2459085
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 10 May 2021 11:53:31 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14AIrNld2459085
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1620672811;
        bh=TfJAZAd7pksa8W5S29dUHXzZi78h1D9ZaH7Tt1BwkUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rPxDvK2v2xiFLaYEXSqrfknvs9jLY/fqmIaSuueAsZM0bbeW+6r8vcCchcEUU4mvE
         CW9wmBCuUEl3bCwlyLXKWFMucAVZ/sPBzKpFdx6ozwhEm7lK8ogRa/dGWTbgiVvF+p
         KvOQUYwBpNOYXd3GHBh9VsU+qWaNlAk483ePRtIdn9dXf7WUpSmOzQo6ha4jUIo+u/
         0Hz1b7XA5UIXwh/2dHwvxqSM3QzhNrt+cHSJTpTZ1ULu3QiTv/j9V0lKgRh6u5e8Ib
         vJaS9MFurSVohhaoQ6Re9jGzi4+5cnrAh5aDsYr+nQ1dSH3a6khbi0L1dEOus+qmcp
         liByqRuAzPKow==
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC v2 PATCH 1/7] x86/entry: unify definitions from calling.h and ptrace-abi.h
Date:   Mon, 10 May 2021 11:53:10 -0700
Message-Id: <20210510185316.3307264-2-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510185316.3307264-1-hpa@zytor.com>
References: <20210510185316.3307264-1-hpa@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

The register offsets in <asm/ptrace-abi.h> are duplicated in
entry/calling.h, but are formatted differently and therefore not
compatible. Use the version from <asm/ptrace-abi.h> consistently.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 arch/x86/entry/calling.h  | 36 +-----------------------------------
 arch/x86/kernel/head_64.S |  6 +++---
 2 files changed, 4 insertions(+), 38 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 07a9331d55e7..7436d4a74ecb 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -6,6 +6,7 @@
 #include <asm/percpu.h>
 #include <asm/asm-offsets.h>
 #include <asm/processor-flags.h>
+#include <asm/ptrace-abi.h>
 
 /*
 
@@ -62,41 +63,6 @@ For 32-bit we have the following conventions - kernel is built with
  * for assembly code:
  */
 
-/* The layout forms the "struct pt_regs" on the stack: */
-/*
- * C ABI says these regs are callee-preserved. They aren't saved on kernel entry
- * unless syscall needs a complete, fully filled "struct pt_regs".
- */
-#define R15		0*8
-#define R14		1*8
-#define R13		2*8
-#define R12		3*8
-#define RBP		4*8
-#define RBX		5*8
-/* These regs are callee-clobbered. Always saved on kernel entry. */
-#define R11		6*8
-#define R10		7*8
-#define R9		8*8
-#define R8		9*8
-#define RAX		10*8
-#define RCX		11*8
-#define RDX		12*8
-#define RSI		13*8
-#define RDI		14*8
-/*
- * On syscall entry, this is syscall#. On CPU exception, this is error code.
- * On hw interrupt, it's IRQ number:
- */
-#define ORIG_RAX	15*8
-/* Return frame for iretq */
-#define RIP		16*8
-#define CS		17*8
-#define EFLAGS		18*8
-#define RSP		19*8
-#define SS		20*8
-
-#define SIZEOF_PTREGS	21*8
-
 .macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax save_ret=0
 	.if \save_ret
 	pushq	%rsi		/* pt_regs->si */
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 04bddaaba8e2..d8b3ebd2bb85 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -62,7 +62,7 @@ SYM_CODE_START_NOALIGN(startup_64)
 	 */
 
 	/* Set up the stack for verify_cpu(), similar to initial_stack below */
-	leaq	(__end_init_task - SIZEOF_PTREGS)(%rip), %rsp
+	leaq	(__end_init_task - FRAME_SIZE)(%rip), %rsp
 
 	leaq	_text(%rip), %rdi
 	pushq	%rsi
@@ -343,10 +343,10 @@ SYM_DATA(initial_vc_handler,	.quad handle_vc_boot_ghcb)
 #endif
 
 /*
- * The SIZEOF_PTREGS gap is a convention which helps the in-kernel unwinder
+ * The FRAME_SIZE gap is a convention which helps the in-kernel unwinder
  * reliably detect the end of the stack.
  */
-SYM_DATA(initial_stack, .quad init_thread_union + THREAD_SIZE - SIZEOF_PTREGS)
+SYM_DATA(initial_stack, .quad init_thread_union + THREAD_SIZE - FRAME_SIZE)
 	__FINITDATA
 
 	__INIT
-- 
2.31.1

