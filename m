Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B8B3CD2AF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 12:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236684AbhGSKHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 06:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236604AbhGSKHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 06:07:07 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE0BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 02:55:41 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id t8-20020a05600001c8b029013e2027cf9aso8524244wrx.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 03:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1v6USBe8mNAVx9OftewEBHt9DvMOxZznDU6MzJZEG7M=;
        b=tdSbuopKCmoJ0ZYg7u+hYeez6RMuzLcn3HSKhcMvEa15oU4q+BUnmsmih8waTH+10G
         c+KOEs+YuXqX5TSWUQQ0/9lQAsSPs3MxhyHKGv2WmtqS/tr6MuOkdtUuN1XRyalXyOko
         jLhvjnzUgRhWxsPGGCNHzueJi5oQGIiUNcv0paNQimuP3x4o57Mu4nIOjXPN+GhgHpjo
         72M930OJqoABPALkQ0VW7pcKmOUAllWIf39LmYK+lIm7buRM7El/jepJCucRdx7w7O4U
         1ZeyRt+T2RNNJpSSW3tFB63GYZ8RtnVDy4YXFMjfLoUKSRQbJq5GA9nOjY06ImjHKdAv
         XMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1v6USBe8mNAVx9OftewEBHt9DvMOxZznDU6MzJZEG7M=;
        b=TvcqIXekqe/YIGEq407JLhIrfpvA615oVhgyTxE8DObtEp1P5Z6qOPWnp80HDVXGux
         1sk6OSL5x34q18nxXB1f+GhkRLUBI9kIQuLiyn4JN1lRKdJ2EL1Uw3AnAN3hY+UeGvBx
         +h2bV6KM9RqQqBkJG1c0OUi2VFOPxUvbqGvGcSUmWEPUMN14hhljmPgx9Hiy4jWLwajJ
         0JS4R6eTqFlVntj92A3ilUzcpBpjUt5X6CwUeMdolUsbuJK+iy0mnNWeEnHkEJirdd2n
         1YoSVgt8K/6RqWd+ZfGyke9ixg/IyBmczH7LZR92laYsghErUFlPfMHwgbRcqsFdt7di
         DrEg==
X-Gm-Message-State: AOAM530V85O0pH5Fe8T6oVf6ZJGhRTddA8dMtOP5cRU0JyT7+Z/idcaf
        x/yJE5AQFF7/ldckxcgUiswvQ+mBuasS
X-Google-Smtp-Source: ABdhPJyR/5wrZXgluPqs2G8EtvNO/lpHpYOHQfbllOEj1h1n4cc3TBv5wr06GFFQFtrZVrhIWfKadbzl5L0S
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:1a96:a43f:6c2e:bb5a])
 (user=qperret job=sendgmr) by 2002:a7b:c1c7:: with SMTP id
 a7mr1853502wmj.1.1626691665402; Mon, 19 Jul 2021 03:47:45 -0700 (PDT)
Date:   Mon, 19 Jul 2021 11:47:23 +0100
In-Reply-To: <20210719104735.3681732-1-qperret@google.com>
Message-Id: <20210719104735.3681732-3-qperret@google.com>
Mime-Version: 1.0
References: <20210719104735.3681732-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH 02/14] KVM: arm64: Optimize kvm_pgtable_stage2_find_range()
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

To avoid these issues, rework kvm_pgtable_stage2_find_range() by walking
the page-table only once to find the closest leaf to the input address,
and return its corresponding range if it is invalid and not owned by
another entity. If a valid leaf is found, return -EAGAIN similar to what
is done in the kvm_pgtable_stage2_map() path to optimize concurrent
faults.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_pgtable.h  | 12 ++---
 arch/arm64/kvm/hyp/nvhe/mem_protect.c |  2 +-
 arch/arm64/kvm/hyp/pgtable.c          | 74 +++++++++++----------------
 3 files changed, 34 insertions(+), 54 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index f004c0115d89..d6649352c8b3 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -434,21 +434,17 @@ int kvm_pgtable_walk(struct kvm_pgtable *pgt, u64 addr, u64 size,
 
 /**
  * kvm_pgtable_stage2_find_range() - Find a range of Intermediate Physical
- *				     Addresses with compatible permission
- *				     attributes.
+ *				     Addresses with a given ownership.
  * @pgt:	Page-table structure initialised by kvm_pgtable_stage2_init*().
  * @addr:	Address that must be covered by the range.
- * @prot:	Protection attributes that the range must be compatible with.
+ * @owner:	Expected owner of the pages of the range.
  * @range:	Range structure used to limit the search space at call time and
  *		that will hold the result.
  *
- * The offset of @addr within a page is ignored. An IPA is compatible with @prot
- * iff its corresponding stage-2 page-table entry has default ownership and, if
- * valid, is mapped with protection attributes identical to @prot.
+ * The offset of @addr within a page is ignored.
  *
  * Return: 0 on success, negative error code on failure.
  */
 int kvm_pgtable_stage2_find_range(struct kvm_pgtable *pgt, u64 addr,
-				  enum kvm_pgtable_prot prot,
-				  struct kvm_mem_range *range);
+				  int owner, struct kvm_mem_range *range);
 #endif	/* __ARM64_KVM_PGTABLE_H__ */
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 56f2117c877b..58edc62be6f7 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -236,7 +236,7 @@ static int host_stage2_idmap(u64 addr)
 		prot |= KVM_PGTABLE_PROT_X;
 
 	hyp_spin_lock(&host_kvm.lock);
-	ret = kvm_pgtable_stage2_find_range(&host_kvm.pgt, addr, prot, &range);
+	ret = kvm_pgtable_stage2_find_range(&host_kvm.pgt, addr, 0, &range);
 	if (ret)
 		goto unlock;
 
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 05321f4165e3..978f341d02ca 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -1103,76 +1103,60 @@ void kvm_pgtable_stage2_destroy(struct kvm_pgtable *pgt)
 	pgt->pgd = NULL;
 }
 
-#define KVM_PTE_LEAF_S2_COMPAT_MASK	(KVM_PTE_LEAF_ATTR_S2_PERMS | \
-					 KVM_PTE_LEAF_ATTR_LO_S2_MEMATTR | \
-					 KVM_PTE_LEAF_ATTR_S2_IGNORED)
+struct stage2_check_permission_data {
+	u32 level;
+	u8 owner;
+};
 
 static int stage2_check_permission_walker(u64 addr, u64 end, u32 level,
 					  kvm_pte_t *ptep,
 					  enum kvm_pgtable_walk_flags flag,
 					  void * const arg)
 {
-	kvm_pte_t old_attr, pte = *ptep, *new_attr = arg;
+	struct stage2_check_permission_data *data = arg;
+	kvm_pte_t pte = *ptep;
 
-	/*
-	 * Compatible mappings are either invalid and owned by the page-table
-	 * owner (whose id is 0), or valid with matching permission attributes.
-	 */
-	if (kvm_pte_valid(pte)) {
-		old_attr = pte & KVM_PTE_LEAF_S2_COMPAT_MASK;
-		if (old_attr != *new_attr)
-			return -EEXIST;
-	} else if (pte) {
+	if (kvm_pte_valid(pte))
+		return -EAGAIN;
+
+	if (FIELD_GET(KVM_INVALID_PTE_OWNER_MASK, pte) != data->owner)
 		return -EEXIST;
-	}
+
+	data->level = level;
 
 	return 0;
 }
 
 int kvm_pgtable_stage2_find_range(struct kvm_pgtable *pgt, u64 addr,
-				  enum kvm_pgtable_prot prot,
-				  struct kvm_mem_range *range)
+				  int owner, struct kvm_mem_range *range)
 {
-	kvm_pte_t attr;
+	struct stage2_check_permission_data data = {
+		.level		= pgt->start_level,
+		.owner		= owner,
+	};
 	struct kvm_pgtable_walker check_perm_walker = {
 		.cb		= stage2_check_permission_walker,
 		.flags		= KVM_PGTABLE_WALK_LEAF,
-		.arg		= &attr,
+		.arg		= &data,
 	};
-	u64 granule, start, end;
-	u32 level;
+	u64 granule, end, start = ALIGN_DOWN(addr, PAGE_SIZE);
 	int ret;
 
-	ret = stage2_set_prot_attr(pgt, prot, &attr);
+	ret = kvm_pgtable_walk(pgt, start, PAGE_SIZE, &check_perm_walker);
 	if (ret)
 		return ret;
-	attr &= KVM_PTE_LEAF_S2_COMPAT_MASK;
 
-	for (level = pgt->start_level; level < KVM_PGTABLE_MAX_LEVELS; level++) {
-		granule = kvm_granule_size(level);
+	do {
+		granule = kvm_granule_size(data.level);
 		start = ALIGN_DOWN(addr, granule);
 		end = start + granule;
+		data.level++;
+	} while ((data.level < KVM_PGTABLE_MAX_LEVELS) &&
+			(!kvm_level_supports_block_mapping(data.level) ||
+			 start < range->start || range->end < end));
 
-		if (!kvm_level_supports_block_mapping(level))
-			continue;
-
-		if (start < range->start || range->end < end)
-			continue;
+	range->start = start;
+	range->end = end;
 
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
+	return 0;
 }
-- 
2.32.0.402.g57bb445576-goog

