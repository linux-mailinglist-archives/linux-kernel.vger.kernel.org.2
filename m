Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F7634F2A7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 22:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbhC3U6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 16:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbhC3U56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 16:57:58 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77721C0613D8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 13:57:57 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so91468pjv.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 13:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dHwr6OVFfk7s7Yw8a90FyZmnLv02IEGSs6EhbG8UN8M=;
        b=hlWyqrrdivPvUsK2urCX5gbrxgHLV4EYIBS2FOfT0y3D/wpHPrKrvmLaAL5Yl6MNe7
         s8xQY60zPWjczFajqojxMdNTb+YVRWOmxbrkyFleNzk2fZr+gpe5pyPWLdMQx1C0pFPg
         odydi07JBlH01reKlWGYNqcTIdZo3NMmPvWCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dHwr6OVFfk7s7Yw8a90FyZmnLv02IEGSs6EhbG8UN8M=;
        b=Y29rvORYHVBqApN+qot/LDOGdyUxDXxOcK70DIwEQww1oMn8rtYrnmJZp3lA2iAGxk
         cdl+0UeaaROr6vuu9UlvMHGGnEqT/RYt7UjzhyRNX2AenclAHieoTDVaFZ3Pd/uLyV8v
         7Dz/loqFe4vc2n4hRt22bpOefOkSSBfxDci31XpCxultYqx0Osd+lcdQ9hIov99e1M8k
         DwXQKYGxruxC3FoSGBY3rQLNPTABgQWs/KZWP5dtu5nvyyN868FiNCqBIE7wEyi6n9kK
         xmv8yaC2jn8RXLc1DYa0+VeZfjmmtcm2taZhpqDF7RbjHJE1862Kh4ng507wVAt+IhRy
         Gndw==
X-Gm-Message-State: AOAM533P0WjR0NqrorBlg/tUdMq/sBIc83DkTo47NKvNY7y5FKCukfvi
        5YRk9Xb/bTZYh3xssofQAWD8kA==
X-Google-Smtp-Source: ABdhPJylAI9yxAoBrtRs4JyfT9rDF2n0nHOzw2dYUFJTY/UD7TWKY70QYv/FPZ+e1PRlkr1nagTnQQ==
X-Received: by 2002:a17:90a:f184:: with SMTP id bv4mr181607pjb.43.1617137876881;
        Tue, 30 Mar 2021 13:57:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mp19sm7171048pjb.2.2021.03.30.13.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 13:57:55 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
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
Subject: [PATCH v8 5/6] arm64: entry: Enable random_kstack_offset support
Date:   Tue, 30 Mar 2021 13:57:49 -0700
Message-Id: <20210330205750.428816-6-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210330205750.428816-1-keescook@chromium.org>
References: <20210330205750.428816-1-keescook@chromium.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=248270d6e87ad6ffcee20e448a3bbf6614f92c8d; i=6FjHrMJQ1a03WxuPiMt8aIK5MW/T0bayLG0SuUm7Wt4=; m=DW/OKOjAEidoxl6ODEV6zN0c7U/uCvK1t/uZsIkKPaM=; p=nb+ZCQAESoMtgqRKEEjn/wowCv7zZGeRTSUAEFbjSEQ=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmBjkM0ACgkQiXL039xtwCaO6Q//aar 6eVN//dg/fHBNLu2Gxap4jQwEL4B/h8LTF1EJJl+k981UHFhnFIYt8oW893e2NxbM0D1e845pN6po JTH0/kJzFiX5epyMsOKxIez20UlQsvmuATkeG7Ps6g+nXIpo54Sh/isnkNMV+NlQ6FZKtmP2/CCXm gXQgeCZJbD5ospCgiwZ5S16NR8Z5x1lzFOh11lCBjULCcG/OSLleoyWdadpnTa0bPjxQ9gIHBDxZE 5ufEVIEM9MmBAoE/UjxYyuIHROQGSdkwQMjfFM64hKOBM0E2+f8uxt0aNwxTWrdl/hwJCKzRP7f/0 LLqb3h825YDdfUxRySjRg66bDXL9j210YtIT1LoXaNcYEC9YR/+KE8ojXkZfi0K9/T4bETedLdhy2 EMNyu7LBrGoghShBmB7+hgMZisZBQvi99S6yGrQx+ZewJlYFlOCfLDUSJle4Cq1d2yZzj0NF9xUDI o/7+0luGZgIrHjoa7jpd9ckdrEFzCjOMrwZ9E2TsOkEVeL/MQlFa2Bndcgl2DkmCmk/dI9VcS+to1 O5NsZSB+oYVwZpg4MWLlEzE+g781nqeZbke/Is3MfFGqn3hHgC39raKe1uUPIyzh7ae5YMSB/v0So COf7PQUrybaOrXlDmivGjp0mfAhxQ2fngtrT32UEvGeLivm3olP9QbeCfmRKzbtY=
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

