Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A64F1341964
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhCSKDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbhCSKC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:02:57 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462A2C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:02:57 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id p133so9866653qka.17
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4Q0s6SIE1DtvhBWe0aGHI0Y65bhUADh2FOVOpNiCP+Q=;
        b=sTVIdYZkAs721hHqacx2zDJTCfgow9HgPl8ZOTSd96Gphpa4bQyQ5kEwgKi2auHYM3
         69taDqe1In+7OUbVpuUTwRr0Po7NjzT5JKUDQ3V3cNV1IYMfaepZOpFQ7QvjmgFacju6
         6qGd46fH0I1ulWBsSNaf4EB+goVFJkeC7wZ8LsbKIc8Xrz7RM+tDhsGXNy3j/PmwHSfB
         13bvomJxTIye1CsgxUvNpK1BKZnB8nYidMmhjWKPvPDdHjLg//W43d95NnxGZLOLRgV0
         nEp4XZBLw+HyQfvr+P+eCgOBKxX2F1TvpQ0+BWXd3VOf/D5iIQFQgA3IXICbLk4jVq0m
         ElAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4Q0s6SIE1DtvhBWe0aGHI0Y65bhUADh2FOVOpNiCP+Q=;
        b=ayYRjiiAfdUUiNtb5WDr/bJDNp74oZWJ4bz7JX5x+wFg5IgbU+B6XkZlxJUdA7of63
         0/K6soy1HARJFH0NMqbdRcFoUIpebYIT8yLb8zFkgVA7s57G+lv73i1YR6MRPfBPBHtl
         6PUxpqEHAu6Gl1sLbT51CSY6HqT5hQY3z6BCEF5ys7l7OseyoJaEIuehw4tbf4z4ij76
         qMug+uzHxORQ7Pzeox6PeGjBS39DJB39G+jx/WzYdH52/muF+E6k6KbKV0ppqCFRyrBt
         OYUyhQudo0NK3ejqtwWGCO1wVkLvNR3y3do6/vktWtSE4XfMnEdCi+zMBQ8QLCF385fO
         8vew==
X-Gm-Message-State: AOAM532maXYmxh/GiLRfc0vHDvxyIESlMi5bA+qcCICAyRvrhX1Rqh2F
        hOVIk/M8RyexufRvPW2olxMW9rdt8CBM
X-Google-Smtp-Source: ABdhPJzIgwiOi8K9czl4FpoKOFu5xN23epvjcpz/hGmlk8kIU9i2KZ+twUBum7R9PzV8qolPA5xBlJV1SZOb
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:ad4:4d82:: with SMTP id
 cv2mr8611432qvb.6.1616148176442; Fri, 19 Mar 2021 03:02:56 -0700 (PDT)
Date:   Fri, 19 Mar 2021 10:01:39 +0000
In-Reply-To: <20210319100146.1149909-1-qperret@google.com>
Message-Id: <20210319100146.1149909-32-qperret@google.com>
Mime-Version: 1.0
References: <20210319100146.1149909-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v6 31/38] KVM: arm64: Add kvm_pgtable_stage2_find_range()
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

Since the host stage 2 will be identity mapped, and since it will own
most of memory, it would preferable for performance to try and use large
block mappings whenever that is possible. To ease this, introduce a new
helper in the KVM page-table code which allows to search for large
ranges of available IPA space. This will be used in the host memory
abort path to greedily idmap large portion of the PA space.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_pgtable.h | 29 +++++++++
 arch/arm64/kvm/hyp/pgtable.c         | 89 ++++++++++++++++++++++++++--
 2 files changed, 114 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index eea2e2b0acaa..e1fed14aee17 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -94,6 +94,16 @@ enum kvm_pgtable_prot {
 #define PAGE_HYP_RO		(KVM_PGTABLE_PROT_R)
 #define PAGE_HYP_DEVICE		(PAGE_HYP | KVM_PGTABLE_PROT_DEVICE)
 
+/**
+ * struct kvm_mem_range - Range of Intermediate Physical Addresses
+ * @start:	Start of the range.
+ * @end:	End of the range.
+ */
+struct kvm_mem_range {
+	u64 start;
+	u64 end;
+};
+
 /**
  * enum kvm_pgtable_walk_flags - Flags to control a depth-first page-table walk.
  * @KVM_PGTABLE_WALK_LEAF:		Visit leaf entries, including invalid
@@ -397,4 +407,23 @@ int kvm_pgtable_stage2_flush(struct kvm_pgtable *pgt, u64 addr, u64 size);
 int kvm_pgtable_walk(struct kvm_pgtable *pgt, u64 addr, u64 size,
 		     struct kvm_pgtable_walker *walker);
 
+/**
+ * kvm_pgtable_stage2_find_range() - Find a range of Intermediate Physical
+ *				     Addresses with compatible permission
+ *				     attributes.
+ * @pgt:	Page-table structure initialised by kvm_pgtable_stage2_init().
+ * @addr:	Address that must be covered by the range.
+ * @prot:	Protection attributes that the range must be compatible with.
+ * @range:	Range structure used to limit the search space at call time and
+ *		that will hold the result.
+ *
+ * The offset of @addr within a page is ignored. An IPA is compatible with @prot
+ * iff its corresponding stage-2 page-table entry has default ownership and, if
+ * valid, is mapped with protection attributes identical to @prot.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int kvm_pgtable_stage2_find_range(struct kvm_pgtable *pgt, u64 addr,
+				  enum kvm_pgtable_prot prot,
+				  struct kvm_mem_range *range);
 #endif	/* __ARM64_KVM_PGTABLE_H__ */
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index f4a514a2e7ae..dc6ef2cfe3eb 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -48,6 +48,8 @@
 					 KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W | \
 					 KVM_PTE_LEAF_ATTR_HI_S2_XN)
 
+#define KVM_PTE_LEAF_ATTR_S2_IGNORED	GENMASK(58, 55)
+
 #define KVM_INVALID_PTE_OWNER_MASK	GENMASK(63, 56)
 #define KVM_MAX_OWNER_ID		1
 
@@ -77,15 +79,20 @@ static bool kvm_phys_is_valid(u64 phys)
 	return phys < BIT(id_aa64mmfr0_parange_to_phys_shift(ID_AA64MMFR0_PARANGE_MAX));
 }
 
-static bool kvm_block_mapping_supported(u64 addr, u64 end, u64 phys, u32 level)
+static bool kvm_level_supports_block_mapping(u32 level)
 {
-	u64 granule = kvm_granule_size(level);
-
 	/*
 	 * Reject invalid block mappings and don't bother with 4TB mappings for
 	 * 52-bit PAs.
 	 */
-	if (level == 0 || (PAGE_SIZE != SZ_4K && level == 1))
+	return !(level == 0 || (PAGE_SIZE != SZ_4K && level == 1));
+}
+
+static bool kvm_block_mapping_supported(u64 addr, u64 end, u64 phys, u32 level)
+{
+	u64 granule = kvm_granule_size(level);
+
+	if (!kvm_level_supports_block_mapping(level))
 		return false;
 
 	if (granule > (end - addr))
@@ -1053,3 +1060,77 @@ void kvm_pgtable_stage2_destroy(struct kvm_pgtable *pgt)
 	pgt->mm_ops->free_pages_exact(pgt->pgd, pgd_sz);
 	pgt->pgd = NULL;
 }
+
+#define KVM_PTE_LEAF_S2_COMPAT_MASK	(KVM_PTE_LEAF_ATTR_S2_PERMS | \
+					 KVM_PTE_LEAF_ATTR_LO_S2_MEMATTR | \
+					 KVM_PTE_LEAF_ATTR_S2_IGNORED)
+
+static int stage2_check_permission_walker(u64 addr, u64 end, u32 level,
+					  kvm_pte_t *ptep,
+					  enum kvm_pgtable_walk_flags flag,
+					  void * const arg)
+{
+	kvm_pte_t old_attr, pte = *ptep, *new_attr = arg;
+
+	/*
+	 * Compatible mappings are either invalid and owned by the page-table
+	 * owner (whose id is 0), or valid with matching permission attributes.
+	 */
+	if (kvm_pte_valid(pte)) {
+		old_attr = pte & KVM_PTE_LEAF_S2_COMPAT_MASK;
+		if (old_attr != *new_attr)
+			return -EEXIST;
+	} else if (pte) {
+		return -EEXIST;
+	}
+
+	return 0;
+}
+
+int kvm_pgtable_stage2_find_range(struct kvm_pgtable *pgt, u64 addr,
+				  enum kvm_pgtable_prot prot,
+				  struct kvm_mem_range *range)
+{
+	kvm_pte_t attr;
+	struct kvm_pgtable_walker check_perm_walker = {
+		.cb		= stage2_check_permission_walker,
+		.flags		= KVM_PGTABLE_WALK_LEAF,
+		.arg		= &attr,
+	};
+	u64 granule, start, end;
+	u32 level;
+	int ret;
+
+	ret = stage2_set_prot_attr(prot, &attr);
+	if (ret)
+		return ret;
+	attr &= KVM_PTE_LEAF_S2_COMPAT_MASK;
+
+	for (level = pgt->start_level; level < KVM_PGTABLE_MAX_LEVELS; level++) {
+		granule = kvm_granule_size(level);
+		start = ALIGN_DOWN(addr, granule);
+		end = start + granule;
+
+		if (!kvm_level_supports_block_mapping(level))
+			continue;
+
+		if (start < range->start || range->end < end)
+			continue;
+
+		/*
+		 * Check the presence of existing mappings with incompatible
+		 * permissions within the current block range, and try one level
+		 * deeper if one is found.
+		 */
+		ret = kvm_pgtable_walk(pgt, start, granule, &check_perm_walker);
+		if (ret != -EEXIST)
+			break;
+	}
+
+	if (!ret) {
+		range->start = start;
+		range->end = end;
+	}
+
+	return ret;
+}
-- 
2.31.0.rc2.261.g7f71774620-goog

