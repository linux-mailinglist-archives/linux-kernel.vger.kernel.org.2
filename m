Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B903D568F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 11:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbhGZIsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 04:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbhGZIsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 04:48:51 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20048C061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 02:29:19 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id k13-20020a05600c1c8db029025018ac4f7dso1267841wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 02:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=q1zqD73fJkFVmAAq4dO3uZVcGUuPFE+HczOzBsWKqIA=;
        b=MGESZEF7diylBA6Kx1cQU7HsTAr2Dx3Sx2H/5ckbKa1+lNzUwqXNq3+HyK7pQ7t+79
         GdSkBeHZk2on8PnJvvmF7eeNr3gYvaA4hb2R/vEdxFXLjdIYQMs6dXGIAgcJKAFuJuvk
         9YIEBUcgIAThdYkh3hLGPnW+J4a2ufP8TaR5xvj7I7smpbQd6k81PXyf0wIvDOjPHSnO
         GsUi68byOHXQ1RiabG7/pQ9xq3UZP89oLuQwZsRgH0Szp0DpmeIOIEA518pldBB0RMru
         b5fxHNLKCpJtoYgrOEFncCNUgrmp+YvtHf1zA5RkIxmDYe9WMiYoGQg0yzNbKzMtuKKm
         B4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=q1zqD73fJkFVmAAq4dO3uZVcGUuPFE+HczOzBsWKqIA=;
        b=T/h/cSxZ+W2dB//MoGuhWmQyUEWFFfcZfjcvxsJNtp2r8YWDDTL3x5wKVoKcbjIehr
         JOLe0y6GwSo7NuPvHjhMAtggbW9SOHqAD1ZVFHl8/Jc0pau8BU/0MgnrnPfaBjaZ3cFv
         xvexzgF0ox9mDtKwhaMhqRkQYdCS+9/YElqmKH6G7OJTzfGWmUo1gMemBz1ud/rjEiYf
         4AjRUeAZSbZrUKAr32R60honrsHRvNukSBY2SNYKXz8xP6/M1TWkxT40UbolG46HhSM4
         WG5mIoR5RwbIu6/gYWU2D6v1gLxKCeFY5K8pmF9NqKOvpPwyo1kG6FHVRd3l5Rzjt6ne
         hrRQ==
X-Gm-Message-State: AOAM533co86Rku7LbtygFAE+lzSbyhq6Xxcuuy30uWczu45D+JLZNqVh
        XGk6NrWDWNufyc7qprwo3MzF31UyIde+
X-Google-Smtp-Source: ABdhPJx1wCuqsWbjKEjDSr1O9R264wGcMnHVqFdGsLki/Uzi81IzUAaHKQtIg2C1kDCAaUPziAz6p3UcRgZ0
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:23a0:2f14:433:e6cb])
 (user=qperret job=sendgmr) by 2002:a05:6000:120f:: with SMTP id
 e15mr17783536wrx.399.1627291757591; Mon, 26 Jul 2021 02:29:17 -0700 (PDT)
Date:   Mon, 26 Jul 2021 10:28:52 +0100
In-Reply-To: <20210726092905.2198501-1-qperret@google.com>
Message-Id: <20210726092905.2198501-4-qperret@google.com>
Mime-Version: 1.0
References: <20210726092905.2198501-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v2 03/16] KVM: arm64: Expose page-table helpers
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

The KVM pgtable API exposes the kvm_pgtable_walk() function to allow
the definition of walkers outside of pgtable.c. However, it is not easy
to implement any of those walkers without some of the low-level helpers.
Move some of them to the header file to allow re-use from other places.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_pgtable.h | 27 +++++++++++++++++++++++++++
 arch/arm64/kvm/hyp/pgtable.c         | 26 --------------------------
 2 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 082b9d65f40b..5a7a13bbd4a1 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -25,6 +25,33 @@ static inline u64 kvm_get_parange(u64 mmfr0)
 
 typedef u64 kvm_pte_t;
 
+#define KVM_PTE_VALID			BIT(0)
+
+static inline bool kvm_pte_valid(kvm_pte_t pte)
+{
+	return pte & KVM_PTE_VALID;
+}
+
+static inline u64 kvm_granule_shift(u32 level)
+{
+	/* Assumes KVM_PGTABLE_MAX_LEVELS is 4 */
+	return ARM64_HW_PGTABLE_LEVEL_SHIFT(level);
+}
+
+static inline u64 kvm_granule_size(u32 level)
+{
+	return BIT(kvm_granule_shift(level));
+}
+
+static inline bool kvm_level_supports_block_mapping(u32 level)
+{
+	/*
+	 * Reject invalid block mappings and don't bother with 4TB mappings for
+	 * 52-bit PAs.
+	 */
+	return !(level == 0 || (PAGE_SIZE != SZ_4K && level == 1));
+}
+
 /**
  * struct kvm_pgtable_mm_ops - Memory management callbacks.
  * @zalloc_page:		Allocate a single zeroed memory page.
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 78f36bd5df6c..2c5d4d3e31cc 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -11,7 +11,6 @@
 #include <asm/kvm_pgtable.h>
 #include <asm/stage2_pgtable.h>
 
-#define KVM_PTE_VALID			BIT(0)
 
 #define KVM_PTE_TYPE			BIT(1)
 #define KVM_PTE_TYPE_BLOCK		0
@@ -61,17 +60,6 @@ struct kvm_pgtable_walk_data {
 	u64				end;
 };
 
-static u64 kvm_granule_shift(u32 level)
-{
-	/* Assumes KVM_PGTABLE_MAX_LEVELS is 4 */
-	return ARM64_HW_PGTABLE_LEVEL_SHIFT(level);
-}
-
-static u64 kvm_granule_size(u32 level)
-{
-	return BIT(kvm_granule_shift(level));
-}
-
 #define KVM_PHYS_INVALID (-1ULL)
 
 static bool kvm_phys_is_valid(u64 phys)
@@ -79,15 +67,6 @@ static bool kvm_phys_is_valid(u64 phys)
 	return phys < BIT(id_aa64mmfr0_parange_to_phys_shift(ID_AA64MMFR0_PARANGE_MAX));
 }
 
-static bool kvm_level_supports_block_mapping(u32 level)
-{
-	/*
-	 * Reject invalid block mappings and don't bother with 4TB mappings for
-	 * 52-bit PAs.
-	 */
-	return !(level == 0 || (PAGE_SIZE != SZ_4K && level == 1));
-}
-
 static bool kvm_block_mapping_supported(u64 addr, u64 end, u64 phys, u32 level)
 {
 	u64 granule = kvm_granule_size(level);
@@ -135,11 +114,6 @@ static u32 kvm_pgd_pages(u32 ia_bits, u32 start_level)
 	return __kvm_pgd_page_idx(&pgt, -1ULL) + 1;
 }
 
-static bool kvm_pte_valid(kvm_pte_t pte)
-{
-	return pte & KVM_PTE_VALID;
-}
-
 static bool kvm_pte_table(kvm_pte_t pte, u32 level)
 {
 	if (level == KVM_PGTABLE_MAX_LEVELS - 1)
-- 
2.32.0.432.gabb21c7263-goog

