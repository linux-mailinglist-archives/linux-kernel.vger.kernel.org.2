Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB943DA429
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 15:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237704AbhG2N2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 09:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237637AbhG2N2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:28:40 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3A3C0613D5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:28:37 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id b8-20020a0562141148b02902f1474ce8b7so3894450qvt.20
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Vtw+99RHnSwt8m0h/K1748WonMCx6xnq/TU9kqpCDps=;
        b=SS0ObHT0a2jGjjWNqwJMq9EFMptgPm8qfoASrI1QO04/EtIPlBgkkAh0xNtRaPevsI
         LWBXYoGGL88UNvCSa++qVPcQzClCnwobO9slUzG2Qy11yLfFPhSFbAjLAfNhouCFqGTr
         AebRRvfliZozrMSyBac2X9+c6oFhJ0y9lreCEWx/IPrM9wCyOwPwYITeX0D48RVcDYyL
         IEm9MsgqQGwKnTzT6IKjX8MrjHbZw5a4+YPRXD8LW7mFNskPBd3TSAleOGe2NWPF9rai
         cRS2jVrnRWSgThRnTqExzS5rC/yVviKDUlpV20jsd8NRjRg7kQWMpMJ7dZDTumf7WYB0
         hHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Vtw+99RHnSwt8m0h/K1748WonMCx6xnq/TU9kqpCDps=;
        b=U4kQ0dPLGIbYjMbCivH0L4JnG5/6OxszPB6t8svsjUARUENWYoprdGZPdBgfGBCpol
         UjWjgbBoL7H/EpVKD0PvcJnUs9cYyD9x3/Ahpnhl0KSRzT5aVpfMzsRw15jIUWAe/PMP
         Dpqqjvd1iu1WLBTBuj/tV9xuDzm+dozwxEsKlkh9G6Q9RdRT3PoYrE5syeNByLruf3Da
         vugd9wLcWONAX+TJsjp3RM+hkE8wJEiXYZLYjjAPfammabFW/eKdycw9qYz3Ep56tau7
         Zbaozl8GEHljkG4jVRw4Mpn0KwP025Ncdlg352LWC/qs7Odl/JLl81jnIoaEAmBX0JZ8
         8Nig==
X-Gm-Message-State: AOAM531VwB3Au7qzk2semuSJmW0mKTU/XfgBw0VhxXfeFQsFcfIpALm1
        XApT4WXb7Gqbe0kOGFumnVVAEDaPJBXQ
X-Google-Smtp-Source: ABdhPJxX9lBRmrW4UHAZNvD4OuS7Yq+AjD04kFvGufhGX6CXVguYeexFfDeG9IwwoKxyn8t2nOd7KrL/BUAg
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:293a:bc89:7514:5218])
 (user=qperret job=sendgmr) by 2002:a05:6214:178d:: with SMTP id
 ct13mr4937778qvb.22.1627565316579; Thu, 29 Jul 2021 06:28:36 -0700 (PDT)
Date:   Thu, 29 Jul 2021 14:28:03 +0100
In-Reply-To: <20210729132818.4091769-1-qperret@google.com>
Message-Id: <20210729132818.4091769-7-qperret@google.com>
Mime-Version: 1.0
References: <20210729132818.4091769-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v3 06/21] KVM: arm64: Optimize host memory aborts
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

The kvm_pgtable_stage2_find_range() function is used in the host memory
abort path to try and look for the largest block mapping that can be
used to map the faulting address. In order to do so, the function
currently walks the stage-2 page-table and looks for existing
incompatible mappings within the range of the largest possible block.
If incompatible mappings are found, it tries the same procedure again,
but using a smaller block range, and repeats until a matching range is
found (potentially up to page granularity). While this approach has
benefits (mostly in the fact that it proactively coalesces host stage-2
mappings), it can be slow if the ranges are fragmented, and it isn't
optimized to deal with CPUs faulting on the same IPA as all of them will
do all the work every time.

To avoid these issues, remove kvm_pgtable_stage2_find_range(), and walk
the page-table only once in the host_mem_abort() path to find the
closest leaf to the input address. With this, use the corresponding
range if it is invalid and not owned by another entity. If a valid leaf
is found, return -EAGAIN similar to what is done in the
kvm_pgtable_stage2_map() path to optimize concurrent faults.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_pgtable.h  | 30 -----------
 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 45 +++++++++++++++-
 arch/arm64/kvm/hyp/pgtable.c          | 74 ---------------------------
 3 files changed, 44 insertions(+), 105 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 6938eac72c1f..83c5c97d9eac 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -154,16 +154,6 @@ enum kvm_pgtable_prot {
 #define PAGE_HYP_RO		(KVM_PGTABLE_PROT_R)
 #define PAGE_HYP_DEVICE		(PAGE_HYP | KVM_PGTABLE_PROT_DEVICE)
 
-/**
- * struct kvm_mem_range - Range of Intermediate Physical Addresses
- * @start:	Start of the range.
- * @end:	End of the range.
- */
-struct kvm_mem_range {
-	u64 start;
-	u64 end;
-};
-
 /**
  * enum kvm_pgtable_walk_flags - Flags to control a depth-first page-table walk.
  * @KVM_PGTABLE_WALK_LEAF:		Visit leaf entries, including invalid
@@ -490,24 +480,4 @@ int kvm_pgtable_walk(struct kvm_pgtable *pgt, u64 addr, u64 size,
  */
 int kvm_pgtable_get_leaf(struct kvm_pgtable *pgt, u64 addr,
 			 kvm_pte_t *ptep, u32 *level);
-
-/**
- * kvm_pgtable_stage2_find_range() - Find a range of Intermediate Physical
- *				     Addresses with compatible permission
- *				     attributes.
- * @pgt:	Page-table structure initialised by kvm_pgtable_stage2_init*().
- * @addr:	Address that must be covered by the range.
- * @prot:	Protection attributes that the range must be compatible with.
- * @range:	Range structure used to limit the search space at call time and
- *		that will hold the result.
- *
- * The offset of @addr within a page is ignored. An IPA is compatible with @prot
- * iff its corresponding stage-2 page-table entry has default ownership and, if
- * valid, is mapped with protection attributes identical to @prot.
- *
- * Return: 0 on success, negative error code on failure.
- */
-int kvm_pgtable_stage2_find_range(struct kvm_pgtable *pgt, u64 addr,
-				  enum kvm_pgtable_prot prot,
-				  struct kvm_mem_range *range);
 #endif	/* __ARM64_KVM_PGTABLE_H__ */
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 74280a753efb..2148d3968aa5 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -159,6 +159,11 @@ static int host_stage2_unmap_dev_all(void)
 	return kvm_pgtable_stage2_unmap(pgt, addr, BIT(pgt->ia_bits) - addr);
 }
 
+struct kvm_mem_range {
+	u64 start;
+	u64 end;
+};
+
 static bool find_mem_range(phys_addr_t addr, struct kvm_mem_range *range)
 {
 	int cur, left = 0, right = hyp_memblock_nr;
@@ -227,6 +232,44 @@ static inline int __host_stage2_idmap(u64 start, u64 end,
 		__ret;							\
 	 })
 
+static inline bool range_included(struct kvm_mem_range *child,
+				  struct kvm_mem_range *parent)
+{
+	return parent->start <= child->start && child->end <= parent->end;
+}
+
+static int host_stage2_adjust_range(u64 addr, struct kvm_mem_range *range)
+{
+	struct kvm_mem_range cur;
+	kvm_pte_t pte;
+	u32 level;
+	int ret;
+
+	hyp_assert_lock_held(&host_kvm.lock);
+	ret = kvm_pgtable_get_leaf(&host_kvm.pgt, addr, &pte, &level);
+	if (ret)
+		return ret;
+
+	if (kvm_pte_valid(pte))
+		return -EAGAIN;
+
+	if (pte)
+		return -EPERM;
+
+	do {
+		u64 granule = kvm_granule_size(level);
+		cur.start = ALIGN_DOWN(addr, granule);
+		cur.end = cur.start + granule;
+		level++;
+	} while ((level < KVM_PGTABLE_MAX_LEVELS) &&
+			!(kvm_level_supports_block_mapping(level) &&
+			  range_included(&cur, range)));
+
+	*range = cur;
+
+	return 0;
+}
+
 static int host_stage2_idmap(u64 addr)
 {
 	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_R | KVM_PGTABLE_PROT_W;
@@ -238,7 +281,7 @@ static int host_stage2_idmap(u64 addr)
 		prot |= KVM_PGTABLE_PROT_X;
 
 	hyp_spin_lock(&host_kvm.lock);
-	ret = kvm_pgtable_stage2_find_range(&host_kvm.pgt, addr, prot, &range);
+	ret = host_stage2_adjust_range(addr, &range);
 	if (ret)
 		goto unlock;
 
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 49d768b92997..4dff2ad39ee4 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -1102,77 +1102,3 @@ void kvm_pgtable_stage2_destroy(struct kvm_pgtable *pgt)
 	pgt->mm_ops->free_pages_exact(pgt->pgd, pgd_sz);
 	pgt->pgd = NULL;
 }
-
-#define KVM_PTE_LEAF_S2_COMPAT_MASK	(KVM_PTE_LEAF_ATTR_S2_PERMS | \
-					 KVM_PTE_LEAF_ATTR_LO_S2_MEMATTR | \
-					 KVM_PTE_LEAF_ATTR_S2_IGNORED)
-
-static int stage2_check_permission_walker(u64 addr, u64 end, u32 level,
-					  kvm_pte_t *ptep,
-					  enum kvm_pgtable_walk_flags flag,
-					  void * const arg)
-{
-	kvm_pte_t old_attr, pte = *ptep, *new_attr = arg;
-
-	/*
-	 * Compatible mappings are either invalid and owned by the page-table
-	 * owner (whose id is 0), or valid with matching permission attributes.
-	 */
-	if (kvm_pte_valid(pte)) {
-		old_attr = pte & KVM_PTE_LEAF_S2_COMPAT_MASK;
-		if (old_attr != *new_attr)
-			return -EEXIST;
-	} else if (pte) {
-		return -EEXIST;
-	}
-
-	return 0;
-}
-
-int kvm_pgtable_stage2_find_range(struct kvm_pgtable *pgt, u64 addr,
-				  enum kvm_pgtable_prot prot,
-				  struct kvm_mem_range *range)
-{
-	kvm_pte_t attr;
-	struct kvm_pgtable_walker check_perm_walker = {
-		.cb		= stage2_check_permission_walker,
-		.flags		= KVM_PGTABLE_WALK_LEAF,
-		.arg		= &attr,
-	};
-	u64 granule, start, end;
-	u32 level;
-	int ret;
-
-	ret = stage2_set_prot_attr(pgt, prot, &attr);
-	if (ret)
-		return ret;
-	attr &= KVM_PTE_LEAF_S2_COMPAT_MASK;
-
-	for (level = pgt->start_level; level < KVM_PGTABLE_MAX_LEVELS; level++) {
-		granule = kvm_granule_size(level);
-		start = ALIGN_DOWN(addr, granule);
-		end = start + granule;
-
-		if (!kvm_level_supports_block_mapping(level))
-			continue;
-
-		if (start < range->start || range->end < end)
-			continue;
-
-		/*
-		 * Check the presence of existing mappings with incompatible
-		 * permissions within the current block range, and try one level
-		 * deeper if one is found.
-		 */
-		ret = kvm_pgtable_walk(pgt, start, granule, &check_perm_walker);
-		if (ret != -EEXIST)
-			break;
-	}
-
-	if (!ret) {
-		range->start = start;
-		range->end = end;
-	}
-
-	return ret;
-}
-- 
2.32.0.432.gabb21c7263-goog

