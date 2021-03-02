Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1EDE32A83C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580000AbhCBRVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 12:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448626AbhCBPHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:07:48 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A065C0698D0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 07:01:11 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id v13so10265626wrs.21
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 07:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=5Zt+as2f0a/zAo23kFlziOtkEY/5uJ8Xq9YYontT/aE=;
        b=oy/UdeB5LbnLjtFmM/dbYim6mMzp2qHYBSC13VZs9FaJTFSyaT5CDRtQj/Eb4TG+BN
         0qtiQe0mzOlHVdur176OUctyO9lmahpfO/cGM2Iz8/eLYjlye4xly371PfFUU6L1dmsW
         flOfBgxFPo02Ph1rABAUHRoOy8BisQRcd1qsoH8uwGogHwNT1F7aM+pl3qwYmMwE3rZ9
         EOf4aVi4DTalvrWxvq7Nfmlls3aOTfLbQl8kPnYd+v0IKHNr1fcEHNU1ksLlXUbt8htj
         tPYk6Ic5sJ+UTglqHEL5gmqam/FGCqcrJCZzjWFrHaxx9v8IRAOvLk/SYa3HSSkqCdAe
         wljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5Zt+as2f0a/zAo23kFlziOtkEY/5uJ8Xq9YYontT/aE=;
        b=fPkSh3y8i4BivXScpxQG54p3JXEyUKL/9JnIGktQ9jjs7Xo926f3Jjpi8yb5V1h/mx
         o/0hTILPTU1b9/BVB5l4pciGC6SGPtv71XSRVD9iEku037zgm7FtSEP0a9e89rU/sSGh
         4axOKM6SuNwU2cS+jrRJEXoTsungel1ky4TcaTRRLR6D6ZuzElL15k+P0IVgmcYnUzE/
         PgnkB134nYmC+ZwaCfPKTbmAV7kxjrIOouCEBTNgB1tD7tbkFy2aSmqYrWBXopwRj0Wj
         t8RBZb1u/ljlmkYiQDeyhAfBOo2omntHrZAV0P7TBc+plfHleqfKLlKEdvoIszng3XtU
         5MfQ==
X-Gm-Message-State: AOAM531kFgkuMHI+ecbOM9ZD4SQnOL0ge/Yf/mtl30R0gvqYUnux3ATA
        QQzX8o0gF4UqRp91Fnr6zQlOW60CHEH7
X-Google-Smtp-Source: ABdhPJxty67guDux2vyMCWfPogWra+Q8rpbOely2ebtEwkY4f4QkKw5qaFq5tmMfz2TLhcjiBewjHI5nTeut
Sender: "qperret via sendgmr" <qperret@r2d2-qp.c.googlers.com>
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a05:600c:2254:: with SMTP id
 a20mr4602912wmm.115.1614697269979; Tue, 02 Mar 2021 07:01:09 -0800 (PST)
Date:   Tue,  2 Mar 2021 14:59:58 +0000
In-Reply-To: <20210302150002.3685113-1-qperret@google.com>
Message-Id: <20210302150002.3685113-29-qperret@google.com>
Mime-Version: 1.0
References: <20210302150002.3685113-1-qperret@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v3 28/32] KVM: arm64: Add kvm_pgtable_stage2_idmap_greedy()
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, qperret@google.com, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new map function to the KVM page-table library that allows to
greedily create block identity-mappings. This will be useful to create
lazily the host stage 2 page-table as it will own most of memory and
will always be identity mapped.

The new helper function creates the mapping in 2 steps: it first walks
the page-table to compute the largest possible granule that can be used
to idmap a given address without overriding existing incompatible
mappings; and then creates a mapping accordingly.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_pgtable.h |  37 +++++++++
 arch/arm64/kvm/hyp/pgtable.c         | 119 +++++++++++++++++++++++++++
 2 files changed, 156 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index c9f6ed76e0ad..e51dcce69a5e 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -96,6 +96,16 @@ enum kvm_pgtable_prot {
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
@@ -379,4 +389,31 @@ int kvm_pgtable_stage2_flush(struct kvm_pgtable *pgt, u64 addr, u64 size);
 int kvm_pgtable_walk(struct kvm_pgtable *pgt, u64 addr, u64 size,
 		     struct kvm_pgtable_walker *walker);
 
+/**
+ * kvm_pgtable_stage2_idmap_greedy() - Identity-map an Intermediate Physical
+ *				       Address with a leaf entry at the highest
+ *				       possible level.
+ * @pgt:	Page-table structure initialised by kvm_pgtable_*_init().
+ * @addr:	Input address to identity-map.
+ * @prot:	Permissions and attributes for the mapping.
+ * @range:	Boundaries of the maximum memory region to map.
+ * @mc:		Cache of pre-allocated memory from which to allocate page-table
+ *		pages.
+ *
+ * This function attempts to install high-level identity-mappings covering @addr
+ * without overriding existing mappings with incompatible permissions or
+ * attributes. An existing table entry may be coalesced into a block mapping
+ * if and only if it covers @addr and all its leafs are either invalid and/or
+ * have permissions and attributes strictly matching @prot. The mapping is
+ * guaranteed to be contained within the boundaries specified by @range at call
+ * time. If only a subset of the memory specified by @range is mapped (because
+ * of e.g. alignment issues or existing incompatible mappings), @range will be
+ * updated accordingly.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int kvm_pgtable_stage2_idmap_greedy(struct kvm_pgtable *pgt, u64 addr,
+				    enum kvm_pgtable_prot prot,
+				    struct kvm_mem_range *range,
+				    void *mc);
 #endif	/* __ARM64_KVM_PGTABLE_H__ */
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 8aa01a9e2603..6897d771e2b2 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -987,3 +987,122 @@ void kvm_pgtable_stage2_destroy(struct kvm_pgtable *pgt)
 	pgt->mm_ops->free_pages_exact(pgt->pgd, pgd_sz);
 	pgt->pgd = NULL;
 }
+
+struct stage2_reduce_range_data {
+	kvm_pte_t attr;
+	u64 target_addr;
+	u32 start_level;
+	struct kvm_mem_range *range;
+};
+
+static int __stage2_reduce_range(struct stage2_reduce_range_data *data, u64 addr)
+{
+	u32 level = data->start_level;
+
+	for (; level < KVM_PGTABLE_MAX_LEVELS; level++) {
+		u64 granule = kvm_granule_size(level);
+		u64 start = ALIGN_DOWN(data->target_addr, granule);
+		u64 end = start + granule;
+
+		/*
+		 * The pinned address is in the current range, try one level
+		 * deeper.
+		 */
+		if (start == ALIGN_DOWN(addr, granule))
+			continue;
+
+		/*
+		 * Make sure the current range is a reduction of the existing
+		 * range before updating it.
+		 */
+		if (data->range->start <= start && end <= data->range->end) {
+			data->start_level = level;
+			data->range->start = start;
+			data->range->end = end;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+#define KVM_PTE_LEAF_S2_COMPAT_MASK	(KVM_PTE_LEAF_ATTR_S2_PERMS | \
+					 KVM_PTE_LEAF_ATTR_LO_S2_MEMATTR | \
+					 KVM_PTE_LEAF_SW_BIT_PROT_NONE)
+
+static int stage2_reduce_range_walker(u64 addr, u64 end, u32 level,
+				      kvm_pte_t *ptep,
+				      enum kvm_pgtable_walk_flags flag,
+				      void * const arg)
+{
+	struct stage2_reduce_range_data *data = arg;
+	kvm_pte_t attr;
+	int ret;
+
+	if (addr < data->range->start || addr >= data->range->end)
+		return 0;
+
+	attr = *ptep & KVM_PTE_LEAF_S2_COMPAT_MASK;
+	if (!attr || attr == data->attr)
+		return 0;
+
+	/*
+	 * An existing mapping with incompatible protection attributes is
+	 * 'pinned', so reduce the range if we hit one.
+	 */
+	ret = __stage2_reduce_range(data, addr);
+	if (ret)
+		return ret;
+
+	return -EAGAIN;
+}
+
+static int stage2_reduce_range(struct kvm_pgtable *pgt, u64 addr,
+			       enum kvm_pgtable_prot prot,
+			       struct kvm_mem_range *range)
+{
+	struct stage2_reduce_range_data data = {
+		.start_level	= pgt->start_level,
+		.range		= range,
+		.target_addr	= addr,
+	};
+	struct kvm_pgtable_walker walker = {
+		.cb		= stage2_reduce_range_walker,
+		.flags		= KVM_PGTABLE_WALK_LEAF,
+		.arg		= &data,
+	};
+	int ret;
+
+	data.attr = stage2_get_prot_attr(prot) & KVM_PTE_LEAF_S2_COMPAT_MASK;
+	if (!data.attr)
+		return -EINVAL;
+
+	/* Reduce the kvm_mem_range to a granule size */
+	ret = __stage2_reduce_range(&data, range->end);
+	if (ret)
+		return ret;
+
+	/* Walk the range to check permissions and reduce further if needed */
+	do {
+		ret = kvm_pgtable_walk(pgt, range->start, range->end, &walker);
+	} while (ret == -EAGAIN);
+
+	return ret;
+}
+
+int kvm_pgtable_stage2_idmap_greedy(struct kvm_pgtable *pgt, u64 addr,
+				    enum kvm_pgtable_prot prot,
+				    struct kvm_mem_range *range,
+				    void *mc)
+{
+	u64 size;
+	int ret;
+
+	ret = stage2_reduce_range(pgt, addr, prot, range);
+	if (ret)
+		return ret;
+
+	size = range->end - range->start;
+	return kvm_pgtable_stage2_map(pgt, range->start, size, range->start,
+				      prot, mc);
+}
-- 
2.30.1.766.gb4fecdf3b7-goog

