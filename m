Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36BF3DA44C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 15:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237968AbhG2N37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 09:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237835AbhG2N3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:29:12 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49134C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:29:09 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id o2-20020a05620a1102b02903b9ade0af31so3393608qkk.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=U+etsjhdZysbfpN5f3aQijrR79iQpOJUR6haEZ5h+Dc=;
        b=dnpblcLgQZnSwKJDXnlhTevo3wgyttV+xg+nyZWanPpfxhC4upVCtIQV0mHz6w1CAj
         hjwevrpQQrl8bQgXQ2iO1FXCA6NxRw4CQBgJlfZrBujr/66uAdg7p86UebuJb+z/jtcR
         3kJwj4O78VJOdidSVW7piFyY2UIxTPTAedzdpd/ZmmJtrxA5YahdOTeDBXjY4QF+Uq4t
         vIhBNZ0Fd/6RRMQtDl5yApYFlSAwZzdSsCWjmUbZt1uD4Wc5yfO/OYP7fFR8fRilXPdI
         yH1P1pAQobQVFlqYmd2axU9R/pgarGz6c70tlKUxdyKrDDJTdyWgl5qHfXMjTOTOz+0b
         v5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=U+etsjhdZysbfpN5f3aQijrR79iQpOJUR6haEZ5h+Dc=;
        b=Npf6dw5TSIz7jgBaBlL5yCOKu0unUSMNKbH/rrfyfptj38HALprKFXn6ixdOVqhPwd
         bk8g0JFH47NSSu6MayjM55+zf3rtBOD6grFwfJi3pCeqHnKWUqlEs4ebQLJqoehHUAzS
         kjZDWVPgsw/Lzj6jTvgoRIFWVpW5qlomisQYORxbukWX4W4RbgUxq2IVpccptjqeoMHF
         1mccWCWwche17y370pcp2HXVmCQohE3+V22fDDKky77GzgEQinTm6W2MZNR8+5vp8JYU
         wKjRXGtCyNbC9J8R7Qjw4dqBcPRpqU8ILi77MOf8jlRiSaa8DpzeI+vgLGnyIdmCybTr
         U7hQ==
X-Gm-Message-State: AOAM531yFbvJ0Ysmp+FSRk1B+sYyruJ8Rv3kX0zv3gvvfkJqBG+9wlUG
        CVogAV3GvpNBsLWmeuHNDyydjfd3xoqk
X-Google-Smtp-Source: ABdhPJzxZBGJGjuhPUpNeQEO1dRW0w+ioiHAo4VDnESn/2eleOJphVSIXacUC11VE1YgRvPhF+yioMYrl3eH
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:293a:bc89:7514:5218])
 (user=qperret job=sendgmr) by 2002:a0c:f14f:: with SMTP id
 y15mr5369567qvl.12.1627565348412; Thu, 29 Jul 2021 06:29:08 -0700 (PDT)
Date:   Thu, 29 Jul 2021 14:28:17 +0100
In-Reply-To: <20210729132818.4091769-1-qperret@google.com>
Message-Id: <20210729132818.4091769-21-qperret@google.com>
Mime-Version: 1.0
References: <20210729132818.4091769-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v3 20/21] KVM: arm64: Restrict EL2 stage-1 changes in
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
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 89 +++++++++++++++++++
 arch/arm64/kvm/mmu.c                          | 28 +++++-
 5 files changed, 119 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 432a9ea1f02e..aed2aa61766a 100644
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
index 7ce36fbf5158..3d78d7782f1b 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -49,6 +49,7 @@ extern struct host_kvm host_kvm;
 extern const u8 pkvm_hyp_id;
 
 int __pkvm_prot_finalize(void);
+int __pkvm_host_share_hyp(u64 pfn);
 
 bool addr_is_memory(phys_addr_t phys);
 int host_stage2_idmap_locked(u64 start, u64 end, enum kvm_pgtable_prot prot);
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 7900d5b66ba3..2da6aa8da868 100644
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
@@ -185,7 +182,7 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__vgic_v3_restore_aprs),
 	HANDLE_FUNC(__pkvm_init),
 	HANDLE_FUNC(__pkvm_cpu_set_vector),
-	HANDLE_FUNC(__pkvm_create_mappings),
+	HANDLE_FUNC(__pkvm_host_share_hyp),
 	HANDLE_FUNC(__pkvm_create_private_mapping),
 	HANDLE_FUNC(__pkvm_prot_finalize),
 };
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 0ccea58df7e0..1b67f562b6fc 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -338,6 +338,95 @@ static int host_stage2_idmap(u64 addr)
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
+	void *virt = __hyp_va(addr);
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
+	BUG_ON(ret);
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
 void handle_host_mem_abort(struct kvm_cpu_context *host_ctxt)
 {
 	struct kvm_vcpu_fault_info fault;
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

