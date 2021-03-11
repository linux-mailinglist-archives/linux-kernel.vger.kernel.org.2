Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B79D337586
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 15:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbhCKOX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 09:23:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:47460 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233290AbhCKOXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 09:23:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615472602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KWeM4wbpx13GD4L4elDBN4aKGS1VmuJ7l8IaSi0wKRM=;
        b=LD7R9sR2C2we9Da23K+zm8HgDkKwHk9Quss/6ThGQ/pzCj0kFuxVWDUXtPvuUAmry4So57
        ZY/dKHqTJgn2yg/E7shTpu3jNXedNzYOx3kUTL+Y5jKnoadBlofGIRkpJfIOkpKyzOksY0
        r2bYGN62/9EJUul3dYqCbT3jOKNr+Kw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A3D33AC16;
        Thu, 11 Mar 2021 14:23:22 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v7 01/14] x86/alternative: merge include files
Date:   Thu, 11 Mar 2021 15:23:06 +0100
Message-Id: <20210311142319.4723-2-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210311142319.4723-1-jgross@suse.com>
References: <20210311142319.4723-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge arch/x86/include/asm/alternative-asm.h into
arch/x86/include/asm/alternative.h in order to make it easier to use
common definitions later.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V6:
- new patch
V7:
- moved to begin of series (Boris Petkov)
---
 arch/x86/entry/entry_32.S                |   2 +-
 arch/x86/entry/vdso/vdso32/system_call.S |   2 +-
 arch/x86/include/asm/alternative-asm.h   | 114 -----------------------
 arch/x86/include/asm/alternative.h       | 112 +++++++++++++++++++++-
 arch/x86/include/asm/nospec-branch.h     |   1 -
 arch/x86/include/asm/smap.h              |   5 +-
 arch/x86/lib/atomic64_386_32.S           |   2 +-
 arch/x86/lib/atomic64_cx8_32.S           |   2 +-
 arch/x86/lib/copy_page_64.S              |   2 +-
 arch/x86/lib/copy_user_64.S              |   2 +-
 arch/x86/lib/memcpy_64.S                 |   2 +-
 arch/x86/lib/memmove_64.S                |   2 +-
 arch/x86/lib/memset_64.S                 |   2 +-
 arch/x86/lib/retpoline.S                 |   2 +-
 14 files changed, 120 insertions(+), 132 deletions(-)
 delete mode 100644 arch/x86/include/asm/alternative-asm.h

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index df8c017e6161..4e079f250962 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -40,7 +40,7 @@
 #include <asm/processor-flags.h>
 #include <asm/irq_vectors.h>
 #include <asm/cpufeatures.h>
-#include <asm/alternative-asm.h>
+#include <asm/alternative.h>
 #include <asm/asm.h>
 #include <asm/smap.h>
 #include <asm/frame.h>
diff --git a/arch/x86/entry/vdso/vdso32/system_call.S b/arch/x86/entry/vdso/vdso32/system_call.S
index de1fff7188aa..d6a6080bade0 100644
--- a/arch/x86/entry/vdso/vdso32/system_call.S
+++ b/arch/x86/entry/vdso/vdso32/system_call.S
@@ -6,7 +6,7 @@
 #include <linux/linkage.h>
 #include <asm/dwarf2.h>
 #include <asm/cpufeatures.h>
-#include <asm/alternative-asm.h>
+#include <asm/alternative.h>
 
 	.text
 	.globl __kernel_vsyscall
diff --git a/arch/x86/include/asm/alternative-asm.h b/arch/x86/include/asm/alternative-asm.h
deleted file mode 100644
index 464034db299f..000000000000
--- a/arch/x86/include/asm/alternative-asm.h
+++ /dev/null
@@ -1,114 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_ALTERNATIVE_ASM_H
-#define _ASM_X86_ALTERNATIVE_ASM_H
-
-#ifdef __ASSEMBLY__
-
-#include <asm/asm.h>
-
-#ifdef CONFIG_SMP
-	.macro LOCK_PREFIX
-672:	lock
-	.pushsection .smp_locks,"a"
-	.balign 4
-	.long 672b - .
-	.popsection
-	.endm
-#else
-	.macro LOCK_PREFIX
-	.endm
-#endif
-
-/*
- * objtool annotation to ignore the alternatives and only consider the original
- * instruction(s).
- */
-.macro ANNOTATE_IGNORE_ALTERNATIVE
-	.Lannotate_\@:
-	.pushsection .discard.ignore_alts
-	.long .Lannotate_\@ - .
-	.popsection
-.endm
-
-/*
- * Issue one struct alt_instr descriptor entry (need to put it into
- * the section .altinstructions, see below). This entry contains
- * enough information for the alternatives patching code to patch an
- * instruction. See apply_alternatives().
- */
-.macro altinstruction_entry orig alt feature orig_len alt_len pad_len
-	.long \orig - .
-	.long \alt - .
-	.word \feature
-	.byte \orig_len
-	.byte \alt_len
-	.byte \pad_len
-.endm
-
-/*
- * Define an alternative between two instructions. If @feature is
- * present, early code in apply_alternatives() replaces @oldinstr with
- * @newinstr. ".skip" directive takes care of proper instruction padding
- * in case @newinstr is longer than @oldinstr.
- */
-.macro ALTERNATIVE oldinstr, newinstr, feature
-140:
-	\oldinstr
-141:
-	.skip -(((144f-143f)-(141b-140b)) > 0) * ((144f-143f)-(141b-140b)),0x90
-142:
-
-	.pushsection .altinstructions,"a"
-	altinstruction_entry 140b,143f,\feature,142b-140b,144f-143f,142b-141b
-	.popsection
-
-	.pushsection .altinstr_replacement,"ax"
-143:
-	\newinstr
-144:
-	.popsection
-.endm
-
-#define old_len			141b-140b
-#define new_len1		144f-143f
-#define new_len2		145f-144f
-
-/*
- * gas compatible max based on the idea from:
- * http://graphics.stanford.edu/~seander/bithacks.html#IntegerMinOrMax
- *
- * The additional "-" is needed because gas uses a "true" value of -1.
- */
-#define alt_max_short(a, b)	((a) ^ (((a) ^ (b)) & -(-((a) < (b)))))
-
-
-/*
- * Same as ALTERNATIVE macro above but for two alternatives. If CPU
- * has @feature1, it replaces @oldinstr with @newinstr1. If CPU has
- * @feature2, it replaces @oldinstr with @feature2.
- */
-.macro ALTERNATIVE_2 oldinstr, newinstr1, feature1, newinstr2, feature2
-140:
-	\oldinstr
-141:
-	.skip -((alt_max_short(new_len1, new_len2) - (old_len)) > 0) * \
-		(alt_max_short(new_len1, new_len2) - (old_len)),0x90
-142:
-
-	.pushsection .altinstructions,"a"
-	altinstruction_entry 140b,143f,\feature1,142b-140b,144f-143f,142b-141b
-	altinstruction_entry 140b,144f,\feature2,142b-140b,145f-144f,142b-141b
-	.popsection
-
-	.pushsection .altinstr_replacement,"ax"
-143:
-	\newinstr1
-144:
-	\newinstr2
-145:
-	.popsection
-.endm
-
-#endif  /*  __ASSEMBLY__  */
-
-#endif /* _ASM_X86_ALTERNATIVE_ASM_H */
diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 5753fb2ac489..53f295f41c34 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -2,13 +2,14 @@
 #ifndef _ASM_X86_ALTERNATIVE_H
 #define _ASM_X86_ALTERNATIVE_H
 
-#ifndef __ASSEMBLY__
-
 #include <linux/types.h>
-#include <linux/stddef.h>
 #include <linux/stringify.h>
 #include <asm/asm.h>
 
+#ifndef __ASSEMBLY__
+
+#include <linux/stddef.h>
+
 /*
  * Alternative inline assembly for SMP.
  *
@@ -271,6 +272,111 @@ static inline int alternatives_text_reserved(void *start, void *end)
  */
 #define ASM_NO_INPUT_CLOBBER(clbr...) "i" (0) : clbr
 
+#else /* __ASSEMBLY__ */
+
+#ifdef CONFIG_SMP
+	.macro LOCK_PREFIX
+672:	lock
+	.pushsection .smp_locks,"a"
+	.balign 4
+	.long 672b - .
+	.popsection
+	.endm
+#else
+	.macro LOCK_PREFIX
+	.endm
+#endif
+
+/*
+ * objtool annotation to ignore the alternatives and only consider the original
+ * instruction(s).
+ */
+.macro ANNOTATE_IGNORE_ALTERNATIVE
+	.Lannotate_\@:
+	.pushsection .discard.ignore_alts
+	.long .Lannotate_\@ - .
+	.popsection
+.endm
+
+/*
+ * Issue one struct alt_instr descriptor entry (need to put it into
+ * the section .altinstructions, see below). This entry contains
+ * enough information for the alternatives patching code to patch an
+ * instruction. See apply_alternatives().
+ */
+.macro altinstruction_entry orig alt feature orig_len alt_len pad_len
+	.long \orig - .
+	.long \alt - .
+	.word \feature
+	.byte \orig_len
+	.byte \alt_len
+	.byte \pad_len
+.endm
+
+/*
+ * Define an alternative between two instructions. If @feature is
+ * present, early code in apply_alternatives() replaces @oldinstr with
+ * @newinstr. ".skip" directive takes care of proper instruction padding
+ * in case @newinstr is longer than @oldinstr.
+ */
+.macro ALTERNATIVE oldinstr, newinstr, feature
+140:
+	\oldinstr
+141:
+	.skip -(((144f-143f)-(141b-140b)) > 0) * ((144f-143f)-(141b-140b)),0x90
+142:
+
+	.pushsection .altinstructions,"a"
+	altinstruction_entry 140b,143f,\feature,142b-140b,144f-143f,142b-141b
+	.popsection
+
+	.pushsection .altinstr_replacement,"ax"
+143:
+	\newinstr
+144:
+	.popsection
+.endm
+
+#define old_len			141b-140b
+#define new_len1		144f-143f
+#define new_len2		145f-144f
+
+/*
+ * gas compatible max based on the idea from:
+ * http://graphics.stanford.edu/~seander/bithacks.html#IntegerMinOrMax
+ *
+ * The additional "-" is needed because gas uses a "true" value of -1.
+ */
+#define alt_max_short(a, b)	((a) ^ (((a) ^ (b)) & -(-((a) < (b)))))
+
+
+/*
+ * Same as ALTERNATIVE macro above but for two alternatives. If CPU
+ * has @feature1, it replaces @oldinstr with @newinstr1. If CPU has
+ * @feature2, it replaces @oldinstr with @feature2.
+ */
+.macro ALTERNATIVE_2 oldinstr, newinstr1, feature1, newinstr2, feature2
+140:
+	\oldinstr
+141:
+	.skip -((alt_max_short(new_len1, new_len2) - (old_len)) > 0) * \
+		(alt_max_short(new_len1, new_len2) - (old_len)),0x90
+142:
+
+	.pushsection .altinstructions,"a"
+	altinstruction_entry 140b,143f,\feature1,142b-140b,144f-143f,142b-141b
+	altinstruction_entry 140b,144f,\feature2,142b-140b,145f-144f,142b-141b
+	.popsection
+
+	.pushsection .altinstr_replacement,"ax"
+143:
+	\newinstr1
+144:
+	\newinstr2
+145:
+	.popsection
+.endm
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_ALTERNATIVE_H */
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index cb9ad6b73973..529f8e9380d8 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -7,7 +7,6 @@
 #include <linux/objtool.h>
 
 #include <asm/alternative.h>
-#include <asm/alternative-asm.h>
 #include <asm/cpufeatures.h>
 #include <asm/msr-index.h>
 #include <asm/unwind_hints.h>
diff --git a/arch/x86/include/asm/smap.h b/arch/x86/include/asm/smap.h
index 8b58d6975d5d..ea1d8eb644cb 100644
--- a/arch/x86/include/asm/smap.h
+++ b/arch/x86/include/asm/smap.h
@@ -11,6 +11,7 @@
 
 #include <asm/nops.h>
 #include <asm/cpufeatures.h>
+#include <asm/alternative.h>
 
 /* "Raw" instruction opcodes */
 #define __ASM_CLAC	".byte 0x0f,0x01,0xca"
@@ -18,8 +19,6 @@
 
 #ifdef __ASSEMBLY__
 
-#include <asm/alternative-asm.h>
-
 #ifdef CONFIG_X86_SMAP
 
 #define ASM_CLAC \
@@ -37,8 +36,6 @@
 
 #else /* __ASSEMBLY__ */
 
-#include <asm/alternative.h>
-
 #ifdef CONFIG_X86_SMAP
 
 static __always_inline void clac(void)
diff --git a/arch/x86/lib/atomic64_386_32.S b/arch/x86/lib/atomic64_386_32.S
index 3b6544111ac9..16bc9130e7a5 100644
--- a/arch/x86/lib/atomic64_386_32.S
+++ b/arch/x86/lib/atomic64_386_32.S
@@ -6,7 +6,7 @@
  */
 
 #include <linux/linkage.h>
-#include <asm/alternative-asm.h>
+#include <asm/alternative.h>
 
 /* if you want SMP support, implement these with real spinlocks */
 .macro LOCK reg
diff --git a/arch/x86/lib/atomic64_cx8_32.S b/arch/x86/lib/atomic64_cx8_32.S
index 1c5c81c16b06..ce6935690766 100644
--- a/arch/x86/lib/atomic64_cx8_32.S
+++ b/arch/x86/lib/atomic64_cx8_32.S
@@ -6,7 +6,7 @@
  */
 
 #include <linux/linkage.h>
-#include <asm/alternative-asm.h>
+#include <asm/alternative.h>
 
 .macro read64 reg
 	movl %ebx, %eax
diff --git a/arch/x86/lib/copy_page_64.S b/arch/x86/lib/copy_page_64.S
index 2402d4c489d2..db4b4f9197c7 100644
--- a/arch/x86/lib/copy_page_64.S
+++ b/arch/x86/lib/copy_page_64.S
@@ -3,7 +3,7 @@
 
 #include <linux/linkage.h>
 #include <asm/cpufeatures.h>
-#include <asm/alternative-asm.h>
+#include <asm/alternative.h>
 #include <asm/export.h>
 
 /*
diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index 77b9b2a3b5c8..57b79c577496 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -11,7 +11,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/thread_info.h>
 #include <asm/cpufeatures.h>
-#include <asm/alternative-asm.h>
+#include <asm/alternative.h>
 #include <asm/asm.h>
 #include <asm/smap.h>
 #include <asm/export.h>
diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
index 1e299ac73c86..1cc9da6e29c7 100644
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -4,7 +4,7 @@
 #include <linux/linkage.h>
 #include <asm/errno.h>
 #include <asm/cpufeatures.h>
-#include <asm/alternative-asm.h>
+#include <asm/alternative.h>
 #include <asm/export.h>
 
 .pushsection .noinstr.text, "ax"
diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
index 41902fe8b859..64801010d312 100644
--- a/arch/x86/lib/memmove_64.S
+++ b/arch/x86/lib/memmove_64.S
@@ -8,7 +8,7 @@
  */
 #include <linux/linkage.h>
 #include <asm/cpufeatures.h>
-#include <asm/alternative-asm.h>
+#include <asm/alternative.h>
 #include <asm/export.h>
 
 #undef memmove
diff --git a/arch/x86/lib/memset_64.S b/arch/x86/lib/memset_64.S
index 0bfd26e4ca9e..9827ae267f96 100644
--- a/arch/x86/lib/memset_64.S
+++ b/arch/x86/lib/memset_64.S
@@ -3,7 +3,7 @@
 
 #include <linux/linkage.h>
 #include <asm/cpufeatures.h>
-#include <asm/alternative-asm.h>
+#include <asm/alternative.h>
 #include <asm/export.h>
 
 /*
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index f6fb1d218dcc..6bb74b5c238c 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -4,7 +4,7 @@
 #include <linux/linkage.h>
 #include <asm/dwarf2.h>
 #include <asm/cpufeatures.h>
-#include <asm/alternative-asm.h>
+#include <asm/alternative.h>
 #include <asm/export.h>
 #include <asm/nospec-branch.h>
 #include <asm/unwind_hints.h>
-- 
2.26.2

