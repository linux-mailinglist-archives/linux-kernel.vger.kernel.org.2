Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45473A4867
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 20:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhFKSGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 14:06:55 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:36623 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbhFKSGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 14:06:40 -0400
Received: by mail-wm1-f53.google.com with SMTP id h11-20020a05600c350bb02901b59c28e8b4so8656338wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 11:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yyVm0tQntX/7I8tz8gvAiO3NFPPve9mcalQgIVPo3gU=;
        b=d0WdiWROCPfy0G0uQizChamHHCZX+Acph4KNURtFFKXabQZ0PuEJIm9gmMx65v/hOS
         VIEsBfD2eC38kKn+AuwWP1+HRxB5lLg+JT9UYIdGlv2ePAsAXwQIDQPPr9G+xBIOv+Qc
         jzqkk5sATNNznKQCMXntF2BR1a66DUdwHU6PRMM47BYG8rLT8WixZU5HxeWlywX5CL/D
         hYt92vuZeIPHvd5mIRZ8IXLMPDM5cIF/vwNP1XBIC3hGsVNpc5hynQROk5Tay3zH5wiX
         a5HSNsU6LI88s0jXFiJdUqeaWtCVrjbFQlyVDGowtyMJMaJbJN5pTHMhqJoW65NxCXPx
         lugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yyVm0tQntX/7I8tz8gvAiO3NFPPve9mcalQgIVPo3gU=;
        b=FR6FPXnqXpB/F18EI8GrW2E+5QR6inj2NDsDruVzr6fRXrMron51v3GxUax/OLfyxs
         2w3csIhm629kiKdAy0N7nWQ+uVzFboQl2BJSlClAp62DHMGReIXyVj/UFaLZDn4N/S3Q
         xI81R7Hc/0m/NeHLwQh7j3SaViQ9M3LCg6F1amNS3bjHCyF2DOvzMIqoqDVnJgqqU18F
         vlIx8dBtracpc1s3qc43zMtQVhRpka+lWtRWtIeSkr/P46tUltdhhzPrW4opRRPwdPyz
         dHM6zG79aWE/SLCoDKZmAMsdhx0IwsBZoAIbkoPy0taKVmRAo7Y2GSlRV+HfHNN1XRdU
         viRQ==
X-Gm-Message-State: AOAM533mLpv0HuTUIXrcDVIhYqvktFucFvGinZPTNZRI002Hqm+sh8m2
        jIhKOYV04tcOJjsQafk7wOt88gBSrPiK5oaq
X-Google-Smtp-Source: ABdhPJzXu6iRNmV+gK69dB4W/I1vUyTy6jMRq7o8Z3UGNqi6JlMclOZ/1aeKdlJ4VvAuFCI6YLnxqg==
X-Received: by 2002:a05:600c:3581:: with SMTP id p1mr19012401wmq.109.1623434607103;
        Fri, 11 Jun 2021 11:03:27 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id v15sm7425881wrw.24.2021.06.11.11.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 11:03:26 -0700 (PDT)
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
        Will Deacon <will@kernel.org>, x86@kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 22/23] powerpc/vdso: Migrate native signals to generic vdso_base
Date:   Fri, 11 Jun 2021 19:02:41 +0100
Message-Id: <20210611180242.711399-23-dima@arista.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611180242.711399-1-dima@arista.com>
References: <20210611180242.711399-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generic way to track the land vma area.
Stat speaks for itself.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/powerpc/Kconfig                          |  1 +
 arch/powerpc/include/asm/book3s/32/mmu-hash.h |  1 -
 arch/powerpc/include/asm/book3s/64/mmu.h      |  1 -
 arch/powerpc/include/asm/mmu_context.h        |  9 ------
 arch/powerpc/include/asm/nohash/32/mmu-40x.h  |  1 -
 arch/powerpc/include/asm/nohash/32/mmu-44x.h  |  1 -
 arch/powerpc/include/asm/nohash/32/mmu-8xx.h  |  1 -
 arch/powerpc/include/asm/nohash/mmu-book3e.h  |  1 -
 arch/powerpc/kernel/signal_32.c               |  8 ++---
 arch/powerpc/kernel/signal_64.c               |  4 +--
 arch/powerpc/kernel/vdso.c                    | 31 +------------------
 arch/powerpc/perf/callchain_32.c              |  8 ++---
 arch/powerpc/perf/callchain_64.c              |  4 +--
 arch/x86/include/asm/mmu_context.h            |  5 ---
 include/asm-generic/mm_hooks.h                |  9 ++----
 mm/mmap.c                                     |  7 -----
 16 files changed, 16 insertions(+), 76 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a9f842230ee4..21e58d145c82 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -145,6 +145,7 @@ config PPC
 	select ARCH_HAS_TICK_BROADCAST		if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UACCESS_FLUSHCACHE
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
+	select ARCH_HAS_VDSO_BASE
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_KEEP_MEMBLOCK
 	select ARCH_MIGHT_HAVE_PC_PARPORT
diff --git a/arch/powerpc/include/asm/book3s/32/mmu-hash.h b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
index b85f8e114a9c..d5ee68f394d9 100644
--- a/arch/powerpc/include/asm/book3s/32/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
@@ -90,7 +90,6 @@ struct hash_pte {
 
 typedef struct {
 	unsigned long id;
-	void __user *vdso;
 } mm_context_t;
 
 void update_bats(void);
diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index eace8c3f7b0a..66bcc3ee3add 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -111,7 +111,6 @@ typedef struct {
 
 	struct hash_mm_context *hash_context;
 
-	void __user *vdso;
 	/*
 	 * pagetable fragment support
 	 */
diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 4bc45d3ed8b0..71dedeac7fdb 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -260,15 +260,6 @@ static inline void enter_lazy_tlb(struct mm_struct *mm,
 
 extern void arch_exit_mmap(struct mm_struct *mm);
 
-static inline void arch_unmap(struct mm_struct *mm,
-			      unsigned long start, unsigned long end)
-{
-	unsigned long vdso_base = (unsigned long)mm->context.vdso;
-
-	if (start <= vdso_base && vdso_base < end)
-		mm->context.vdso = NULL;
-}
-
 #ifdef CONFIG_PPC_MEM_KEYS
 bool arch_vma_access_permitted(struct vm_area_struct *vma, bool write,
 			       bool execute, bool foreign);
diff --git a/arch/powerpc/include/asm/nohash/32/mmu-40x.h b/arch/powerpc/include/asm/nohash/32/mmu-40x.h
index 8a8f13a22cf4..366088bb1c3f 100644
--- a/arch/powerpc/include/asm/nohash/32/mmu-40x.h
+++ b/arch/powerpc/include/asm/nohash/32/mmu-40x.h
@@ -57,7 +57,6 @@
 typedef struct {
 	unsigned int	id;
 	unsigned int	active;
-	void __user	*vdso;
 } mm_context_t;
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/powerpc/include/asm/nohash/32/mmu-44x.h b/arch/powerpc/include/asm/nohash/32/mmu-44x.h
index 2d92a39d8f2e..d67256ab7887 100644
--- a/arch/powerpc/include/asm/nohash/32/mmu-44x.h
+++ b/arch/powerpc/include/asm/nohash/32/mmu-44x.h
@@ -108,7 +108,6 @@ extern unsigned int tlb_44x_index;
 typedef struct {
 	unsigned int	id;
 	unsigned int	active;
-	void __user	*vdso;
 } mm_context_t;
 
 /* patch sites */
diff --git a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
index 6e4faa0a9b35..9e394810faac 100644
--- a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
@@ -184,7 +184,6 @@ void mmu_pin_tlb(unsigned long top, bool readonly);
 typedef struct {
 	unsigned int id;
 	unsigned int active;
-	void __user *vdso;
 	void *pte_frag;
 } mm_context_t;
 
diff --git a/arch/powerpc/include/asm/nohash/mmu-book3e.h b/arch/powerpc/include/asm/nohash/mmu-book3e.h
index e43a418d3ccd..61ac19f315e5 100644
--- a/arch/powerpc/include/asm/nohash/mmu-book3e.h
+++ b/arch/powerpc/include/asm/nohash/mmu-book3e.h
@@ -238,7 +238,6 @@ extern unsigned int tlbcam_index;
 typedef struct {
 	unsigned int	id;
 	unsigned int	active;
-	void __user	*vdso;
 } mm_context_t;
 
 /* Page size definitions, common between 32 and 64-bit
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 8f05ed0da292..ae61c480af53 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -824,8 +824,8 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 	}
 
 	/* Save user registers on the stack */
-	if (tsk->mm->context.vdso) {
-		tramp = VDSO32_SYMBOL(tsk->mm->context.vdso, sigtramp_rt32);
+	if (tsk->mm->vdso_base != (void __user *)UNMAPPED_VDSO_BASE) {
+		tramp = VDSO32_SYMBOL(tsk->mm->vdso_base, sigtramp_rt32);
 	} else {
 		tramp = (unsigned long)mctx->mc_pad;
 		/* Set up the sigreturn trampoline: li r0,sigret; sc */
@@ -922,8 +922,8 @@ int handle_signal32(struct ksignal *ksig, sigset_t *oldset,
 	else
 		unsafe_save_user_regs(regs, mctx, tm_mctx, 1, failed);
 
-	if (tsk->mm->context.vdso) {
-		tramp = VDSO32_SYMBOL(tsk->mm->context.vdso, sigtramp32);
+	if (tsk->mm->vdso_base != (void __user *)UNMAPPED_VDSO_BASE) {
+		tramp = VDSO32_SYMBOL(tsk->mm->vdso_base, sigtramp32);
 	} else {
 		tramp = (unsigned long)mctx->mc_pad;
 		/* Set up the sigreturn trampoline: li r0,sigret; sc */
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index dca66481d0c2..468866dc1e0e 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -906,8 +906,8 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 	tsk->thread.fp_state.fpscr = 0;
 
 	/* Set up to return from userspace. */
-	if (tsk->mm->context.vdso) {
-		regs->nip = VDSO64_SYMBOL(tsk->mm->context.vdso, sigtramp_rt64);
+	if (tsk->mm->vdso_base != (void __user *)UNMAPPED_VDSO_BASE) {
+		regs->nip = VDSO64_SYMBOL(tsk->mm->vdso_base, sigtramp_rt64);
 	} else {
 		err |= setup_trampoline(__NR_rt_sigreturn, &frame->tramp[0]);
 		if (err)
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 6d6e575630c1..2080a0540537 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -57,29 +57,6 @@ enum vvar_pages {
 	VVAR_NR_PAGES,
 };
 
-static int vdso_mremap(const struct vm_special_mapping *sm, struct vm_area_struct *new_vma,
-		       unsigned long text_size)
-{
-	unsigned long new_size = new_vma->vm_end - new_vma->vm_start;
-
-	if (new_size != text_size)
-		return -EINVAL;
-
-	current->mm->context.vdso = (void __user *)new_vma->vm_start;
-
-	return 0;
-}
-
-static int vdso32_mremap(const struct vm_special_mapping *sm, struct vm_area_struct *new_vma)
-{
-	return vdso_mremap(sm, new_vma, &vdso32_end - &vdso32_start);
-}
-
-static int vdso64_mremap(const struct vm_special_mapping *sm, struct vm_area_struct *new_vma)
-{
-	return vdso_mremap(sm, new_vma, &vdso64_end - &vdso64_start);
-}
-
 static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 			     struct vm_area_struct *vma, struct vm_fault *vmf);
 
@@ -90,12 +67,10 @@ static struct vm_special_mapping vvar_spec __ro_after_init = {
 
 static struct vm_special_mapping vdso32_spec __ro_after_init = {
 	.name = "[vdso]",
-	.mremap = vdso32_mremap,
 };
 
 static struct vm_special_mapping vdso64_spec __ro_after_init = {
 	.name = "[vdso]",
-	.mremap = vdso64_mremap,
 };
 
 #ifdef CONFIG_TIME_NS
@@ -251,7 +226,7 @@ static int __arch_setup_additional_pages(unsigned long *sysinfo_ehdr)
 	if (IS_ERR(vma)) {
 		do_munmap(mm, vdso_base, vvar_size, NULL);
 	} else {
-		mm->context.vdso = (void __user *)vdso_base + vvar_size;
+		mm->vdso_base = (void __user *)vdso_base + vvar_size;
 		*sysinfo_ehdr = vdso_base + vvar_size;
 	}
 
@@ -263,14 +238,10 @@ int arch_setup_additional_pages(unsigned long *sysinfo_ehdr)
 	struct mm_struct *mm = current->mm;
 	int rc;
 
-	mm->context.vdso = NULL;
-
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
 
 	rc = __arch_setup_additional_pages(sysinfo_ehdr);
-	if (rc)
-		mm->context.vdso = NULL;
 
 	mmap_write_unlock(mm);
 	return rc;
diff --git a/arch/powerpc/perf/callchain_32.c b/arch/powerpc/perf/callchain_32.c
index b83c47b7947f..c48b63e16603 100644
--- a/arch/powerpc/perf/callchain_32.c
+++ b/arch/powerpc/perf/callchain_32.c
@@ -59,8 +59,8 @@ static int is_sigreturn_32_address(unsigned int nip, unsigned int fp)
 {
 	if (nip == fp + offsetof(struct signal_frame_32, mctx.mc_pad))
 		return 1;
-	if (current->mm->context.vdso &&
-	    nip == VDSO32_SYMBOL(current->mm->context.vdso, sigtramp32))
+	if (current->mm->vdso_base != (void __user *)UNMAPPED_VDSO_BASE &&
+	    nip == VDSO32_SYMBOL(current->mm->vdso_base, sigtramp32))
 		return 1;
 	return 0;
 }
@@ -70,8 +70,8 @@ static int is_rt_sigreturn_32_address(unsigned int nip, unsigned int fp)
 	if (nip == fp + offsetof(struct rt_signal_frame_32,
 				 uc.uc_mcontext.mc_pad))
 		return 1;
-	if (current->mm->context.vdso &&
-	    nip == VDSO32_SYMBOL(current->mm->context.vdso, sigtramp_rt32))
+	if (current->mm->vdso_base != (void __user *)UNMAPPED_VDSO_BASE &&
+	    nip == VDSO32_SYMBOL(current->mm->vdso_base, sigtramp_rt32))
 		return 1;
 	return 0;
 }
diff --git a/arch/powerpc/perf/callchain_64.c b/arch/powerpc/perf/callchain_64.c
index 8d0df4226328..ef7116bd525a 100644
--- a/arch/powerpc/perf/callchain_64.c
+++ b/arch/powerpc/perf/callchain_64.c
@@ -68,8 +68,8 @@ static int is_sigreturn_64_address(unsigned long nip, unsigned long fp)
 {
 	if (nip == fp + offsetof(struct signal_frame_64, tramp))
 		return 1;
-	if (current->mm->context.vdso &&
-	    nip == VDSO64_SYMBOL(current->mm->context.vdso, sigtramp_rt64))
+	if (current->mm->vdso_base != (void __user *)UNMAPPED_VDSO_BASE &&
+	    nip == VDSO64_SYMBOL(current->mm->vdso_base, sigtramp_rt64))
 		return 1;
 	return 0;
 }
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 27516046117a..394aeaf136bb 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -190,11 +190,6 @@ static inline bool is_64bit_mm(struct mm_struct *mm)
 }
 #endif
 
-static inline void arch_unmap(struct mm_struct *mm, unsigned long start,
-			      unsigned long end)
-{
-}
-
 /*
  * We only want to enforce protection keys on the current process
  * because we effectively have no access to PKRU for other
diff --git a/include/asm-generic/mm_hooks.h b/include/asm-generic/mm_hooks.h
index 4dbb177d1150..6cd41034743d 100644
--- a/include/asm-generic/mm_hooks.h
+++ b/include/asm-generic/mm_hooks.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Define generic no-op hooks for arch_dup_mmap, arch_exit_mmap
- * and arch_unmap to be included in asm-FOO/mmu_context.h for any
+ * Define generic no-op hooks for arch_dup_mmap() and arch_exit_mmap()
+ * to be included in asm-FOO/mmu_context.h for any
  * arch FOO which doesn't need to hook these.
  */
 #ifndef _ASM_GENERIC_MM_HOOKS_H
@@ -17,11 +17,6 @@ static inline void arch_exit_mmap(struct mm_struct *mm)
 {
 }
 
-static inline void arch_unmap(struct mm_struct *mm,
-			unsigned long start, unsigned long end)
-{
-}
-
 static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
 		bool write, bool execute, bool foreign)
 {
diff --git a/mm/mmap.c b/mm/mmap.c
index 5d1ffce51119..d22eb9ab770c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2821,13 +2821,6 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	if (len == 0)
 		return -EINVAL;
 
-	/*
-	 * arch_unmap() might do unmaps itself.  It must be called
-	 * and finish any rbtree manipulation before this code
-	 * runs and also starts to manipulate the rbtree.
-	 */
-	arch_unmap(mm, start, end);
-
 	/* Find the first overlapping VMA */
 	vma = find_vma(mm, start);
 	if (!vma)
-- 
2.31.1

