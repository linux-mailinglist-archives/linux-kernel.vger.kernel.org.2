Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36AB43A4857
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 20:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhFKSGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 14:06:06 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:46611 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbhFKSF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 14:05:58 -0400
Received: by mail-wr1-f52.google.com with SMTP id a11so6959430wrt.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 11:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=syeTZ14JvApjj5oKORk8jD7JMxxAQ3k9B7v+glQkE7o=;
        b=hiNTKKJhrnXgBP8osTTqczkb3MTTUHt1YIm1yI3Fp+5zSLcCTxS1VCME45/DLYrcZK
         Piqj/g+HsDaBQcDRDfYKbLraDX8e6Ej0WGMve9NqHS2TqrT344f/ZEPKgRNh8mWW1C7g
         wycJBbAI5O6xojBYv3CtktUl7gteckUfJRTDBP+qIVUnpdE7ARLwRHTp/+bRoQjJEZ7h
         jRR2zBFafRMlzSAMsGLapTtgzUiI8dR12ZpF9nzyl+fSqw/Al49qBo9hQssVdzAzTrvJ
         XLYGTjEN0SrApYam508cPMkij0z8IUGckAagnf4T+mp0xKopClt8ZCAOJZJUsYuLTUJ3
         mquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=syeTZ14JvApjj5oKORk8jD7JMxxAQ3k9B7v+glQkE7o=;
        b=WsHJZ4IeuznZopmka2PgbEboNIKKMohvU89nQuFGyWOH8v9+XyggU1Es7J7HEmIy39
         VECoJheaij0IPGNSP8ZPeR9JBaf25D879RSN0aGOdj6eCf0fRXL+jUSTZew+qvMEGVYj
         z+4K7ynsBAporPIHwIoQC2JfelX+XXmuR9PSaknGK9f5w0YLjslG1/uv0wuMQs8f2lGn
         YtoYEMgHzWxVNbEF9sifISD8HoMMNnjG/uh2hKoXMdZ1i+CkBTXVN4KqXZHePYQaUrY3
         S4fMprk7f6rgNKp3V2BYlsVzNXCxPP9TCDXPeZRganrO85x7okW/dKuXe+guTc/Hx8+s
         IWTw==
X-Gm-Message-State: AOAM532Vw2LBSy7Vss6try9YAHpmUDljHhPsB0ENIv1rzOnk3rPgx947
        TR4xIJkpW877zyaOoD63hoUD7iJxAzMelav4
X-Google-Smtp-Source: ABdhPJxHx7InWofvhKrfWm9GgP1NDpfBP7sndFDrPQheilEwbhdB0B75Mn14RGUnMLQEVHXfU5pzLQ==
X-Received: by 2002:a5d:59a3:: with SMTP id p3mr5522010wrr.284.1623434570388;
        Fri, 11 Jun 2021 11:02:50 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id v15sm7425881wrw.24.2021.06.11.11.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 11:02:50 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org
Subject: [PATCH v3 02/23] elf: Move arch_setup_additional_pages() to generic elf.h
Date:   Fri, 11 Jun 2021 19:02:21 +0100
Message-Id: <20210611180242.711399-3-dima@arista.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611180242.711399-1-dima@arista.com>
References: <20210611180242.711399-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ifdef the function in the header, not around it's usage in the code.
Following kernel style, move it to Kconfig.
Makes it easier to follow when the option is enabled/disabled.
Remove re-definition from compat_binfmt_elf, as it's always defined
for architectures that define compat_arch_setup_additional_pages (arm64/x86).
CONFIG_VDSO depends on MMU, so

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/arm/Kconfig                |  1 +
 arch/arm/include/asm/elf.h      |  3 ---
 arch/arm64/Kconfig              |  1 +
 arch/arm64/include/asm/elf.h    |  6 +-----
 arch/csky/Kconfig               |  1 +
 arch/csky/include/asm/elf.h     |  4 ----
 arch/hexagon/Kconfig            |  1 +
 arch/hexagon/include/asm/elf.h  |  6 ------
 arch/mips/Kconfig               |  1 +
 arch/mips/include/asm/elf.h     |  5 -----
 arch/nds32/Kconfig              |  1 +
 arch/nds32/include/asm/elf.h    |  3 ---
 arch/nios2/Kconfig              |  1 +
 arch/nios2/include/asm/elf.h    |  4 ----
 arch/powerpc/Kconfig            |  1 +
 arch/powerpc/include/asm/elf.h  |  5 -----
 arch/riscv/Kconfig              |  1 +
 arch/riscv/include/asm/elf.h    |  4 ----
 arch/s390/Kconfig               |  1 +
 arch/s390/include/asm/elf.h     |  5 -----
 arch/sh/Kconfig                 |  1 +
 arch/sh/include/asm/elf.h       |  6 ------
 arch/sparc/Kconfig              |  1 +
 arch/sparc/include/asm/elf_64.h |  6 ------
 arch/x86/Kconfig                |  1 +
 arch/x86/include/asm/elf.h      |  4 ----
 arch/x86/um/asm/elf.h           |  5 -----
 fs/Kconfig.binfmt               |  3 +++
 fs/binfmt_elf.c                 |  2 --
 fs/binfmt_elf_fdpic.c           |  3 +--
 fs/compat_binfmt_elf.c          |  2 --
 include/linux/elf.h             | 12 ++++++++++++
 32 files changed, 30 insertions(+), 71 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 24804f11302d..2df5ad505b8b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -14,6 +14,7 @@ config ARM
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PTE_SPECIAL if ARM_LPAE
 	select ARCH_HAS_PHYS_TO_DMA
+	select ARCH_HAS_SETUP_ADDITIONAL_PAGES if MMU
 	select ARCH_HAS_SETUP_DMA_OPS
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
diff --git a/arch/arm/include/asm/elf.h b/arch/arm/include/asm/elf.h
index b8102a6ddf16..a7cd90b3a779 100644
--- a/arch/arm/include/asm/elf.h
+++ b/arch/arm/include/asm/elf.h
@@ -145,9 +145,6 @@ do {								\
 		    (elf_addr_t)current->mm->context.vdso);	\
 } while (0)
 #endif
-#define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
-struct linux_binprm;
-int arch_setup_additional_pages(struct linux_binprm *, int);
 #endif
 
 #endif
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9f1d8566bbf9..385ef8d8ad9b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -31,6 +31,7 @@ config ARM64
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PTE_DEVMAP
 	select ARCH_HAS_PTE_SPECIAL
+	select ARCH_HAS_SETUP_ADDITIONAL_PAGES
 	select ARCH_HAS_SETUP_DMA_OPS
 	select ARCH_HAS_SET_DIRECT_MAP
 	select ARCH_HAS_SET_MEMORY
diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 8d1c8dcb87fd..d1073ffa7f24 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -181,11 +181,6 @@ do {									\
 		NEW_AUX_ENT(AT_IGNORE, 0);				\
 } while (0)
 
-#define ARCH_HAS_SETUP_ADDITIONAL_PAGES
-struct linux_binprm;
-extern int arch_setup_additional_pages(struct linux_binprm *bprm,
-				       int uses_interp);
-
 /* 1GB of VA */
 #ifdef CONFIG_COMPAT
 #define STACK_RND_MASK			(test_thread_flag(TIF_32BIT) ? \
@@ -242,6 +237,7 @@ do {									\
 #else
 #define COMPAT_ARCH_DLINFO
 #endif
+struct linux_binprm;
 extern int aarch32_setup_additional_pages(struct linux_binprm *bprm,
 					  int uses_interp);
 #define compat_arch_setup_additional_pages \
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 8de5b987edb9..68139fa18691 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -4,6 +4,7 @@ config CSKY
 	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_GCOV_PROFILE_ALL
+	select ARCH_HAS_SETUP_ADDITIONAL_PAGES
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_USE_BUILTIN_BSWAP
diff --git a/arch/csky/include/asm/elf.h b/arch/csky/include/asm/elf.h
index 48b83e283ed4..89067e028335 100644
--- a/arch/csky/include/asm/elf.h
+++ b/arch/csky/include/asm/elf.h
@@ -83,8 +83,4 @@ extern int dump_task_regs(struct task_struct *tsk, elf_gregset_t *elf_regs);
 #define ELF_PLATFORM		(NULL)
 #define SET_PERSONALITY(ex)	set_personality(PER_LINUX)
 
-#define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
-struct linux_binprm;
-extern int arch_setup_additional_pages(struct linux_binprm *bprm,
-				       int uses_interp);
 #endif /* __ASM_CSKY_ELF_H */
diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 44a409967af1..04dc816d04bd 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -5,6 +5,7 @@ comment "Linux Kernel Configuration for Hexagon"
 config HEXAGON
 	def_bool y
 	select ARCH_32BIT_OFF_T
+	select ARCH_HAS_SETUP_ADDITIONAL_PAGES
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_NO_PREEMPT
 	# Other pending projects/to-do items.
diff --git a/arch/hexagon/include/asm/elf.h b/arch/hexagon/include/asm/elf.h
index 5bfdd9b147fd..eba4131610aa 100644
--- a/arch/hexagon/include/asm/elf.h
+++ b/arch/hexagon/include/asm/elf.h
@@ -207,10 +207,4 @@ do {					\
  */
 #define ELF_PLATFORM  (NULL)
 
-#define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
-struct linux_binprm;
-extern int arch_setup_additional_pages(struct linux_binprm *bprm,
-				       int uses_interp);
-
-
 #endif
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ed51970c08e7..81096dd2c1ef 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -9,6 +9,7 @@ config MIPS
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE if !EVA
 	select ARCH_HAS_PTE_SPECIAL if !(32BIT && CPU_HAS_RIXI)
+	select ARCH_HAS_SETUP_ADDITIONAL_PAGES
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_HAS_GCOV_PROFILE_ALL
diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
index dc8d2863752c..a5c8be47a39d 100644
--- a/arch/mips/include/asm/elf.h
+++ b/arch/mips/include/asm/elf.h
@@ -462,11 +462,6 @@ do {									\
 		    (unsigned long)current->mm->context.vdso);		\
 } while (0)
 
-#define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
-struct linux_binprm;
-extern int arch_setup_additional_pages(struct linux_binprm *bprm,
-				       int uses_interp);
-
 #ifdef CONFIG_MIPS_FP_SUPPORT
 
 struct arch_elf_state {
diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
index 62313902d75d..02afe5ebdfff 100644
--- a/arch/nds32/Kconfig
+++ b/arch/nds32/Kconfig
@@ -8,6 +8,7 @@ config NDS32
 	def_bool y
 	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_DMA_PREP_COHERENT
+	select ARCH_HAS_SETUP_ADDITIONAL_PAGES
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_WANT_FRAME_POINTERS if FTRACE
diff --git a/arch/nds32/include/asm/elf.h b/arch/nds32/include/asm/elf.h
index 1853dc89b8ac..36cec4ae5a84 100644
--- a/arch/nds32/include/asm/elf.h
+++ b/arch/nds32/include/asm/elf.h
@@ -173,8 +173,5 @@ do {								\
 	NEW_AUX_ENT(AT_SYSINFO_EHDR,				\
 		    (elf_addr_t)current->mm->context.vdso);	\
 } while (0)
-#define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
-struct linux_binprm;
-int arch_setup_additional_pages(struct linux_binprm *, int);
 
 #endif
diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index c24955c81c92..8159123a995e 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -3,6 +3,7 @@ config NIOS2
 	def_bool y
 	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_DMA_PREP_COHERENT
+	select ARCH_HAS_SETUP_ADDITIONAL_PAGES
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_HAS_DMA_SET_UNCACHED
diff --git a/arch/nios2/include/asm/elf.h b/arch/nios2/include/asm/elf.h
index 984dd6de17c2..4f8baaef843f 100644
--- a/arch/nios2/include/asm/elf.h
+++ b/arch/nios2/include/asm/elf.h
@@ -28,10 +28,6 @@
 /* regs is struct pt_regs, pr_reg is elf_gregset_t (which is
    now struct_user_regs, they are different) */
 
-#define ARCH_HAS_SETUP_ADDITIONAL_PAGES	1
-struct linux_binprm;
-extern int arch_setup_additional_pages(struct linux_binprm *bprm,
-	int uses_interp);
 #define ELF_CORE_COPY_REGS(pr_reg, regs)				\
 { do {									\
 	/* Bleech. */							\
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 088dd2afcfe4..a9f842230ee4 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -140,6 +140,7 @@ config PPC
 	select ARCH_HAS_PTE_DEVMAP		if PPC_BOOK3S_64
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE && PPC_BOOK3S_64
+	select ARCH_HAS_SETUP_ADDITIONAL_PAGES
 	select ARCH_HAS_STRICT_KERNEL_RWX	if ((PPC_BOOK3S_64 || PPC32) && !HIBERNATION)
 	select ARCH_HAS_TICK_BROADCAST		if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UACCESS_FLUSHCACHE
diff --git a/arch/powerpc/include/asm/elf.h b/arch/powerpc/include/asm/elf.h
index b8425e3cfd81..d7d9820c9096 100644
--- a/arch/powerpc/include/asm/elf.h
+++ b/arch/powerpc/include/asm/elf.h
@@ -111,11 +111,6 @@ extern int dcache_bsize;
 extern int icache_bsize;
 extern int ucache_bsize;
 
-/* vDSO has arch_setup_additional_pages */
-#define ARCH_HAS_SETUP_ADDITIONAL_PAGES
-struct linux_binprm;
-extern int arch_setup_additional_pages(struct linux_binprm *bprm,
-				       int uses_interp);
 #define VDSO_AUX_ENT(a,b) NEW_AUX_ENT(a,b)
 
 /* 1GB for 64bit, 8MB for 32bit */
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c5914e70a0fd..1003fa4534a7 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -28,6 +28,7 @@ config RISCV
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SET_DIRECT_MAP
 	select ARCH_HAS_SET_MEMORY
+	select ARCH_HAS_SETUP_ADDITIONAL_PAGES if MMU
 	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
 	select ARCH_HAS_STRICT_MODULE_RWX if MMU && !XIP_KERNEL
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
index f4b490cd0e5d..1d1d60df632e 100644
--- a/arch/riscv/include/asm/elf.h
+++ b/arch/riscv/include/asm/elf.h
@@ -75,10 +75,6 @@ do {								\
 	NEW_AUX_ENT(AT_L2_CACHEGEOMETRY,			\
 		get_cache_geometry(2, CACHE_TYPE_UNIFIED));	\
 } while (0)
-#define ARCH_HAS_SETUP_ADDITIONAL_PAGES
-struct linux_binprm;
-extern int arch_setup_additional_pages(struct linux_binprm *bprm,
-	int uses_interp);
 #endif /* CONFIG_MMU */
 
 #define ELF_CORE_COPY_REGS(dest, regs)			\
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index b4c7c34069f8..ccca15663345 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -76,6 +76,7 @@ config S390
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SCALED_CPUTIME
 	select ARCH_HAS_SET_MEMORY
+	select ARCH_HAS_SETUP_ADDITIONAL_PAGES
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_STRICT_MODULE_RWX
 	select ARCH_HAS_SYSCALL_WRAPPER
diff --git a/arch/s390/include/asm/elf.h b/arch/s390/include/asm/elf.h
index 66d51ad090ab..6583142149b0 100644
--- a/arch/s390/include/asm/elf.h
+++ b/arch/s390/include/asm/elf.h
@@ -275,9 +275,4 @@ do {									    \
 			    (unsigned long)current->mm->context.vdso_base); \
 } while (0)
 
-struct linux_binprm;
-
-#define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
-int arch_setup_additional_pages(struct linux_binprm *, int);
-
 #endif
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 68129537e350..9a1a39c5b3c4 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -10,6 +10,7 @@ config SUPERH
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_PTE_SPECIAL
+	select ARCH_HAS_SETUP_ADDITIONAL_PAGES if VSYSCALL
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HIBERNATION_POSSIBLE if MMU
 	select ARCH_MIGHT_HAVE_PC_PARPORT
diff --git a/arch/sh/include/asm/elf.h b/arch/sh/include/asm/elf.h
index 2862d6d1cb64..9b3e22e771a1 100644
--- a/arch/sh/include/asm/elf.h
+++ b/arch/sh/include/asm/elf.h
@@ -164,12 +164,6 @@ do {									\
 	set_personality(PER_LINUX_32BIT | (current->personality & (~PER_MASK)))
 
 #ifdef CONFIG_VSYSCALL
-/* vDSO has arch_setup_additional_pages */
-#define ARCH_HAS_SETUP_ADDITIONAL_PAGES
-struct linux_binprm;
-extern int arch_setup_additional_pages(struct linux_binprm *bprm,
-				       int uses_interp);
-
 extern unsigned int vdso_enabled;
 extern void __kernel_vsyscall;
 
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 164a5254c91c..10c719a73b90 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -13,6 +13,7 @@ config 64BIT
 config SPARC
 	bool
 	default y
+	select ARCH_HAS_SETUP_ADDITIONAL_PAGES if SPARC64
 	select ARCH_MIGHT_HAVE_PC_PARPORT if SPARC64 && PCI
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select DMA_OPS
diff --git a/arch/sparc/include/asm/elf_64.h b/arch/sparc/include/asm/elf_64.h
index 8fb09eec8c3e..63a622c36df3 100644
--- a/arch/sparc/include/asm/elf_64.h
+++ b/arch/sparc/include/asm/elf_64.h
@@ -223,10 +223,4 @@ do {									\
 	NEW_AUX_ENT(AT_ADI_NBITS, adi_state.caps.nbits);		\
 	NEW_AUX_ENT(AT_ADI_UEONADI, adi_state.caps.ue_on_adi);		\
 } while (0)
-
-struct linux_binprm;
-
-#define ARCH_HAS_SETUP_ADDITIONAL_PAGES	1
-extern int arch_setup_additional_pages(struct linux_binprm *bprm,
-					int uses_interp);
 #endif /* !(__ASM_SPARC64_ELF_H) */
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0045e1b44190..d30b952f4453 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -87,6 +87,7 @@ config X86
 	select ARCH_HAS_COPY_MC			if X86_64
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_SET_DIRECT_MAP
+	select ARCH_HAS_SETUP_ADDITIONAL_PAGES
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_STRICT_MODULE_RWX
 	select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index c0b5733005af..9ee5b3b3ba93 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -378,10 +378,6 @@ else if (IS_ENABLED(CONFIG_IA32_EMULATION))				\
 	 vdso_image_32.sym___kernel_vsyscall)
 
 struct linux_binprm;
-
-#define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
-extern int arch_setup_additional_pages(struct linux_binprm *bprm,
-				       int uses_interp);
 extern int compat_arch_setup_additional_pages(struct linux_binprm *bprm,
 					      int uses_interp);
 #define compat_arch_setup_additional_pages compat_arch_setup_additional_pages
diff --git a/arch/x86/um/asm/elf.h b/arch/x86/um/asm/elf.h
index dcaf3b38a9e0..b7c03a760a3c 100644
--- a/arch/x86/um/asm/elf.h
+++ b/arch/x86/um/asm/elf.h
@@ -181,11 +181,6 @@ do {								\
 #define FIXADDR_USER_START      0
 #define FIXADDR_USER_END        0
 
-#define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
-struct linux_binprm;
-extern int arch_setup_additional_pages(struct linux_binprm *bprm,
-	int uses_interp);
-
 extern unsigned long um_vdso_addr;
 #define AT_SYSINFO_EHDR 33
 #define ARCH_DLINFO	NEW_AUX_ENT(AT_SYSINFO_EHDR, um_vdso_addr)
diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index 06fb7a93a1bd..d98206ad7749 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -39,6 +39,9 @@ config ARCH_BINFMT_ELF_STATE
 config ARCH_HAVE_ELF_PROT
 	bool
 
+config ARCH_HAS_SETUP_ADDITIONAL_PAGES
+	bool
+
 config ARCH_USE_GNU_PROPERTY
 	bool
 
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 2347d9067df6..dac2713c10ee 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1252,11 +1252,9 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 	set_binfmt(&elf_format);
 
-#ifdef ARCH_HAS_SETUP_ADDITIONAL_PAGES
 	retval = arch_setup_additional_pages(bprm, !!interpreter);
 	if (retval < 0)
 		goto out;
-#endif /* ARCH_HAS_SETUP_ADDITIONAL_PAGES */
 
 	retval = create_elf_tables(bprm, elf_ex,
 			  load_addr, interp_load_addr, e_entry);
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 2c99b102c860..11cbf20b19da 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -374,11 +374,10 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 				 executable_stack);
 	if (retval < 0)
 		goto error;
-#ifdef ARCH_HAS_SETUP_ADDITIONAL_PAGES
+
 	retval = arch_setup_additional_pages(bprm, !!interpreter_name);
 	if (retval < 0)
 		goto error;
-#endif
 #endif
 
 	/* load the executable and interpreter into memory */
diff --git a/fs/compat_binfmt_elf.c b/fs/compat_binfmt_elf.c
index 049ba7c011b9..fad63a4f842e 100644
--- a/fs/compat_binfmt_elf.c
+++ b/fs/compat_binfmt_elf.c
@@ -111,8 +111,6 @@
 #endif
 
 #ifdef	compat_arch_setup_additional_pages
-#undef	ARCH_HAS_SETUP_ADDITIONAL_PAGES
-#define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
 #undef	arch_setup_additional_pages
 #define	arch_setup_additional_pages compat_arch_setup_additional_pages
 #endif
diff --git a/include/linux/elf.h b/include/linux/elf.h
index 6dbcfe7a3fd7..95bf7a1abaef 100644
--- a/include/linux/elf.h
+++ b/include/linux/elf.h
@@ -104,4 +104,16 @@ static inline int arch_elf_adjust_prot(int prot,
 }
 #endif
 
+struct linux_binprm;
+#ifdef CONFIG_ARCH_HAS_SETUP_ADDITIONAL_PAGES
+extern int arch_setup_additional_pages(struct linux_binprm *bprm,
+				       int uses_interp);
+#else
+static inline int arch_setup_additional_pages(struct linux_binprm *bprm,
+				       int uses_interp)
+{
+	return 0;
+}
+#endif
+
 #endif /* _LINUX_ELF_H */
-- 
2.31.1

