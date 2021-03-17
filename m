Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC1533F26C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 15:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbhCQORb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 10:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbhCQORW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 10:17:22 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78741C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 07:17:21 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id y5so18477683wrp.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 07:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ofHcNgr0Pl4VkDV5f1artNRx+/0EgZ9eR34QMcFCvis=;
        b=Od/Dkr5f9X+sFwQ/PPSBMn3Rfbaib8wTDjMBSIbBz+QOIMCDJ3KR71qT143ESQToAx
         bG0SCn2Fub/82whL5ctZPkGiTgSLMC/DvfLsMCmgFWHqY51VWeKHmddbTAg8pICVI4Yz
         qes2Mgptn/NikNSk/sNVe+6nQYylKvV/3YvYaBvcqI5mVvaxTSr9Fg0PNg1vet2tO16f
         ina25IdqHrBsJZMYvvyC+mqo1dXYkVh7JipOGPPmrXQErkbLYZzIZJ7b1Jvm9KORaojU
         4GK70FmDPgv3zcPkGyGxeaVDVK+YP1R67NeSrUULwETHwCwKnwYhIfEImERJ1Oj+Huwn
         i7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ofHcNgr0Pl4VkDV5f1artNRx+/0EgZ9eR34QMcFCvis=;
        b=qz+cUqJRR5endXLnSgJDPtmpovh1i6cL8nZ6rE6yrjk9OyUyRJs24bCQ8bsrD6MuTg
         36qqxG1wSRP+v3wVVyIRdFpnTFcXyHmsoKDqZvTy4M2viPZSOAf+tfuW0VzkZ5cNolfh
         vWuVs7Jh0GN8nS3J6h4y2zhLaZBaKcnX+Nhxg1AauakYqCXzgiqAtbOPSFM/FKWfKCHR
         YmspyHyoIrddbhw+5T+kJBoD++5GFJ2Uz5Cvd9OWogH0jxzyRpPyLle8pwn0zNWX9tQp
         jKB4jrVKH23O2s1p65qSzHvL5ARulhZAIWg9DNFdJum7VpZ1eJppXQu3daHfCnY5r048
         sOmg==
X-Gm-Message-State: AOAM533dnSbcJ0yG1cMfNBHoYukstJdfSjwaZ3DDcFG1BGFZk5+iRqaM
        ble0TxGsKtWQuz5JKDiYp/w6dTUNZW0F
X-Google-Smtp-Source: ABdhPJwxAYz5Iri4DN3bhgEtPD+kFC9haoPXBGyODiYoykDFiJGfjIZcngYiEE53lKo0gs3a7Dhudlxkjr+O
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a1c:400b:: with SMTP id
 n11mr3854468wma.167.1615990640064; Wed, 17 Mar 2021 07:17:20 -0700 (PDT)
Date:   Wed, 17 Mar 2021 14:17:13 +0000
In-Reply-To: <20210317141714.383046-1-qperret@google.com>
Message-Id: <20210317141714.383046-2-qperret@google.com>
Mime-Version: 1.0
References: <20210315143536.214621-34-qperret@google.com> <20210317141714.383046-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH 1/2] KVM: arm64: Introduce KVM_PGTABLE_S2_NOFWB Stage-2 flag
From:   Quentin Perret <qperret@google.com>
To:     qperret@google.com
Cc:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com, android-kvm@google.com, seanjc@google.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, tabba@google.com, ardb@kernel.org,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to further configure stage-2 page-tables, pass flags to the
init function using a new enum.

The first of these flags allows to disable FWB even if the hardware
supports it as we will need to do so for the host stage-2.

Signed-off-by: Quentin Perret <qperret@google.com>

---

One question is, do we want to use stage2_has_fwb() everywhere, including
guest-specific paths (e.g. kvm_arch_prepare_memory_region(), ...) ?

That'd make this patch more intrusive, but would make the whole codebase
work with FWB enabled on a guest by guest basis. I don't see us use that
anytime soon (other than maybe debug of some sort?) but it'd be good to
have an agreement.
---
 arch/arm64/include/asm/kvm_pgtable.h  | 19 +++++++++--
 arch/arm64/include/asm/pgtable-prot.h |  4 +--
 arch/arm64/kvm/hyp/pgtable.c          | 49 +++++++++++++++++----------
 3 files changed, 50 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index b93a2a3526ab..7382bdfb6284 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -56,6 +56,15 @@ struct kvm_pgtable_mm_ops {
 	phys_addr_t	(*virt_to_phys)(void *addr);
 };
 
+/**
+ * enum kvm_pgtable_stage2_flags - Stage-2 page-table flags.
+ * @KVM_PGTABLE_S2_NOFWB:	Don't enforce Normal-WB even if the CPUs have
+ *				ARM64_HAS_STAGE2_FWB.
+ */
+enum kvm_pgtable_stage2_flags {
+	KVM_PGTABLE_S2_NOFWB			= BIT(0),
+};
+
 /**
  * struct kvm_pgtable - KVM page-table.
  * @ia_bits:		Maximum input address size, in bits.
@@ -72,6 +81,7 @@ struct kvm_pgtable {
 
 	/* Stage-2 only */
 	struct kvm_s2_mmu			*mmu;
+	enum kvm_pgtable_stage2_flags		flags;
 };
 
 /**
@@ -201,11 +211,16 @@ u64 kvm_get_vtcr(u64 mmfr0, u64 mmfr1, u32 phys_shift);
  * @arch:	Arch-specific KVM structure representing the guest virtual
  *		machine.
  * @mm_ops:	Memory management callbacks.
+ * @flags:	Stage-2 configuration flags.
  *
  * Return: 0 on success, negative error code on failure.
  */
-int kvm_pgtable_stage2_init(struct kvm_pgtable *pgt, struct kvm_arch *arch,
-			    struct kvm_pgtable_mm_ops *mm_ops);
+int kvm_pgtable_stage2_init_flags(struct kvm_pgtable *pgt, struct kvm_arch *arch,
+				  struct kvm_pgtable_mm_ops *mm_ops,
+				  enum kvm_pgtable_stage2_flags flags);
+
+#define kvm_pgtable_stage2_init(pgt, arch, mm_ops) \
+	kvm_pgtable_stage2_init_flags(pgt, arch, mm_ops, 0)
 
 /**
  * kvm_pgtable_stage2_destroy() - Destroy an unused guest stage-2 page-table.
diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index 046be789fbb4..beeb722a82d3 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -72,10 +72,10 @@ extern bool arm64_use_ng_mappings;
 #define PAGE_KERNEL_EXEC	__pgprot(PROT_NORMAL & ~PTE_PXN)
 #define PAGE_KERNEL_EXEC_CONT	__pgprot((PROT_NORMAL & ~PTE_PXN) | PTE_CONT)
 
-#define PAGE_S2_MEMATTR(attr)						\
+#define PAGE_S2_MEMATTR(attr, has_fwb)					\
 	({								\
 		u64 __val;						\
-		if (cpus_have_const_cap(ARM64_HAS_STAGE2_FWB))		\
+		if (has_fwb)						\
 			__val = PTE_S2_MEMATTR(MT_S2_FWB_ ## attr);	\
 		else							\
 			__val = PTE_S2_MEMATTR(MT_S2_ ## attr);		\
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 3a971df278bd..dee8aaeaf13e 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -507,12 +507,25 @@ u64 kvm_get_vtcr(u64 mmfr0, u64 mmfr1, u32 phys_shift)
 	return vtcr;
 }
 
-static int stage2_set_prot_attr(enum kvm_pgtable_prot prot, kvm_pte_t *ptep)
+static bool stage2_has_fwb(struct kvm_pgtable *pgt)
+{
+	if (!cpus_have_const_cap(ARM64_HAS_STAGE2_FWB))
+		return false;
+
+	return !(pgt->flags & KVM_PGTABLE_S2_NOFWB);
+}
+
+static int stage2_set_prot_attr(enum kvm_pgtable_prot prot, kvm_pte_t *ptep,
+				struct kvm_pgtable *pgt)
 {
 	bool device = prot & KVM_PGTABLE_PROT_DEVICE;
-	kvm_pte_t attr = device ? PAGE_S2_MEMATTR(DEVICE_nGnRE) :
-			    PAGE_S2_MEMATTR(NORMAL);
 	u32 sh = KVM_PTE_LEAF_ATTR_LO_S2_SH_IS;
+	kvm_pte_t attr;
+
+	if (device)
+		attr = PAGE_S2_MEMATTR(DEVICE_nGnRE, stage2_has_fwb(pgt));
+	else
+		attr = PAGE_S2_MEMATTR(NORMAL, stage2_has_fwb(pgt));
 
 	if (!(prot & KVM_PGTABLE_PROT_X))
 		attr |= KVM_PTE_LEAF_ATTR_HI_S2_XN;
@@ -748,7 +761,7 @@ int kvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
 		.arg		= &map_data,
 	};
 
-	ret = stage2_set_prot_attr(prot, &map_data.attr);
+	ret = stage2_set_prot_attr(prot, &map_data.attr, pgt);
 	if (ret)
 		return ret;
 
@@ -786,16 +799,13 @@ int kvm_pgtable_stage2_set_owner(struct kvm_pgtable *pgt, u64 addr, u64 size,
 
 static void stage2_flush_dcache(void *addr, u64 size)
 {
-	if (cpus_have_const_cap(ARM64_HAS_STAGE2_FWB))
-		return;
-
 	__flush_dcache_area(addr, size);
 }
 
-static bool stage2_pte_cacheable(kvm_pte_t pte)
+static bool stage2_pte_cacheable(kvm_pte_t pte, struct kvm_pgtable *pgt)
 {
 	u64 memattr = pte & KVM_PTE_LEAF_ATTR_LO_S2_MEMATTR;
-	return memattr == PAGE_S2_MEMATTR(NORMAL);
+	return memattr == PAGE_S2_MEMATTR(NORMAL, stage2_has_fwb(pgt));
 }
 
 static int stage2_unmap_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
@@ -821,8 +831,8 @@ static int stage2_unmap_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 
 		if (mm_ops->page_count(childp) != 1)
 			return 0;
-	} else if (stage2_pte_cacheable(pte)) {
-		need_flush = true;
+	} else if (stage2_pte_cacheable(pte, pgt)) {
+		need_flush = !stage2_has_fwb(pgt);
 	}
 
 	/*
@@ -979,10 +989,11 @@ static int stage2_flush_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 			       enum kvm_pgtable_walk_flags flag,
 			       void * const arg)
 {
-	struct kvm_pgtable_mm_ops *mm_ops = arg;
+	struct kvm_pgtable *pgt = arg;
+	struct kvm_pgtable_mm_ops *mm_ops = pgt->mm_ops;
 	kvm_pte_t pte = *ptep;
 
-	if (!kvm_pte_valid(pte) || !stage2_pte_cacheable(pte))
+	if (!kvm_pte_valid(pte) || !stage2_pte_cacheable(pte, pgt))
 		return 0;
 
 	stage2_flush_dcache(kvm_pte_follow(pte, mm_ops), kvm_granule_size(level));
@@ -994,17 +1005,18 @@ int kvm_pgtable_stage2_flush(struct kvm_pgtable *pgt, u64 addr, u64 size)
 	struct kvm_pgtable_walker walker = {
 		.cb	= stage2_flush_walker,
 		.flags	= KVM_PGTABLE_WALK_LEAF,
-		.arg	= pgt->mm_ops,
+		.arg	= pgt,
 	};
 
-	if (cpus_have_const_cap(ARM64_HAS_STAGE2_FWB))
+	if (stage2_has_fwb(pgt))
 		return 0;
 
 	return kvm_pgtable_walk(pgt, addr, size, &walker);
 }
 
-int kvm_pgtable_stage2_init(struct kvm_pgtable *pgt, struct kvm_arch *arch,
-			    struct kvm_pgtable_mm_ops *mm_ops)
+int kvm_pgtable_stage2_init_flags(struct kvm_pgtable *pgt, struct kvm_arch *arch,
+				  struct kvm_pgtable_mm_ops *mm_ops,
+				  enum kvm_pgtable_stage2_flags flags)
 {
 	size_t pgd_sz;
 	u64 vtcr = arch->vtcr;
@@ -1017,6 +1029,7 @@ int kvm_pgtable_stage2_init(struct kvm_pgtable *pgt, struct kvm_arch *arch,
 	if (!pgt->pgd)
 		return -ENOMEM;
 
+	pgt->flags		= flags;
 	pgt->ia_bits		= ia_bits;
 	pgt->start_level	= start_level;
 	pgt->mm_ops		= mm_ops;
@@ -1101,7 +1114,7 @@ int kvm_pgtable_stage2_find_range(struct kvm_pgtable *pgt, u64 addr,
 	u32 level;
 	int ret;
 
-	ret = stage2_set_prot_attr(prot, &attr);
+	ret = stage2_set_prot_attr(prot, &attr, pgt);
 	if (ret)
 		return ret;
 	attr &= KVM_PTE_LEAF_S2_COMPAT_MASK;
-- 
2.31.0.rc2.261.g7f71774620-goog

