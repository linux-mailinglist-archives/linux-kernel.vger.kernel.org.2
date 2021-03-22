Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8CB3435E0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 01:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhCVAMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 20:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbhCVAMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 20:12:35 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F31C061756
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 17:12:34 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id v11so14846672wro.7
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 17:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dQEq1jLbYzQJXO4TeSHTe5gIZlgtakCbMwf+B27NNZM=;
        b=MgrxyLKaMZs5gJPSMyfKfiTc2bjjcxsbilj4LHw8ZNcec020pJH/RU78It+gtMyvY+
         Usf9Nnj5Z+aWZidutPanI7FlGvf//k+I+91uzSiMflOQBJ2GRsKOKY8lYANnkgnluO4r
         aTsGSB4VB9+dSDUZNrFh1QjHixBMDHzgnnH4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dQEq1jLbYzQJXO4TeSHTe5gIZlgtakCbMwf+B27NNZM=;
        b=oyJ2c5lICPbIzKcL2Dyt+qhzBfVK5sW5DhBWBJCk1KxAgZT7OudlOBks8rzRm1znEC
         PLNiuHXWCNeOQyF+V3DoYkCDi2JQYKrymlh5prVtLzy6kZVhcw77HKoJWBzdmf7SaiMW
         i7KIPpwZIbqpeFl3W0viFUpuXzGNpGwXCz0AJ8pGtExG5dHqyr4dd3z/eBNYbngTntOr
         hUwPzjqB4+Z680kvRMhxTFE9KS6BD0m1UuVnCXHNumPC3GJVeMMCFPAApl1WS7maCzIM
         pggpggSPq9snvBLE+fKq2zc6ej8HPTuyqpicpOIv6Q58gHQtGmwleiQwobh0ti/dgMha
         I65A==
X-Gm-Message-State: AOAM530L8Quh4ynZe3bPgrIiR8gV0QaVkwkjn8b4lnj82J9x69hR3kMV
        Mi9u2bWCzoY5hZ28bVpXjLNGVw==
X-Google-Smtp-Source: ABdhPJyjjYO/IBnGlfrAE3l2sA/B9udYL/wRZ2p+N8s8l6VPlFpfzequoe8y3tzdYxH2bZI8WYxZig==
X-Received: by 2002:a05:6000:5:: with SMTP id h5mr15853400wrx.97.1616371953151;
        Sun, 21 Mar 2021 17:12:33 -0700 (PDT)
Received: from lootbox.konsulko.bg (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id h21sm14060417wmp.10.2021.03.21.17.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 17:12:32 -0700 (PDT)
From:   Vitaly Wool <vitaly.wool@konsulko.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Bin Meng <bin.meng@windriver.com>,
        Anup Patel <anup@brainfault.org>,
        Alistair Francis <alistair.francis@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Nicolas Pitre <nico@fluxnic.net>, Alex Ghiti <alex@ghiti.fr>,
        Vitaly Wool <vitaly.wool@konsulko.com>
Subject: [PATCH v6] RISC-V: enable XIP
Date:   Mon, 22 Mar 2021 02:12:15 +0200
Message-Id: <20210322001214.29985-1-vitaly.wool@konsulko.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce XIP (eXecute In Place) support for RISC-V platforms.
It allows code to be executed directly from non-volatile storage
directly addressable by the CPU, such as QSPI NOR flash which can
be found on many RISC-V platforms. This makes way for significant
optimization of RAM footprint. The XIP kernel is not compressed
since it has to run directly from flash, so it will occupy more
space on the non-volatile storage. The physical flash address used
to link the kernel object files and for storing it has to be known
at compile time and is represented by a Kconfig option.

XIP on RISC-V will for the time being only work on MMU-enabled
kernels.

Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>

---

Changes in v2:
- dedicated macro for XIP address fixup when MMU is not enabled yet
  o both for 32-bit and 64-bit RISC-V
- SP is explicitly set to a safe place in RAM before __copy_data call
- removed redundant alignment requirements in vmlinux-xip.lds.S
- changed long -> uintptr_t typecast in __XIP_FIXUP macro.
Changes in v3:
- rebased against latest for-next
- XIP address fixup macro now takes an argument
- SMP related fixes
Changes in v4:
- rebased against the current for-next
- less #ifdef's in C/ASM code
- dedicated XIP_FIXUP_OFFSET assembler macro in head.S
- C-specific definitions moved into #ifndef __ASSEMBLY__
- Fixed multi-core boot
Changes in v5:
- fixed build error for non-XIP kernels
Changes in v6:
- XIP_PHYS_RAM_BASE config option renamed to PHYS_RAM_BASE
- added PHYS_RAM_BASE_FIXED config flag to allow usage of
  PHYS_RAM_BASE in non-XIP configurations if needed
- XIP_FIXUP macro rewritten with a tempoarary variable to avoid side
  effects
- fixed crash for non-XIP kernels that don't use built-in DTB

 arch/riscv/Kconfig                  |  49 ++++++++++-
 arch/riscv/Makefile                 |   8 +-
 arch/riscv/boot/Makefile            |  13 +++
 arch/riscv/include/asm/pgtable.h    |  65 ++++++++++++--
 arch/riscv/kernel/cpu_ops_sbi.c     |  11 ++-
 arch/riscv/kernel/head.S            |  49 ++++++++++-
 arch/riscv/kernel/head.h            |   3 +
 arch/riscv/kernel/setup.c           |   8 +-
 arch/riscv/kernel/vmlinux-xip.lds.S | 132 ++++++++++++++++++++++++++++
 arch/riscv/kernel/vmlinux.lds.S     |   6 ++
 arch/riscv/mm/init.c                | 100 +++++++++++++++++++--
 11 files changed, 426 insertions(+), 18 deletions(-)
 create mode 100644 arch/riscv/kernel/vmlinux-xip.lds.S

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 8ea60a0a19ae..bd6f82240c34 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -441,7 +441,7 @@ config EFI_STUB
 
 config EFI
 	bool "UEFI runtime support"
-	depends on OF
+	depends on OF && !XIP_KERNEL
 	select LIBFDT
 	select UCS2_STRING
 	select EFI_PARAMS_FROM_FDT
@@ -465,11 +465,56 @@ config STACKPROTECTOR_PER_TASK
 	def_bool y
 	depends on STACKPROTECTOR && CC_HAVE_STACKPROTECTOR_TLS
 
+config PHYS_RAM_BASE_FIXED
+	bool "Explicitly specified physical RAM address"
+	default n
+
+config PHYS_RAM_BASE
+	hex "Platform Physical RAM address"
+	depends on PHYS_RAM_BASE_FIXED
+	default "0x80000000"
+	help
+	  This is the physical address of RAM in the system. It has to be
+	  explicitly specified to run early relocations of read-write data
+	  from flash to RAM.
+
+config XIP_KERNEL
+	bool "Kernel Execute-In-Place from ROM"
+	depends on MMU
+	select PHYS_RAM_BASE_FIXED
+	help
+	  Execute-In-Place allows the kernel to run from non-volatile storage
+	  directly addressable by the CPU, such as NOR flash. This saves RAM
+	  space since the text section of the kernel is not loaded from flash
+	  to RAM.  Read-write sections, such as the data section and stack,
+	  are still copied to RAM.  The XIP kernel is not compressed since
+	  it has to run directly from flash, so it will take more space to
+	  store it.  The flash address used to link the kernel object files,
+	  and for storing it, is configuration dependent. Therefore, if you
+	  say Y here, you must know the proper physical address where to
+	  store the kernel image depending on your own flash memory usage.
+
+	  Also note that the make target becomes "make xipImage" rather than
+	  "make zImage" or "make Image".  The final kernel binary to put in
+	  ROM memory will be arch/riscv/boot/xipImage.
+
+	  If unsure, say N.
+
+config XIP_PHYS_ADDR
+	hex "XIP Kernel Physical Location"
+	depends on XIP_KERNEL
+	default "0x21000000"
+	help
+	  This is the physical address in your flash memory the kernel will
+	  be linked for and stored to.  This address is dependent on your
+	  own flash usage.
+
 endmenu
 
 config BUILTIN_DTB
-	def_bool n
+	bool
 	depends on OF
+	default y if XIP_KERNEL
 
 menu "Power management options"
 
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 1368d943f1f3..8fcbec03974d 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -82,7 +82,11 @@ CHECKFLAGS += -D__riscv -D__riscv_xlen=$(BITS)
 
 # Default target when executing plain make
 boot		:= arch/riscv/boot
+ifeq ($(CONFIG_XIP_KERNEL),y)
+KBUILD_IMAGE := $(boot)/xipImage
+else
 KBUILD_IMAGE	:= $(boot)/Image.gz
+endif
 
 head-y := arch/riscv/kernel/head.o
 
@@ -95,12 +99,14 @@ PHONY += vdso_install
 vdso_install:
 	$(Q)$(MAKE) $(build)=arch/riscv/kernel/vdso $@
 
+ifneq ($(CONFIG_XIP_KERNEL),y)
 ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_SOC_CANAAN),yy)
 KBUILD_IMAGE := $(boot)/loader.bin
 else
 KBUILD_IMAGE := $(boot)/Image.gz
 endif
-BOOT_TARGETS := Image Image.gz loader loader.bin
+endif
+BOOT_TARGETS := Image Image.gz loader loader.bin xipImage
 
 all:	$(notdir $(KBUILD_IMAGE))
 
diff --git a/arch/riscv/boot/Makefile b/arch/riscv/boot/Makefile
index 03404c84f971..6bf299f70c27 100644
--- a/arch/riscv/boot/Makefile
+++ b/arch/riscv/boot/Makefile
@@ -17,8 +17,21 @@
 KCOV_INSTRUMENT := n
 
 OBJCOPYFLAGS_Image :=-O binary -R .note -R .note.gnu.build-id -R .comment -S
+OBJCOPYFLAGS_xipImage :=-O binary -R .note -R .note.gnu.build-id -R .comment -S
 
 targets := Image Image.* loader loader.o loader.lds loader.bin
+targets := Image Image.* loader loader.o loader.lds loader.bin xipImage
+
+ifeq ($(CONFIG_XIP_KERNEL),y)
+
+quiet_cmd_mkxip = $(quiet_cmd_objcopy)
+cmd_mkxip = $(cmd_objcopy)
+
+$(obj)/xipImage: vmlinux FORCE
+	$(call if_changed,mkxip)
+	@$(kecho) '  Physical Address of xipImage: $(CONFIG_XIP_PHYS_ADDR)'
+
+endif
 
 $(obj)/Image: vmlinux FORCE
 	$(call if_changed,objcopy)
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index ebf817c1bdf4..21a9b2f8d1c7 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -11,6 +11,33 @@
 
 #include <asm/pgtable-bits.h>
 
+#ifdef CONFIG_MMU
+
+#define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
+
+#ifdef CONFIG_XIP_KERNEL
+#define VMALLOC_SIZE     ((KERN_VIRT_SIZE >> 1) - SZ_16M)
+#define VMALLOC_END      (PAGE_OFFSET - SZ_16M - 1)
+
+#define XIP_OFFSET		SZ_8M
+#define XIP_MASK		(SZ_8M - 1)
+#define XIP_VIRT_ADDR(physaddr)	\
+	(PAGE_OFFSET - XIP_OFFSET + ((physaddr) & XIP_MASK))
+
+#else
+
+#define VMALLOC_SIZE     (KERN_VIRT_SIZE >> 1)
+#define VMALLOC_END      (PAGE_OFFSET - 1)
+
+#endif /* CONFIG_XIP_KERNEL */
+
+#else
+
+#ifdef CONFIG_XIP_KERNEL
+#define XIP_VIRT_ADDR(physaddr) (physaddr)
+#endif /* CONFIG_XIP_KERNEL */
+#endif /* CONFIG_MMU */
+
 #ifndef __ASSEMBLY__
 
 /* Page Upper Directory not used in RISC-V */
@@ -21,9 +48,25 @@
 
 #ifdef CONFIG_MMU
 
-#define VMALLOC_SIZE     (KERN_VIRT_SIZE >> 1)
-#define VMALLOC_END      (PAGE_OFFSET - 1)
-#define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
+#ifdef CONFIG_XIP_KERNEL
+/*
+ * Since we use sections to map it, this macro replaces the physical address
+ * with its virtual address while keeping offset from the base section.
+ */
+#define XIP_PHYS_ADDR(va)	 \
+	((uintptr_t)(va) - PAGE_OFFSET + XIP_OFFSET + CONFIG_XIP_PHYS_ADDR)
+
+#define XIP_VIRT_ADDR_START	XIP_VIRT_ADDR(CONFIG_XIP_PHYS_ADDR)
+
+#define XIP_FIXUP(addr)		({ \
+	uintptr_t __a = (uintptr_t)(addr); \
+	(__a >= CONFIG_XIP_PHYS_ADDR && \
+	 __a < CONFIG_XIP_PHYS_ADDR + SZ_16M) ? \
+	__a - CONFIG_XIP_PHYS_ADDR + CONFIG_PHYS_RAM_BASE - XIP_OFFSET : __a; \
+})
+#else
+#define XIP_FIXUP(addr)		(addr)
+#endif /* CONFIG_XIP_KERNEL */
 
 #define BPF_JIT_REGION_SIZE	(SZ_128M)
 #define BPF_JIT_REGION_START	(PAGE_OFFSET - BPF_JIT_REGION_SIZE)
@@ -484,8 +527,20 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
 
 #define kern_addr_valid(addr)   (1) /* FIXME */
 
-extern void *dtb_early_va;
-extern uintptr_t dtb_early_pa;
+extern void *_dtb_early_va;
+extern uintptr_t _dtb_early_pa;
+#if defined(CONFIG_XIP_KERNEL) && defined(CONFIG_MMU)
+
+#define dtb_early_va	(*(void **)XIP_FIXUP(&_dtb_early_va))
+#define dtb_early_pa	(*(uintptr_t *)XIP_FIXUP(&_dtb_early_pa))
+
+#else
+
+#define dtb_early_va	_dtb_early_va
+#define dtb_early_pa	_dtb_early_pa
+
+#endif /* CONFIG_XIP_KERNEL */
+
 void setup_bootmem(void);
 void paging_init(void);
 void misc_mem_init(void);
diff --git a/arch/riscv/kernel/cpu_ops_sbi.c b/arch/riscv/kernel/cpu_ops_sbi.c
index 685fae72b7f5..2413c2997350 100644
--- a/arch/riscv/kernel/cpu_ops_sbi.c
+++ b/arch/riscv/kernel/cpu_ops_sbi.c
@@ -53,10 +53,19 @@ static int sbi_hsm_hart_get_status(unsigned long hartid)
 }
 #endif
 
+static inline unsigned long get_secondary_start_phys(void)
+{
+#ifdef CONFIG_XIP_KERNEL
+	return XIP_PHYS_ADDR(secondary_start_sbi);
+#else
+	return __pa_symbol(secondary_start_sbi);
+#endif
+}
+
 static int sbi_cpu_start(unsigned int cpuid, struct task_struct *tidle)
 {
 	int rc;
-	unsigned long boot_addr = __pa_symbol(secondary_start_sbi);
+	unsigned long boot_addr = get_secondary_start_phys();
 	int hartid = cpuid_to_hartid_map(cpuid);
 
 	cpu_update_secondary_bootdata(cpuid, tidle);
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index f5a9bad86e58..bbe74e37914f 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -9,11 +9,23 @@
 #include <linux/linkage.h>
 #include <asm/thread_info.h>
 #include <asm/page.h>
+#include <asm/pgtable.h>
 #include <asm/csr.h>
 #include <asm/hwcap.h>
 #include <asm/image.h>
 #include "efi-header.S"
 
+#ifdef CONFIG_XIP_KERNEL
+.macro XIP_FIXUP_OFFSET reg
+	REG_L t0, _xip_fixup
+	add \reg, \reg, t0
+.endm
+_xip_fixup: .dword CONFIG_PHYS_RAM_BASE - CONFIG_XIP_PHYS_ADDR - XIP_OFFSET
+#else
+.macro XIP_FIXUP_OFFSET reg
+.endm
+#endif /* CONFIG_XIP_KERNEL */
+
 __HEAD
 ENTRY(_start)
 	/*
@@ -69,7 +81,11 @@ pe_head_start:
 #ifdef CONFIG_MMU
 relocate:
 	/* Relocate return address */
+#ifdef CONFIG_XIP_KERNEL
+	li a1, XIP_VIRT_ADDR(CONFIG_XIP_PHYS_ADDR)
+#else
 	li a1, PAGE_OFFSET
+#endif
 	la a2, _start
 	sub a1, a1, a2
 	add ra, ra, a1
@@ -91,6 +107,7 @@ relocate:
 	 * to ensure the new translations are in use.
 	 */
 	la a0, trampoline_pg_dir
+	XIP_FIXUP_OFFSET a0
 	srl a0, a0, PAGE_SHIFT
 	or a0, a0, a1
 	sfence.vma
@@ -144,7 +161,9 @@ secondary_start_sbi:
 
 	slli a3, a0, LGREG
 	la a4, __cpu_up_stack_pointer
+	XIP_FIXUP_OFFSET a4
 	la a5, __cpu_up_task_pointer
+	XIP_FIXUP_OFFSET a5
 	add a4, a3, a4
 	add a5, a3, a5
 	REG_L sp, (a4)
@@ -156,6 +175,7 @@ secondary_start_common:
 #ifdef CONFIG_MMU
 	/* Enable virtual memory and relocate to virtual address */
 	la a0, swapper_pg_dir
+	XIP_FIXUP_OFFSET a0
 	call relocate
 #endif
 	call setup_trap_vector
@@ -236,12 +256,33 @@ pmp_done:
 .Lgood_cores:
 #endif
 
+#ifndef CONFIG_XIP_KERNEL
 	/* Pick one hart to run the main boot sequence */
 	la a3, hart_lottery
 	li a2, 1
 	amoadd.w a3, a2, (a3)
 	bnez a3, .Lsecondary_start
 
+#else
+	/* hart_lottery in flash contains a magic number */
+	la a3, hart_lottery
+	mv a2, a3
+	XIP_FIXUP_OFFSET a2
+	lw t1, (a3)
+	amoswap.w t0, t1, (a2)
+	/* first time here if hart_lottery in RAM is not set */
+	beq t0, t1, .Lsecondary_start
+
+	la sp, _end + THREAD_SIZE
+	XIP_FIXUP_OFFSET sp
+	mv s0, a0
+	call __copy_data
+
+	/* Restore a0 copy */
+	mv a0, s0
+#endif
+
+#ifndef CONFIG_XIP_KERNEL
 	/* Clear BSS for flat non-ELF images */
 	la a3, __bss_start
 	la a4, __bss_stop
@@ -251,15 +292,18 @@ clear_bss:
 	add a3, a3, RISCV_SZPTR
 	blt a3, a4, clear_bss
 clear_bss_done:
-
+#endif
 	/* Save hart ID and DTB physical address */
 	mv s0, a0
 	mv s1, a1
+
 	la a2, boot_cpu_hartid
+	XIP_FIXUP_OFFSET a2
 	REG_S a0, (a2)
 
 	/* Initialize page tables and relocate to virtual addresses */
 	la sp, init_thread_union + THREAD_SIZE
+	XIP_FIXUP_OFFSET sp
 #ifdef CONFIG_BUILTIN_DTB
 	la a0, __dtb_start
 #else
@@ -268,6 +312,7 @@ clear_bss_done:
 	call setup_vm
 #ifdef CONFIG_MMU
 	la a0, early_pg_dir
+	XIP_FIXUP_OFFSET a0
 	call relocate
 #endif /* CONFIG_MMU */
 
@@ -292,7 +337,9 @@ clear_bss_done:
 
 	slli a3, a0, LGREG
 	la a1, __cpu_up_stack_pointer
+	XIP_FIXUP_OFFSET a1
 	la a2, __cpu_up_task_pointer
+	XIP_FIXUP_OFFSET a2
 	add a1, a3, a1
 	add a2, a3, a2
 
diff --git a/arch/riscv/kernel/head.h b/arch/riscv/kernel/head.h
index b48dda3d04f6..aabbc3ac3e48 100644
--- a/arch/riscv/kernel/head.h
+++ b/arch/riscv/kernel/head.h
@@ -12,6 +12,9 @@ extern atomic_t hart_lottery;
 
 asmlinkage void do_page_fault(struct pt_regs *regs);
 asmlinkage void __init setup_vm(uintptr_t dtb_pa);
+#ifdef CONFIG_XIP_KERNEL
+asmlinkage void __init __copy_data(void);
+#endif
 
 extern void *__cpu_up_stack_pointer[];
 extern void *__cpu_up_task_pointer[];
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index e85bacff1b50..a0384c72c272 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -50,7 +50,11 @@ struct screen_info screen_info __section(".data") = {
  * This is used before the kernel initializes the BSS so it can't be in the
  * BSS.
  */
-atomic_t hart_lottery __section(".sdata");
+atomic_t hart_lottery __section(".sdata")
+#ifdef CONFIG_XIP_KERNEL
+= ATOMIC_INIT(0xC001BEEF)
+#endif
+;
 unsigned long boot_cpu_hartid;
 static DEFINE_PER_CPU(struct cpu, cpu_devices);
 
@@ -254,7 +258,7 @@ void __init setup_arch(char **cmdline_p)
 #if IS_ENABLED(CONFIG_BUILTIN_DTB)
 	unflatten_and_copy_device_tree();
 #else
-	if (early_init_dt_verify(__va(dtb_early_pa)))
+	if (early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa))))
 		unflatten_device_tree();
 	else
 		pr_err("No DTB found in kernel mappings\n");
diff --git a/arch/riscv/kernel/vmlinux-xip.lds.S b/arch/riscv/kernel/vmlinux-xip.lds.S
new file mode 100644
index 000000000000..9f0f08c34cd3
--- /dev/null
+++ b/arch/riscv/kernel/vmlinux-xip.lds.S
@@ -0,0 +1,132 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ * Copyright (C) 2017 SiFive
+ * Copyright (C) 2020 Vitaly Wool, Konsulko AB
+ */
+
+#define LOAD_OFFSET XIP_VIRT_ADDR(CONFIG_XIP_PHYS_ADDR)
+/* No __ro_after_init data in the .rodata section - which will always be ro */
+#define RO_AFTER_INIT_DATA
+
+#include <asm/vmlinux.lds.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/cache.h>
+#include <asm/thread_info.h>
+
+OUTPUT_ARCH(riscv)
+ENTRY(_start)
+
+jiffies = jiffies_64;
+
+SECTIONS
+{
+	/* Beginning of code and text segment */
+	. = XIP_VIRT_ADDR(CONFIG_XIP_PHYS_ADDR);
+	_xiprom = .;
+	_start = .;
+	HEAD_TEXT_SECTION
+	INIT_TEXT_SECTION(PAGE_SIZE)
+	/* we have to discard exit text and such at runtime, not link time */
+	.exit.text :
+	{
+		EXIT_TEXT
+	}
+
+	.text : {
+		_text = .;
+		_stext = .;
+		TEXT_TEXT
+		SCHED_TEXT
+		CPUIDLE_TEXT
+		LOCK_TEXT
+		KPROBES_TEXT
+		ENTRY_TEXT
+		IRQENTRY_TEXT
+		SOFTIRQENTRY_TEXT
+		*(.fixup)
+		_etext = .;
+	}
+	RO_DATA(L1_CACHE_BYTES)
+	.srodata : {
+		*(.srodata*)
+	}
+	.init.rodata : {
+		INIT_SETUP(16)
+		INIT_CALLS
+		CON_INITCALL
+		INIT_RAM_FS
+	}
+	_exiprom = .;			/* End of XIP ROM area */
+
+
+/*
+ * From this point, stuff is considered writable and will be copied to RAM
+ */
+	__data_loc = ALIGN(16);		/* location in file */
+	. = PAGE_OFFSET;		/* location in memory */
+
+	_sdata = .;			/* Start of data section */
+	_data = .;
+	RW_DATA(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
+	_edata = .;
+	__start_ro_after_init = .;
+	.data.ro_after_init : AT(ADDR(.data.ro_after_init) - LOAD_OFFSET) {
+		*(.data..ro_after_init)
+	}
+	__end_ro_after_init = .;
+
+	. = ALIGN(PAGE_SIZE);
+	__init_begin = .;
+	.init.data : {
+		INIT_DATA
+	}
+	.exit.data : {
+		EXIT_DATA
+	}
+	. = ALIGN(8);
+	__soc_early_init_table : {
+		__soc_early_init_table_start = .;
+		KEEP(*(__soc_early_init_table))
+		__soc_early_init_table_end = .;
+	}
+	__soc_builtin_dtb_table : {
+		__soc_builtin_dtb_table_start = .;
+		KEEP(*(__soc_builtin_dtb_table))
+		__soc_builtin_dtb_table_end = .;
+	}
+	PERCPU_SECTION(L1_CACHE_BYTES)
+
+	. = ALIGN(PAGE_SIZE);
+	__init_end = .;
+
+	.sdata : {
+		__global_pointer$ = . + 0x800;
+		*(.sdata*)
+		*(.sbss*)
+	}
+
+	BSS_SECTION(PAGE_SIZE, PAGE_SIZE, 0)
+	EXCEPTION_TABLE(0x10)
+
+	.rel.dyn : AT(ADDR(.rel.dyn) - LOAD_OFFSET) {
+		*(.rel.dyn*)
+	}
+
+	/*
+	 * End of copied data. We need a dummy section to get its LMA.
+	 * Also located before final ALIGN() as trailing padding is not stored
+	 * in the resulting binary file and useless to copy.
+	 */
+	.data.endmark : AT(ADDR(.data.endmark) - LOAD_OFFSET) { }
+	_edata_loc = LOADADDR(.data.endmark);
+
+	. = ALIGN(PAGE_SIZE);
+	_end = .;
+
+	STABS_DEBUG
+	DWARF_DEBUG
+
+	DISCARDS
+}
diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index de03cb22d0e9..6745ec325930 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -4,7 +4,12 @@
  * Copyright (C) 2017 SiFive
  */
 
+#ifdef CONFIG_XIP_KERNEL
+#include "vmlinux-xip.lds.S"
+#else
+
 #define LOAD_OFFSET PAGE_OFFSET
+
 #include <asm/vmlinux.lds.h>
 #include <asm/page.h>
 #include <asm/cache.h>
@@ -132,3 +137,4 @@ SECTIONS
 
 	DISCARDS
 }
+#endif /* CONFIG_XIP_KERNEL */
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 7f5036fbee8c..efe649d41f95 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -31,8 +31,8 @@ EXPORT_SYMBOL(empty_zero_page);
 
 extern char _start[];
 #define DTB_EARLY_BASE_VA      PGDIR_SIZE
-void *dtb_early_va __initdata;
-uintptr_t dtb_early_pa __initdata;
+void *_dtb_early_va __initdata;
+uintptr_t _dtb_early_pa __initdata;
 
 struct pt_alloc_ops {
 	pte_t *(*get_pte_virt)(phys_addr_t pa);
@@ -88,6 +88,10 @@ static void print_vm_layout(void)
 		  (unsigned long)VMALLOC_END);
 	print_mlm("lowmem", (unsigned long)PAGE_OFFSET,
 		  (unsigned long)high_memory);
+#ifdef CONFIG_XIP_KERNEL
+	print_mlm("xip", (unsigned long)XIP_VIRT_ADDR_START,
+		  (unsigned long)XIP_VIRT_ADDR_START + SZ_16M);
+#endif /* CONFIG_XIP_KERNEL */
 }
 #else
 static void print_vm_layout(void) { }
@@ -113,6 +117,10 @@ void __init setup_bootmem(void)
 	phys_addr_t dram_end = memblock_end_of_DRAM();
 	phys_addr_t max_mapped_addr = __pa(~(ulong)0);
 
+#ifdef CONFIG_XIP_KERNEL
+	vmlinux_start = __pa_symbol(&_sdata);
+#endif
+
 	/* The maximal physical memory size is -PAGE_OFFSET. */
 	memblock_enforce_memory_limit(-PAGE_OFFSET);
 
@@ -149,11 +157,27 @@ void __init setup_bootmem(void)
 	memblock_allow_resize();
 }
 
+#ifdef CONFIG_XIP_KERNEL
+
+extern char _xiprom[], _exiprom[];
+extern char _sdata[], _edata[];
+
+#endif /* CONFIG_XIP_KERNEL */
+
 #ifdef CONFIG_MMU
-static struct pt_alloc_ops pt_ops;
+static struct pt_alloc_ops _pt_ops;
+
+#ifdef CONFIG_XIP_KERNEL
+#define pt_ops (*(struct pt_alloc_ops *)XIP_FIXUP(&_pt_ops))
+#else
+#define pt_ops	_pt_ops
+#endif
 
 unsigned long va_pa_offset;
 EXPORT_SYMBOL(va_pa_offset);
+#ifdef CONFIG_XIP_KERNEL
+#define va_pa_offset	(*((unsigned long *)XIP_FIXUP(&va_pa_offset)))
+#endif
 unsigned long pfn_base;
 EXPORT_SYMBOL(pfn_base);
 
@@ -163,6 +187,12 @@ pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
 
 pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
 
+#ifdef CONFIG_XIP_KERNEL
+#define trampoline_pg_dir	((pgd_t *)XIP_FIXUP(trampoline_pg_dir))
+#define fixmap_pte		((pte_t *)XIP_FIXUP(fixmap_pte))
+#define early_pg_dir		((pgd_t *)XIP_FIXUP(early_pg_dir))
+#endif /* CONFIG_XIP_KERNEL */
+
 void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot)
 {
 	unsigned long addr = __fix_to_virt(idx);
@@ -238,6 +268,15 @@ pmd_t fixmap_pmd[PTRS_PER_PMD] __page_aligned_bss;
 pmd_t early_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
 pmd_t early_dtb_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
 
+#ifdef CONFIG_XIP_KERNEL
+pmd_t xip_pmd[PTRS_PER_PMD] __page_aligned_bss;
+
+#define trampoline_pmd	((pmd_t *)XIP_FIXUP(trampoline_pmd))
+#define fixmap_pmd	((pmd_t *)XIP_FIXUP(fixmap_pmd))
+#define xip_pmd		((pmd_t *)XIP_FIXUP(xip_pmd))
+#define early_pmd	((pmd_t *)XIP_FIXUP(early_pmd))
+#endif /* CONFIG_XIP_KERNEL */
+
 static pmd_t *__init get_pmd_virt_early(phys_addr_t pa)
 {
 	/* Before MMU is enabled */
@@ -354,6 +393,19 @@ static uintptr_t __init best_map_size(phys_addr_t base, phys_addr_t size)
 	return PMD_SIZE;
 }
 
+#ifdef CONFIG_XIP_KERNEL
+/* called from head.S with MMU off */
+asmlinkage void __init __copy_data(void)
+{
+	void *from = (void *)(&_sdata);
+	void *end = (void *)(&_end);
+	void *to = (void *)CONFIG_PHYS_RAM_BASE;
+	size_t sz = (size_t)(end - from);
+
+	memcpy(to, from, sz);
+}
+#endif
+
 /*
  * setup_vm() is called from head.S with MMU-off.
  *
@@ -374,7 +426,8 @@ static uintptr_t __init best_map_size(phys_addr_t base, phys_addr_t size)
 
 asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 {
-	uintptr_t va, pa, end_va;
+	uintptr_t va, end_va;
+	uintptr_t __maybe_unused pa;
 	uintptr_t load_pa = (uintptr_t)(&_start);
 	uintptr_t load_sz = (uintptr_t)(&_end) - load_pa;
 	uintptr_t map_size;
@@ -382,6 +435,13 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	pmd_t fix_bmap_spmd, fix_bmap_epmd;
 #endif
 
+#ifdef CONFIG_XIP_KERNEL
+	uintptr_t xiprom = (uintptr_t)CONFIG_XIP_PHYS_ADDR;
+	uintptr_t xiprom_sz = (uintptr_t)(&_exiprom) - (uintptr_t)(&_xiprom);
+
+	load_pa = (uintptr_t)CONFIG_PHYS_RAM_BASE;
+	load_sz = (uintptr_t)(&_end) - (uintptr_t)(&_sdata);
+#endif
 	va_pa_offset = PAGE_OFFSET - load_pa;
 	pfn_base = PFN_DOWN(load_pa);
 
@@ -420,6 +480,21 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 			   load_pa, PGDIR_SIZE, PAGE_KERNEL_EXEC);
 #endif
 
+#ifdef CONFIG_XIP_KERNEL
+	create_pgd_mapping(trampoline_pg_dir, XIP_VIRT_ADDR_START,
+			   (uintptr_t)xip_pmd, PGDIR_SIZE, PAGE_TABLE);
+	for (va = XIP_VIRT_ADDR_START;
+	     va < XIP_VIRT_ADDR_START + xiprom_sz;
+	     va += PMD_SIZE) {
+		create_pmd_mapping(xip_pmd, va,
+				   xiprom + (va - XIP_VIRT_ADDR_START),
+				   PMD_SIZE, PAGE_KERNEL_EXEC);
+	}
+
+	create_pgd_mapping(early_pg_dir, XIP_VIRT_ADDR_START,
+			   (uintptr_t)xip_pmd, PGDIR_SIZE, PAGE_TABLE);
+#endif
+
 	/*
 	 * Setup early PGD covering entire kernel which will allows
 	 * us to reach paging_init(). We map all memory banks later
@@ -444,7 +519,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 			   pa + PMD_SIZE, PMD_SIZE, PAGE_KERNEL);
 	dtb_early_va = (void *)DTB_EARLY_BASE_VA + (dtb_pa & (PMD_SIZE - 1));
 #else /* CONFIG_BUILTIN_DTB */
-	dtb_early_va = __va(dtb_pa);
+	dtb_early_va = __va(XIP_FIXUP(dtb_pa));
 #endif /* CONFIG_BUILTIN_DTB */
 #else
 #ifndef CONFIG_BUILTIN_DTB
@@ -456,7 +531,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 			   pa + PGDIR_SIZE, PGDIR_SIZE, PAGE_KERNEL);
 	dtb_early_va = (void *)DTB_EARLY_BASE_VA + (dtb_pa & (PGDIR_SIZE - 1));
 #else /* CONFIG_BUILTIN_DTB */
-	dtb_early_va = __va(dtb_pa);
+	dtb_early_va = __va(XIP_FIXUP(dtb_pa));
 #endif /* CONFIG_BUILTIN_DTB */
 #endif
 	dtb_early_pa = dtb_pa;
@@ -497,6 +572,9 @@ static void __init setup_vm_final(void)
 	uintptr_t va, map_size;
 	phys_addr_t pa, start, end;
 	u64 i;
+#ifdef CONFIG_XIP_KERNEL
+	uintptr_t xiprom_sz = (uintptr_t)(&_exiprom) - (uintptr_t)(&_xiprom);
+#endif
 
 	/**
 	 * MMU is enabled at this point. But page table setup is not complete yet.
@@ -528,6 +606,16 @@ static void __init setup_vm_final(void)
 					   map_size, PAGE_KERNEL_EXEC);
 		}
 	}
+#ifdef CONFIG_XIP_KERNEL
+	map_size = best_map_size(CONFIG_XIP_PHYS_ADDR, xiprom_sz);
+	for (va = XIP_VIRT_ADDR_START;
+	     va < XIP_VIRT_ADDR_START + xiprom_sz;
+	     va += map_size)
+		create_pgd_mapping(swapper_pg_dir, va,
+				   CONFIG_XIP_PHYS_ADDR + (va - XIP_VIRT_ADDR_START),
+				   map_size, PAGE_KERNEL_EXEC);
+
+#endif
 
 	/* Clear fixmap PTE and PMD mappings */
 	clear_fixmap(FIX_PTE);
-- 
2.29.2

