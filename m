Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB308341953
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhCSKC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhCSKC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:02:27 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD3BC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:02:26 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id u5so33516018qkj.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=adU0LgcF88sYIsaPbVIpcqknE7rFgI7HAN5vkI6zgpk=;
        b=r+Yq+r5/p2h7LJFqTQy8UNiqr8kHP5xrvJj3+m0iWWZHqYOUfgBzp74CUTqjdbKLfk
         /9pRRyttWwXb73Fa4WXUpZnQgmCDLzqBW3uCJeLTVLXT4yj8Td6EN4222g0kvlnUamkd
         ucr5Ot9kGgoUZbuIz0i0aq+4wUdmpJucDgxmRHYe5KKKAAHlSfWy9/0t5kS2D7kn9tUl
         mDSWjSWOMpgcitfrmmrAN/3jQ3T+lUtDCUhp6bD/n1aC6az2CymRLPTaOTq+nxsq+SHp
         DJAuJKOukeJI3++fd236J0Rz6ZJjnyH8IK8cABZPCfMOV0xv4O+3g0O0ZRD6AhHKhDD1
         UEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=adU0LgcF88sYIsaPbVIpcqknE7rFgI7HAN5vkI6zgpk=;
        b=SxZk9XF4lONvi2LXl8tScW1VEVSxTbYJ38WUSPJMXi1wQfdu0h1/2PQdbr27Zim7+w
         yUKsX0fbKYsCiuGc+O/WLyMhr4BpO8zNVVEcGfTMatJqQJxfmdORDRCjwhrbFkx9II2F
         tmjuabTU8ftXBjJMQtknwNzzq0fMUAoFIizs8V9+g7wdO2liKFfCZDWhtQUtIgvfTGFZ
         t9+g3qMjNw66PutjB37fsSpQdNX55uj8Chu7w3ySkGkt8E8+E2JlRX60+e+NXc8ay3WL
         u8BCoDKVza5RS2hav0/9WpVJwnaFJ24yf/o6Lp7R52ko+yO20KzPbfVACAVBRWTKX5g1
         7vCA==
X-Gm-Message-State: AOAM531y5m+tFY+QysuLj4lJRKsE4Lp6LN1ZoIScuml2VO+1X++HeMaM
        ytvxf/cpJgsV/kouf8PoGi0vD/RpqO8g
X-Google-Smtp-Source: ABdhPJw+p4HbHByw8ifHJIMF89JvceWo8bez5H5GaLEfjx5IaGYV9Ox1zT9VTTglSpZLfFPlsS4e6cMBYzz2
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a0c:f54d:: with SMTP id
 p13mr8435867qvm.32.1616148145905; Fri, 19 Mar 2021 03:02:25 -0700 (PDT)
Date:   Fri, 19 Mar 2021 10:01:25 +0000
In-Reply-To: <20210319100146.1149909-1-qperret@google.com>
Message-Id: <20210319100146.1149909-18-qperret@google.com>
Mime-Version: 1.0
References: <20210319100146.1149909-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v6 17/38] KVM: arm64: Prepare the creation of s1 mappings at EL2
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, seanjc@google.com, mate.toth-pal@arm.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, tabba@google.com, ardb@kernel.org,
        mark.rutland@arm.com, dbrazdil@google.com, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When memory protection is enabled, the EL2 code needs the ability to
create and manage its own page-table. To do so, introduce a new set of
hypercalls to bootstrap a memory management system at EL2.

This leads to the following boot flow in nVHE Protected mode:

 1. the host allocates memory for the hypervisor very early on, using
    the memblock API;

 2. the host creates a set of stage 1 page-table for EL2, installs the
    EL2 vectors, and issues the __pkvm_init hypercall;

 3. during __pkvm_init, the hypervisor re-creates its stage 1 page-table
    and stores it in the memory pool provided by the host;

 4. the hypervisor then extends its stage 1 mappings to include a
    vmemmap in the EL2 VA space, hence allowing to use the buddy
    allocator introduced in a previous patch;

 5. the hypervisor jumps back in the idmap page, switches from the
    host-provided page-table to the new one, and wraps up its
    initialization by enabling the new allocator, before returning to
    the host.

 6. the host can free the now unused page-table created for EL2, and
    will now need to issue hypercalls to make changes to the EL2 stage 1
    mappings instead of modifying them directly.

Note that for the sake of simplifying the review, this patch focuses on
the hypervisor side of things. In other words, this only implements the
new hypercalls, but does not make use of them from the host yet. The
host-side changes will follow in a subsequent patch.

Credits to Will for __pkvm_init_switch_pgd.

Acked-by: Will Deacon <will@kernel.org>
Co-authored-by: Will Deacon <will@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_asm.h     |   4 +
 arch/arm64/include/asm/kvm_host.h    |   7 +
 arch/arm64/include/asm/kvm_hyp.h     |   8 ++
 arch/arm64/include/asm/kvm_pgtable.h |   2 +
 arch/arm64/kernel/image-vars.h       |  16 +++
 arch/arm64/kvm/hyp/Makefile          |   2 +-
 arch/arm64/kvm/hyp/include/nvhe/mm.h |  71 ++++++++++
 arch/arm64/kvm/hyp/nvhe/Makefile     |   4 +-
 arch/arm64/kvm/hyp/nvhe/hyp-init.S   |  27 ++++
 arch/arm64/kvm/hyp/nvhe/hyp-main.c   |  49 +++++++
 arch/arm64/kvm/hyp/nvhe/mm.c         | 173 +++++++++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/setup.c      | 197 +++++++++++++++++++++++++++
 arch/arm64/kvm/hyp/pgtable.c         |   2 -
 arch/arm64/kvm/hyp/reserved_mem.c    |  92 +++++++++++++
 arch/arm64/mm/init.c                 |   3 +
 15 files changed, 652 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/mm.h
 create mode 100644 arch/arm64/kvm/hyp/nvhe/mm.c
 create mode 100644 arch/arm64/kvm/hyp/nvhe/setup.c
 create mode 100644 arch/arm64/kvm/hyp/reserved_mem.c

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index a7ab84f781f7..ebe7007b820b 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -57,6 +57,10 @@
 #define __KVM_HOST_SMCCC_FUNC___kvm_get_mdcr_el2		12
 #define __KVM_HOST_SMCCC_FUNC___vgic_v3_save_aprs		13
 #define __KVM_HOST_SMCCC_FUNC___vgic_v3_restore_aprs		14
+#define __KVM_HOST_SMCCC_FUNC___pkvm_init			15
+#define __KVM_HOST_SMCCC_FUNC___pkvm_create_mappings		16
+#define __KVM_HOST_SMCCC_FUNC___pkvm_create_private_mapping	17
+#define __KVM_HOST_SMCCC_FUNC___pkvm_cpu_set_vector		18
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 02e172dc5087..f813e1191027 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -770,5 +770,12 @@ bool kvm_arm_vcpu_is_finalized(struct kvm_vcpu *vcpu);
 	(test_bit(KVM_ARM_VCPU_PMU_V3, (vcpu)->arch.features))
 
 int kvm_trng_call(struct kvm_vcpu *vcpu);
+#ifdef CONFIG_KVM
+extern phys_addr_t hyp_mem_base;
+extern phys_addr_t hyp_mem_size;
+void __init kvm_hyp_reserve(void);
+#else
+static inline void kvm_hyp_reserve(void) { }
+#endif
 
 #endif /* __ARM64_KVM_HOST_H__ */
diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index 8b6c3a7aac51..de40a565d7e5 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -108,4 +108,12 @@ void __noreturn __hyp_do_panic(struct kvm_cpu_context *host_ctxt, u64 spsr,
 			       u64 elr, u64 par);
 #endif
 
+#ifdef __KVM_NVHE_HYPERVISOR__
+void __pkvm_init_switch_pgd(phys_addr_t phys, unsigned long size,
+			    phys_addr_t pgd, void *sp, void *cont_fn);
+int __pkvm_init(phys_addr_t phys, unsigned long size, unsigned long nr_cpus,
+		unsigned long *per_cpu_base, u32 hyp_va_bits);
+void __noreturn __host_enter(struct kvm_cpu_context *host_ctxt);
+#endif
+
 #endif /* __ARM64_KVM_HYP_H__ */
diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index bbe840e430cb..bf7a3cc49420 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -11,6 +11,8 @@
 #include <linux/kvm_host.h>
 #include <linux/types.h>
 
+#define KVM_PGTABLE_MAX_LEVELS		4U
+
 typedef u64 kvm_pte_t;
 
 /**
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 4eb7a15c8b60..940c378fa837 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -115,6 +115,22 @@ KVM_NVHE_ALIAS_HYP(__memcpy, __pi_memcpy);
 KVM_NVHE_ALIAS_HYP(__memset, __pi_memset);
 #endif
 
+/* Kernel memory sections */
+KVM_NVHE_ALIAS(__start_rodata);
+KVM_NVHE_ALIAS(__end_rodata);
+KVM_NVHE_ALIAS(__bss_start);
+KVM_NVHE_ALIAS(__bss_stop);
+
+/* Hyp memory sections */
+KVM_NVHE_ALIAS(__hyp_idmap_text_start);
+KVM_NVHE_ALIAS(__hyp_idmap_text_end);
+KVM_NVHE_ALIAS(__hyp_text_start);
+KVM_NVHE_ALIAS(__hyp_text_end);
+KVM_NVHE_ALIAS(__hyp_bss_start);
+KVM_NVHE_ALIAS(__hyp_bss_end);
+KVM_NVHE_ALIAS(__hyp_rodata_start);
+KVM_NVHE_ALIAS(__hyp_rodata_end);
+
 #endif /* CONFIG_KVM */
 
 #endif /* __ARM64_KERNEL_IMAGE_VARS_H */
diff --git a/arch/arm64/kvm/hyp/Makefile b/arch/arm64/kvm/hyp/Makefile
index 687598e41b21..b726332eec49 100644
--- a/arch/arm64/kvm/hyp/Makefile
+++ b/arch/arm64/kvm/hyp/Makefile
@@ -10,4 +10,4 @@ subdir-ccflags-y := -I$(incdir)				\
 		    -DDISABLE_BRANCH_PROFILING		\
 		    $(DISABLE_STACKLEAK_PLUGIN)
 
-obj-$(CONFIG_KVM) += vhe/ nvhe/ pgtable.o
+obj-$(CONFIG_KVM) += vhe/ nvhe/ pgtable.o reserved_mem.o
diff --git a/arch/arm64/kvm/hyp/include/nvhe/mm.h b/arch/arm64/kvm/hyp/include/nvhe/mm.h
new file mode 100644
index 000000000000..ac0f7fcffd08
--- /dev/null
+++ b/arch/arm64/kvm/hyp/include/nvhe/mm.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __KVM_HYP_MM_H
+#define __KVM_HYP_MM_H
+
+#include <asm/kvm_pgtable.h>
+#include <asm/spectre.h>
+#include <linux/memblock.h>
+#include <linux/types.h>
+
+#include <nvhe/memory.h>
+#include <nvhe/spinlock.h>
+
+#define HYP_MEMBLOCK_REGIONS 128
+extern struct memblock_region kvm_nvhe_sym(hyp_memory)[];
+extern unsigned int kvm_nvhe_sym(hyp_memblock_nr);
+extern struct kvm_pgtable pkvm_pgtable;
+extern hyp_spinlock_t pkvm_pgd_lock;
+extern struct hyp_pool hpool;
+extern u64 __io_map_base;
+
+int hyp_create_idmap(u32 hyp_va_bits);
+int hyp_map_vectors(void);
+int hyp_back_vmemmap(phys_addr_t phys, unsigned long size, phys_addr_t back);
+int pkvm_cpu_set_vector(enum arm64_hyp_spectre_vector slot);
+int pkvm_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot);
+int __pkvm_create_mappings(unsigned long start, unsigned long size,
+			   unsigned long phys, enum kvm_pgtable_prot prot);
+unsigned long __pkvm_create_private_mapping(phys_addr_t phys, size_t size,
+					    enum kvm_pgtable_prot prot);
+
+static inline void hyp_vmemmap_range(phys_addr_t phys, unsigned long size,
+				     unsigned long *start, unsigned long *end)
+{
+	unsigned long nr_pages = size >> PAGE_SHIFT;
+	struct hyp_page *p = hyp_phys_to_page(phys);
+
+	*start = (unsigned long)p;
+	*end = *start + nr_pages * sizeof(struct hyp_page);
+	*start = ALIGN_DOWN(*start, PAGE_SIZE);
+	*end = ALIGN(*end, PAGE_SIZE);
+}
+
+static inline unsigned long __hyp_pgtable_max_pages(unsigned long nr_pages)
+{
+	unsigned long total = 0, i;
+
+	/* Provision the worst case scenario */
+	for (i = 0; i < KVM_PGTABLE_MAX_LEVELS; i++) {
+		nr_pages = DIV_ROUND_UP(nr_pages, PTRS_PER_PTE);
+		total += nr_pages;
+	}
+
+	return total;
+}
+
+static inline unsigned long hyp_s1_pgtable_pages(void)
+{
+	unsigned long res = 0, i;
+
+	/* Cover all of memory with page-granularity */
+	for (i = 0; i < kvm_nvhe_sym(hyp_memblock_nr); i++) {
+		struct memblock_region *reg = &kvm_nvhe_sym(hyp_memory)[i];
+		res += __hyp_pgtable_max_pages(reg->size >> PAGE_SHIFT);
+	}
+
+	/* Allow 1 GiB for private mappings */
+	res += __hyp_pgtable_max_pages(SZ_1G >> PAGE_SHIFT);
+
+	return res;
+}
+#endif /* __KVM_HYP_MM_H */
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index 42dde4bb80b1..b334354b8dd0 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -14,9 +14,9 @@ lib-objs := $(addprefix ../../../lib/, $(lib-objs))
 
 obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o \
 	 hyp-main.o hyp-smp.o psci-relay.o early_alloc.o stub.o page_alloc.o \
-	 cache.o
+	 cache.o setup.o mm.o
 obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
-	 ../fpsimd.o ../hyp-entry.o ../exception.o
+	 ../fpsimd.o ../hyp-entry.o ../exception.o ../pgtable.o
 obj-y += $(lib-objs)
 
 ##
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
index 2e16b2098bbd..557fb79b29cf 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
@@ -236,4 +236,31 @@ alternative_else_nop_endif
 
 SYM_CODE_END(__kvm_handle_stub_hvc)
 
+SYM_FUNC_START(__pkvm_init_switch_pgd)
+	/* Turn the MMU off */
+	pre_disable_mmu_workaround
+	mrs	x2, sctlr_el2
+	bic	x3, x2, #SCTLR_ELx_M
+	msr	sctlr_el2, x3
+	isb
+
+	tlbi	alle2
+
+	/* Install the new pgtables */
+	ldr	x3, [x0, #NVHE_INIT_PGD_PA]
+	phys_to_ttbr x4, x3
+alternative_if ARM64_HAS_CNP
+	orr	x4, x4, #TTBR_CNP_BIT
+alternative_else_nop_endif
+	msr	ttbr0_el2, x4
+
+	/* Set the new stack pointer */
+	ldr	x0, [x0, #NVHE_INIT_STACK_HYP_VA]
+	mov	sp, x0
+
+	/* And turn the MMU back on! */
+	set_sctlr_el2	x2
+	ret	x1
+SYM_FUNC_END(__pkvm_init_switch_pgd)
+
 	.popsection
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 4a67850702c8..a571cee99a5c 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -6,12 +6,14 @@
 
 #include <hyp/switch.h>
 
+#include <asm/pgtable-types.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_host.h>
 #include <asm/kvm_hyp.h>
 #include <asm/kvm_mmu.h>
 
+#include <nvhe/mm.h>
 #include <nvhe/trap_handler.h>
 
 DEFINE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);
@@ -106,6 +108,49 @@ static void handle___vgic_v3_restore_aprs(struct kvm_cpu_context *host_ctxt)
 	__vgic_v3_restore_aprs(kern_hyp_va(cpu_if));
 }
 
+static void handle___pkvm_init(struct kvm_cpu_context *host_ctxt)
+{
+	DECLARE_REG(phys_addr_t, phys, host_ctxt, 1);
+	DECLARE_REG(unsigned long, size, host_ctxt, 2);
+	DECLARE_REG(unsigned long, nr_cpus, host_ctxt, 3);
+	DECLARE_REG(unsigned long *, per_cpu_base, host_ctxt, 4);
+	DECLARE_REG(u32, hyp_va_bits, host_ctxt, 5);
+
+	/*
+	 * __pkvm_init() will return only if an error occurred, otherwise it
+	 * will tail-call in __pkvm_init_finalise() which will have to deal
+	 * with the host context directly.
+	 */
+	cpu_reg(host_ctxt, 1) = __pkvm_init(phys, size, nr_cpus, per_cpu_base,
+					    hyp_va_bits);
+}
+
+static void handle___pkvm_cpu_set_vector(struct kvm_cpu_context *host_ctxt)
+{
+	DECLARE_REG(enum arm64_hyp_spectre_vector, slot, host_ctxt, 1);
+
+	cpu_reg(host_ctxt, 1) = pkvm_cpu_set_vector(slot);
+}
+
+static void handle___pkvm_create_mappings(struct kvm_cpu_context *host_ctxt)
+{
+	DECLARE_REG(unsigned long, start, host_ctxt, 1);
+	DECLARE_REG(unsigned long, size, host_ctxt, 2);
+	DECLARE_REG(unsigned long, phys, host_ctxt, 3);
+	DECLARE_REG(enum kvm_pgtable_prot, prot, host_ctxt, 4);
+
+	cpu_reg(host_ctxt, 1) = __pkvm_create_mappings(start, size, phys, prot);
+}
+
+static void handle___pkvm_create_private_mapping(struct kvm_cpu_context *host_ctxt)
+{
+	DECLARE_REG(phys_addr_t, phys, host_ctxt, 1);
+	DECLARE_REG(size_t, size, host_ctxt, 2);
+	DECLARE_REG(enum kvm_pgtable_prot, prot, host_ctxt, 3);
+
+	cpu_reg(host_ctxt, 1) = __pkvm_create_private_mapping(phys, size, prot);
+}
+
 typedef void (*hcall_t)(struct kvm_cpu_context *);
 
 #define HANDLE_FUNC(x)	[__KVM_HOST_SMCCC_FUNC_##x] = (hcall_t)handle_##x
@@ -125,6 +170,10 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__kvm_get_mdcr_el2),
 	HANDLE_FUNC(__vgic_v3_save_aprs),
 	HANDLE_FUNC(__vgic_v3_restore_aprs),
+	HANDLE_FUNC(__pkvm_init),
+	HANDLE_FUNC(__pkvm_cpu_set_vector),
+	HANDLE_FUNC(__pkvm_create_mappings),
+	HANDLE_FUNC(__pkvm_create_private_mapping),
 };
 
 static void handle_host_hcall(struct kvm_cpu_context *host_ctxt)
diff --git a/arch/arm64/kvm/hyp/nvhe/mm.c b/arch/arm64/kvm/hyp/nvhe/mm.c
new file mode 100644
index 000000000000..a8efdf0f9003
--- /dev/null
+++ b/arch/arm64/kvm/hyp/nvhe/mm.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020 Google LLC
+ * Author: Quentin Perret <qperret@google.com>
+ */
+
+#include <linux/kvm_host.h>
+#include <asm/kvm_hyp.h>
+#include <asm/kvm_mmu.h>
+#include <asm/kvm_pgtable.h>
+#include <asm/spectre.h>
+
+#include <nvhe/early_alloc.h>
+#include <nvhe/gfp.h>
+#include <nvhe/memory.h>
+#include <nvhe/mm.h>
+#include <nvhe/spinlock.h>
+
+struct kvm_pgtable pkvm_pgtable;
+hyp_spinlock_t pkvm_pgd_lock;
+u64 __io_map_base;
+
+struct memblock_region hyp_memory[HYP_MEMBLOCK_REGIONS];
+unsigned int hyp_memblock_nr;
+
+int __pkvm_create_mappings(unsigned long start, unsigned long size,
+			  unsigned long phys, enum kvm_pgtable_prot prot)
+{
+	int err;
+
+	hyp_spin_lock(&pkvm_pgd_lock);
+	err = kvm_pgtable_hyp_map(&pkvm_pgtable, start, size, phys, prot);
+	hyp_spin_unlock(&pkvm_pgd_lock);
+
+	return err;
+}
+
+unsigned long __pkvm_create_private_mapping(phys_addr_t phys, size_t size,
+					    enum kvm_pgtable_prot prot)
+{
+	unsigned long addr;
+	int err;
+
+	hyp_spin_lock(&pkvm_pgd_lock);
+
+	size = PAGE_ALIGN(size + offset_in_page(phys));
+	addr = __io_map_base;
+	__io_map_base += size;
+
+	/* Are we overflowing on the vmemmap ? */
+	if (__io_map_base > __hyp_vmemmap) {
+		__io_map_base -= size;
+		addr = (unsigned long)ERR_PTR(-ENOMEM);
+		goto out;
+	}
+
+	err = kvm_pgtable_hyp_map(&pkvm_pgtable, addr, size, phys, prot);
+	if (err) {
+		addr = (unsigned long)ERR_PTR(err);
+		goto out;
+	}
+
+	addr = addr + offset_in_page(phys);
+out:
+	hyp_spin_unlock(&pkvm_pgd_lock);
+
+	return addr;
+}
+
+int pkvm_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
+{
+	unsigned long start = (unsigned long)from;
+	unsigned long end = (unsigned long)to;
+	unsigned long virt_addr;
+	phys_addr_t phys;
+
+	start = start & PAGE_MASK;
+	end = PAGE_ALIGN(end);
+
+	for (virt_addr = start; virt_addr < end; virt_addr += PAGE_SIZE) {
+		int err;
+
+		phys = hyp_virt_to_phys((void *)virt_addr);
+		err = __pkvm_create_mappings(virt_addr, PAGE_SIZE, phys, prot);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+int hyp_back_vmemmap(phys_addr_t phys, unsigned long size, phys_addr_t back)
+{
+	unsigned long start, end;
+
+	hyp_vmemmap_range(phys, size, &start, &end);
+
+	return __pkvm_create_mappings(start, end - start, back, PAGE_HYP);
+}
+
+static void *__hyp_bp_vect_base;
+int pkvm_cpu_set_vector(enum arm64_hyp_spectre_vector slot)
+{
+	void *vector;
+
+	switch (slot) {
+	case HYP_VECTOR_DIRECT: {
+		vector = __kvm_hyp_vector;
+		break;
+	}
+	case HYP_VECTOR_SPECTRE_DIRECT: {
+		vector = __bp_harden_hyp_vecs;
+		break;
+	}
+	case HYP_VECTOR_INDIRECT:
+	case HYP_VECTOR_SPECTRE_INDIRECT: {
+		vector = (void *)__hyp_bp_vect_base;
+		break;
+	}
+	default:
+		return -EINVAL;
+	}
+
+	vector = __kvm_vector_slot2addr(vector, slot);
+	*this_cpu_ptr(&kvm_hyp_vector) = (unsigned long)vector;
+
+	return 0;
+}
+
+int hyp_map_vectors(void)
+{
+	phys_addr_t phys;
+	void *bp_base;
+
+	if (!cpus_have_const_cap(ARM64_SPECTRE_V3A))
+		return 0;
+
+	phys = __hyp_pa(__bp_harden_hyp_vecs);
+	bp_base = (void *)__pkvm_create_private_mapping(phys,
+							__BP_HARDEN_HYP_VECS_SZ,
+							PAGE_HYP_EXEC);
+	if (IS_ERR_OR_NULL(bp_base))
+		return PTR_ERR(bp_base);
+
+	__hyp_bp_vect_base = bp_base;
+
+	return 0;
+}
+
+int hyp_create_idmap(u32 hyp_va_bits)
+{
+	unsigned long start, end;
+
+	start = hyp_virt_to_phys((void *)__hyp_idmap_text_start);
+	start = ALIGN_DOWN(start, PAGE_SIZE);
+
+	end = hyp_virt_to_phys((void *)__hyp_idmap_text_end);
+	end = ALIGN(end, PAGE_SIZE);
+
+	/*
+	 * One half of the VA space is reserved to linearly map portions of
+	 * memory -- see va_layout.c for more details. The other half of the VA
+	 * space contains the trampoline page, and needs some care. Split that
+	 * second half in two and find the quarter of VA space not conflicting
+	 * with the idmap to place the IOs and the vmemmap. IOs use the lower
+	 * half of the quarter and the vmemmap the upper half.
+	 */
+	__io_map_base = start & BIT(hyp_va_bits - 2);
+	__io_map_base ^= BIT(hyp_va_bits - 2);
+	__hyp_vmemmap = __io_map_base | BIT(hyp_va_bits - 3);
+
+	return __pkvm_create_mappings(start, end - start, start, PAGE_HYP_EXEC);
+}
diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
new file mode 100644
index 000000000000..1e8bcd8b0299
--- /dev/null
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020 Google LLC
+ * Author: Quentin Perret <qperret@google.com>
+ */
+
+#include <linux/kvm_host.h>
+#include <asm/kvm_hyp.h>
+#include <asm/kvm_mmu.h>
+#include <asm/kvm_pgtable.h>
+
+#include <nvhe/early_alloc.h>
+#include <nvhe/gfp.h>
+#include <nvhe/memory.h>
+#include <nvhe/mm.h>
+#include <nvhe/trap_handler.h>
+
+struct hyp_pool hpool;
+struct kvm_pgtable_mm_ops pkvm_pgtable_mm_ops;
+unsigned long hyp_nr_cpus;
+
+#define hyp_percpu_size ((unsigned long)__per_cpu_end - \
+			 (unsigned long)__per_cpu_start)
+
+static void *vmemmap_base;
+static void *hyp_pgt_base;
+
+static int divide_memory_pool(void *virt, unsigned long size)
+{
+	unsigned long vstart, vend, nr_pages;
+
+	hyp_early_alloc_init(virt, size);
+
+	hyp_vmemmap_range(__hyp_pa(virt), size, &vstart, &vend);
+	nr_pages = (vend - vstart) >> PAGE_SHIFT;
+	vmemmap_base = hyp_early_alloc_contig(nr_pages);
+	if (!vmemmap_base)
+		return -ENOMEM;
+
+	nr_pages = hyp_s1_pgtable_pages();
+	hyp_pgt_base = hyp_early_alloc_contig(nr_pages);
+	if (!hyp_pgt_base)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int recreate_hyp_mappings(phys_addr_t phys, unsigned long size,
+				 unsigned long *per_cpu_base,
+				 u32 hyp_va_bits)
+{
+	void *start, *end, *virt = hyp_phys_to_virt(phys);
+	unsigned long pgt_size = hyp_s1_pgtable_pages() << PAGE_SHIFT;
+	int ret, i;
+
+	/* Recreate the hyp page-table using the early page allocator */
+	hyp_early_alloc_init(hyp_pgt_base, pgt_size);
+	ret = kvm_pgtable_hyp_init(&pkvm_pgtable, hyp_va_bits,
+				   &hyp_early_alloc_mm_ops);
+	if (ret)
+		return ret;
+
+	ret = hyp_create_idmap(hyp_va_bits);
+	if (ret)
+		return ret;
+
+	ret = hyp_map_vectors();
+	if (ret)
+		return ret;
+
+	ret = hyp_back_vmemmap(phys, size, hyp_virt_to_phys(vmemmap_base));
+	if (ret)
+		return ret;
+
+	ret = pkvm_create_mappings(__hyp_text_start, __hyp_text_end, PAGE_HYP_EXEC);
+	if (ret)
+		return ret;
+
+	ret = pkvm_create_mappings(__start_rodata, __end_rodata, PAGE_HYP_RO);
+	if (ret)
+		return ret;
+
+	ret = pkvm_create_mappings(__hyp_rodata_start, __hyp_rodata_end, PAGE_HYP_RO);
+	if (ret)
+		return ret;
+
+	ret = pkvm_create_mappings(__hyp_bss_start, __hyp_bss_end, PAGE_HYP);
+	if (ret)
+		return ret;
+
+	ret = pkvm_create_mappings(__hyp_bss_end, __bss_stop, PAGE_HYP_RO);
+	if (ret)
+		return ret;
+
+	ret = pkvm_create_mappings(virt, virt + size, PAGE_HYP);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < hyp_nr_cpus; i++) {
+		start = (void *)kern_hyp_va(per_cpu_base[i]);
+		end = start + PAGE_ALIGN(hyp_percpu_size);
+		ret = pkvm_create_mappings(start, end, PAGE_HYP);
+		if (ret)
+			return ret;
+
+		end = (void *)per_cpu_ptr(&kvm_init_params, i)->stack_hyp_va;
+		start = end - PAGE_SIZE;
+		ret = pkvm_create_mappings(start, end, PAGE_HYP);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static void update_nvhe_init_params(void)
+{
+	struct kvm_nvhe_init_params *params;
+	unsigned long i;
+
+	for (i = 0; i < hyp_nr_cpus; i++) {
+		params = per_cpu_ptr(&kvm_init_params, i);
+		params->pgd_pa = __hyp_pa(pkvm_pgtable.pgd);
+		__flush_dcache_area(params, sizeof(*params));
+	}
+}
+
+static void *hyp_zalloc_hyp_page(void *arg)
+{
+	return hyp_alloc_pages(&hpool, 0);
+}
+
+void __noreturn __pkvm_init_finalise(void)
+{
+	struct kvm_host_data *host_data = this_cpu_ptr(&kvm_host_data);
+	struct kvm_cpu_context *host_ctxt = &host_data->host_ctxt;
+	unsigned long nr_pages, reserved_pages, pfn;
+	int ret;
+
+	/* Now that the vmemmap is backed, install the full-fledged allocator */
+	pfn = hyp_virt_to_pfn(hyp_pgt_base);
+	nr_pages = hyp_s1_pgtable_pages();
+	reserved_pages = hyp_early_alloc_nr_used_pages();
+	ret = hyp_pool_init(&hpool, pfn, nr_pages, reserved_pages);
+	if (ret)
+		goto out;
+
+	pkvm_pgtable_mm_ops = (struct kvm_pgtable_mm_ops) {
+		.zalloc_page = hyp_zalloc_hyp_page,
+		.phys_to_virt = hyp_phys_to_virt,
+		.virt_to_phys = hyp_virt_to_phys,
+		.get_page = hyp_get_page,
+		.put_page = hyp_put_page,
+	};
+	pkvm_pgtable.mm_ops = &pkvm_pgtable_mm_ops;
+
+out:
+	/*
+	 * We tail-called to here from handle___pkvm_init() and will not return,
+	 * so make sure to propagate the return value to the host.
+	 */
+	cpu_reg(host_ctxt, 1) = ret;
+
+	__host_enter(host_ctxt);
+}
+
+int __pkvm_init(phys_addr_t phys, unsigned long size, unsigned long nr_cpus,
+		unsigned long *per_cpu_base, u32 hyp_va_bits)
+{
+	struct kvm_nvhe_init_params *params;
+	void *virt = hyp_phys_to_virt(phys);
+	void (*fn)(phys_addr_t params_pa, void *finalize_fn_va);
+	int ret;
+
+	if (!PAGE_ALIGNED(phys) || !PAGE_ALIGNED(size))
+		return -EINVAL;
+
+	hyp_spin_lock_init(&pkvm_pgd_lock);
+	hyp_nr_cpus = nr_cpus;
+
+	ret = divide_memory_pool(virt, size);
+	if (ret)
+		return ret;
+
+	ret = recreate_hyp_mappings(phys, size, per_cpu_base, hyp_va_bits);
+	if (ret)
+		return ret;
+
+	update_nvhe_init_params();
+
+	/* Jump in the idmap page to switch to the new page-tables */
+	params = this_cpu_ptr(&kvm_init_params);
+	fn = (typeof(fn))__hyp_pa(__pkvm_init_switch_pgd);
+	fn(__hyp_pa(params), __pkvm_init_finalise);
+
+	unreachable();
+}
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index ff478a576f4d..82aca35a22f6 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -10,8 +10,6 @@
 #include <linux/bitfield.h>
 #include <asm/kvm_pgtable.h>
 
-#define KVM_PGTABLE_MAX_LEVELS		4U
-
 #define KVM_PTE_VALID			BIT(0)
 
 #define KVM_PTE_TYPE			BIT(1)
diff --git a/arch/arm64/kvm/hyp/reserved_mem.c b/arch/arm64/kvm/hyp/reserved_mem.c
new file mode 100644
index 000000000000..9bc6a6d27904
--- /dev/null
+++ b/arch/arm64/kvm/hyp/reserved_mem.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 - Google LLC
+ * Author: Quentin Perret <qperret@google.com>
+ */
+
+#include <linux/kvm_host.h>
+#include <linux/memblock.h>
+
+#include <asm/kvm_host.h>
+
+#include <nvhe/memory.h>
+#include <nvhe/mm.h>
+
+static struct memblock_region *hyp_memory = kvm_nvhe_sym(hyp_memory);
+static unsigned int *hyp_memblock_nr_ptr = &kvm_nvhe_sym(hyp_memblock_nr);
+
+phys_addr_t hyp_mem_base;
+phys_addr_t hyp_mem_size;
+
+static int __init register_memblock_regions(void)
+{
+	struct memblock_region *reg;
+
+	for_each_mem_region(reg) {
+		if (*hyp_memblock_nr_ptr >= HYP_MEMBLOCK_REGIONS)
+			return -ENOMEM;
+
+		hyp_memory[*hyp_memblock_nr_ptr] = *reg;
+		(*hyp_memblock_nr_ptr)++;
+	}
+
+	return 0;
+}
+
+void __init kvm_hyp_reserve(void)
+{
+	u64 nr_pages, prev, hyp_mem_pages = 0;
+	int ret;
+
+	if (!is_hyp_mode_available() || is_kernel_in_hyp_mode())
+		return;
+
+	if (kvm_get_mode() != KVM_MODE_PROTECTED)
+		return;
+
+	ret = register_memblock_regions();
+	if (ret) {
+		*hyp_memblock_nr_ptr = 0;
+		kvm_err("Failed to register hyp memblocks: %d\n", ret);
+		return;
+	}
+
+	hyp_mem_pages += hyp_s1_pgtable_pages();
+
+	/*
+	 * The hyp_vmemmap needs to be backed by pages, but these pages
+	 * themselves need to be present in the vmemmap, so compute the number
+	 * of pages needed by looking for a fixed point.
+	 */
+	nr_pages = 0;
+	do {
+		prev = nr_pages;
+		nr_pages = hyp_mem_pages + prev;
+		nr_pages = DIV_ROUND_UP(nr_pages * sizeof(struct hyp_page), PAGE_SIZE);
+		nr_pages += __hyp_pgtable_max_pages(nr_pages);
+	} while (nr_pages != prev);
+	hyp_mem_pages += nr_pages;
+
+	/*
+	 * Try to allocate a PMD-aligned region to reduce TLB pressure once
+	 * this is unmapped from the host stage-2, and fallback to PAGE_SIZE.
+	 */
+	hyp_mem_size = hyp_mem_pages << PAGE_SHIFT;
+	hyp_mem_base = memblock_find_in_range(0, memblock_end_of_DRAM(),
+					      ALIGN(hyp_mem_size, PMD_SIZE),
+					      PMD_SIZE);
+	if (!hyp_mem_base)
+		hyp_mem_base = memblock_find_in_range(0, memblock_end_of_DRAM(),
+						      hyp_mem_size, PAGE_SIZE);
+	else
+		hyp_mem_size = ALIGN(hyp_mem_size, PMD_SIZE);
+
+	if (!hyp_mem_base) {
+		kvm_err("Failed to reserve hyp memory\n");
+		return;
+	}
+	memblock_reserve(hyp_mem_base, hyp_mem_size);
+
+	kvm_info("Reserved %lld MiB at 0x%llx\n", hyp_mem_size >> 20,
+		 hyp_mem_base);
+}
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 3685e12aba9b..6cb22da2e226 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -35,6 +35,7 @@
 #include <asm/fixmap.h>
 #include <asm/kasan.h>
 #include <asm/kernel-pgtable.h>
+#include <asm/kvm_host.h>
 #include <asm/memory.h>
 #include <asm/numa.h>
 #include <asm/sections.h>
@@ -452,6 +453,8 @@ void __init bootmem_init(void)
 
 	dma_pernuma_cma_reserve();
 
+	kvm_hyp_reserve();
+
 	/*
 	 * sparse_init() tries to allocate memory from memblock, so must be
 	 * done after the fixed reservations
-- 
2.31.0.rc2.261.g7f71774620-goog

