Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15BE8375614
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 16:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbhEFPAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 11:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbhEFPAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 11:00:39 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB97C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 07:59:41 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id b7so7454351ljr.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 07:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KrzgRbnB6jTNt7gyrzprHPI8C/4GLLeLK4m+rl2GCyo=;
        b=RgwJvUJg7BYYJ8PffXYd/DQDXYSEN09mrJrvoDYBicZOEMxhKhl4SfbGp5RkU4w66t
         qWYE+/gdwG4yxey2xZXrFV8v5qRIQ7UcMwrj5IEg4udkjwTHHHAc+16c46mLNqETUVYh
         zgaIvyQicElA/w5xx49tNmnBzyWWLlnrgtqRfbxf4GdlFr4W65ESXuGe9iO9zGcrrwZE
         3Ky1c2DGF8tIU/OtRMoaS6P5tjV7pKgzwgEbEFNvGgwsVVFKyY7VtG+9CJemBLloMwqt
         3LPtZxhMusxTIBup8AlrKuQv9VMKVktQ+UJrPLH4pmuy28gURSAwp4FPgrZBMNSfhuvy
         yy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KrzgRbnB6jTNt7gyrzprHPI8C/4GLLeLK4m+rl2GCyo=;
        b=DSkprfJkjqR4L2J7LiLLC7u/wuYXj9qq3RthehOUgbXE5e66PfY/QUTKSvpos8Nohl
         pbpP7mq6/g2yhYj3cX1HwpGe7ob6qQ5HZ6Iag1my8/Mpiahz+icZGDMAOLbRWw+8Tjxy
         aia+uS1JT+f0GICABBLhNQHNWY5c71flLb94NKlXzDn8k55gjWsiZ+0wCTY3A2Cvzj+a
         UikCibX1LVPL0xwgrFFDyWtkfIdwFcaNVBMulB2ZhbytfdwoIN3afjgpPyWcAqiSEDs2
         tXpY9yYIsA51hdfS+dBDOWBDnhucJZbJh9gAT6lrjTFdWYeGikGqVCgKySHgPUZyecil
         rr0A==
X-Gm-Message-State: AOAM532QJbtivPYmLCmPr2Ymq7UVJulogg69RPFabg9pNxj7FfeLmJv8
        swK5rFVX9xtzd9+80zlwCYkhew==
X-Google-Smtp-Source: ABdhPJzWOMkm/jfE/KBGIhj/5cXIVp9cDgkOeodLGjby878fPxHQjNlhfdP5ydymXsy8H89zst7LHg==
X-Received: by 2002:a2e:2f16:: with SMTP id v22mr3803532ljv.35.1620313179843;
        Thu, 06 May 2021 07:59:39 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id o20sm732752lfu.283.2021.05.06.07.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 07:59:38 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id BCC921012A7; Thu,  6 May 2021 17:59:44 +0300 (+03)
Date:   Thu, 6 May 2021 17:59:44 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        =?utf-8?Q?J=C3=BCrgen?= Gross <jgross@suse.com>
Subject: Re: [RFC v2 01/32] x86/paravirt: Introduce CONFIG_PARAVIRT_XL
Message-ID: <20210506145944.xbrvysstupyabvlj@box>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <4f8c9559dd04d8e8485c419c5ebc9471613f7928.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <YIhKXcNuinL0ar0O@zn.tnic>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6nh4u7smv55ybec6"
Content-Disposition: inline
In-Reply-To: <YIhKXcNuinL0ar0O@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6nh4u7smv55ybec6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 27, 2021 at 07:31:09PM +0200, Borislav Petkov wrote:
> Or something to that effect.

See the couple of attached patches. Does look along the lines you wanted?

The first one renames PARAVIRT_XXL and the second one introduces
PARAVIRT_HLT.

-- 
 Kirill A. Shutemov

--6nh4u7smv55ybec6
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-x86-paravirt-Rename-PARAVIRT_XXL-to-PARAVIRT_FULL.patch"

From 2671a044687da0e0c7105beb3467a270b8863a1b Mon Sep 17 00:00:00 2001
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Thu, 6 May 2021 17:04:42 +0300
Subject: [PATCH 1/2] x86/paravirt: Rename PARAVIRT_XXL to PARAVIRT_FULL

PARAVIRT_XXL provides a way to hook up a full set paravirt ops.
Rename it to PARAVIRT_FULL to be more self-descriptive.

It's a preparation for the next patch.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/Kconfig                               |  2 +-
 arch/x86/boot/compressed/misc.h                |  2 +-
 arch/x86/entry/vdso/vdso32/vclock_gettime.c    |  2 +-
 arch/x86/include/asm/debugreg.h                |  2 +-
 arch/x86/include/asm/desc.h                    |  4 ++--
 arch/x86/include/asm/fixmap.h                  |  4 ++--
 arch/x86/include/asm/io_bitmap.h               |  2 +-
 arch/x86/include/asm/irqflags.h                |  4 ++--
 arch/x86/include/asm/mmu_context.h             |  4 ++--
 arch/x86/include/asm/msr.h                     |  4 ++--
 arch/x86/include/asm/paravirt.h                | 12 ++++++------
 arch/x86/include/asm/paravirt_types.h          | 10 +++++-----
 arch/x86/include/asm/pgalloc.h                 |  2 +-
 arch/x86/include/asm/pgtable.h                 |  6 +++---
 arch/x86/include/asm/processor.h               |  4 ++--
 arch/x86/include/asm/ptrace.h                  |  2 +-
 arch/x86/include/asm/required-features.h       |  2 +-
 arch/x86/include/asm/special_insns.h           |  4 ++--
 arch/x86/kernel/asm-offsets.c                  |  2 +-
 arch/x86/kernel/asm-offsets_64.c               |  2 +-
 arch/x86/kernel/paravirt.c                     | 18 +++++++++---------
 arch/x86/kernel/paravirt_patch.c               |  6 +++---
 arch/x86/mm/mem_encrypt_identity.c             |  2 +-
 arch/x86/xen/Kconfig                           |  2 +-
 tools/arch/x86/include/asm/required-features.h |  2 +-
 25 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2792879d398e..568b96e20d59 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -783,7 +783,7 @@ config PARAVIRT
 	  over full virtualization.  However, when run without a hypervisor
 	  the kernel is theoretically slower and slightly larger.
 
-config PARAVIRT_XXL
+config PARAVIRT_FULL
 	bool
 
 config PARAVIRT_DEBUG
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 901ea5ebec22..0e5713c1cb86 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -9,7 +9,7 @@
  * paravirt and debugging variants are added.)
  */
 #undef CONFIG_PARAVIRT
-#undef CONFIG_PARAVIRT_XXL
+#undef CONFIG_PARAVIRT_FULL
 #undef CONFIG_PARAVIRT_SPINLOCKS
 #undef CONFIG_KASAN
 #undef CONFIG_KASAN_GENERIC
diff --git a/arch/x86/entry/vdso/vdso32/vclock_gettime.c b/arch/x86/entry/vdso/vdso32/vclock_gettime.c
index 283ed9d00426..6f543b40b1f4 100644
--- a/arch/x86/entry/vdso/vdso32/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vdso32/vclock_gettime.c
@@ -14,7 +14,7 @@
 #undef CONFIG_ILLEGAL_POINTER_VALUE
 #undef CONFIG_SPARSEMEM_VMEMMAP
 #undef CONFIG_NR_CPUS
-#undef CONFIG_PARAVIRT_XXL
+#undef CONFIG_PARAVIRT_FULL
 
 #define CONFIG_X86_32 1
 #define CONFIG_PGTABLE_LEVELS 2
diff --git a/arch/x86/include/asm/debugreg.h b/arch/x86/include/asm/debugreg.h
index cfdf307ddc01..c4c9b9cbda55 100644
--- a/arch/x86/include/asm/debugreg.h
+++ b/arch/x86/include/asm/debugreg.h
@@ -8,7 +8,7 @@
 
 DECLARE_PER_CPU(unsigned long, cpu_dr7);
 
-#ifndef CONFIG_PARAVIRT_XXL
+#ifndef CONFIG_PARAVIRT_FULL
 /*
  * These special macros can be used to get or set a debugging register
  */
diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
index 476082a83d1c..51b77118307b 100644
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -103,7 +103,7 @@ static inline int desc_empty(const void *ptr)
 	return !(desc[0] | desc[1]);
 }
 
-#ifdef CONFIG_PARAVIRT_XXL
+#ifdef CONFIG_PARAVIRT_FULL
 #include <asm/paravirt.h>
 #else
 #define load_TR_desc()				native_load_tr_desc()
@@ -129,7 +129,7 @@ static inline void paravirt_alloc_ldt(struct desc_struct *ldt, unsigned entries)
 static inline void paravirt_free_ldt(struct desc_struct *ldt, unsigned entries)
 {
 }
-#endif	/* CONFIG_PARAVIRT_XXL */
+#endif	/* CONFIG_PARAVIRT_FULL */
 
 #define store_ldt(ldt) asm("sldt %0" : "=m"(ldt))
 
diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
index d0dcefb5cc59..a0a4db7b255e 100644
--- a/arch/x86/include/asm/fixmap.h
+++ b/arch/x86/include/asm/fixmap.h
@@ -105,7 +105,7 @@ enum fixed_addresses {
 	FIX_PCIE_MCFG,
 #endif
 #endif
-#ifdef CONFIG_PARAVIRT_XXL
+#ifdef CONFIG_PARAVIRT_FULL
 	FIX_PARAVIRT_BOOTMAP,
 #endif
 
@@ -160,7 +160,7 @@ void __native_set_fixmap(enum fixed_addresses idx, pte_t pte);
 void native_set_fixmap(unsigned /* enum fixed_addresses */ idx,
 		       phys_addr_t phys, pgprot_t flags);
 
-#ifndef CONFIG_PARAVIRT_XXL
+#ifndef CONFIG_PARAVIRT_FULL
 static inline void __set_fixmap(enum fixed_addresses idx,
 				phys_addr_t phys, pgprot_t flags)
 {
diff --git a/arch/x86/include/asm/io_bitmap.h b/arch/x86/include/asm/io_bitmap.h
index 7f080f5c7def..2c20cd0669d3 100644
--- a/arch/x86/include/asm/io_bitmap.h
+++ b/arch/x86/include/asm/io_bitmap.h
@@ -36,7 +36,7 @@ static inline void native_tss_invalidate_io_bitmap(void)
 
 void native_tss_update_io_bitmap(void);
 
-#ifdef CONFIG_PARAVIRT_XXL
+#ifdef CONFIG_PARAVIRT_FULL
 #include <asm/paravirt.h>
 #else
 #define tss_update_io_bitmap native_tss_update_io_bitmap
diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index 144d70ea4393..a4d7dbc2b034 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -59,7 +59,7 @@ static inline __cpuidle void native_halt(void)
 
 #endif
 
-#ifdef CONFIG_PARAVIRT_XXL
+#ifdef CONFIG_PARAVIRT_FULL
 #include <asm/paravirt.h>
 #else
 #ifndef __ASSEMBLY__
@@ -124,7 +124,7 @@ static __always_inline unsigned long arch_local_irq_save(void)
 #endif
 
 #endif /* __ASSEMBLY__ */
-#endif /* CONFIG_PARAVIRT_XXL */
+#endif /* CONFIG_PARAVIRT_FULL */
 
 #ifndef __ASSEMBLY__
 static __always_inline int arch_irqs_disabled_flags(unsigned long flags)
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 27516046117a..98949a97daf3 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -15,12 +15,12 @@
 
 extern atomic64_t last_mm_ctx_id;
 
-#ifndef CONFIG_PARAVIRT_XXL
+#ifndef CONFIG_PARAVIRT_FULL
 static inline void paravirt_activate_mm(struct mm_struct *prev,
 					struct mm_struct *next)
 {
 }
-#endif	/* !CONFIG_PARAVIRT_XXL */
+#endif	/* !CONFIG_PARAVIRT_FULL */
 
 #ifdef CONFIG_PERF_EVENTS
 DECLARE_STATIC_KEY_FALSE(rdpmc_never_available_key);
diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index e16cccdd0420..7d1c97093780 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -251,7 +251,7 @@ static inline unsigned long long native_read_pmc(int counter)
 	return EAX_EDX_VAL(val, low, high);
 }
 
-#ifdef CONFIG_PARAVIRT_XXL
+#ifdef CONFIG_PARAVIRT_FULL
 #include <asm/paravirt.h>
 #else
 #include <linux/errno.h>
@@ -314,7 +314,7 @@ do {							\
 
 #define rdpmcl(counter, val) ((val) = native_read_pmc(counter))
 
-#endif	/* !CONFIG_PARAVIRT_XXL */
+#endif	/* !CONFIG_PARAVIRT_FULL */
 
 /*
  * 64-bit version of wrmsr_safe():
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 4abf110e2243..02751519b0d9 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -84,7 +84,7 @@ static inline void paravirt_arch_exit_mmap(struct mm_struct *mm)
 	PVOP_VCALL1(mmu.exit_mmap, mm);
 }
 
-#ifdef CONFIG_PARAVIRT_XXL
+#ifdef CONFIG_PARAVIRT_FULL
 static inline void load_sp0(unsigned long sp0)
 {
 	PVOP_VCALL1(cpu.load_sp0, sp0);
@@ -642,7 +642,7 @@ bool __raw_callee_save___native_vcpu_is_preempted(long cpu);
 #define __PV_IS_CALLEE_SAVE(func)			\
 	((struct paravirt_callee_save) { func })
 
-#ifdef CONFIG_PARAVIRT_XXL
+#ifdef CONFIG_PARAVIRT_FULL
 static inline notrace unsigned long arch_local_save_flags(void)
 {
 	return PVOP_CALLEE0(unsigned long, irq.save_fl);
@@ -748,7 +748,7 @@ extern void default_banner(void);
 #define PARA_INDIRECT(addr)	*%cs:addr
 #endif
 
-#ifdef CONFIG_PARAVIRT_XXL
+#ifdef CONFIG_PARAVIRT_FULL
 #define INTERRUPT_RETURN						\
 	PARA_SITE(PARA_PATCH(PV_CPU_iret),				\
 		  ANNOTATE_RETPOLINE_SAFE;				\
@@ -770,7 +770,7 @@ extern void default_banner(void);
 #endif
 
 #ifdef CONFIG_X86_64
-#ifdef CONFIG_PARAVIRT_XXL
+#ifdef CONFIG_PARAVIRT_FULL
 #ifdef CONFIG_DEBUG_ENTRY
 #define SAVE_FLAGS(clobbers)                                        \
 	PARA_SITE(PARA_PATCH(PV_IRQ_save_fl),			    \
@@ -779,7 +779,7 @@ extern void default_banner(void);
 		  call PARA_INDIRECT(pv_ops+PV_IRQ_save_fl);	    \
 		  PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE);)
 #endif
-#endif /* CONFIG_PARAVIRT_XXL */
+#endif /* CONFIG_PARAVIRT_FULL */
 #endif	/* CONFIG_X86_64 */
 
 #endif /* __ASSEMBLY__ */
@@ -788,7 +788,7 @@ extern void default_banner(void);
 #endif /* !CONFIG_PARAVIRT */
 
 #ifndef __ASSEMBLY__
-#ifndef CONFIG_PARAVIRT_XXL
+#ifndef CONFIG_PARAVIRT_FULL
 static inline void paravirt_arch_dup_mmap(struct mm_struct *oldmm,
 					  struct mm_struct *mm)
 {
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index de87087d3bde..ae3503b2e8a2 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -66,7 +66,7 @@ struct paravirt_callee_save {
 
 /* general info */
 struct pv_info {
-#ifdef CONFIG_PARAVIRT_XXL
+#ifdef CONFIG_PARAVIRT_FULL
 	u16 extra_user_64bit_cs;  /* __USER_CS if none */
 #endif
 
@@ -86,7 +86,7 @@ struct pv_init_ops {
 			  unsigned long addr, unsigned len);
 } __no_randomize_layout;
 
-#ifdef CONFIG_PARAVIRT_XXL
+#ifdef CONFIG_PARAVIRT_FULL
 struct pv_lazy_ops {
 	/* Set deferred update mode, used for batching operations. */
 	void (*enter)(void);
@@ -104,7 +104,7 @@ struct pv_cpu_ops {
 	/* hooks for various privileged instructions */
 	void (*io_delay)(void);
 
-#ifdef CONFIG_PARAVIRT_XXL
+#ifdef CONFIG_PARAVIRT_FULL
 	unsigned long (*get_debugreg)(int regno);
 	void (*set_debugreg)(int regno, unsigned long value);
 
@@ -166,7 +166,7 @@ struct pv_cpu_ops {
 } __no_randomize_layout;
 
 struct pv_irq_ops {
-#ifdef CONFIG_PARAVIRT_XXL
+#ifdef CONFIG_PARAVIRT_FULL
 	/*
 	 * Get/set interrupt state.  save_fl is expected to use X86_EFLAGS_IF;
 	 * all other bits returned from save_fl are undefined.
@@ -196,7 +196,7 @@ struct pv_mmu_ops {
 	/* Hook for intercepting the destruction of an mm_struct. */
 	void (*exit_mmap)(struct mm_struct *mm);
 
-#ifdef CONFIG_PARAVIRT_XXL
+#ifdef CONFIG_PARAVIRT_FULL
 	struct paravirt_callee_save read_cr2;
 	void (*write_cr2)(unsigned long);
 
diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
index 62ad61d6fefc..7bd2744b52ba 100644
--- a/arch/x86/include/asm/pgalloc.h
+++ b/arch/x86/include/asm/pgalloc.h
@@ -12,7 +12,7 @@
 
 static inline int  __paravirt_pgd_alloc(struct mm_struct *mm) { return 0; }
 
-#ifdef CONFIG_PARAVIRT_XXL
+#ifdef CONFIG_PARAVIRT_FULL
 #include <asm/paravirt.h>
 #else
 #define paravirt_pgd_alloc(mm)	__paravirt_pgd_alloc(mm)
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index a02c67291cfc..8c4eecc0444a 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -59,9 +59,9 @@ extern struct mm_struct *pgd_page_get_mm(struct page *page);
 
 extern pmdval_t early_pmd_flags;
 
-#ifdef CONFIG_PARAVIRT_XXL
+#ifdef CONFIG_PARAVIRT_FULL
 #include <asm/paravirt.h>
-#else  /* !CONFIG_PARAVIRT_XXL */
+#else  /* !CONFIG_PARAVIRT_FULL */
 #define set_pte(ptep, pte)		native_set_pte(ptep, pte)
 
 #define set_pte_atomic(ptep, pte)					\
@@ -115,7 +115,7 @@ extern pmdval_t early_pmd_flags;
 #define __pte(x)	native_make_pte(x)
 
 #define arch_end_context_switch(prev)	do {} while(0)
-#endif	/* CONFIG_PARAVIRT_XXL */
+#endif	/* CONFIG_PARAVIRT_FULL */
 
 /*
  * The following only work if pte_present() is true.
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index f1b9ed5efaa9..47c4eb146a87 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -580,7 +580,7 @@ static inline bool on_thread_stack(void)
 			       current_stack_pointer) < THREAD_SIZE;
 }
 
-#ifdef CONFIG_PARAVIRT_XXL
+#ifdef CONFIG_PARAVIRT_FULL
 #include <asm/paravirt.h>
 #else
 #define __cpuid			native_cpuid
@@ -590,7 +590,7 @@ static inline void load_sp0(unsigned long sp0)
 	native_load_sp0(sp0);
 }
 
-#endif /* CONFIG_PARAVIRT_XXL */
+#endif /* CONFIG_PARAVIRT_FULL */
 
 /* Free all resources held by a thread. */
 extern void release_thread(struct task_struct *);
diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 409f661481e1..0f8adc38fc03 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -146,7 +146,7 @@ static inline int v8086_mode(struct pt_regs *regs)
 static inline bool user_64bit_mode(struct pt_regs *regs)
 {
 #ifdef CONFIG_X86_64
-#ifndef CONFIG_PARAVIRT_XXL
+#ifndef CONFIG_PARAVIRT_FULL
 	/*
 	 * On non-paravirt systems, this is the only long mode CPL 3
 	 * selector.  We do not allow long mode selectors in the LDT.
diff --git a/arch/x86/include/asm/required-features.h b/arch/x86/include/asm/required-features.h
index b2d504f11937..e37ef3a4cbd3 100644
--- a/arch/x86/include/asm/required-features.h
+++ b/arch/x86/include/asm/required-features.h
@@ -54,7 +54,7 @@
 #endif
 
 #ifdef CONFIG_X86_64
-#ifdef CONFIG_PARAVIRT_XXL
+#ifdef CONFIG_PARAVIRT_FULL
 /* Paravirtualized systems may not have PSE or PGE available */
 #define NEED_PSE	0
 #define NEED_PGE	0
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 1d3cbaef4bb7..f26fc9acf4cc 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -148,7 +148,7 @@ static inline unsigned long __read_cr4(void)
 	return native_read_cr4();
 }
 
-#ifdef CONFIG_PARAVIRT_XXL
+#ifdef CONFIG_PARAVIRT_FULL
 #include <asm/paravirt.h>
 #else
 
@@ -205,7 +205,7 @@ static inline void load_gs_index(unsigned int selector)
 
 #endif
 
-#endif /* CONFIG_PARAVIRT_XXL */
+#endif /* CONFIG_PARAVIRT_FULL */
 
 static inline void clflush(volatile void *__p)
 {
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 60b9f42ce3c1..cc247c723c5e 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -61,7 +61,7 @@ static void __used common(void)
 	OFFSET(IA32_RT_SIGFRAME_sigcontext, rt_sigframe_ia32, uc.uc_mcontext);
 #endif
 
-#ifdef CONFIG_PARAVIRT_XXL
+#ifdef CONFIG_PARAVIRT_FULL
 	BLANK();
 	OFFSET(PV_IRQ_irq_disable, paravirt_patch_template, irq.irq_disable);
 	OFFSET(PV_IRQ_irq_enable, paravirt_patch_template, irq.irq_enable);
diff --git a/arch/x86/kernel/asm-offsets_64.c b/arch/x86/kernel/asm-offsets_64.c
index b14533af7676..7bc5cb486eca 100644
--- a/arch/x86/kernel/asm-offsets_64.c
+++ b/arch/x86/kernel/asm-offsets_64.c
@@ -12,7 +12,7 @@
 int main(void)
 {
 #ifdef CONFIG_PARAVIRT
-#ifdef CONFIG_PARAVIRT_XXL
+#ifdef CONFIG_PARAVIRT_FULL
 #ifdef CONFIG_DEBUG_ENTRY
 	OFFSET(PV_IRQ_save_fl, paravirt_patch_template, irq.save_fl);
 #endif
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index c60222ab8ab9..e3a5f0cf9340 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -79,7 +79,7 @@ static unsigned paravirt_patch_call(void *insn_buff, const void *target,
 	return call_len;
 }
 
-#ifdef CONFIG_PARAVIRT_XXL
+#ifdef CONFIG_PARAVIRT_FULL
 /* identity function, which can be inlined */
 u64 notrace _paravirt_ident_64(u64 x)
 {
@@ -130,7 +130,7 @@ unsigned paravirt_patch_default(u8 type, void *insn_buff,
 	else if (opfunc == _paravirt_nop)
 		ret = 0;
 
-#ifdef CONFIG_PARAVIRT_XXL
+#ifdef CONFIG_PARAVIRT_FULL
 	/* identity functions just return their single argument */
 	else if (opfunc == _paravirt_ident_64)
 		ret = paravirt_patch_ident_64(insn_buff, len);
@@ -227,7 +227,7 @@ void paravirt_flush_lazy_mmu(void)
 	preempt_enable();
 }
 
-#ifdef CONFIG_PARAVIRT_XXL
+#ifdef CONFIG_PARAVIRT_FULL
 void paravirt_start_context_switch(struct task_struct *prev)
 {
 	BUG_ON(preemptible());
@@ -260,7 +260,7 @@ enum paravirt_lazy_mode paravirt_get_lazy_mode(void)
 
 struct pv_info pv_info = {
 	.name = "bare hardware",
-#ifdef CONFIG_PARAVIRT_XXL
+#ifdef CONFIG_PARAVIRT_FULL
 	.extra_user_64bit_cs = __USER_CS,
 #endif
 };
@@ -279,7 +279,7 @@ struct paravirt_patch_template pv_ops = {
 	/* Cpu ops. */
 	.cpu.io_delay		= native_io_delay,
 
-#ifdef CONFIG_PARAVIRT_XXL
+#ifdef CONFIG_PARAVIRT_FULL
 	.cpu.cpuid		= native_cpuid,
 	.cpu.get_debugreg	= native_get_debugreg,
 	.cpu.set_debugreg	= native_set_debugreg,
@@ -324,7 +324,7 @@ struct paravirt_patch_template pv_ops = {
 	.irq.irq_enable		= __PV_IS_CALLEE_SAVE(native_irq_enable),
 	.irq.safe_halt		= native_safe_halt,
 	.irq.halt		= native_halt,
-#endif /* CONFIG_PARAVIRT_XXL */
+#endif /* CONFIG_PARAVIRT_FULL */
 
 	/* Mmu ops. */
 	.mmu.flush_tlb_user	= native_flush_tlb_local,
@@ -336,7 +336,7 @@ struct paravirt_patch_template pv_ops = {
 
 	.mmu.exit_mmap		= paravirt_nop,
 
-#ifdef CONFIG_PARAVIRT_XXL
+#ifdef CONFIG_PARAVIRT_FULL
 	.mmu.read_cr2		= __PV_IS_CALLEE_SAVE(native_read_cr2),
 	.mmu.write_cr2		= native_write_cr2,
 	.mmu.read_cr3		= __native_read_cr3,
@@ -393,7 +393,7 @@ struct paravirt_patch_template pv_ops = {
 	},
 
 	.mmu.set_fixmap		= native_set_fixmap,
-#endif /* CONFIG_PARAVIRT_XXL */
+#endif /* CONFIG_PARAVIRT_FULL */
 
 #if defined(CONFIG_PARAVIRT_SPINLOCKS)
 	/* Lock ops. */
@@ -409,7 +409,7 @@ struct paravirt_patch_template pv_ops = {
 #endif
 };
 
-#ifdef CONFIG_PARAVIRT_XXL
+#ifdef CONFIG_PARAVIRT_FULL
 /* At this point, native_get/set_debugreg has real function entries */
 NOKPROBE_SYMBOL(native_get_debugreg);
 NOKPROBE_SYMBOL(native_set_debugreg);
diff --git a/arch/x86/kernel/paravirt_patch.c b/arch/x86/kernel/paravirt_patch.c
index abd27ec67397..d100993dfdb3 100644
--- a/arch/x86/kernel/paravirt_patch.c
+++ b/arch/x86/kernel/paravirt_patch.c
@@ -17,7 +17,7 @@
 	case PARAVIRT_PATCH(ops.m):					\
 		return PATCH(data, ops##_##m, insn_buff, len)
 
-#ifdef CONFIG_PARAVIRT_XXL
+#ifdef CONFIG_PARAVIRT_FULL
 struct patch_xxl {
 	const unsigned char	irq_irq_disable[1];
 	const unsigned char	irq_irq_enable[1];
@@ -44,7 +44,7 @@ unsigned int paravirt_patch_ident_64(void *insn_buff, unsigned int len)
 {
 	return PATCH(xxl, mov64, insn_buff, len);
 }
-# endif /* CONFIG_PARAVIRT_XXL */
+# endif /* CONFIG_PARAVIRT_FULL */
 
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
 struct patch_lock {
@@ -68,7 +68,7 @@ unsigned int native_patch(u8 type, void *insn_buff, unsigned long addr,
 {
 	switch (type) {
 
-#ifdef CONFIG_PARAVIRT_XXL
+#ifdef CONFIG_PARAVIRT_FULL
 	PATCH_CASE(irq, save_fl, xxl, insn_buff, len);
 	PATCH_CASE(irq, irq_enable, xxl, insn_buff, len);
 	PATCH_CASE(irq, irq_disable, xxl, insn_buff, len);
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 6c5eb6f3f14f..53fe895cefe2 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -24,7 +24,7 @@
  * be extended when new paravirt and debugging variants are added.)
  */
 #undef CONFIG_PARAVIRT
-#undef CONFIG_PARAVIRT_XXL
+#undef CONFIG_PARAVIRT_FULL
 #undef CONFIG_PARAVIRT_SPINLOCKS
 
 #include <linux/kernel.h>
diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
index afc1da68b06d..aa96670248e7 100644
--- a/arch/x86/xen/Kconfig
+++ b/arch/x86/xen/Kconfig
@@ -20,7 +20,7 @@ config XEN_PV
 	default y
 	depends on XEN
 	depends on X86_64
-	select PARAVIRT_XXL
+	select PARAVIRT_FULL
 	select XEN_HAVE_PVMMU
 	select XEN_HAVE_VPMU
 	help
diff --git a/tools/arch/x86/include/asm/required-features.h b/tools/arch/x86/include/asm/required-features.h
index b2d504f11937..e37ef3a4cbd3 100644
--- a/tools/arch/x86/include/asm/required-features.h
+++ b/tools/arch/x86/include/asm/required-features.h
@@ -54,7 +54,7 @@
 #endif
 
 #ifdef CONFIG_X86_64
-#ifdef CONFIG_PARAVIRT_XXL
+#ifdef CONFIG_PARAVIRT_FULL
 /* Paravirtualized systems may not have PSE or PGE available */
 #define NEED_PSE	0
 #define NEED_PGE	0
-- 
2.26.3


--6nh4u7smv55ybec6
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0002-x86-paravirt-Introduce-CONFIG_PARAVIRT_HLT.patch"

From 08e03cebb65b48e6b7e5bf0d805762cc661d09f0 Mon Sep 17 00:00:00 2001
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Tue, 19 Nov 2019 14:56:03 +0300
Subject: [PATCH 2/2] x86/paravirt: Introduce CONFIG_PARAVIRT_HLT

CONFIG_PARAVIRT_FULL provides a way to hook up the full set of paravirt
ops, but TDX only needs two of them: halt() and safe_halt().

Split off halt paravirt calls from CONFIG_PARAVIRT_FULL into
a separate config option -- CONFIG_PARAVIRT_HLT.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/Kconfig                      |  4 +++
 arch/x86/boot/compressed/misc.h       |  1 +
 arch/x86/include/asm/irqflags.h       | 38 +++++++++++++++------------
 arch/x86/include/asm/paravirt.h       | 22 +++++++++-------
 arch/x86/include/asm/paravirt_types.h |  3 ++-
 arch/x86/kernel/paravirt.c            |  4 ++-
 arch/x86/mm/mem_encrypt_identity.c    |  1 +
 7 files changed, 44 insertions(+), 29 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 568b96e20d59..830367e36d5a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -783,8 +783,12 @@ config PARAVIRT
 	  over full virtualization.  However, when run without a hypervisor
 	  the kernel is theoretically slower and slightly larger.
 
+config PARAVIRT_HLT
+	bool
+
 config PARAVIRT_FULL
 	bool
+	select PARAVIRT_HLT
 
 config PARAVIRT_DEBUG
 	bool "paravirt-ops debugging"
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 0e5713c1cb86..293f22dbada4 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -9,6 +9,7 @@
  * paravirt and debugging variants are added.)
  */
 #undef CONFIG_PARAVIRT
+#undef CONFIG_PARAVIRT_HLT
 #undef CONFIG_PARAVIRT_FULL
 #undef CONFIG_PARAVIRT_SPINLOCKS
 #undef CONFIG_KASAN
diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index a4d7dbc2b034..ae839e74fc34 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -59,27 +59,11 @@ static inline __cpuidle void native_halt(void)
 
 #endif
 
-#ifdef CONFIG_PARAVIRT_FULL
+#ifdef CONFIG_PARAVIRT_HLT
 #include <asm/paravirt.h>
 #else
 #ifndef __ASSEMBLY__
 #include <linux/types.h>
-
-static __always_inline unsigned long arch_local_save_flags(void)
-{
-	return native_save_fl();
-}
-
-static __always_inline void arch_local_irq_disable(void)
-{
-	native_irq_disable();
-}
-
-static __always_inline void arch_local_irq_enable(void)
-{
-	native_irq_enable();
-}
-
 /*
  * Used in the idle loop; sti takes one instruction cycle
  * to complete:
@@ -97,6 +81,26 @@ static inline __cpuidle void halt(void)
 {
 	native_halt();
 }
+#endif /* !__ASSEMBLY__ */
+#endif /* CONFIG_PARAVIRT_HLT */
+
+#ifndef CONFIG_PARAVIRT_FULL
+#ifndef __ASSEMBLY__
+
+static __always_inline unsigned long arch_local_save_flags(void)
+{
+	return native_save_fl();
+}
+
+static __always_inline void arch_local_irq_disable(void)
+{
+	native_irq_disable();
+}
+
+static __always_inline void arch_local_irq_enable(void)
+{
+	native_irq_enable();
+}
 
 /*
  * For spinlocks, etc:
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 02751519b0d9..6bc5c1eab6eb 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -84,6 +84,18 @@ static inline void paravirt_arch_exit_mmap(struct mm_struct *mm)
 	PVOP_VCALL1(mmu.exit_mmap, mm);
 }
 
+#ifdef CONFIG_PARAVIRT_HLT
+static inline void arch_safe_halt(void)
+{
+	PVOP_VCALL0(irq.safe_halt);
+}
+
+static inline void halt(void)
+{
+	PVOP_VCALL0(irq.halt);
+}
+#endif
+
 #ifdef CONFIG_PARAVIRT_FULL
 static inline void load_sp0(unsigned long sp0)
 {
@@ -145,16 +157,6 @@ static inline void __write_cr4(unsigned long x)
 	PVOP_VCALL1(cpu.write_cr4, x);
 }
 
-static inline void arch_safe_halt(void)
-{
-	PVOP_VCALL0(irq.safe_halt);
-}
-
-static inline void halt(void)
-{
-	PVOP_VCALL0(irq.halt);
-}
-
 static inline void wbinvd(void)
 {
 	PVOP_VCALL0(cpu.wbinvd);
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index ae3503b2e8a2..cac32ffd95ca 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -177,7 +177,8 @@ struct pv_irq_ops {
 	struct paravirt_callee_save save_fl;
 	struct paravirt_callee_save irq_disable;
 	struct paravirt_callee_save irq_enable;
-
+#endif
+#ifdef CONFIG_PARAVIRT_HLT
 	void (*safe_halt)(void);
 	void (*halt)(void);
 #endif
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index e3a5f0cf9340..752fc3ab81bf 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -322,9 +322,11 @@ struct paravirt_patch_template pv_ops = {
 	.irq.save_fl		= __PV_IS_CALLEE_SAVE(native_save_fl),
 	.irq.irq_disable	= __PV_IS_CALLEE_SAVE(native_irq_disable),
 	.irq.irq_enable		= __PV_IS_CALLEE_SAVE(native_irq_enable),
+#endif /* CONFIG_PARAVIRT_FULL */
+#ifdef CONFIG_PARAVIRT_HLT
 	.irq.safe_halt		= native_safe_halt,
 	.irq.halt		= native_halt,
-#endif /* CONFIG_PARAVIRT_FULL */
+#endif /* CONFIG_PARAVIRT_HLT */
 
 	/* Mmu ops. */
 	.mmu.flush_tlb_user	= native_flush_tlb_local,
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 53fe895cefe2..7cb9b70edbe7 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -24,6 +24,7 @@
  * be extended when new paravirt and debugging variants are added.)
  */
 #undef CONFIG_PARAVIRT
+#undef CONFIG_PARAVIRT_HLT
 #undef CONFIG_PARAVIRT_FULL
 #undef CONFIG_PARAVIRT_SPINLOCKS
 
-- 
2.26.3


--6nh4u7smv55ybec6--
