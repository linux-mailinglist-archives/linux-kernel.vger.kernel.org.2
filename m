Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB873CD2B4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 12:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236796AbhGSKHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 06:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236714AbhGSKHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 06:07:19 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEF2C061762
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 02:55:53 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id j11-20020ac8664b0000b029026549e62339so1472659qtp.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 03:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xQPZWURbGoPTKgOKUpwXSewirNhESBxNhrKKCWt7434=;
        b=L8RdXw4ttae5Vs2K7NINOKLZoBbdFGwfjXFWn8bkET0oJOKxBfwAPfw/a3CCFAChd3
         rZ/mUyHzvmIR3hJe+r7LrLjJt56aB+o/eRqcS+1BSFUEs5hR1ChiyAxlcdn2Zz7cHnLt
         5J4W9Oqi9c3E6GF4M6WDvGahS3AwZti3tVxlOF8inYB3t//iiG9q4OHpoPpJgF4pxAZ7
         oGL8UyjLVBTJSTFqtMlARZktzU1Hwr6mrMMHZXqXSR75VYbVotw0Yfe5bjfFx4t8YYHa
         c19lmbnAmZIW+93r6iI3/FvOpyk5tTSdKVwTvq6eqA8GF1nxCYVLrPThZ2bTv9UbNbHu
         7LPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xQPZWURbGoPTKgOKUpwXSewirNhESBxNhrKKCWt7434=;
        b=eOnYsTF2ry5lZAdbyA7umU7VI2aCb4s8tU0ulUgesGM2gPgIo9Vrk261kH8r9MsL5w
         3YnQcIMppjLlL28Ahp3MgyV720g1l8ckHMLpbH4u9o0gfuqU5NxtbHB5g3bjhuglstp+
         WbFp2b7OgUjpvdYQqceDQm+EG5q9L8SkO/1m0FUYvQqjBxto3+vQxgaUgs1aQ+LFg3zd
         rBew9M4KDuHQzsC5h4oUV6nXWCjGXX+8cZkAaj5xie52VpFsRfTW05Z+aqep97E8qMWv
         rQ5X8d4U/ZOWXpO7u7hF6fPsgXAWYCuGDg9owE7h6TE6lBb5B40NLbk4VgP0ZF85kcGc
         dLVQ==
X-Gm-Message-State: AOAM530Y+JD5aWjygz0OAhPqV2CIoS1oSu/ViSTm5qm+eieY/RqYg3VU
        5o76QatXdPUttGYZr/y55I/KX7mwtKG3
X-Google-Smtp-Source: ABdhPJyrkesxT86s4Tj/djq2B3CEsycyHyzOhzkaxyjOrOLuPXgOsyycOyHK+NTGbCGeSB4g1fJRBUf3HDlq
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:1a96:a43f:6c2e:bb5a])
 (user=qperret job=sendgmr) by 2002:a0c:9ac7:: with SMTP id
 k7mr24138746qvf.49.1626691677038; Mon, 19 Jul 2021 03:47:57 -0700 (PDT)
Date:   Mon, 19 Jul 2021 11:47:28 +0100
In-Reply-To: <20210719104735.3681732-1-qperret@google.com>
Message-Id: <20210719104735.3681732-8-qperret@google.com>
Mime-Version: 1.0
References: <20210719104735.3681732-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH 07/14] KVM: arm64: Enable forcing page-level stage-2 mappings
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

Much of the stage-2 manipulation logic relies on being able to destroy
block mappings if e.g. installing a smaller mapping in the range. The
rationale for this behaviour is that stage-2 mappings can always be
re-created lazily. However, this gets more complicated when the stage-2
page-table is used to store metadata about the underlying pages. In such
a case, destroying a block mapping may lead to losing part of the
state, and confuse the user of those metadata (such as the hypervisor in
nVHE protected mode).

To fix this, introduce a callback function in the pgtable struct which
is called during all map operations to determine whether the mappings
can us blocks, or should be forced to page-granularity level. This is
used by the hypervisor when creating the host stage-2 to force
page-level mappings when using non-default protection attributes.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_pgtable.h  | 63 +++++++++++++++++----------
 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 16 +++++--
 arch/arm64/kvm/hyp/pgtable.c          | 20 +++++++--
 3 files changed, 69 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index af62203d2f7a..dd72653314c7 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -75,25 +75,6 @@ enum kvm_pgtable_stage2_flags {
 	KVM_PGTABLE_S2_IDMAP			= BIT(1),
 };
 
-/**
- * struct kvm_pgtable - KVM page-table.
- * @ia_bits:		Maximum input address size, in bits.
- * @start_level:	Level at which the page-table walk starts.
- * @pgd:		Pointer to the first top-level entry of the page-table.
- * @mm_ops:		Memory management callbacks.
- * @mmu:		Stage-2 KVM MMU struct. Unused for stage-1 page-tables.
- */
-struct kvm_pgtable {
-	u32					ia_bits;
-	u32					start_level;
-	kvm_pte_t				*pgd;
-	struct kvm_pgtable_mm_ops		*mm_ops;
-
-	/* Stage-2 only */
-	struct kvm_s2_mmu			*mmu;
-	enum kvm_pgtable_stage2_flags		flags;
-};
-
 /**
  * enum kvm_pgtable_prot - Page-table permissions and attributes.
  * @KVM_PGTABLE_PROT_X:		Execute permission.
@@ -109,11 +90,41 @@ enum kvm_pgtable_prot {
 	KVM_PGTABLE_PROT_DEVICE			= BIT(3),
 };
 
-#define PAGE_HYP		(KVM_PGTABLE_PROT_R | KVM_PGTABLE_PROT_W)
+#define KVM_PGTABLE_PROT_RW	(KVM_PGTABLE_PROT_R | KVM_PGTABLE_PROT_W)
+#define KVM_PGTABLE_PROT_RWX	(KVM_PGTABLE_PROT_RW | KVM_PGTABLE_PROT_X)
+
+#define PAGE_HYP		KVM_PGTABLE_PROT_RW
 #define PAGE_HYP_EXEC		(KVM_PGTABLE_PROT_R | KVM_PGTABLE_PROT_X)
 #define PAGE_HYP_RO		(KVM_PGTABLE_PROT_R)
 #define PAGE_HYP_DEVICE		(PAGE_HYP | KVM_PGTABLE_PROT_DEVICE)
 
+typedef bool (*kvm_pgtable_want_pte_cb_t)(u64 addr, u64 end,
+					  enum kvm_pgtable_prot prot);
+
+/**
+ * struct kvm_pgtable - KVM page-table.
+ * @ia_bits:		Maximum input address size, in bits.
+ * @start_level:	Level at which the page-table walk starts.
+ * @pgd:		Pointer to the first top-level entry of the page-table.
+ * @mm_ops:		Memory management callbacks.
+ * @mmu:		Stage-2 KVM MMU struct. Unused for stage-1 page-tables.
+ * @flags:		Stage-2 page-table flags.
+ * @want_pte_cb:	Callback function used during map operations to decide
+ *			whether block mappings can be used to map the given IPA
+ *			range.
+ */
+struct kvm_pgtable {
+	u32					ia_bits;
+	u32					start_level;
+	kvm_pte_t				*pgd;
+	struct kvm_pgtable_mm_ops		*mm_ops;
+
+	/* Stage-2 only */
+	struct kvm_s2_mmu			*mmu;
+	enum kvm_pgtable_stage2_flags		flags;
+	kvm_pgtable_want_pte_cb_t		want_pte_cb;
+};
+
 /**
  * struct kvm_mem_range - Range of Intermediate Physical Addresses
  * @start:	Start of the range.
@@ -216,21 +227,25 @@ int kvm_pgtable_hyp_map(struct kvm_pgtable *pgt, u64 addr, u64 size, u64 phys,
 u64 kvm_get_vtcr(u64 mmfr0, u64 mmfr1, u32 phys_shift);
 
 /**
- * kvm_pgtable_stage2_init_flags() - Initialise a guest stage-2 page-table.
+ * kvm_pgtable_stage2_init_full() - Initialise a guest stage-2 page-table.
  * @pgt:	Uninitialised page-table structure to initialise.
  * @arch:	Arch-specific KVM structure representing the guest virtual
  *		machine.
  * @mm_ops:	Memory management callbacks.
  * @flags:	Stage-2 configuration flags.
+ * @want_pte_cb: Callback function used during map operations to decide
+ *		whether block mappings can be used to map the given IPA
+ *		range.
  *
  * Return: 0 on success, negative error code on failure.
  */
-int kvm_pgtable_stage2_init_flags(struct kvm_pgtable *pgt, struct kvm_arch *arch,
+int kvm_pgtable_stage2_init_full(struct kvm_pgtable *pgt, struct kvm_arch *arch,
 				  struct kvm_pgtable_mm_ops *mm_ops,
-				  enum kvm_pgtable_stage2_flags flags);
+				  enum kvm_pgtable_stage2_flags flags,
+				  kvm_pgtable_want_pte_cb_t want_pte_cb);
 
 #define kvm_pgtable_stage2_init(pgt, arch, mm_ops) \
-	kvm_pgtable_stage2_init_flags(pgt, arch, mm_ops, 0)
+	kvm_pgtable_stage2_init_full(pgt, arch, mm_ops, 0, NULL)
 
 /**
  * kvm_pgtable_stage2_destroy() - Destroy an unused guest stage-2 page-table.
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 58edc62be6f7..cdace80d3e28 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -89,6 +89,7 @@ static void prepare_host_vtcr(void)
 					  id_aa64mmfr1_el1_sys_val, phys_shift);
 }
 
+static bool host_stage2_want_pte_cb(u64 addr, u64 end, enum kvm_pgtable_prot prot);
 int kvm_host_prepare_stage2(void *pgt_pool_base)
 {
 	struct kvm_s2_mmu *mmu = &host_kvm.arch.mmu;
@@ -101,8 +102,9 @@ int kvm_host_prepare_stage2(void *pgt_pool_base)
 	if (ret)
 		return ret;
 
-	ret = kvm_pgtable_stage2_init_flags(&host_kvm.pgt, &host_kvm.arch,
-					    &host_kvm.mm_ops, KVM_HOST_S2_FLAGS);
+	ret = kvm_pgtable_stage2_init_full(&host_kvm.pgt, &host_kvm.arch,
+					   &host_kvm.mm_ops, KVM_HOST_S2_FLAGS,
+					   host_stage2_want_pte_cb);
 	if (ret)
 		return ret;
 
@@ -225,9 +227,17 @@ static inline int __host_stage2_idmap(u64 start, u64 end,
 		__ret;							\
 	 })
 
+static bool host_stage2_want_pte_cb(u64 addr, u64 end, enum kvm_pgtable_prot prot)
+{
+	if (range_is_memory(addr, end))
+		return prot != KVM_PGTABLE_PROT_RWX;
+	else
+		return prot != KVM_PGTABLE_PROT_RW;
+}
+
 static int host_stage2_idmap(u64 addr)
 {
-	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_R | KVM_PGTABLE_PROT_W;
+	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_RW;
 	struct kvm_mem_range range;
 	bool is_memory = find_mem_range(addr, &range);
 	int ret;
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 34cf67997a82..5bdbe7a31551 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -452,6 +452,8 @@ int kvm_pgtable_hyp_init(struct kvm_pgtable *pgt, u32 va_bits,
 	pgt->start_level	= KVM_PGTABLE_MAX_LEVELS - levels;
 	pgt->mm_ops		= mm_ops;
 	pgt->mmu		= NULL;
+	pgt->want_pte_cb	= NULL;
+
 	return 0;
 }
 
@@ -491,6 +493,7 @@ struct stage2_map_data {
 	struct kvm_pgtable_mm_ops	*mm_ops;
 
 	int				ret;
+	bool				force_pte;
 };
 
 u64 kvm_get_vtcr(u64 mmfr0, u64 mmfr1, u32 phys_shift)
@@ -613,6 +616,9 @@ static int stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
 	struct kvm_pgtable *pgt = data->mmu->pgt;
 	struct kvm_pgtable_mm_ops *mm_ops = data->mm_ops;
 
+	if (data->force_pte && (level < (KVM_PGTABLE_MAX_LEVELS - 1)))
+		return -E2BIG;
+
 	if (!kvm_block_mapping_supported(addr, end, phys, level))
 		return -E2BIG;
 
@@ -660,6 +666,9 @@ static int stage2_map_walk_table_pre(u64 addr, u64 end, u32 level,
 	if (data->anchor)
 		return 0;
 
+	if (data->force_pte && (level < (KVM_PGTABLE_MAX_LEVELS - 1)))
+		return 0;
+
 	if (!kvm_block_mapping_supported(addr, end, data->phys, level))
 		return 0;
 
@@ -791,6 +800,7 @@ int kvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
 		.memcache	= mc,
 		.mm_ops		= pgt->mm_ops,
 		.ret		= 0,
+		.force_pte	= pgt->want_pte_cb && pgt->want_pte_cb(addr, addr + size, prot),
 	};
 	struct kvm_pgtable_walker walker = {
 		.cb		= stage2_map_walker,
@@ -826,6 +836,7 @@ int kvm_pgtable_stage2_set_owner(struct kvm_pgtable *pgt, u64 addr, u64 size,
 		.mm_ops		= pgt->mm_ops,
 		.owner_id	= owner_id,
 		.ret		= 0,
+		.force_pte	= true,
 	};
 	struct kvm_pgtable_walker walker = {
 		.cb		= stage2_map_walker,
@@ -1070,9 +1081,11 @@ int kvm_pgtable_stage2_flush(struct kvm_pgtable *pgt, u64 addr, u64 size)
 	return kvm_pgtable_walk(pgt, addr, size, &walker);
 }
 
-int kvm_pgtable_stage2_init_flags(struct kvm_pgtable *pgt, struct kvm_arch *arch,
-				  struct kvm_pgtable_mm_ops *mm_ops,
-				  enum kvm_pgtable_stage2_flags flags)
+
+int kvm_pgtable_stage2_init_full(struct kvm_pgtable *pgt, struct kvm_arch *arch,
+				 struct kvm_pgtable_mm_ops *mm_ops,
+				 enum kvm_pgtable_stage2_flags flags,
+				 kvm_pgtable_want_pte_cb_t want_pte_cb)
 {
 	size_t pgd_sz;
 	u64 vtcr = arch->vtcr;
@@ -1090,6 +1103,7 @@ int kvm_pgtable_stage2_init_flags(struct kvm_pgtable *pgt, struct kvm_arch *arch
 	pgt->mm_ops		= mm_ops;
 	pgt->mmu		= &arch->mmu;
 	pgt->flags		= flags;
+	pgt->want_pte_cb	= want_pte_cb;
 
 	/* Ensure zeroed PGD pages are visible to the hardware walker */
 	dsb(ishst);
-- 
2.32.0.402.g57bb445576-goog

