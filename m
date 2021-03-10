Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4971C334628
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 19:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbhCJR7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbhCJR7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:59:01 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C796C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:59:01 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id l13so2247115qtu.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=v22OPvpSkxqoB2GxDbJ4rnO0RdXvHHXz0HAMkqu2tKU=;
        b=nYF7az3GofIlNu5zNxCiTcHwvkEdtos7U9v0280LOmKI6mg0GPAeX5KEzv/BtqLLFj
         6v+C9HZnCnX0J7yNbu0L+ew4Uncbw3RBqDvnK3sOCGPtm7DRIWLSkId7+QUq/uz9VhL/
         BDCplnG3XhLHnkyKSaAFm4ywblHwJZXVVTU8Jk3EcedqOBR8YiWyQpF2qvweyNSolH/A
         NqsGfVTnQFG/Lb84IJ7Kq3FpYSVVXdrg9uSiu4sZ+FTbfeQpRGUaGrlvtOEAeFojuKLY
         qh03mESFMb4ZBlUZgOqEbw4/vV3dpokD8PMpLKxrMK/udtM9HG9xXCWlU2COvR1Luin7
         gtiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=v22OPvpSkxqoB2GxDbJ4rnO0RdXvHHXz0HAMkqu2tKU=;
        b=nkfnfBngt6XvdTqcT0+phB2a80/62ykkjL9C0SNZIPs/W4xAlrbr6EtOcN8XFgIh8f
         Afh23380kBjgcFQtSEpQGRX5J9b/e926CIr03l9O/4yABsbPluONKS6651BbmIqEBIdq
         Jcz6/74t2TGhPZJ1dU8bgFpnZKeC8ZsqZgGOMM73Hn++1bzAWqTo1JLglVyiePPeclPY
         FVlBH9q2dv4R6ASN+hL1w7fFXcLXYBZvKfHsagfRjyOkjAh/iYqPgywQnNWC3W3oryKU
         a0iNjAG4ymGJm7FDBplxR33Z2uVOh/PCSmsBYgRQVSeH1N84RtiH20LCEqPSxASCHnKX
         W6Vg==
X-Gm-Message-State: AOAM531QxqSWJ3+37R7hcQOpY8FuDaQO/MxxghxxJ+i0dQM2nQMx7eWw
        oc/oZU6kYJDemsSmkdu+tX1AWKkLW3RC
X-Google-Smtp-Source: ABdhPJyp3d83D9IJZw5miKqWsWt+Sc6zcBaNVvFInoqRG/CRUiZ7DZZiE71n712cDvkDiwaqnfGCK7uI+r3s
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a05:6214:553:: with SMTP id
 ci19mr4103466qvb.18.1615399140822; Wed, 10 Mar 2021 09:59:00 -0800 (PST)
Date:   Wed, 10 Mar 2021 17:57:47 +0000
In-Reply-To: <20210310175751.3320106-1-qperret@google.com>
Message-Id: <20210310175751.3320106-31-qperret@google.com>
Mime-Version: 1.0
References: <20210310175751.3320106-1-qperret@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v4 30/34] KVM: arm64: Add kvm_pgtable_stage2_find_range()
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, qperret@google.com, robh+dt@kernel.org,
        ardb@kernel.org
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

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_pgtable.h | 30 ++++++++++
 arch/arm64/kvm/hyp/pgtable.c         | 90 +++++++++++++++++++++++++++-
 2 files changed, 117 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index b09af4612656..477bf10c48a9 100644
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
@@ -398,4 +408,24 @@ int kvm_pgtable_stage2_flush(struct kvm_pgtable *pgt, u64 addr, u64 size);
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
+ * The offset of @addr within a page is ignored. An existing mapping is defined
+ * as compatible with @prot if it is invalid and not owned by another entity, or
+ * if its permission attributes are strictly similar to @prot and it has no
+ * software bits set.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int kvm_pgtable_stage2_find_range(struct kvm_pgtable *pgt, u64 addr,
+				  enum kvm_pgtable_prot prot,
+				  struct kvm_mem_range *range);
 #endif	/* __ARM64_KVM_PGTABLE_H__ */
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index c16e0306dd9a..f20287bb3e41 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -48,6 +48,8 @@
 					 KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W | \
 					 KVM_PTE_LEAF_ATTR_HI_S2_XN)
 
+#define KVM_PTE_LEAF_ATTR_S2_RES	GENMASK(58, 55)
+
 #define KVM_INVALID_PTE_OWNER_MASK	GENMASK(63, 32)
 
 struct kvm_pgtable_walk_data {
@@ -69,10 +71,8 @@ static u64 kvm_granule_size(u32 level)
 	return BIT(kvm_granule_shift(level));
 }
 
-static bool kvm_block_mapping_supported(u64 addr, u64 end, u64 phys, u32 level)
+static bool kvm_level_support_block_mappings(u32 level)
 {
-	u64 granule = kvm_granule_size(level);
-
 	/*
 	 * Reject invalid block mappings and don't bother with 4TB mappings for
 	 * 52-bit PAs.
@@ -80,6 +80,16 @@ static bool kvm_block_mapping_supported(u64 addr, u64 end, u64 phys, u32 level)
 	if (level == 0 || (PAGE_SIZE != SZ_4K && level == 1))
 		return false;
 
+	return true;
+}
+
+static bool kvm_block_mapping_supported(u64 addr, u64 end, u64 phys, u32 level)
+{
+	u64 granule = kvm_granule_size(level);
+
+	if (!kvm_level_support_block_mappings(level))
+		return false;
+
 	if (granule > (end - addr))
 		return false;
 
@@ -1042,3 +1052,77 @@ void kvm_pgtable_stage2_destroy(struct kvm_pgtable *pgt)
 	pgt->mm_ops->free_pages_exact(pgt->pgd, pgd_sz);
 	pgt->pgd = NULL;
 }
+
+#define KVM_PTE_LEAF_S2_COMPAT_MASK	(KVM_PTE_LEAF_ATTR_S2_PERMS | \
+					 KVM_PTE_LEAF_ATTR_LO_S2_MEMATTR | \
+					 KVM_PTE_LEAF_ATTR_S2_RES)
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
+		if (!kvm_level_support_block_mappings(level))
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
2.30.1.766.gb4fecdf3b7-goog

