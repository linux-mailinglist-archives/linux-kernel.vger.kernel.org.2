Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5191B3D56A3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 11:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbhGZItg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 04:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbhGZItQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 04:49:16 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83ECDC061765
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 02:29:45 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id s14-20020ac8528e0000b029025f76cabdfcso4012631qtn.15
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 02:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aIX6xnE8zrFaLzY6zKSYesqv/ybRjMtzHpsGgsZjePU=;
        b=AKqVOtdbPJZfuI9SGEOBzNkUPBgGuAKlIF2CC0rYzNIewRZE3+fMM1rZZFHKBcvAWU
         91wTXuuRYF9wXou5LxhrIRnVc8hpBI3hQe28Su92hOEdfubiwLrD/1t41N2BOfpz9TtU
         TPDu7xDyRgtzFVVw5OQFvXEB31WuwZe9PcPofSBr85aUX4B1W+E2LmYRHq5Nf1oOaYA1
         JhL7+gD7tyclI2KfyX22t20aetWQz/MfhGckwTVXUr2POFp9WgjtTx1WdR+/NNYwGMsi
         Q0OkNTxymKpgV4U++xw1gbR0kc5DN3blpr6Wd3DgJ98iwhlf94bZqyGujI8XDtMkw02w
         w12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aIX6xnE8zrFaLzY6zKSYesqv/ybRjMtzHpsGgsZjePU=;
        b=F6xwDZlrz8HauOfW4pqtVEWo8oy3aTkHgZh9qYApCVC+DeonaK3CWxyqCS0G4FBBtB
         hJebPZl0Bsrfbw3Oxg/2TZ6nyX9jmuGkEz+MnqBWDP4qzxwpzRZ39UIacHOOuH1p0TDz
         hGBpz0AlSvTSHdokyr9IRC4NMxPaR338ArkAtUEvH+RN/nGUgAYq9cYlWKiTvg0yE1mm
         GJFVZTXWrTjphQoTdYv4CjYpOIjaLuwhGXEEUmYfoQaddg4bZjcIBDv5ftz0rwjj062t
         xhLPLwOkYpTZM7JSp2+5lL4yF2Uhvxtd4uDLCmHF+4+dH/FmA+KJ7JoC/3+gPOdgiYp7
         NPyg==
X-Gm-Message-State: AOAM530k/AHhco8qMFnO06B9jBtyv1fVOL5pgxeMNK6aIyvj+HFAJQwx
        qs7Arl2N9O+UhgBeeiD8Ygkd+4M/w4aV
X-Google-Smtp-Source: ABdhPJz+6y5CnoN87oobsVqCl0gHo4b+5rQT7Y9mI+YcG/ciA9YQ647DFc4SlAzgitr8BhoEDkXPRXpOOssh
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:23a0:2f14:433:e6cb])
 (user=qperret job=sendgmr) by 2002:ad4:4bae:: with SMTP id
 i14mr17035153qvw.24.1627291784628; Mon, 26 Jul 2021 02:29:44 -0700 (PDT)
Date:   Mon, 26 Jul 2021 10:29:04 +0100
In-Reply-To: <20210726092905.2198501-1-qperret@google.com>
Message-Id: <20210726092905.2198501-16-qperret@google.com>
Mime-Version: 1.0
References: <20210726092905.2198501-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v2 15/16] KVM: arm64: Restrict EL2 stage-1 changes in
 protected mode
From:   Quentin Perret <qperret@google.com>
To:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        tabba@google.com, dbrazdil@google.com, kernel-team@android.com,
        Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The host kernel is currently able to change EL2 stage-1 mappings without
restrictions thanks to the __pkvm_create_mappings() hypercall. But in a
world where the host is no longer part of the TCB, this clearly poses a
problem.

To fix this, introduce a new hypercall to allow the host to share a
physical memory page with the hypervisor, and remove the
__pkvm_create_mappings() variant. The new hypercall implements
ownership and permission checks before allowing the sharing operation,
and it annotates the shared page in the hypervisor stage-1 and host
stage-2 page-tables.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_asm.h              |  2 +-
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  1 +
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            | 11 +--
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 90 +++++++++++++++++++
 arch/arm64/kvm/mmu.c                          | 28 +++++-
 5 files changed, 120 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 9f0bf2109be7..78db818ae2c9 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -59,7 +59,7 @@
 #define __KVM_HOST_SMCCC_FUNC___vgic_v3_save_aprs		13
 #define __KVM_HOST_SMCCC_FUNC___vgic_v3_restore_aprs		14
 #define __KVM_HOST_SMCCC_FUNC___pkvm_init			15
-#define __KVM_HOST_SMCCC_FUNC___pkvm_create_mappings		16
+#define __KVM_HOST_SMCCC_FUNC___pkvm_host_share_hyp		16
 #define __KVM_HOST_SMCCC_FUNC___pkvm_create_private_mapping	17
 #define __KVM_HOST_SMCCC_FUNC___pkvm_cpu_set_vector		18
 #define __KVM_HOST_SMCCC_FUNC___pkvm_prot_finalize		19
diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index 8e5725d032b2..1b8e59a9d065 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -49,6 +49,7 @@ extern struct host_kvm host_kvm;
 
 int __pkvm_prot_finalize(void);
 int __pkvm_mark_hyp(phys_addr_t start, phys_addr_t end);
+int __pkvm_host_share_hyp(u64 pfn);
 
 int host_stage2_idmap_locked(u64 start, u64 end, enum kvm_pgtable_prot prot);
 int kvm_host_prepare_stage2(void *pgt_pool_base);
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 1632f001f4ed..dd155646ec86 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -140,14 +140,11 @@ static void handle___pkvm_cpu_set_vector(struct kvm_cpu_context *host_ctxt)
 	cpu_reg(host_ctxt, 1) = pkvm_cpu_set_vector(slot);
 }
 
-static void handle___pkvm_create_mappings(struct kvm_cpu_context *host_ctxt)
+static void handle___pkvm_host_share_hyp(struct kvm_cpu_context *host_ctxt)
 {
-	DECLARE_REG(unsigned long, start, host_ctxt, 1);
-	DECLARE_REG(unsigned long, size, host_ctxt, 2);
-	DECLARE_REG(unsigned long, phys, host_ctxt, 3);
-	DECLARE_REG(enum kvm_pgtable_prot, prot, host_ctxt, 4);
+	DECLARE_REG(u64, pfn, host_ctxt, 1);
 
-	cpu_reg(host_ctxt, 1) = __pkvm_create_mappings(start, size, phys, prot);
+	cpu_reg(host_ctxt, 1) = __pkvm_host_share_hyp(pfn);
 }
 
 static void handle___pkvm_create_private_mapping(struct kvm_cpu_context *host_ctxt)
@@ -193,7 +190,7 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__vgic_v3_restore_aprs),
 	HANDLE_FUNC(__pkvm_init),
 	HANDLE_FUNC(__pkvm_cpu_set_vector),
-	HANDLE_FUNC(__pkvm_create_mappings),
+	HANDLE_FUNC(__pkvm_host_share_hyp),
 	HANDLE_FUNC(__pkvm_create_private_mapping),
 	HANDLE_FUNC(__pkvm_prot_finalize),
 	HANDLE_FUNC(__pkvm_mark_hyp),
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 223c541a7051..75273166d2c5 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -315,6 +315,96 @@ static int host_stage2_idmap(u64 addr)
 	return ret;
 }
 
+static inline bool check_prot(enum kvm_pgtable_prot prot,
+			      enum kvm_pgtable_prot required,
+			      enum kvm_pgtable_prot denied)
+{
+	return (prot & (required | denied)) == required;
+}
+
+int __pkvm_host_share_hyp(u64 pfn)
+{
+	phys_addr_t addr = hyp_pfn_to_phys(pfn);
+	enum kvm_pgtable_prot prot, cur;
+	void * virt = __hyp_va(addr);
+	enum pkvm_page_state state;
+	kvm_pte_t pte;
+	u32 level;
+	int ret;
+
+	if (!range_is_memory(addr, addr + PAGE_SIZE))
+		return -EINVAL;
+
+	hyp_spin_lock(&host_kvm.lock);
+	hyp_spin_lock(&pkvm_pgd_lock);
+
+	ret = kvm_pgtable_get_leaf(&host_kvm.pgt, addr, &pte, &level);
+	if (ret)
+		goto unlock;
+	if (!pte)
+		goto map_shared;
+
+	/*
+	 * Check attributes in the host stage-2 PTE. We need the page to be:
+	 *  - mapped RWX as we're sharing memory;
+	 *  - not borrowed, as that implies absence of ownership.
+	 * Otherwise, we can't let it got through
+	 */
+	cur = kvm_pgtable_stage2_pte_prot(pte);
+	prot = pkvm_mkstate(0, PKVM_PAGE_SHARED_BORROWED);
+	if (!check_prot(cur, KVM_PGTABLE_PROT_RWX, prot)) {
+		ret = -EPERM;
+		goto unlock;
+	}
+
+	state = pkvm_getstate(cur);
+	if (state == PKVM_PAGE_OWNED)
+		goto map_shared;
+
+	/*
+	 * Tolerate double-sharing the same page, but this requires
+	 * cross-checking the hypervisor stage-1.
+	 */
+	if (state != PKVM_PAGE_SHARED_OWNED) {
+		ret = -EPERM;
+		goto unlock;
+	}
+
+	ret = kvm_pgtable_get_leaf(&pkvm_pgtable, (u64)virt, &pte, &level);
+	if (ret)
+		goto unlock;
+
+	/*
+	 * If the page has been shared with the hypervisor, it must be
+	 * SHARED_BORROWED already.
+	 */
+	cur = kvm_pgtable_hyp_pte_prot(pte);
+	prot = pkvm_mkstate(PAGE_HYP, PKVM_PAGE_SHARED_BORROWED);
+	if (!check_prot(cur, prot, ~prot))
+		ret = EPERM;
+	goto unlock;
+
+map_shared:
+	/*
+	 * If the page is not yet shared, adjust mappings in both page-tables
+	 * while both locks are held.
+	 */
+	prot = pkvm_mkstate(PAGE_HYP, PKVM_PAGE_SHARED_BORROWED);
+	ret = pkvm_create_mappings_locked(virt, virt + PAGE_SIZE, prot);
+	if (ret)
+		goto unlock;
+
+	prot = pkvm_mkstate(KVM_PGTABLE_PROT_RWX, PKVM_PAGE_SHARED_OWNED);
+	ret = host_stage2_idmap_locked(addr, addr + PAGE_SIZE, prot);
+	BUG_ON(ret);
+
+unlock:
+	hyp_spin_unlock(&pkvm_pgd_lock);
+	hyp_spin_unlock(&host_kvm.lock);
+
+	return ret;
+}
+
 int __pkvm_mark_hyp(phys_addr_t start, phys_addr_t end)
 {
 	int ret;
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 0625bf2353c2..cbab146cda6a 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -259,10 +259,8 @@ static int __create_hyp_mappings(unsigned long start, unsigned long size,
 {
 	int err;
 
-	if (!kvm_host_owns_hyp_mappings()) {
-		return kvm_call_hyp_nvhe(__pkvm_create_mappings,
-					 start, size, phys, prot);
-	}
+	if (WARN_ON(!kvm_host_owns_hyp_mappings()))
+		return -EINVAL;
 
 	mutex_lock(&kvm_hyp_pgd_mutex);
 	err = kvm_pgtable_hyp_map(hyp_pgtable, start, size, phys, prot);
@@ -282,6 +280,21 @@ static phys_addr_t kvm_kaddr_to_phys(void *kaddr)
 	}
 }
 
+static int pkvm_share_hyp(phys_addr_t start, phys_addr_t end)
+{
+	phys_addr_t addr;
+	int ret;
+
+	for (addr = ALIGN_DOWN(start, PAGE_SIZE); addr < end; addr += PAGE_SIZE) {
+		ret = kvm_call_hyp_nvhe(__pkvm_host_share_hyp,
+					__phys_to_pfn(addr));
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 /**
  * create_hyp_mappings - duplicate a kernel virtual address range in Hyp mode
  * @from:	The virtual kernel start address of the range
@@ -302,6 +315,13 @@ int create_hyp_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
 	if (is_kernel_in_hyp_mode())
 		return 0;
 
+	if (!kvm_host_owns_hyp_mappings()) {
+		if (WARN_ON(prot != PAGE_HYP))
+			return -EPERM;
+		return pkvm_share_hyp(kvm_kaddr_to_phys(from),
+				      kvm_kaddr_to_phys(to));
+	}
+
 	start = start & PAGE_MASK;
 	end = PAGE_ALIGN(end);
 
-- 
2.32.0.432.gabb21c7263-goog

