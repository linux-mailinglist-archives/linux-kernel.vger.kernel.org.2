Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCCA350898
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 22:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbhCaUzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 16:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbhCaUzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 16:55:08 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73116C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 13:55:08 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id t18so10158697pjs.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 13:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dHwr6OVFfk7s7Yw8a90FyZmnLv02IEGSs6EhbG8UN8M=;
        b=gB9GGvNMPcPCjkKE6OWQgvLC37uUT4Z7LoJrr3lFosvD/AiGL7SG40QJN9QweDNYhs
         JJDRszWl5pu8J6qeT4zOqWIUIgxw890IJtSF0gAlvXAY/PKHr2fuIV4GAiM2BkHWXK+w
         fofEGeEHSH8JfszSnSky7cV9zxSCI1nmFtsAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dHwr6OVFfk7s7Yw8a90FyZmnLv02IEGSs6EhbG8UN8M=;
        b=glPnxE6KLTND0K9wwxoYMTwLgkLG68OmhPSdvzt0PZWDqYDKhOoPyRkwzLoMzZH7nM
         97YzxqwcaCnFL+3WCYuZjNsq+8G+7O2jSBq2sZSiYeLpBTLZ3KUNs33/6xfbmUBlnXAD
         ueiCjLuzttfDA0CVGs7DLDMliWHErhGxKosgfSus4cY1jyXMHHK291n2nvemXzqTtsRt
         NRkkcPQCex9dnV3Poa6LhHw9gDy3RB6qtvKdDqQZQ5Y1ow3jhyldhU1J2EswZVnXQfz2
         W+xhk/vdkPt1vQkJorJLVrtHq817rA4qMnU8aVQ0P7Qd7QBZTDDWCVzS5uQv8/SxCQ/e
         T+gg==
X-Gm-Message-State: AOAM533TKxYUq8jUE0k6alhTYvdZfdimykuRaF+Q40rs1M5Ez7PtXXjY
        UR+kLOeI5qBewXkPTwH97qiX6w==
X-Google-Smtp-Source: ABdhPJxQBkc1cS4++h7xQKjJpQz0b/qfsdGLu2VaFaj0TWROyDXRT34yURtIu2bG8Gko7MEMrVIMtg==
X-Received: by 2002:a17:90a:c7d5:: with SMTP id gf21mr5105027pjb.165.1617224108053;
        Wed, 31 Mar 2021 13:55:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r22sm3668971pgu.81.2021.03.31.13.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 13:55:06 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Potapenko <glider@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 5/6] arm64: entry: Enable random_kstack_offset support
Date:   Wed, 31 Mar 2021 13:54:57 -0700
Message-Id: <20210331205458.1871746-6-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210331205458.1871746-1-keescook@chromium.org>
References: <20210331205458.1871746-1-keescook@chromium.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=248270d6e87ad6ffcee20e448a3bbf6614f92c8d; i=6FjHrMJQ1a03WxuPiMt8aIK5MW/T0bayLG0SuUm7Wt4=; m=DW/OKOjAEidoxl6ODEV6zN0c7U/uCvK1t/uZsIkKPaM=; p=nb+ZCQAESoMtgqRKEEjn/wowCv7zZGeRTSUAEFbjSEQ=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmBk4aIACgkQiXL039xtwCbuGA//cnl or0wGJsp9zuuu7RUVPT168DY9SeI2dBagE9tma2ABm5wKRMiTBRSF+AthahdmPBTMkwV5LCbGamCr rws3ZQI16Npw5X61hBS2x7rPhnOrdoYfZPQiAg9izOOE0sgBjJ/959nkYC3vZ6mRH0Tv+iYDnKS6U 9qZlwGAFYgvRnpxFvMNrW9eyg2GWw1ApC0Tm34B2Y0BaWM3qGcNe3b7Y0CfUMONpBbIZsonheV89x 1Ls1vPQ9eNMw5ZQQKaLQtn4gNi+TYn3m7qQqplCS0eBN1L7HGIWNCXt9HRlGx9JKTd1GEPejgVkIp PQ1xKhgZtalvCJOl2fU6fST4AONY1R8psbP7GXXPxA9KbakgES0a/gylA6oVJSROb4Rc1rvaprQuz gyoCFsXyEWwoc5JQaORNm0lcFK6W9LLTCYTCkrgVXLd9PXDS6GDdt93Ut2ElKxuXvIpN65GD9dQKH gOnXVftWsBKautWUwzhjzS9mAzPi/4U24IePUs4ceOJCUASTg6767peFoQZzDHnnIu5tXeNzoEuBR GGcRHeGlNeoFZ0h8wc+hZZ1V0fwyHSPIu/GhO2TMmCyawkZ1mh67DRon3XLHts17uBS/1+5gEulCY mHH0WI/FkNXh8RbbBzxVQU6kehaG10ehhKLOSC0oH+vTq1kLpE+9paBMT6slvyRg=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow for a randomized stack offset on a per-syscall basis, with roughly
5 bits of entropy. (And include AAPCS rationale AAPCS thanks to Mark
Rutland.)

In order to avoid unconditional stack canaries on syscall entry (due to
the use of alloca()), also disable stack protector to avoid triggering
needless checks and slowing down the entry path. As there is no general
way to control stack protector coverage with a function attribute[1],
this must be disabled at the compilation unit level. This isn't a problem
here, though, since stack protector was not triggered before: examining
the resulting syscall.o, there are no changes in canary coverage (none
before, none now).

[1] a working __attribute__((no_stack_protector)) has been added to GCC
and Clang but has not been released in any version yet:
https://gcc.gnu.org/git/gitweb.cgi?p=gcc.git;h=346b302d09c1e6db56d9fe69048acb32fbb97845
https://reviews.llvm.org/rG4fbf84c1732fca596ad1d6e96015e19760eb8a9b

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/Kconfig          |  1 +
 arch/arm64/kernel/Makefile  |  5 +++++
 arch/arm64/kernel/syscall.c | 16 ++++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1f212b47a48a..2d0e5f544429 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -146,6 +146,7 @@ config ARM64
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
 	select HAVE_ARCH_PFN_VALID
 	select HAVE_ARCH_PREL32_RELOCATIONS
+	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_STACKLEAK
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index ed65576ce710..6cc97730790e 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -9,6 +9,11 @@ CFLAGS_REMOVE_ftrace.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_insn.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_return_address.o = $(CC_FLAGS_FTRACE)
 
+# Remove stack protector to avoid triggering unneeded stack canary
+# checks due to randomize_kstack_offset.
+CFLAGS_REMOVE_syscall.o	 = -fstack-protector -fstack-protector-strong
+CFLAGS_syscall.o	+= -fno-stack-protector
+
 # Object file lists.
 obj-y			:= debug-monitors.o entry.o irq.o fpsimd.o		\
 			   entry-common.o entry-fpsimd.o process.o ptrace.o	\
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index b9cf12b271d7..263d6c1a525f 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -5,6 +5,7 @@
 #include <linux/errno.h>
 #include <linux/nospec.h>
 #include <linux/ptrace.h>
+#include <linux/randomize_kstack.h>
 #include <linux/syscalls.h>
 
 #include <asm/daifflags.h>
@@ -43,6 +44,8 @@ static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
 {
 	long ret;
 
+	add_random_kstack_offset();
+
 	if (scno < sc_nr) {
 		syscall_fn_t syscall_fn;
 		syscall_fn = syscall_table[array_index_nospec(scno, sc_nr)];
@@ -55,6 +58,19 @@ static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
 		ret = lower_32_bits(ret);
 
 	regs->regs[0] = ret;
+
+	/*
+	 * Ultimately, this value will get limited by KSTACK_OFFSET_MAX(),
+	 * but not enough for arm64 stack utilization comfort. To keep
+	 * reasonable stack head room, reduce the maximum offset to 9 bits.
+	 *
+	 * The actual entropy will be further reduced by the compiler when
+	 * applying stack alignment constraints: the AAPCS mandates a
+	 * 16-byte (i.e. 4-bit) aligned SP at function boundaries.
+	 *
+	 * The resulting 5 bits of entropy is seen in SP[8:4].
+	 */
+	choose_random_kstack_offset(get_random_int() & 0x1FF);
 }
 
 static inline bool has_syscall_work(unsigned long flags)
-- 
2.25.1

