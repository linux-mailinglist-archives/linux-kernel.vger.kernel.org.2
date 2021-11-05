Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588CE446850
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 19:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhKESUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 14:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhKESUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 14:20:38 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4510C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 11:17:58 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id k4so11569235plx.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 11:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8NAqTO+Bo8OWCBV0fzq0ld8I2ivZF5JJMk1VhoH157s=;
        b=kzd9dqFo0dgbv0v9r80jsuo3QSpewXowQtpn4Pw2uQi/3JN0CZ9LyGwyoQeSOCo0mD
         cNKWmtorE7NoOa5S2DEzEDE8aGSvbvOh/xKrDgSn9CIenJCRZTY5ALDBNr53A0ky0lUt
         lQBzS2YYgY7FmWHOLWDObDGD1yfRz6i1DMjlDo64at/5gXRY2TMLST5cn16eDREJhORw
         yTY9SfDYnz+ezmyE8d4A4yev++xfikYeEvqk8uGsp42arRN2birqa6t8GyPUlSI0rm9D
         Fmf16HT5cOK3XWEP2/6mva+xa0aLdqyCMNwgxIdIvBVQktouKslQHN17nWvFwRoTAuzT
         736A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8NAqTO+Bo8OWCBV0fzq0ld8I2ivZF5JJMk1VhoH157s=;
        b=pwVRTAgYeNfA5wQAa6k3/irM5BRII+XjUNWCEEHi2N34ro5IMlDHU4hd+CwpqZ5oz2
         FKKdRWTrEOwjOKwEQSNjoLOo4AZsm8LYyF4nvhpeno7peH6DTZouPRm4BJNp2J/lx0iG
         678IjtUTemHhbTQfL0ZXx+KmuPYG7A/qo06pZXVI67RShP/wA6TzTcDBCvfoK93TMS6M
         3MuPUNHt2BF0X2wfcvSJ2zO3nZp1zr2D6k62fbEa+PhD1IyY0PA979K+OU1g3TQkgeKj
         HJvoDeUYRWP4WHF8dsnjwQOZzMATQfLwh9sJEWVqn4Mir3ngIXsbbt7l7sd4pOpDgg0m
         a2nA==
X-Gm-Message-State: AOAM530eQIwjC53a1FFf+RFjZPzvYzfuHoyGtkD6hpL5n70Jnj4Z3plb
        +uuL8jSwD2x5cDzuUQBdxRsKaQ==
X-Google-Smtp-Source: ABdhPJz3bParFSQ52Yksu5OL3HogezZQ+wsuWdBR4iOgtpTaXc0UDAUMdk4KXSZwilBraZSeQcwbrw==
X-Received: by 2002:a17:90a:917:: with SMTP id n23mr32175302pjn.131.1636136277869;
        Fri, 05 Nov 2021 11:17:57 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id m26sm3788066pfe.23.2021.11.05.11.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 11:17:57 -0700 (PDT)
Date:   Fri, 5 Nov 2021 18:17:53 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        mark.rutland@arm.com, dvyukov@google.com, pbonzini@redhat.com,
        mbenes@suse.cz
Subject: Re: [RFC][PATCH 15/22] x86,vmx: Remove .fixup usage
Message-ID: <YYV1UeFeWUtnQ4jV@google.com>
References: <20211104164729.226550532@infradead.org>
 <20211104165525.408049586@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104165525.408049586@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021, Peter Zijlstra wrote:
> In the vmread exceptin path, use the, thus far, unused output register
> to push the @fault argument onto the stack. This, in turn, enables the
> exception handler to not do pushes and only modify that register when
> an exception does occur.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/kvm/vmx/vmx_ops.h |   14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> --- a/arch/x86/kvm/vmx/vmx_ops.h
> +++ b/arch/x86/kvm/vmx/vmx_ops.h
> @@ -80,9 +80,11 @@ static __always_inline unsigned long __v
>  		      * @field, and bounce through the trampoline to preserve
>  		      * volatile registers.
>  		      */
> -		     "push $0\n\t"
> +		     "xorl %k1, %k1\n\t"
> +		     "2:\n\t"
> +		     "push %1\n\t"
>  		     "push %2\n\t"

This trick doesn't work if the compiler selects the same GPR for %1 and %2, as
the "field" will get lost.

   0x00000000000005a2 <+66>:	0f 78 c0	vmread %rax,%rax
   0x00000000000005a5 <+69>:	3e 77 0b	ja,pt  0x5b3 <vmx_read_guest_seg_selector+83>
   0x00000000000005a8 <+72>:	31 c0	xor    %eax,%eax
   0x00000000000005aa <+74>:	50	push   %rax
   0x00000000000005ab <+75>:	50	push   %rax
   0x00000000000005ac <+76>:	e8 00 00 00 00	callq  0x5b1 <vmx_read_guest_seg_selector+81>
   0x00000000000005b1 <+81>:	58	pop    %rax
   0x00000000000005b2 <+82>:	58	pop    %rax

I'm struggling to think of a not-awful way to handle this without custom fixup.
Once "asm goto with output" is ubiquitous, we can get rid of this mess entirely,
but until then...

The best idea I can come up with is to abuse the current spec and use bits N:16
to indicate a fault, i.e. use EX_TYPE_EFAULT_REG.  VMCS fields are technically
32-bit values, but bits 31:15 are reserved.  That would yield a false positive
if KVM really screwed up and/or state was corrupted and the VMREAD actually tried
to read the non-existed field -EFAULT, but that's very, very unlikely (-1 would
be slightly more likey, hence EX_TYPE_EFAULT_REG instead of EX_TYPE_NEG_REG).
The fault patch would also lose the field, but vmread_error() doesn't consume
that info, I can't think of a reason that KVM would want to, and if the debugger
cares, most of the time the field is hardcoded at the call site.

Another horrific idea would be to encode the fault information in EFLAGS.  On
VM-Fail, the arithmetic flags are all set to specific values.  That would require
yet another flavor of _ASM_EXTABLE_ though, and would make the asm subroutine
even more ugly than it already is.  Probably not worth it.

Forcing different registers would be another option, but I would strongly prefer
to give the compiler free reign to optimize the happy path.

Tested all paths of this on 64-bit and 32-bit KVM.

From a4d602649ac7ea2e5136b642a57291fc5658d859 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Fri, 5 Nov 2021 10:40:21 -0700
Subject: [PATCH] KVM: VMX: Remove .fixup usage in VMREAD fault path

Rework the VMREAD magic to eliminate usage of custom .fixup as a step
toward eliminating .fixup throughout the kernel.  Because the compiler
can use the same register for both the input and output, e.g. generate
VMREAD %rax, %rax, hijacking the output register to store the "fault"
flag is not an option.  To avoid yet another flavor of fixup, overload
"field" to treat -EFAULT as a magic value.

Because -EFAULT is (obviously) a negative value, collision with a VMCS
field encoding is impossible on 64-bit kernels due to the encodings being
32-bit values.  And for 32-bit fields, no known VMCS field can collide
with the magic value because despite field encodings being 32-bit values,
bits 31:15 are currently reserved and must be zero.  These shenanigans
can be revisited in the extremely unlikely event that a future CPU
supports a "negative" VMCS encoding.  And hopefully this entire mess will
go away before that happens, as the trampoline shenanigans are needed
only because the minimum compiler version doesn't guarantee support for
asm goto with outputs.

Alternatively, the fault information could be encoded in EFLAGS since
VM-Fail sets arithmetic flags to well-known values.  However, that would
require yet another flavor of fixup and would complicate the already ugly
asm trampoline.

Forcing different output registers is undesirable as doing so would
prevent the compiler from fully optimizing the happy path, which is what
KVM really cares about since faults and failures on VMREAD occur if and
only if there is a KVM bug or hardware error, i.e. are very rare events.

Because a false positive is theoretically possible, e.g. if KVM executed
VMREAD with -EFAULT as the target field, WARN and log a suspected fault
but don't call kvm_spurious_fault().  If VMREAD really did fault, either
KVM is all bug guaranteed to hit a fault on another VMX instruction due
to VMX being disabled/broken, or the fault was specific to _that_ VMREAD,
e.g. due to a bad memory operand, in which case killing KVM isn't
necessary since the faulting VMREAD will "return" '0'.

Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmenter.S | 13 +++++--------
 arch/x86/kvm/vmx/vmx.c     | 13 ++++++++++---
 arch/x86/kvm/vmx/vmx_ops.h | 30 ++++++++++++------------------
 3 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
index 3a6461694fc2..f0f5487de077 100644
--- a/arch/x86/kvm/vmx/vmenter.S
+++ b/arch/x86/kvm/vmx/vmenter.S
@@ -240,8 +240,7 @@ SYM_FUNC_END(__vmx_vcpu_run)

 /**
  * vmread_error_trampoline - Trampoline from inline asm to vmread_error()
- * @field:	VMCS field encoding that failed
- * @fault:	%true if the VMREAD faulted, %false if it failed
+ * @field:	VMCS field encoding that failed, -EFAULT on fault

  * Save and restore volatile registers across a call to vmread_error().  Note,
  * all parameters are passed on the stack.
@@ -262,23 +261,21 @@ SYM_FUNC_START(vmread_error_trampoline)
 	push %r11
 #endif
 #ifdef CONFIG_X86_64
-	/* Load @field and @fault to arg1 and arg2 respectively. */
-	mov 3*WORD_SIZE(%rbp), %_ASM_ARG2
+	/* Load @field arg1. */
 	mov 2*WORD_SIZE(%rbp), %_ASM_ARG1
 #else
 	/* Parameters are passed on the stack for 32-bit (see asmlinkage). */
-	push 3*WORD_SIZE(%ebp)
 	push 2*WORD_SIZE(%ebp)
 #endif

 	call vmread_error

 #ifndef CONFIG_X86_64
-	add $8, %esp
+	add $4, %esp
 #endif

-	/* Zero out @fault, which will be popped into the result register. */
-	_ASM_MOV $0, 3*WORD_SIZE(%_ASM_BP)
+	/* Zero out @field, which will be popped into the result register. */
+	_ASM_MOV $0, 2*WORD_SIZE(%_ASM_BP)

 #ifdef CONFIG_X86_64
 	pop %r11
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 9a979279a37b..ddce443baa9c 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -373,10 +373,17 @@ do {					\
 	pr_warn_ratelimited(fmt);	\
 } while (0)

-asmlinkage void vmread_error(unsigned long field, bool fault)
+asmlinkage void vmread_error(unsigned long field)
 {
-	if (fault)
-		kvm_spurious_fault();
+	/*
+	 * @field is stuff with -EFAULT if VMREAD faulted.  There is a teeny
+	 * tiny chance of a false positive, i.e. KVM could attempt to VMREAD
+	 * -EFAULT if things go sidways, so just log the fault instead of
+	 * doing kvm_spurious_fault().  If VMREAD did fault, KVM is all but
+	 * guaranteed to die on a VMWRITE, VMRESUME, etc... fault soon enough.
+	 */
+	if (field == (unsigned long)-EFAULT)
+		vmx_insn_failed("kvm: vmread faulted\n");
 	else
 		vmx_insn_failed("kvm: vmread failed: field=%lx\n", field);
 }
diff --git a/arch/x86/kvm/vmx/vmx_ops.h b/arch/x86/kvm/vmx/vmx_ops.h
index 9e9ef47e988c..5e5113d2b324 100644
--- a/arch/x86/kvm/vmx/vmx_ops.h
+++ b/arch/x86/kvm/vmx/vmx_ops.h
@@ -10,9 +10,8 @@
 #include "vmcs.h"
 #include "x86.h"

-asmlinkage void vmread_error(unsigned long field, bool fault);
-__attribute__((regparm(0))) void vmread_error_trampoline(unsigned long field,
-							 bool fault);
+asmlinkage void vmread_error(unsigned long field);
+__attribute__((regparm(0))) void vmread_error_trampoline(unsigned long field);
 void vmwrite_error(unsigned long field, unsigned long value);
 void vmclear_error(struct vmcs *vmcs, u64 phys_addr);
 void vmptrld_error(struct vmcs *vmcs, u64 phys_addr);
@@ -76,29 +75,24 @@ static __always_inline unsigned long __vmcs_readl(unsigned long field)
 		     "ja 3f\n\t"

 		     /*
-		      * VMREAD failed.  Push '0' for @fault, push the failing
-		      * @field, and bounce through the trampoline to preserve
-		      * volatile registers.
+		      * VMREAD failed, push the failing @field, and bounce
+		      * through the trampoline to preserve volatile registers.
+		      * If VMREAD faults, this will push -FAULT (see below).
 		      */
-		     "push $0\n\t"
-		     "push %2\n\t"
-		     "2:call vmread_error_trampoline\n\t"
+		     "2: push %2\n\t"
+		     "call vmread_error_trampoline\n\t"

 		     /*
 		      * Unwind the stack.  Note, the trampoline zeros out the
-		      * memory for @fault so that the result is '0' on error.
+		      * memory for @field so that the result is '0' on error,
+		      * hence the pop to %1, not %2.
 		      */
-		     "pop %2\n\t"
 		     "pop %1\n\t"
 		     "3:\n\t"

-		     /* VMREAD faulted.  As above, except push '1' for @fault. */
-		     ".pushsection .fixup, \"ax\"\n\t"
-		     "4: push $1\n\t"
-		     "push %2\n\t"
-		     "jmp 2b\n\t"
-		     ".popsection\n\t"
-		     _ASM_EXTABLE(1b, 4b)
+		     /* VMREAD faulted.  As above, except push '-EFAULT' for @fault. */
+		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG, %1)
+
 		     : ASM_CALL_CONSTRAINT, "=r"(value) : "r"(field) : "cc");
 	return value;
 }
--
2.34.0.rc0.344.g81b53c2807-goog
