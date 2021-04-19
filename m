Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC393638EA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 02:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237056AbhDSA4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 20:56:42 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:46702 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236492AbhDSA4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 20:56:31 -0400
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 13J0u0Fa011027
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 03:56:00 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1618793755; x=1621385755;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=x1NfQeDGuzUddylrd2vfl4leKdgz1sp1myNqliXpqR8=;
        b=mdCd6MGlIbsK1iDKG0VRgPA0wjqRZ9LxhrY2/X+97C1ftCl9hoo0qfGu3APuA0kS
        h9xrtIbKY1d3G6tlsa+C4rHPQ03tGh0O8NH0rlK8G+NFoDiqdoRMSf7mZATYRb/t
        dcJLvhWmF0S4NvI6xTs2WDutphXlAQHxAfJdSDd6gnc4YdLcgdIN6WNvNHkErKZL
        73vCxJxU/+ZCWe71jCZh6JtRf0f1FYswU2+vcGTetV/onrkcTW+QtvStIkGVLhZt
        x4vv6c8CbQ6q/lYnNIijIOFEdB4J1cvclkzv02UGMhmBVTFhpMXkl0ecK1xm9uAR
        lai2878nupkDJB77cDp7OA==;
X-AuditID: 8b5b014d-a4c337000000209f-e4-607cd51b4ad9
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 14.FF.08351.B15DC706; Mon, 19 Apr 2021 03:55:55 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user: mick@ics.forth.gr at ics.forth.gr
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     linux-riscv@lists.infradead.org, palmer@dabbelt.com
Cc:     paul.walmsley@sifive.com, linux-kernel@vger.kernel.org,
        Nick Kossifidis <mick@ics.forth.gr>
Subject: [PATCH v4 2/5] RISC-V: Add kexec support
Date:   Mon, 19 Apr 2021 03:55:36 +0300
Message-Id: <20210419005539.22729-3-mick@ics.forth.gr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210419005539.22729-1-mick@ics.forth.gr>
References: <20210419005539.22729-1-mick@ics.forth.gr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBLMWRmVeSWpSXmKPExsXSHT1dWVf6ak2CwbqnchaXd81hs9j2uYXN
        ovndOXaLl5d7mC3aZvE7sHq8efmSxePhpktMHpuX1Htcar7O7vF5k1wAaxSXTUpqTmZZapG+
        XQJXxoePd9kL9hZX3H58k72BsSOmi5GDQ0LARGJns2oXIxeHkMBRRomnW26wdDFyAsXdJG7f
        38kKYrMJaErMv3QQLC4iYC7RPPM1I4jNLJAhcXTfL3YQW1jAUGLf3QawehYBVYnlt08ygdi8
        AmYS35/shJopL9G+fDsbiM0JNGfKhM9gc4SAaub9vwtVLyhxcuYTFoj58hLNW2czT2Dkm4Uk
        NQtJagEj0ypGgcQyY73M5GK9tPyikgy99KJNjODAY/TdwXh781u9Q4xMHIyHGCU4mJVEeO/X
        1iQI8aYkVlalFuXHF5XmpBYfYpTmYFES5+XVmxAvJJCeWJKanZpakFoEk2Xi4JRqYArdmHDX
        6bXA+qd5dRLN+punl6aUxToyJ9rusPiq90jsW9yF43l+n2z6vn81eW59onznocKWmGadpVs6
        f2k9e3I1YmNOpMIdFcV33+aK3FBZzyQfv9lRx/Xo5K4lKSGKm6f4x7faNtQvvP1TacHuAo+k
        ZlVu7vJvrcdKr+VKPb614dXlhfs+T81fOm/uE99pL1x8pv2eEqAZs3jSnqbtYjx8yaVhk3g/
        7Ex3zMiYabk9bpavmPb3ebUK0zf1zPGere7Ukv7rw4Xzx2+rTmhbqHvByEphXsiNNybn8lrW
        Ppezffk3beIhjt+/MtSP564KdKjR8L7DcTSo60zyb95oi+dHFyi268aKVD56xODko6LEUpyR
        aKjFXFScCADxRaq1qwIAAA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for kexec on RISC-V. On SMP systems it depends
on HOTPLUG_CPU in order to be able to bring up all harts after kexec.
It also needs a recent OpenSBI version that supports the HSM extension.
I tested it on riscv64 QEMU on both an smp and a non-smp system.

v6:
 * Re-based on top of "fixes" branch
 * Use PAGE_SIZE and CSR_* macros where possible
 * Small cleanups

v5:
 * For now depend on MMU, further changes needed for NOMMU support
 * Make sure stvec is aligned
 * Cleanup some unneeded fences
 * Verify control code's buffer size
 * Compile kexec_relocate.S with medany and norelax

v4:
 * No functional changes, just re-based

v3:
 * Use the new smp_shutdown_nonboot_cpus() call.
 * Move riscv_kexec_relocate to .rodata

v2:
 * Pass needed parameters as arguments to riscv_kexec_relocate
   instead of using global variables.
 * Use kimage_arch to hold the fdt address of the included fdt.
 * Use SYM_* macros on kexec_relocate.S.
 * Compatibility with STRICT_KERNEL_RWX.
 * Compatibility with HOTPLUG_CPU for SMP
 * Small cleanups

Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>
---
 arch/riscv/Kconfig                 |  15 +++
 arch/riscv/include/asm/kexec.h     |  49 ++++++++
 arch/riscv/kernel/Makefile         |   5 +
 arch/riscv/kernel/kexec_relocate.S | 157 ++++++++++++++++++++++++
 arch/riscv/kernel/machine_kexec.c  | 186 +++++++++++++++++++++++++++++
 5 files changed, 412 insertions(+)
 create mode 100644 arch/riscv/include/asm/kexec.h
 create mode 100644 arch/riscv/kernel/kexec_relocate.S
 create mode 100644 arch/riscv/kernel/machine_kexec.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 4515a10c5..10cc19be0 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -386,6 +386,21 @@ config RISCV_SBI_V01
 	help
 	  This config allows kernel to use SBI v0.1 APIs. This will be
 	  deprecated in future once legacy M-mode software are no longer in use.
+
+config KEXEC
+	bool "Kexec system call"
+	select KEXEC_CORE
+	select HOTPLUG_CPU if SMP
+	depends on MMU
+	help
+	  kexec is a system call that implements the ability to shutdown your
+	  current kernel, and to start another kernel. It is like a reboot
+	  but it is independent of the system firmware. And like a reboot
+	  you can start any kernel with it, not just Linux.
+
+	  The name comes from the similarity to the exec system call.
+
+
 endmenu
 
 menu "Boot options"
diff --git a/arch/riscv/include/asm/kexec.h b/arch/riscv/include/asm/kexec.h
new file mode 100644
index 000000000..86e6e4922
--- /dev/null
+++ b/arch/riscv/include/asm/kexec.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 FORTH-ICS/CARV
+ *  Nick Kossifidis <mick@ics.forth.gr>
+ */
+
+#ifndef _RISCV_KEXEC_H
+#define _RISCV_KEXEC_H
+
+#include <asm/page.h>    /* For PAGE_SIZE */
+
+/* Maximum physical address we can use pages from */
+#define KEXEC_SOURCE_MEMORY_LIMIT (-1UL)
+
+/* Maximum address we can reach in physical address mode */
+#define KEXEC_DESTINATION_MEMORY_LIMIT (-1UL)
+
+/* Maximum address we can use for the control code buffer */
+#define KEXEC_CONTROL_MEMORY_LIMIT (-1UL)
+
+/* Reserve a page for the control code buffer */
+#define KEXEC_CONTROL_PAGE_SIZE PAGE_SIZE
+
+#define KEXEC_ARCH KEXEC_ARCH_RISCV
+
+static inline void
+crash_setup_regs(struct pt_regs *newregs,
+		 struct pt_regs *oldregs)
+{
+	/* Dummy implementation for now */
+}
+
+
+#define ARCH_HAS_KIMAGE_ARCH
+
+struct kimage_arch {
+	unsigned long fdt_addr;
+};
+
+const extern unsigned char riscv_kexec_relocate[];
+const extern unsigned int riscv_kexec_relocate_size;
+
+typedef void (*riscv_kexec_do_relocate)(unsigned long first_ind_entry,
+					unsigned long jump_addr,
+					unsigned long fdt_addr,
+					unsigned long hartid,
+					unsigned long va_pa_off);
+
+#endif
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 647a47f54..211ef87de 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -10,6 +10,10 @@ CFLAGS_REMOVE_sbi.o	= $(CC_FLAGS_FTRACE)
 endif
 CFLAGS_syscall_table.o	+= $(call cc-option,-Wno-override-init,)
 
+ifdef CONFIG_KEXEC
+AFLAGS_kexec_relocate.o := -mcmodel=medany -mno-relax
+endif
+
 extra-y += head.o
 extra-y += vmlinux.lds
 
@@ -55,6 +59,7 @@ obj-$(CONFIG_SMP) += cpu_ops_sbi.o
 endif
 obj-$(CONFIG_HOTPLUG_CPU)	+= cpu-hotplug.o
 obj-$(CONFIG_KGDB)		+= kgdb.o
+obj-$(CONFIG_KEXEC)		+= kexec_relocate.o machine_kexec.o
 
 obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
 
diff --git a/arch/riscv/kernel/kexec_relocate.S b/arch/riscv/kernel/kexec_relocate.S
new file mode 100644
index 000000000..84101d0a2
--- /dev/null
+++ b/arch/riscv/kernel/kexec_relocate.S
@@ -0,0 +1,157 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 FORTH-ICS/CARV
+ *  Nick Kossifidis <mick@ics.forth.gr>
+ */
+
+#include <asm/asm.h>	/* For RISCV_* and REG_* macros */
+#include <asm/csr.h>	/* For CSR_* macros */
+#include <asm/page.h>	/* For PAGE_SIZE */
+#include <linux/linkage.h> /* For SYM_* macros */
+
+.section ".rodata"
+SYM_CODE_START(riscv_kexec_relocate)
+
+	/*
+	 * s0: Pointer to the current entry
+	 * s1: (const) Phys address to jump to after relocation
+	 * s2: (const) Phys address of the FDT image
+	 * s3: (const) The hartid of the current hart
+	 * s4: Pointer to the destination address for the relocation
+	 * s5: (const) Number of words per page
+	 * s6: (const) 1, used for subtraction
+	 * s7: (const) va_pa_offset, used when switching MMU off
+	 * s8: (const) Physical address of the main loop
+	 * s9: (debug) indirection page counter
+	 * s10: (debug) entry counter
+	 * s11: (debug) copied words counter
+	 */
+	mv	s0, a0
+	mv	s1, a1
+	mv	s2, a2
+	mv	s3, a3
+	mv	s4, zero
+	li	s5, (PAGE_SIZE / RISCV_SZPTR)
+	li	s6, 1
+	mv	s7, a4
+	mv	s8, zero
+	mv	s9, zero
+	mv	s10, zero
+	mv	s11, zero
+
+	/* Disable / cleanup interrupts */
+	csrw	CSR_SIE, zero
+	csrw	CSR_SIP, zero
+
+	/*
+	 * When we switch SATP.MODE to "Bare" we'll only
+	 * play with physical addresses. However the first time
+	 * we try to jump somewhere, the offset on the jump
+	 * will be relative to pc which will still be on VA. To
+	 * deal with this we set stvec to the physical address at
+	 * the start of the loop below so that we jump there in
+	 * any case.
+	 */
+	la	s8, 1f
+	sub	s8, s8, s7
+	csrw	CSR_STVEC, s8
+
+	/* Process entries in a loop */
+.align 2
+1:
+	addi	s10, s10, 1
+	REG_L	t0, 0(s0)		/* t0 = *image->entry */
+	addi	s0, s0, RISCV_SZPTR	/* image->entry++ */
+
+	/* IND_DESTINATION entry ? -> save destination address */
+	andi	t1, t0, 0x1
+	beqz	t1, 2f
+	andi	s4, t0, ~0x1
+	j	1b
+
+2:
+	/* IND_INDIRECTION entry ? -> update next entry ptr (PA) */
+	andi	t1, t0, 0x2
+	beqz	t1, 2f
+	andi	s0, t0, ~0x2
+	addi	s9, s9, 1
+	csrw	CSR_SATP, zero
+	jalr	zero, s8, 0
+
+2:
+	/* IND_DONE entry ? -> jump to done label */
+	andi	t1, t0, 0x4
+	beqz	t1, 2f
+	j	4f
+
+2:
+	/*
+	 * IND_SOURCE entry ? -> copy page word by word to the
+	 * destination address we got from IND_DESTINATION
+	 */
+	andi	t1, t0, 0x8
+	beqz	t1, 1b		/* Unknown entry type, ignore it */
+	andi	t0, t0, ~0x8
+	mv	t3, s5		/* i = num words per page */
+3:	/* copy loop */
+	REG_L	t1, (t0)	/* t1 = *src_ptr */
+	REG_S	t1, (s4)	/* *dst_ptr = *src_ptr */
+	addi	t0, t0, RISCV_SZPTR /* stc_ptr++ */
+	addi	s4, s4, RISCV_SZPTR /* dst_ptr++ */
+	sub	t3, t3, s6	/* i-- */
+	addi	s11, s11, 1	/* c++ */
+	beqz	t3, 1b		/* copy done ? */
+	j	3b
+
+4:
+	/* Pass the arguments to the next kernel  / Cleanup*/
+	mv	a0, s3
+	mv	a1, s2
+	mv	a2, s1
+
+	/* Cleanup */
+	mv	a3, zero
+	mv	a4, zero
+	mv	a5, zero
+	mv	a6, zero
+	mv	a7, zero
+
+	mv	s0, zero
+	mv	s1, zero
+	mv	s2, zero
+	mv	s3, zero
+	mv	s4, zero
+	mv	s5, zero
+	mv	s6, zero
+	mv	s7, zero
+	mv	s8, zero
+	mv	s9, zero
+	mv	s10, zero
+	mv	s11, zero
+
+	mv	t0, zero
+	mv	t1, zero
+	mv	t2, zero
+	mv	t3, zero
+	mv	t4, zero
+	mv	t5, zero
+	mv	t6, zero
+	csrw	CSR_SEPC, zero
+	csrw	CSR_SCAUSE, zero
+	csrw	CSR_SSCRATCH, zero
+
+	/*
+	 * Make sure the relocated code is visible
+	 * and jump to the new kernel
+	 */
+	fence.i
+
+	jalr	zero, a2, 0
+
+SYM_CODE_END(riscv_kexec_relocate)
+riscv_kexec_relocate_end:
+
+	.section ".rodata"
+SYM_DATA(riscv_kexec_relocate_size,
+	.long riscv_kexec_relocate_end - riscv_kexec_relocate)
+
diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
new file mode 100644
index 000000000..cd6803311
--- /dev/null
+++ b/arch/riscv/kernel/machine_kexec.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 FORTH-ICS/CARV
+ *  Nick Kossifidis <mick@ics.forth.gr>
+ */
+
+#include <linux/kexec.h>
+#include <asm/kexec.h>		/* For riscv_kexec_* symbol defines */
+#include <linux/smp.h>		/* For smp_send_stop () */
+#include <asm/cacheflush.h>	/* For local_flush_icache_all() */
+#include <asm/barrier.h>	/* For smp_wmb() */
+#include <asm/page.h>		/* For PAGE_MASK */
+#include <linux/libfdt.h>	/* For fdt_check_header() */
+#include <asm/set_memory.h>	/* For set_memory_x() */
+#include <linux/compiler.h>	/* For unreachable() */
+#include <linux/cpu.h>		/* For cpu_down() */
+
+/**
+ * kexec_image_info - Print received image details
+ */
+static void
+kexec_image_info(const struct kimage *image)
+{
+	unsigned long i;
+
+	pr_debug("Kexec image info:\n");
+	pr_debug("\ttype:        %d\n", image->type);
+	pr_debug("\tstart:       %lx\n", image->start);
+	pr_debug("\thead:        %lx\n", image->head);
+	pr_debug("\tnr_segments: %lu\n", image->nr_segments);
+
+	for (i = 0; i < image->nr_segments; i++) {
+		pr_debug("\t    segment[%lu]: %016lx - %016lx", i,
+			image->segment[i].mem,
+			image->segment[i].mem + image->segment[i].memsz);
+		pr_debug("\t\t0x%lx bytes, %lu pages\n",
+			(unsigned long) image->segment[i].memsz,
+			(unsigned long) image->segment[i].memsz /  PAGE_SIZE);
+	}
+}
+
+/**
+ * machine_kexec_prepare - Initialize kexec
+ *
+ * This function is called from do_kexec_load, when the user has
+ * provided us with an image to be loaded. Its goal is to validate
+ * the image and prepare the control code buffer as needed.
+ * Note that kimage_alloc_init has already been called and the
+ * control buffer has already been allocated.
+ */
+int
+machine_kexec_prepare(struct kimage *image)
+{
+	struct kimage_arch *internal = &image->arch;
+	struct fdt_header fdt = {0};
+	void *control_code_buffer = NULL;
+	unsigned int control_code_buffer_sz = 0;
+	int i = 0;
+
+	kexec_image_info(image);
+
+	if (image->type == KEXEC_TYPE_CRASH) {
+		pr_warn("Loading a crash kernel is unsupported for now.\n");
+		return -EINVAL;
+	}
+
+	/* Find the Flattened Device Tree and save its physical address */
+	for (i = 0; i < image->nr_segments; i++) {
+		if (image->segment[i].memsz <= sizeof(fdt))
+			continue;
+
+		if (copy_from_user(&fdt, image->segment[i].buf, sizeof(fdt)))
+			continue;
+
+		if (fdt_check_header(&fdt))
+			continue;
+
+		internal->fdt_addr = (unsigned long) image->segment[i].mem;
+		break;
+	}
+
+	if (!internal->fdt_addr) {
+		pr_err("Device tree not included in the provided image\n");
+		return -EINVAL;
+	}
+
+	/* Copy the assembler code for relocation to the control page */
+	control_code_buffer = page_address(image->control_code_page);
+	control_code_buffer_sz = page_size(image->control_code_page);
+	if (unlikely(riscv_kexec_relocate_size > control_code_buffer_sz)) {
+		pr_err("Relocation code doesn't fit within a control page\n");
+		return -EINVAL;
+	}
+	memcpy(control_code_buffer, riscv_kexec_relocate,
+		riscv_kexec_relocate_size);
+
+	/* Mark the control page executable */
+	set_memory_x((unsigned long) control_code_buffer, 1);
+
+	return 0;
+}
+
+
+/**
+ * machine_kexec_cleanup - Cleanup any leftovers from
+ *			   machine_kexec_prepare
+ *
+ * This function is called by kimage_free to handle any arch-specific
+ * allocations done on machine_kexec_prepare. Since we didn't do any
+ * allocations there, this is just an empty function. Note that the
+ * control buffer is freed by kimage_free.
+ */
+void
+machine_kexec_cleanup(struct kimage *image)
+{
+}
+
+
+/*
+ * machine_shutdown - Prepare for a kexec reboot
+ *
+ * This function is called by kernel_kexec just before machine_kexec
+ * below. Its goal is to prepare the rest of the system (the other
+ * harts and possibly devices etc) for a kexec reboot.
+ */
+void machine_shutdown(void)
+{
+	/*
+	 * No more interrupts on this hart
+	 * until we are back up.
+	 */
+	local_irq_disable();
+
+#if defined(CONFIG_HOTPLUG_CPU)
+	smp_shutdown_nonboot_cpus(smp_processor_id());
+#endif
+}
+
+/**
+ * machine_crash_shutdown - Prepare to kexec after a kernel crash
+ *
+ * This function is called by crash_kexec just before machine_kexec
+ * below and its goal is similar to machine_shutdown, but in case of
+ * a kernel crash. Since we don't handle such cases yet, this function
+ * is empty.
+ */
+void
+machine_crash_shutdown(struct pt_regs *regs)
+{
+}
+
+/**
+ * machine_kexec - Jump to the loaded kimage
+ *
+ * This function is called by kernel_kexec which is called by the
+ * reboot system call when the reboot cmd is LINUX_REBOOT_CMD_KEXEC,
+ * or by crash_kernel which is called by the kernel's arch-specific
+ * trap handler in case of a kernel panic. It's the final stage of
+ * the kexec process where the pre-loaded kimage is ready to be
+ * executed. We assume at this point that all other harts are
+ * suspended and this hart will be the new boot hart.
+ */
+void __noreturn
+machine_kexec(struct kimage *image)
+{
+	struct kimage_arch *internal = &image->arch;
+	unsigned long jump_addr = (unsigned long) image->start;
+	unsigned long first_ind_entry = (unsigned long) &image->head;
+	unsigned long this_hart_id = raw_smp_processor_id();
+	unsigned long fdt_addr = internal->fdt_addr;
+	void *control_code_buffer = page_address(image->control_code_page);
+	riscv_kexec_do_relocate do_relocate = control_code_buffer;
+
+	pr_notice("Will call new kernel at %08lx from hart id %lx\n",
+		  jump_addr, this_hart_id);
+	pr_notice("FDT image at %08lx\n", fdt_addr);
+
+	/* Make sure the relocation code is visible to the hart */
+	local_flush_icache_all();
+
+	/* Jump to the relocation code */
+	pr_notice("Bye...\n");
+	do_relocate(first_ind_entry, jump_addr, fdt_addr,
+		    this_hart_id, va_pa_offset);
+	unreachable();
+}
-- 
2.26.2

