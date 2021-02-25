Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47597324B55
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 08:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbhBYHgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 02:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbhBYHeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:34:18 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547C1C061788
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 23:33:53 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id w18so2707159plc.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 23:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y3sPy044K8OK/fHnemDT9h+eBrVf8ED4HLMVS2xW7Ww=;
        b=eePsIdmliCbqiaRylWemGy7PqRX5igzSUxNh11OhklFJWQo37Lut9vXXemqCp/bVTY
         mjs0PMLx9IXyr4wwaVkz9PFt7D7jKWB5hl5upqD0hFsMQY5Rk9cKAHJscSAvZ4rj91xX
         ND8CIMyVnqIeowKTaJNjQCtpQF7pwoGkYHXp496JEb0tORwaPzcExh3Wn4g3UCshRmWA
         xkdTjRZ09F1jloI1yO7JDQ2DuA2Jwi9eEyv7uqNbve6TrPftVujfi2kPpGIBuLoY4EC0
         ARm069rNNRjb5W1r7e8Pow5SwWZPp3YpQm6Uh47biRuXcu2Bd36uaMX2opFMYEe2QYgu
         0zYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y3sPy044K8OK/fHnemDT9h+eBrVf8ED4HLMVS2xW7Ww=;
        b=GzrTGyH77qToUEHVInBBO5ljKQUGpqLSsobg5/x2v93P/4cpQclmN9uNz+wPLmoFW7
         rcFBvUww/Idd2A+/i7Bwbn3I0p8J8zTWHP6nu+OOeU7i4PPk4n9DtFSdCnjNPmA+VF3q
         4sjMDXg7oeFwA05wYNA1gChmwVeqd5Vg7o9s1a2LF9il5aPIepBBCRSeVLXX9p2QUYYr
         ipjTix0TRt4WRJ0WfUErywRUwnZ8UqhB1Tizhypxt2lRAXz3MXBS8PtYPaqeauuNnCjM
         LgstasdJUfNK8L95lBIChRPhN9qPeO66NjTdHMRal3P8CAz9rrfIqClBqZQzbIx9CTX3
         b7jQ==
X-Gm-Message-State: AOAM531j44Xcw/XtIZAauYnnTt9DLrLHZ8QRRqeuiBSatSpG3cOQBZTf
        wRjKxjwaijr/1sekNNxH1qo=
X-Google-Smtp-Source: ABdhPJwQKZ1gEUuuRDb10ggdD8J/o5EHLicPpQsdWwjLGG8ZFCGBr/8ITx253xVJibGmkOimKln6HA==
X-Received: by 2002:a17:90a:4f85:: with SMTP id q5mr1997681pjh.42.1614238432716;
        Wed, 24 Feb 2021 23:33:52 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id w3sm4917561pjt.24.2021.02.24.23.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 23:33:51 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Hugh Dickins <hughd@google.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Nadav Amit <namit@vmware.com>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org
Subject: [RFC 3/6] x86/vdso: introduce page_prefetch()
Date:   Wed, 24 Feb 2021 23:29:07 -0800
Message-Id: <20210225072910.2811795-4-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210225072910.2811795-1-namit@vmware.com>
References: <20210225072910.2811795-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Introduce a new vDSO function: page_prefetch() which is to be used when
certain memory, which might be paged out, is expected to be used soon.
The function prefetches the page if needed. The function returns zero if
the page is accessible after the call and -1 otherwise.

page_prefetch() is intended to be very lightweight both when the page is
already present and when the page is prefetched.

The implementation leverages the new vDSO exception tables mechanism.
page_prefetch() accesses the page for read and has a corresponding vDSO
exception-table entry that indicates that a #PF might occur and that in
such case the page should be brought asynchronously. If #PF indeed
occurs, the page-fault handler sets the FAULT_FLAG_RETRY_NOWAIT flag.

If the page-fault was not resolved, the page-fault handler does not
retry, and instead jumps to the new IP that is marked in the exception
table. The vDSO part returns accordingly the return value.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: x86@kernel.org
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/Kconfig                |  1 +
 arch/x86/entry/vdso/Makefile    |  1 +
 arch/x86/entry/vdso/extable.c   | 59 +++++++++++++++++++++++++--------
 arch/x86/entry/vdso/vdso.lds.S  |  1 +
 arch/x86/entry/vdso/vprefetch.S | 39 ++++++++++++++++++++++
 arch/x86/include/asm/vdso.h     | 38 +++++++++++++++++++--
 arch/x86/mm/fault.c             | 11 ++++--
 lib/vdso/Kconfig                |  5 +++
 8 files changed, 136 insertions(+), 19 deletions(-)
 create mode 100644 arch/x86/entry/vdso/vprefetch.S

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 21f851179ff0..86a4c265e8af 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -136,6 +136,7 @@ config X86
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_GETTIMEOFDAY
 	select GENERIC_VDSO_TIME_NS
+	select GENERIC_VDSO_PREFETCH
 	select GUP_GET_PTE_LOW_HIGH		if X86_PAE
 	select HARDIRQS_SW_RESEND
 	select HARDLOCKUP_CHECK_TIMESTAMP	if X86_64
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 02e3e42f380b..e32ca1375b84 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -28,6 +28,7 @@ vobjs-y := vdso-note.o vclock_gettime.o vgetcpu.o
 vobjs32-y := vdso32/note.o vdso32/system_call.o vdso32/sigreturn.o
 vobjs32-y += vdso32/vclock_gettime.o
 vobjs-$(CONFIG_X86_SGX)	+= vsgx.o
+vobjs-$(CONFIG_GENERIC_VDSO_PREFETCH) += vprefetch.o
 
 # files to link into kernel
 obj-y				+= vma.o extable.o
diff --git a/arch/x86/entry/vdso/extable.c b/arch/x86/entry/vdso/extable.c
index 93fb37bd32ad..e821887112ce 100644
--- a/arch/x86/entry/vdso/extable.c
+++ b/arch/x86/entry/vdso/extable.c
@@ -4,36 +4,67 @@
 #include <asm/current.h>
 #include <asm/traps.h>
 #include <asm/vdso.h>
+#include "extable.h"
 
 struct vdso_exception_table_entry {
 	int insn, fixup;
 	unsigned int mask, flags;
 };
 
-bool fixup_vdso_exception(struct pt_regs *regs, int trapnr,
-			  unsigned long error_code, unsigned long fault_addr)
+static unsigned long
+get_vdso_exception_table_entry(const struct pt_regs *regs, int trapnr,
+			       unsigned int *flags)
 {
 	const struct vdso_image *image = current->mm->context.vdso_image;
 	const struct vdso_exception_table_entry *extable;
 	unsigned int nr_entries, i;
 	unsigned long base;
+	unsigned long ip = regs->ip;
+	unsigned long vdso_base = (unsigned long)current->mm->context.vdso;
 
-	if (!current->mm->context.vdso)
-		return false;
-
-	base =  (unsigned long)current->mm->context.vdso + image->extable_base;
+	base = vdso_base + image->extable_base;
 	nr_entries = image->extable_len / (sizeof(*extable));
 	extable = image->extable;
 
 	for (i = 0; i < nr_entries; i++, base += sizeof(*extable)) {
-		if (regs->ip == base + extable[i].insn) {
-			regs->ip = base + extable[i].fixup;
-			regs->di = trapnr;
-			regs->si = error_code;
-			regs->dx = fault_addr;
-			return true;
-		}
+		if (ip != base + extable[i].insn)
+			continue;
+
+		if (!((1u << trapnr) & extable[i].mask))
+			continue;
+
+		/* found */
+		if (flags)
+			*flags = extable[i].flags;
+		return base + extable[i].fixup;
 	}
 
-	return false;
+	return 0;
+}
+
+bool __fixup_vdso_exception(struct pt_regs *regs, int trapnr,
+			    unsigned long error_code, unsigned long fault_addr)
+{
+	unsigned long new_ip;
+
+	new_ip = get_vdso_exception_table_entry(regs, trapnr, NULL);
+	if (!new_ip)
+		return false;
+
+	instruction_pointer_set(regs, new_ip);
+	regs->di = trapnr;
+	regs->si = error_code;
+	regs->dx = fault_addr;
+	return true;
+}
+
+__attribute_const__ bool __is_async_vdso_exception(struct pt_regs *regs,
+						   int trapnr)
+{
+	unsigned long new_ip;
+	unsigned int flags;
+
+	new_ip = get_vdso_exception_table_entry(regs, trapnr, &flags);
+
+	return new_ip && (flags & ASM_VDSO_ASYNC_FLAGS);
 }
diff --git a/arch/x86/entry/vdso/vdso.lds.S b/arch/x86/entry/vdso/vdso.lds.S
index 4bf48462fca7..fd4ba24571c8 100644
--- a/arch/x86/entry/vdso/vdso.lds.S
+++ b/arch/x86/entry/vdso/vdso.lds.S
@@ -28,6 +28,7 @@ VERSION {
 		clock_getres;
 		__vdso_clock_getres;
 		__vdso_sgx_enter_enclave;
+		__vdso_prefetch_page;
 	local: *;
 	};
 }
diff --git a/arch/x86/entry/vdso/vprefetch.S b/arch/x86/entry/vdso/vprefetch.S
new file mode 100644
index 000000000000..a0fcafb7d546
--- /dev/null
+++ b/arch/x86/entry/vdso/vprefetch.S
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/linkage.h>
+#include <asm/export.h>
+#include <asm/errno.h>
+#include <asm/enclu.h>
+
+#include "extable.h"
+
+.code64
+.section .text, "ax"
+
+SYM_FUNC_START(__vdso_prefetch_page)
+	/* Prolog */
+	.cfi_startproc
+	push	%rbp
+	.cfi_adjust_cfa_offset	8
+	.cfi_rel_offset		%rbp, 0
+	mov	%rsp, %rbp
+	.cfi_def_cfa_register	%rbp
+
+	xor	%rax, %rax
+.Laccess_page:
+	movb	(%rdi), %dil
+.Lout:
+
+	/* Epilog */
+	pop	%rbp
+	.cfi_def_cfa		%rsp, 8
+	ret
+
+.Lhandle_exception:
+	mov	$-1ll, %rax
+	jmp	.Lout
+	.cfi_endproc
+ASM_VDSO_EXTABLE_HANDLE .Laccess_page, .Lhandle_exception,		\
+			(1<<X86_TRAP_PF), ASM_VDSO_ASYNC_FLAGS
+
+SYM_FUNC_END(__vdso_prefetch_page)
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index 98aa103eb4ab..ee47660fcd0d 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -9,6 +9,7 @@
 #ifndef __ASSEMBLER__
 
 #include <linux/mm_types.h>
+#include <linux/sched.h>
 
 struct vdso_image {
 	void *data;
@@ -49,9 +50,40 @@ extern void __init init_vdso_image(const struct vdso_image *image);
 
 extern int map_vdso_once(const struct vdso_image *image, unsigned long addr);
 
-extern bool fixup_vdso_exception(struct pt_regs *regs, int trapnr,
-				 unsigned long error_code,
-				 unsigned long fault_addr);
+extern bool __fixup_vdso_exception(struct pt_regs *regs, int trapnr,
+				   unsigned long error_code,
+				   unsigned long fault_addr);
+
+extern __attribute_const__ bool __is_async_vdso_exception(struct pt_regs *regs,
+							  int trapnr);
+
+static inline bool is_exception_in_vdso(struct pt_regs *regs)
+{
+	const struct vdso_image *image = current->mm->context.vdso_image;
+	unsigned long vdso_base = (unsigned long)current->mm->context.vdso;
+
+	return regs->ip >= vdso_base && regs->ip < vdso_base + image->size &&
+		vdso_base != 0;
+}
+
+static inline bool is_async_vdso_exception(struct pt_regs *regs, int trapnr)
+{
+	if (!is_exception_in_vdso(regs))
+		return false;
+
+	return __is_async_vdso_exception(regs, trapnr);
+}
+
+static inline bool fixup_vdso_exception(struct pt_regs *regs, int trapnr,
+				   unsigned long error_code,
+				   unsigned long fault_addr)
+{
+	if (is_exception_in_vdso(regs))
+		return __fixup_vdso_exception(regs, trapnr, error_code,
+					      fault_addr);
+	return false;
+}
+
 #endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_X86_VDSO_H */
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index f1f1b5a0956a..87d8ae46510c 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1289,6 +1289,10 @@ void do_user_addr_fault(struct pt_regs *regs,
 	if (user_mode(regs)) {
 		local_irq_enable();
 		flags |= FAULT_FLAG_USER;
+		if (IS_ENABLED(CONFIG_GENERIC_VDSO_PREFETCH) &&
+		    is_async_vdso_exception(regs, X86_TRAP_PF))
+			flags |= FAULT_FLAG_ALLOW_RETRY |
+				 FAULT_FLAG_RETRY_NOWAIT;
 	} else {
 		if (regs->flags & X86_EFLAGS_IF)
 			local_irq_enable();
@@ -1407,8 +1411,11 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 */
 	if (unlikely((fault & VM_FAULT_RETRY) &&
 		     (flags & FAULT_FLAG_ALLOW_RETRY))) {
-		flags |= FAULT_FLAG_TRIED;
-		goto retry;
+		if (!(flags & FAULT_FLAG_RETRY_NOWAIT)) {
+			flags |= FAULT_FLAG_TRIED;
+			goto retry;
+		}
+		fixup_vdso_exception(regs, X86_TRAP_PF, hw_error_code, address);
 	}
 
 	mmap_read_unlock(mm);
diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
index d883ac299508..a64d2b08b6f4 100644
--- a/lib/vdso/Kconfig
+++ b/lib/vdso/Kconfig
@@ -30,4 +30,9 @@ config GENERIC_VDSO_TIME_NS
 	  Selected by architectures which support time namespaces in the
 	  VDSO
 
+config GENERIC_VDSO_PREFETCH
+	bool
+	help
+	  Selected by architectures which support page prefetch VDSO
+
 endif
-- 
2.25.1

