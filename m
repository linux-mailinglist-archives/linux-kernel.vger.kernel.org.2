Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3836C41DA6A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 14:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349146AbhI3NA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 09:00:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:56464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351250AbhI3NA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 09:00:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3EC236124B;
        Thu, 30 Sep 2021 12:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633006754;
        bh=pZUE+JFU70DO6lZHw0XYBT4g6IgzpD/xlow05Rh/8z8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TNKTZVi/XWnH56oiOYl3wSeIgyXy3F5TQpt46FZBcnf+yISH1Md5cU+tOrkOutPVg
         MP9hMLo5YYMjOFL5fXMITQClNxHeQWhucmVgQEZjQCuJVZF9k9cb1bEcVzsQ+vE9uc
         ZvUQ/dC1oQY1TVHwqjda/9YjytHRfZUuj/Vk7tXUoCnQ3mCSTQj+IwxvkslkJDBmr/
         m5N9eUuGguj70IOZB9fr70XfM9+23s/dAS1ao1hKG9ip21mQrBNVKlC7KRypKm4Xug
         ly8sZrZnnVjogD+Ra6x3UNQa/forq0ZXw0olEA0XKtYPPEGuhim9WcypH3gDOEGp5D
         O67SHTtAwir1A==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 6/7] powerpc: smp: remove hack to obtain offset of task_struct::cpu
Date:   Thu, 30 Sep 2021 14:58:12 +0200
Message-Id: <20210930125813.197418-7-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210930125813.197418-1-ardb@kernel.org>
References: <20210930125813.197418-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of relying on awful hacks to obtain the offset of the cpu field
in struct task_struct, move it back into struct thread_info, which does
not create the same level of circular dependency hell when trying to
include the header file that defines it.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Makefile             | 11 -----------
 arch/powerpc/include/asm/smp.h    | 17 +----------------
 arch/powerpc/kernel/asm-offsets.c |  2 --
 3 files changed, 1 insertion(+), 29 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index aa6808e70647..54cad1faa5d0 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -446,17 +446,6 @@ else
 endif
 endif
 
-ifdef CONFIG_SMP
-ifdef CONFIG_PPC32
-prepare: task_cpu_prepare
-
-PHONY += task_cpu_prepare
-task_cpu_prepare: prepare0
-	$(eval KBUILD_CFLAGS += -D_TASK_CPU=$(shell awk '{if ($$2 == "TASK_CPU") print $$3;}' include/generated/asm-offsets.h))
-
-endif # CONFIG_PPC32
-endif # CONFIG_SMP
-
 PHONY += checkbin
 # Check toolchain versions:
 # - gcc-4.6 is the minimum kernel-wide version so nothing required.
diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 7ef1cd8168a0..007332a4a732 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -87,22 +87,7 @@ int is_cpu_dead(unsigned int cpu);
 /* 32-bit */
 extern int smp_hw_index[];
 
-/*
- * This is particularly ugly: it appears we can't actually get the definition
- * of task_struct here, but we need access to the CPU this task is running on.
- * Instead of using task_struct we're using _TASK_CPU which is extracted from
- * asm-offsets.h by kbuild to get the current processor ID.
- *
- * This also needs to be safeguarded when building asm-offsets.s because at
- * that time _TASK_CPU is not defined yet. It could have been guarded by
- * _TASK_CPU itself, but we want the build to fail if _TASK_CPU is missing
- * when building something else than asm-offsets.s
- */
-#ifdef GENERATING_ASM_OFFSETS
-#define raw_smp_processor_id()		(0)
-#else
-#define raw_smp_processor_id()		(*(unsigned int *)((void *)current + _TASK_CPU))
-#endif
+#define raw_smp_processor_id()		(current_thread_info()->cpu)
 #define hard_smp_processor_id() 	(smp_hw_index[smp_processor_id()])
 
 static inline int get_hard_smp_processor_id(int cpu)
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index e37e4546034e..cc05522f50bf 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -9,8 +9,6 @@
  * #defines from the assembly-language output.
  */
 
-#define GENERATING_ASM_OFFSETS	/* asm/smp.h */
-
 #include <linux/compat.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
-- 
2.30.2

