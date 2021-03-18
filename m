Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5354340BA7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 18:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhCRRX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 13:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbhCRRXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 13:23:33 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE3EC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 10:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=I7WBOJMqsONJKh5Go0RSycXHYXNYT82NDXP7uh/337E=; b=U8iIRtWte9gSeiArJwHj1Upind
        swbSY+VjqdYQuaOx6obsp3ncPnt8uZuIJLLc96tuaA0Fq2XHZlWhU7HhgHuVF68U1E75LcIwBEs+W
        D0zip1B3aSAYLsfo7taX8nWOfQaphnRIWQ5v2xdux+KDxPOJgmqeKfYmCUHzmwt+98HuXhshCRh10
        7npMPl09HBnmBVqWl/hEwNrHm9qdjfu8doeHsvQV+bUpvSAtLCL62rye9QUJUSH9uhOOt+zvGm33m
        ssGAJhc/lYYA8K7h4Og5XRZcQOcACZEFh3o7ZW1NdmA53DhPk3PC/D+kRUCfXiN+m+zCZO3hv7TPc
        4qfzVFnA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMwMp-005kET-Ir; Thu, 18 Mar 2021 17:23:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3099330700B;
        Thu, 18 Mar 2021 18:23:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 19F46238A4645; Thu, 18 Mar 2021 18:23:27 +0100 (CET)
Message-ID: <20210318171919.580212227@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 18 Mar 2021 18:11:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jgross@suse.com,
        mbenes@suse.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH v2 03/14] x86/retpoline: Simplify retpolines
References: <20210318171103.577093939@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to commit c9c324dc22aa ("objtool: Support stack layout changes
in alternatives"), it is possible to simplify the retpolines.

Currently our retpolines consist of 2 symbols,
__x86_indirect_thunk_\reg, which is the compiler target, and
__x86_retpoline_\reg, which is the actual retpoline. Both are
consecutive in code and aligned such that for any one register they
both live in the same cacheline:

  0000000000000000 <__x86_indirect_thunk_rax>:
   0:   ff e0                   jmpq   *%rax
   2:   90                      nop
   3:   90                      nop
   4:   90                      nop

  0000000000000005 <__x86_retpoline_rax>:
   5:   e8 07 00 00 00          callq  11 <__x86_retpoline_rax+0xc>
   a:   f3 90                   pause
   c:   0f ae e8                lfence
   f:   eb f9                   jmp    a <__x86_retpoline_rax+0x5>
  11:   48 89 04 24             mov    %rax,(%rsp)
  15:   c3                      retq
  16:   66 2e 0f 1f 84 00 00 00 00 00   nopw   %cs:0x0(%rax,%rax,1)

The thunk is an alternative_2, where one option is a jmp to the
retpoline. This was done so that objtool didn't need to deal with
alternatives with stack ops. But that problem has been solved, so now
it is possible to fold the entire retpoline into the alternative to
simplify and consolidate unused bytes:

  0000000000000000 <__x86_indirect_thunk_rax>:
   0:   ff e0                   jmpq   *%rax
   2:   90                      nop
   3:   90                      nop
   4:   90                      nop
   5:   90                      nop
   6:   90                      nop
   7:   90                      nop
   8:   90                      nop
   9:   90                      nop
   a:   90                      nop
   b:   90                      nop
   c:   90                      nop
   d:   90                      nop
   e:   90                      nop
   f:   90                      nop
  10:   90                      nop
  11:   66 66 2e 0f 1f 84 00 00 00 00 00        data16 nopw %cs:0x0(%rax,%rax,1)
  1c:   0f 1f 40 00             nopl   0x0(%rax)

Notice that since the longest alternative sequence is now:

   0:   e8 07 00 00 00          callq  c <.altinstr_replacement+0xc>
   5:   f3 90                   pause
   7:   0f ae e8                lfence
   a:   eb f9                   jmp    5 <.altinstr_replacement+0x5>
   c:   48 89 04 24             mov    %rax,(%rsp)
  10:   c3                      retq

17 bytes, we have 15 bytes NOP at the end of our 32 byte slot. (IOW,
if we can shrink the retpoline by 1 byte we can pack it more dense)

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/asm-prototypes.h |    7 -------
 arch/x86/include/asm/nospec-branch.h  |    6 +++---
 arch/x86/lib/retpoline.S              |   34 +++++++++++++++++-----------------
 tools/objtool/check.c                 |    3 +--
 4 files changed, 21 insertions(+), 29 deletions(-)

--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -22,15 +22,8 @@ extern void cmpxchg8b_emu(void);
 #define DECL_INDIRECT_THUNK(reg) \
 	extern asmlinkage void __x86_indirect_thunk_ ## reg (void);
 
-#define DECL_RETPOLINE(reg) \
-	extern asmlinkage void __x86_retpoline_ ## reg (void);
-
 #undef GEN
 #define GEN(reg) DECL_INDIRECT_THUNK(reg)
 #include <asm/GEN-for-each-reg.h>
 
-#undef GEN
-#define GEN(reg) DECL_RETPOLINE(reg)
-#include <asm/GEN-for-each-reg.h>
-
 #endif /* CONFIG_RETPOLINE */
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -81,7 +81,7 @@
 .macro JMP_NOSPEC reg:req
 #ifdef CONFIG_RETPOLINE
 	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), \
-		      __stringify(jmp __x86_retpoline_\reg), X86_FEATURE_RETPOLINE, \
+		      __stringify(jmp __x86_indirect_thunk_\reg), X86_FEATURE_RETPOLINE, \
 		      __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), X86_FEATURE_RETPOLINE_AMD
 #else
 	jmp	*%\reg
@@ -91,7 +91,7 @@
 .macro CALL_NOSPEC reg:req
 #ifdef CONFIG_RETPOLINE
 	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; call *%\reg), \
-		      __stringify(call __x86_retpoline_\reg), X86_FEATURE_RETPOLINE, \
+		      __stringify(call __x86_indirect_thunk_\reg), X86_FEATURE_RETPOLINE, \
 		      __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; call *%\reg), X86_FEATURE_RETPOLINE_AMD
 #else
 	call	*%\reg
@@ -129,7 +129,7 @@
 	ALTERNATIVE_2(						\
 	ANNOTATE_RETPOLINE_SAFE					\
 	"call *%[thunk_target]\n",				\
-	"call __x86_retpoline_%V[thunk_target]\n",		\
+	"call __x86_indirect_thunk_%V[thunk_target]\n",		\
 	X86_FEATURE_RETPOLINE,					\
 	"lfence;\n"						\
 	ANNOTATE_RETPOLINE_SAFE					\
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -10,27 +10,31 @@
 #include <asm/unwind_hints.h>
 #include <asm/frame.h>
 
-.macro THUNK reg
-	.section .text.__x86.indirect_thunk
-
-	.align 32
-SYM_FUNC_START(__x86_indirect_thunk_\reg)
-	JMP_NOSPEC \reg
-SYM_FUNC_END(__x86_indirect_thunk_\reg)
-
-SYM_FUNC_START_NOALIGN(__x86_retpoline_\reg)
+.macro RETPOLINE reg
 	ANNOTATE_INTRA_FUNCTION_CALL
-	call	.Ldo_rop_\@
+	call    .Ldo_rop_\@
 .Lspec_trap_\@:
 	UNWIND_HINT_EMPTY
 	pause
 	lfence
-	jmp	.Lspec_trap_\@
+	jmp .Lspec_trap_\@
 .Ldo_rop_\@:
-	mov	%\reg, (%_ASM_SP)
+	mov     %\reg, (%_ASM_SP)
 	UNWIND_HINT_FUNC
 	ret
-SYM_FUNC_END(__x86_retpoline_\reg)
+.endm
+
+.macro THUNK reg
+	.section .text.__x86.indirect_thunk
+
+	.align 32
+SYM_FUNC_START(__x86_indirect_thunk_\reg)
+
+	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), \
+		      __stringify(RETPOLINE \reg), X86_FEATURE_RETPOLINE, \
+		      __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), X86_FEATURE_RETPOLINE_AMD
+
+SYM_FUNC_END(__x86_indirect_thunk_\reg)
 
 .endm
 
@@ -48,7 +52,6 @@ SYM_FUNC_END(__x86_retpoline_\reg)
 
 #define __EXPORT_THUNK(sym)	_ASM_NOKPROBE(sym); EXPORT_SYMBOL(sym)
 #define EXPORT_THUNK(reg)	__EXPORT_THUNK(__x86_indirect_thunk_ ## reg)
-#define EXPORT_RETPOLINE(reg)  __EXPORT_THUNK(__x86_retpoline_ ## reg)
 
 #undef GEN
 #define GEN(reg) THUNK reg
@@ -58,6 +61,3 @@ SYM_FUNC_END(__x86_retpoline_\reg)
 #define GEN(reg) EXPORT_THUNK(reg)
 #include <asm/GEN-for-each-reg.h>
 
-#undef GEN
-#define GEN(reg) EXPORT_RETPOLINE(reg)
-#include <asm/GEN-for-each-reg.h>
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -800,8 +800,7 @@ static int add_jump_destinations(struct
 		} else if (reloc->sym->type == STT_SECTION) {
 			dest_sec = reloc->sym->sec;
 			dest_off = arch_dest_reloc_offset(reloc->addend);
-		} else if (!strncmp(reloc->sym->name, "__x86_indirect_thunk_", 21) ||
-			   !strncmp(reloc->sym->name, "__x86_retpoline_", 16)) {
+		} else if (!strncmp(reloc->sym->name, "__x86_indirect_thunk_", 21)) {
 			/*
 			 * Retpoline jumps are really dynamic jumps in
 			 * disguise, so convert them accordingly.


