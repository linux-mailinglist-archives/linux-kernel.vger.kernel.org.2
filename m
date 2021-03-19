Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B7C341948
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhCSKCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhCSKCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:02:05 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61716C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:02:04 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id n16so20511622wro.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3JSITIapDPkpw3OmwNjmYxtYxTWiK8LWmTKGvzE43B8=;
        b=VHAGaHKsU3H9+jfr27Fi37Aa5cJqHVV3V1Gquu1gFlzcAiw3hpxcZIpmKbhAgl5p5J
         zkUun/AnkG+vx5Up0hbRshFIvQf2+KQ4kob5E42Xnip967OvNxfcWWUwh+ZBhTnhWzMF
         +eL0EfaGnfcRkCLdu7JjWnxzdNFX8xEeCNEkq+EfBCo0cskuCg7Y/hnsQ+mRYrXaElJz
         JwVIn8QcjZ09oycyu1KvxsPHmKRqs6DGZWceEKckCNHeTVGmVqTzJdg8O+KJvLlUdYxI
         LtRj/VkTXGsyQoRW4uQnpbv3KGCWO9sKhsnzM0WAITwd0yuDCY5kCEb7KR+Lhi+PVbdn
         7i8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3JSITIapDPkpw3OmwNjmYxtYxTWiK8LWmTKGvzE43B8=;
        b=R6Ubbh3JoyM7gb9nVWz3NhM+bBzpclaKFLKGEgvXkUwonL3bDGtCVQ0UEpIVPTm6sL
         vda5TchkYr3BNXQltP+Wk7Nbp7DTBFzwS0mnRNfpKCGW7+KdaXb6IT+0XZby7W4hLFPe
         adQgSrtCN+LjHL5m8S/ILE6ljmKQWTyLd+D/K46Uk/IJdWE5ZOsqG4RNeLUgpdiuWzPW
         DPnL+SqaWiiBEdazdG7GWiBiLHNt36u9C5olVZuFWpVark0K3rexzppxdl+dmGU3ClZC
         S87hjyH3G+PUHmrlh3sW5PX5l4Cw3rio7k591YvR/K47S4A1SqnqxvKTyujvjgKdf00t
         qDEw==
X-Gm-Message-State: AOAM531WCuX6Ui+sT6C1kG4E6ueMTuNatYT4Hj138S/aUoNJr9Y2MlZt
        vAUPJ0OEk1kEQPHhjXP4dFPmPsOxvTim
X-Google-Smtp-Source: ABdhPJy8hfdk6ub0WLmbXjZZIEAiw0QKlhCkccKSG9hSRzw4HUfAil/U8wUUD3lAMKgPjJL5BGxUektPiOu0
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a7b:c18e:: with SMTP id
 y14mr1312118wmi.1.1616148122725; Fri, 19 Mar 2021 03:02:02 -0700 (PDT)
Date:   Fri, 19 Mar 2021 10:01:14 +0000
In-Reply-To: <20210319100146.1149909-1-qperret@google.com>
Message-Id: <20210319100146.1149909-7-qperret@google.com>
Mime-Version: 1.0
References: <20210319100146.1149909-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v6 06/38] KVM: arm64: Factor memory allocation out of pgtable.c
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

In preparation for enabling the creation of page-tables at EL2, factor
all memory allocation out of the page-table code, hence making it
re-usable with any compatible memory allocator.

No functional changes intended.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_pgtable.h | 41 +++++++++++-
 arch/arm64/kvm/hyp/pgtable.c         | 98 +++++++++++++++++-----------
 arch/arm64/kvm/mmu.c                 | 66 ++++++++++++++++++-
 3 files changed, 163 insertions(+), 42 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 8886d43cfb11..bbe840e430cb 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -13,17 +13,50 @@
 
 typedef u64 kvm_pte_t;
 
+/**
+ * struct kvm_pgtable_mm_ops - Memory management callbacks.
+ * @zalloc_page:	Allocate a single zeroed memory page. The @arg parameter
+ *			can be used by the walker to pass a memcache. The
+ *			initial refcount of the page is 1.
+ * @zalloc_pages_exact:	Allocate an exact number of zeroed memory pages. The
+ *			@size parameter is in bytes, and is rounded-up to the
+ *			next page boundary. The resulting allocation is
+ *			physically contiguous.
+ * @free_pages_exact:	Free an exact number of memory pages previously
+ *			allocated by zalloc_pages_exact.
+ * @get_page:		Increment the refcount on a page.
+ * @put_page:		Decrement the refcount on a page. When the refcount
+ *			reaches 0 the page is automatically freed.
+ * @page_count:		Return the refcount of a page.
+ * @phys_to_virt:	Convert a physical address into a virtual address mapped
+ *			in the current context.
+ * @virt_to_phys:	Convert a virtual address mapped in the current context
+ *			into a physical address.
+ */
+struct kvm_pgtable_mm_ops {
+	void*		(*zalloc_page)(void *arg);
+	void*		(*zalloc_pages_exact)(size_t size);
+	void		(*free_pages_exact)(void *addr, size_t size);
+	void		(*get_page)(void *addr);
+	void		(*put_page)(void *addr);
+	int		(*page_count)(void *addr);
+	void*		(*phys_to_virt)(phys_addr_t phys);
+	phys_addr_t	(*virt_to_phys)(void *addr);
+};
+
 /**
  * struct kvm_pgtable - KVM page-table.
  * @ia_bits:		Maximum input address size, in bits.
  * @start_level:	Level at which the page-table walk starts.
  * @pgd:		Pointer to the first top-level entry of the page-table.
+ * @mm_ops:		Memory management callbacks.
  * @mmu:		Stage-2 KVM MMU struct. Unused for stage-1 page-tables.
  */
 struct kvm_pgtable {
 	u32					ia_bits;
 	u32					start_level;
 	kvm_pte_t				*pgd;
+	struct kvm_pgtable_mm_ops		*mm_ops;
 
 	/* Stage-2 only */
 	struct kvm_s2_mmu			*mmu;
@@ -86,10 +119,12 @@ struct kvm_pgtable_walker {
  * kvm_pgtable_hyp_init() - Initialise a hypervisor stage-1 page-table.
  * @pgt:	Uninitialised page-table structure to initialise.
  * @va_bits:	Maximum virtual address bits.
+ * @mm_ops:	Memory management callbacks.
  *
  * Return: 0 on success, negative error code on failure.
  */
-int kvm_pgtable_hyp_init(struct kvm_pgtable *pgt, u32 va_bits);
+int kvm_pgtable_hyp_init(struct kvm_pgtable *pgt, u32 va_bits,
+			 struct kvm_pgtable_mm_ops *mm_ops);
 
 /**
  * kvm_pgtable_hyp_destroy() - Destroy an unused hypervisor stage-1 page-table.
@@ -126,10 +161,12 @@ int kvm_pgtable_hyp_map(struct kvm_pgtable *pgt, u64 addr, u64 size, u64 phys,
  * kvm_pgtable_stage2_init() - Initialise a guest stage-2 page-table.
  * @pgt:	Uninitialised page-table structure to initialise.
  * @kvm:	KVM structure representing the guest virtual machine.
+ * @mm_ops:	Memory management callbacks.
  *
  * Return: 0 on success, negative error code on failure.
  */
-int kvm_pgtable_stage2_init(struct kvm_pgtable *pgt, struct kvm *kvm);
+int kvm_pgtable_stage2_init(struct kvm_pgtable *pgt, struct kvm *kvm,
+			    struct kvm_pgtable_mm_ops *mm_ops);
 
 /**
  * kvm_pgtable_stage2_destroy() - Destroy an unused guest stage-2 page-table.
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 0990fda19198..ff478a576f4d 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -152,9 +152,9 @@ static kvm_pte_t kvm_phys_to_pte(u64 pa)
 	return pte;
 }
 
-static kvm_pte_t *kvm_pte_follow(kvm_pte_t pte)
+static kvm_pte_t *kvm_pte_follow(kvm_pte_t pte, struct kvm_pgtable_mm_ops *mm_ops)
 {
-	return __va(kvm_pte_to_phys(pte));
+	return mm_ops->phys_to_virt(kvm_pte_to_phys(pte));
 }
 
 static void kvm_set_invalid_pte(kvm_pte_t *ptep)
@@ -163,9 +163,10 @@ static void kvm_set_invalid_pte(kvm_pte_t *ptep)
 	WRITE_ONCE(*ptep, pte & ~KVM_PTE_VALID);
 }
 
-static void kvm_set_table_pte(kvm_pte_t *ptep, kvm_pte_t *childp)
+static void kvm_set_table_pte(kvm_pte_t *ptep, kvm_pte_t *childp,
+			      struct kvm_pgtable_mm_ops *mm_ops)
 {
-	kvm_pte_t old = *ptep, pte = kvm_phys_to_pte(__pa(childp));
+	kvm_pte_t old = *ptep, pte = kvm_phys_to_pte(mm_ops->virt_to_phys(childp));
 
 	pte |= FIELD_PREP(KVM_PTE_TYPE, KVM_PTE_TYPE_TABLE);
 	pte |= KVM_PTE_VALID;
@@ -228,7 +229,7 @@ static inline int __kvm_pgtable_visit(struct kvm_pgtable_walk_data *data,
 		goto out;
 	}
 
-	childp = kvm_pte_follow(pte);
+	childp = kvm_pte_follow(pte, data->pgt->mm_ops);
 	ret = __kvm_pgtable_walk(data, childp, level + 1);
 	if (ret)
 		goto out;
@@ -303,8 +304,9 @@ int kvm_pgtable_walk(struct kvm_pgtable *pgt, u64 addr, u64 size,
 }
 
 struct hyp_map_data {
-	u64		phys;
-	kvm_pte_t	attr;
+	u64				phys;
+	kvm_pte_t			attr;
+	struct kvm_pgtable_mm_ops	*mm_ops;
 };
 
 static int hyp_map_set_prot_attr(enum kvm_pgtable_prot prot,
@@ -359,6 +361,8 @@ static int hyp_map_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 			  enum kvm_pgtable_walk_flags flag, void * const arg)
 {
 	kvm_pte_t *childp;
+	struct hyp_map_data *data = arg;
+	struct kvm_pgtable_mm_ops *mm_ops = data->mm_ops;
 
 	if (hyp_map_walker_try_leaf(addr, end, level, ptep, arg))
 		return 0;
@@ -366,11 +370,11 @@ static int hyp_map_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 	if (WARN_ON(level == KVM_PGTABLE_MAX_LEVELS - 1))
 		return -EINVAL;
 
-	childp = (kvm_pte_t *)get_zeroed_page(GFP_KERNEL);
+	childp = (kvm_pte_t *)mm_ops->zalloc_page(NULL);
 	if (!childp)
 		return -ENOMEM;
 
-	kvm_set_table_pte(ptep, childp);
+	kvm_set_table_pte(ptep, childp, mm_ops);
 	return 0;
 }
 
@@ -380,6 +384,7 @@ int kvm_pgtable_hyp_map(struct kvm_pgtable *pgt, u64 addr, u64 size, u64 phys,
 	int ret;
 	struct hyp_map_data map_data = {
 		.phys	= ALIGN_DOWN(phys, PAGE_SIZE),
+		.mm_ops	= pgt->mm_ops,
 	};
 	struct kvm_pgtable_walker walker = {
 		.cb	= hyp_map_walker,
@@ -397,16 +402,18 @@ int kvm_pgtable_hyp_map(struct kvm_pgtable *pgt, u64 addr, u64 size, u64 phys,
 	return ret;
 }
 
-int kvm_pgtable_hyp_init(struct kvm_pgtable *pgt, u32 va_bits)
+int kvm_pgtable_hyp_init(struct kvm_pgtable *pgt, u32 va_bits,
+			 struct kvm_pgtable_mm_ops *mm_ops)
 {
 	u64 levels = ARM64_HW_PGTABLE_LEVELS(va_bits);
 
-	pgt->pgd = (kvm_pte_t *)get_zeroed_page(GFP_KERNEL);
+	pgt->pgd = (kvm_pte_t *)mm_ops->zalloc_page(NULL);
 	if (!pgt->pgd)
 		return -ENOMEM;
 
 	pgt->ia_bits		= va_bits;
 	pgt->start_level	= KVM_PGTABLE_MAX_LEVELS - levels;
+	pgt->mm_ops		= mm_ops;
 	pgt->mmu		= NULL;
 	return 0;
 }
@@ -414,7 +421,9 @@ int kvm_pgtable_hyp_init(struct kvm_pgtable *pgt, u32 va_bits)
 static int hyp_free_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 			   enum kvm_pgtable_walk_flags flag, void * const arg)
 {
-	put_page(virt_to_page(kvm_pte_follow(*ptep)));
+	struct kvm_pgtable_mm_ops *mm_ops = arg;
+
+	mm_ops->put_page((void *)kvm_pte_follow(*ptep, mm_ops));
 	return 0;
 }
 
@@ -423,10 +432,11 @@ void kvm_pgtable_hyp_destroy(struct kvm_pgtable *pgt)
 	struct kvm_pgtable_walker walker = {
 		.cb	= hyp_free_walker,
 		.flags	= KVM_PGTABLE_WALK_TABLE_POST,
+		.arg	= pgt->mm_ops,
 	};
 
 	WARN_ON(kvm_pgtable_walk(pgt, 0, BIT(pgt->ia_bits), &walker));
-	put_page(virt_to_page(pgt->pgd));
+	pgt->mm_ops->put_page(pgt->pgd);
 	pgt->pgd = NULL;
 }
 
@@ -438,6 +448,8 @@ struct stage2_map_data {
 
 	struct kvm_s2_mmu		*mmu;
 	struct kvm_mmu_memory_cache	*memcache;
+
+	struct kvm_pgtable_mm_ops	*mm_ops;
 };
 
 static int stage2_map_set_prot_attr(enum kvm_pgtable_prot prot,
@@ -471,7 +483,7 @@ static int stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
 {
 	kvm_pte_t new, old = *ptep;
 	u64 granule = kvm_granule_size(level), phys = data->phys;
-	struct page *page = virt_to_page(ptep);
+	struct kvm_pgtable_mm_ops *mm_ops = data->mm_ops;
 
 	if (!kvm_block_mapping_supported(addr, end, phys, level))
 		return -E2BIG;
@@ -493,11 +505,11 @@ static int stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
 		 */
 		kvm_set_invalid_pte(ptep);
 		kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, data->mmu, addr, level);
-		put_page(page);
+		mm_ops->put_page(ptep);
 	}
 
 	smp_store_release(ptep, new);
-	get_page(page);
+	mm_ops->get_page(ptep);
 	data->phys += granule;
 	return 0;
 }
@@ -527,13 +539,13 @@ static int stage2_map_walk_table_pre(u64 addr, u64 end, u32 level,
 static int stage2_map_walk_leaf(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 				struct stage2_map_data *data)
 {
-	int ret;
+	struct kvm_pgtable_mm_ops *mm_ops = data->mm_ops;
 	kvm_pte_t *childp, pte = *ptep;
-	struct page *page = virt_to_page(ptep);
+	int ret;
 
 	if (data->anchor) {
 		if (kvm_pte_valid(pte))
-			put_page(page);
+			mm_ops->put_page(ptep);
 
 		return 0;
 	}
@@ -548,7 +560,7 @@ static int stage2_map_walk_leaf(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 	if (!data->memcache)
 		return -ENOMEM;
 
-	childp = kvm_mmu_memory_cache_alloc(data->memcache);
+	childp = mm_ops->zalloc_page(data->memcache);
 	if (!childp)
 		return -ENOMEM;
 
@@ -560,11 +572,11 @@ static int stage2_map_walk_leaf(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 	if (kvm_pte_valid(pte)) {
 		kvm_set_invalid_pte(ptep);
 		kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, data->mmu, addr, level);
-		put_page(page);
+		mm_ops->put_page(ptep);
 	}
 
-	kvm_set_table_pte(ptep, childp);
-	get_page(page);
+	kvm_set_table_pte(ptep, childp, mm_ops);
+	mm_ops->get_page(ptep);
 
 	return 0;
 }
@@ -573,13 +585,14 @@ static int stage2_map_walk_table_post(u64 addr, u64 end, u32 level,
 				      kvm_pte_t *ptep,
 				      struct stage2_map_data *data)
 {
+	struct kvm_pgtable_mm_ops *mm_ops = data->mm_ops;
 	int ret = 0;
 
 	if (!data->anchor)
 		return 0;
 
-	put_page(virt_to_page(kvm_pte_follow(*ptep)));
-	put_page(virt_to_page(ptep));
+	mm_ops->put_page(kvm_pte_follow(*ptep, mm_ops));
+	mm_ops->put_page(ptep);
 
 	if (data->anchor == ptep) {
 		data->anchor = NULL;
@@ -634,6 +647,7 @@ int kvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
 		.phys		= ALIGN_DOWN(phys, PAGE_SIZE),
 		.mmu		= pgt->mmu,
 		.memcache	= mc,
+		.mm_ops		= pgt->mm_ops,
 	};
 	struct kvm_pgtable_walker walker = {
 		.cb		= stage2_map_walker,
@@ -670,7 +684,9 @@ static int stage2_unmap_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 			       enum kvm_pgtable_walk_flags flag,
 			       void * const arg)
 {
-	struct kvm_s2_mmu *mmu = arg;
+	struct kvm_pgtable *pgt = arg;
+	struct kvm_s2_mmu *mmu = pgt->mmu;
+	struct kvm_pgtable_mm_ops *mm_ops = pgt->mm_ops;
 	kvm_pte_t pte = *ptep, *childp = NULL;
 	bool need_flush = false;
 
@@ -678,9 +694,9 @@ static int stage2_unmap_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 		return 0;
 
 	if (kvm_pte_table(pte, level)) {
-		childp = kvm_pte_follow(pte);
+		childp = kvm_pte_follow(pte, mm_ops);
 
-		if (page_count(virt_to_page(childp)) != 1)
+		if (mm_ops->page_count(childp) != 1)
 			return 0;
 	} else if (stage2_pte_cacheable(pte)) {
 		need_flush = true;
@@ -693,15 +709,15 @@ static int stage2_unmap_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 	 */
 	kvm_set_invalid_pte(ptep);
 	kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, mmu, addr, level);
-	put_page(virt_to_page(ptep));
+	mm_ops->put_page(ptep);
 
 	if (need_flush) {
-		stage2_flush_dcache(kvm_pte_follow(pte),
+		stage2_flush_dcache(kvm_pte_follow(pte, mm_ops),
 				    kvm_granule_size(level));
 	}
 
 	if (childp)
-		put_page(virt_to_page(childp));
+		mm_ops->put_page(childp);
 
 	return 0;
 }
@@ -710,7 +726,7 @@ int kvm_pgtable_stage2_unmap(struct kvm_pgtable *pgt, u64 addr, u64 size)
 {
 	struct kvm_pgtable_walker walker = {
 		.cb	= stage2_unmap_walker,
-		.arg	= pgt->mmu,
+		.arg	= pgt,
 		.flags	= KVM_PGTABLE_WALK_LEAF | KVM_PGTABLE_WALK_TABLE_POST,
 	};
 
@@ -842,12 +858,13 @@ static int stage2_flush_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 			       enum kvm_pgtable_walk_flags flag,
 			       void * const arg)
 {
+	struct kvm_pgtable_mm_ops *mm_ops = arg;
 	kvm_pte_t pte = *ptep;
 
 	if (!kvm_pte_valid(pte) || !stage2_pte_cacheable(pte))
 		return 0;
 
-	stage2_flush_dcache(kvm_pte_follow(pte), kvm_granule_size(level));
+	stage2_flush_dcache(kvm_pte_follow(pte, mm_ops), kvm_granule_size(level));
 	return 0;
 }
 
@@ -856,6 +873,7 @@ int kvm_pgtable_stage2_flush(struct kvm_pgtable *pgt, u64 addr, u64 size)
 	struct kvm_pgtable_walker walker = {
 		.cb	= stage2_flush_walker,
 		.flags	= KVM_PGTABLE_WALK_LEAF,
+		.arg	= pgt->mm_ops,
 	};
 
 	if (cpus_have_const_cap(ARM64_HAS_STAGE2_FWB))
@@ -864,7 +882,8 @@ int kvm_pgtable_stage2_flush(struct kvm_pgtable *pgt, u64 addr, u64 size)
 	return kvm_pgtable_walk(pgt, addr, size, &walker);
 }
 
-int kvm_pgtable_stage2_init(struct kvm_pgtable *pgt, struct kvm *kvm)
+int kvm_pgtable_stage2_init(struct kvm_pgtable *pgt, struct kvm *kvm,
+			    struct kvm_pgtable_mm_ops *mm_ops)
 {
 	size_t pgd_sz;
 	u64 vtcr = kvm->arch.vtcr;
@@ -873,12 +892,13 @@ int kvm_pgtable_stage2_init(struct kvm_pgtable *pgt, struct kvm *kvm)
 	u32 start_level = VTCR_EL2_TGRAN_SL0_BASE - sl0;
 
 	pgd_sz = kvm_pgd_pages(ia_bits, start_level) * PAGE_SIZE;
-	pgt->pgd = alloc_pages_exact(pgd_sz, GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+	pgt->pgd = mm_ops->zalloc_pages_exact(pgd_sz);
 	if (!pgt->pgd)
 		return -ENOMEM;
 
 	pgt->ia_bits		= ia_bits;
 	pgt->start_level	= start_level;
+	pgt->mm_ops		= mm_ops;
 	pgt->mmu		= &kvm->arch.mmu;
 
 	/* Ensure zeroed PGD pages are visible to the hardware walker */
@@ -890,15 +910,16 @@ static int stage2_free_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 			      enum kvm_pgtable_walk_flags flag,
 			      void * const arg)
 {
+	struct kvm_pgtable_mm_ops *mm_ops = arg;
 	kvm_pte_t pte = *ptep;
 
 	if (!kvm_pte_valid(pte))
 		return 0;
 
-	put_page(virt_to_page(ptep));
+	mm_ops->put_page(ptep);
 
 	if (kvm_pte_table(pte, level))
-		put_page(virt_to_page(kvm_pte_follow(pte)));
+		mm_ops->put_page(kvm_pte_follow(pte, mm_ops));
 
 	return 0;
 }
@@ -910,10 +931,11 @@ void kvm_pgtable_stage2_destroy(struct kvm_pgtable *pgt)
 		.cb	= stage2_free_walker,
 		.flags	= KVM_PGTABLE_WALK_LEAF |
 			  KVM_PGTABLE_WALK_TABLE_POST,
+		.arg	= pgt->mm_ops,
 	};
 
 	WARN_ON(kvm_pgtable_walk(pgt, 0, BIT(pgt->ia_bits), &walker));
 	pgd_sz = kvm_pgd_pages(pgt->ia_bits, pgt->start_level) * PAGE_SIZE;
-	free_pages_exact(pgt->pgd, pgd_sz);
+	pgt->mm_ops->free_pages_exact(pgt->pgd, pgd_sz);
 	pgt->pgd = NULL;
 }
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 8711894db8c2..e583f7fb3620 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -88,6 +88,44 @@ static bool kvm_is_device_pfn(unsigned long pfn)
 	return !pfn_valid(pfn);
 }
 
+static void *stage2_memcache_zalloc_page(void *arg)
+{
+	struct kvm_mmu_memory_cache *mc = arg;
+
+	/* Allocated with __GFP_ZERO, so no need to zero */
+	return kvm_mmu_memory_cache_alloc(mc);
+}
+
+static void *kvm_host_zalloc_pages_exact(size_t size)
+{
+	return alloc_pages_exact(size, GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+}
+
+static void kvm_host_get_page(void *addr)
+{
+	get_page(virt_to_page(addr));
+}
+
+static void kvm_host_put_page(void *addr)
+{
+	put_page(virt_to_page(addr));
+}
+
+static int kvm_host_page_count(void *addr)
+{
+	return page_count(virt_to_page(addr));
+}
+
+static phys_addr_t kvm_host_pa(void *addr)
+{
+	return __pa(addr);
+}
+
+static void *kvm_host_va(phys_addr_t phys)
+{
+	return __va(phys);
+}
+
 /*
  * Unmapping vs dcache management:
  *
@@ -351,6 +389,17 @@ int create_hyp_exec_mappings(phys_addr_t phys_addr, size_t size,
 	return 0;
 }
 
+static struct kvm_pgtable_mm_ops kvm_s2_mm_ops = {
+	.zalloc_page		= stage2_memcache_zalloc_page,
+	.zalloc_pages_exact	= kvm_host_zalloc_pages_exact,
+	.free_pages_exact	= free_pages_exact,
+	.get_page		= kvm_host_get_page,
+	.put_page		= kvm_host_put_page,
+	.page_count		= kvm_host_page_count,
+	.phys_to_virt		= kvm_host_va,
+	.virt_to_phys		= kvm_host_pa,
+};
+
 /**
  * kvm_init_stage2_mmu - Initialise a S2 MMU strucrure
  * @kvm:	The pointer to the KVM structure
@@ -374,7 +423,7 @@ int kvm_init_stage2_mmu(struct kvm *kvm, struct kvm_s2_mmu *mmu)
 	if (!pgt)
 		return -ENOMEM;
 
-	err = kvm_pgtable_stage2_init(pgt, kvm);
+	err = kvm_pgtable_stage2_init(pgt, kvm, &kvm_s2_mm_ops);
 	if (err)
 		goto out_free_pgtable;
 
@@ -1208,6 +1257,19 @@ static int kvm_map_idmap_text(void)
 	return err;
 }
 
+static void *kvm_hyp_zalloc_page(void *arg)
+{
+	return (void *)get_zeroed_page(GFP_KERNEL);
+}
+
+static struct kvm_pgtable_mm_ops kvm_hyp_mm_ops = {
+	.zalloc_page		= kvm_hyp_zalloc_page,
+	.get_page		= kvm_host_get_page,
+	.put_page		= kvm_host_put_page,
+	.phys_to_virt		= kvm_host_va,
+	.virt_to_phys		= kvm_host_pa,
+};
+
 int kvm_mmu_init(void)
 {
 	int err;
@@ -1251,7 +1313,7 @@ int kvm_mmu_init(void)
 		goto out;
 	}
 
-	err = kvm_pgtable_hyp_init(hyp_pgtable, hyp_va_bits);
+	err = kvm_pgtable_hyp_init(hyp_pgtable, hyp_va_bits, &kvm_hyp_mm_ops);
 	if (err)
 		goto out_free_pgtable;
 
-- 
2.31.0.rc2.261.g7f71774620-goog

