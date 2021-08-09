Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33D83E48AD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbhHIPZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235567AbhHIPZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:25:24 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01433C06179C
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 08:25:03 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id bo13-20020a05621414adb029035561c68664so977568qvb.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 08:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nXWh1aBsmvvArSdynKqs/F6MGOyla+y37XGDQDAw0Zw=;
        b=cYfnUsIb5gGe+lWEdMn95RmDSxRUQoPfJdok4pDTRDFpRWfOU0ggbk9mfKP2zsxOUh
         GscOCxW3U2TBjao5XjoBagZImLZH1sNAULkmo2jw8VpjVzlpCivcuhOuCZwZPuvY+KCl
         hAD2kr6od+cAD1+GqOldj1CvFuTxUb7B8NZ51j4ufwBiHfiW6Tm4JyHxRwYCziDocagZ
         uoFADrALl5V/33jTieDKrHukSUoZfweS5IakvG1sJ5RrSD7eHFpVjbt0/Fh1sSvEF3c2
         KqkKTxt+xL7wbhcTpQUvE+6MzgrWIlXHS4E06USqLnvqPIi0HL3+gAKM1SKKoqlrQGdF
         8UsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nXWh1aBsmvvArSdynKqs/F6MGOyla+y37XGDQDAw0Zw=;
        b=uUYgmIRD6IjcmgWU1Q5EmjCUSnw155LM7N3VNBzIxeX4JXAM+KvFS18Do5KXEyqOmD
         DSOtZN3cPEfldyt+hcsBkKcD9uOkA0xsyax/B9xq4yLaz8f69X0T5hh8tXbDEofDKkKu
         92lOIgrq/lAEoP54qMjBfCTAHC0YED8DY8tEjW3ovESOSH6RDwSzxt2nVd8W+0ZTo2Jm
         NE/iuwWqbrh9HHaeDpWjskU2+u58tLxgjIksLEx98EzFP8jwByYbpDUAo3+IJ9O34rPL
         XB51A4/E77asJOpDslzw32CF6BqBRQj0mEu5bLAJFirJAT9lNCjR4F/yEqIclQLCWcfp
         Jekg==
X-Gm-Message-State: AOAM5322GwYdMkMdCnKViVEkwc+C42AiV02Kelk7SxT9vOndueZnE1jb
        c2VqCPr94yLuxmjQrYDQkA6A8zYXkodC
X-Google-Smtp-Source: ABdhPJzInJfMmMfgDqEILlYqnmWDME8lUUPA1VgIQarM5NixXRbdPCHLe8fmcxdPmKC8j+G1kAF2nZVLpZyc
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:b0e8:d460:758b:a0ae])
 (user=qperret job=sendgmr) by 2002:a0c:fe6a:: with SMTP id
 b10mr24245399qvv.6.1628522702203; Mon, 09 Aug 2021 08:25:02 -0700 (PDT)
Date:   Mon,  9 Aug 2021 16:24:32 +0100
In-Reply-To: <20210809152448.1810400-1-qperret@google.com>
Message-Id: <20210809152448.1810400-6-qperret@google.com>
Mime-Version: 1.0
References: <20210809152448.1810400-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH v4 05/21] KVM: arm64: Expose page-table helpers
From:   Quentin Perret <qperret@google.com>
To:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        tabba@google.com, dbrazdil@google.com, kernel-team@android.com,
        qperret@google.com
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
 arch/arm64/include/asm/kvm_pgtable.h | 40 ++++++++++++++++++++++++++++
 arch/arm64/kvm/hyp/pgtable.c         | 39 ---------------------------
 2 files changed, 40 insertions(+), 39 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 082b9d65f40b..6938eac72c1f 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -25,6 +25,46 @@ static inline u64 kvm_get_parange(u64 mmfr0)
 
 typedef u64 kvm_pte_t;
 
+#define KVM_PTE_VALID			BIT(0)
+
+#define KVM_PTE_ADDR_MASK		GENMASK(47, PAGE_SHIFT)
+#define KVM_PTE_ADDR_51_48		GENMASK(15, 12)
+
+static inline bool kvm_pte_valid(kvm_pte_t pte)
+{
+	return pte & KVM_PTE_VALID;
+}
+
+static inline u64 kvm_pte_to_phys(kvm_pte_t pte)
+{
+	u64 pa = pte & KVM_PTE_ADDR_MASK;
+
+	if (PAGE_SHIFT == 16)
+		pa |= FIELD_GET(KVM_PTE_ADDR_51_48, pte) << 48;
+
+	return pa;
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
index 78f36bd5df6c..49d768b92997 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -11,16 +11,12 @@
 #include <asm/kvm_pgtable.h>
 #include <asm/stage2_pgtable.h>
 
-#define KVM_PTE_VALID			BIT(0)
 
 #define KVM_PTE_TYPE			BIT(1)
 #define KVM_PTE_TYPE_BLOCK		0
 #define KVM_PTE_TYPE_PAGE		1
 #define KVM_PTE_TYPE_TABLE		1
 
-#define KVM_PTE_ADDR_MASK		GENMASK(47, PAGE_SHIFT)
-#define KVM_PTE_ADDR_51_48		GENMASK(15, 12)
-
 #define KVM_PTE_LEAF_ATTR_LO		GENMASK(11, 2)
 
 #define KVM_PTE_LEAF_ATTR_LO_S1_ATTRIDX	GENMASK(4, 2)
@@ -61,17 +57,6 @@ struct kvm_pgtable_walk_data {
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
@@ -79,15 +64,6 @@ static bool kvm_phys_is_valid(u64 phys)
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
@@ -135,11 +111,6 @@ static u32 kvm_pgd_pages(u32 ia_bits, u32 start_level)
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
@@ -151,16 +122,6 @@ static bool kvm_pte_table(kvm_pte_t pte, u32 level)
 	return FIELD_GET(KVM_PTE_TYPE, pte) == KVM_PTE_TYPE_TABLE;
 }
 
-static u64 kvm_pte_to_phys(kvm_pte_t pte)
-{
-	u64 pa = pte & KVM_PTE_ADDR_MASK;
-
-	if (PAGE_SHIFT == 16)
-		pa |= FIELD_GET(KVM_PTE_ADDR_51_48, pte) << 48;
-
-	return pa;
-}
-
 static kvm_pte_t kvm_phys_to_pte(u64 pa)
 {
 	kvm_pte_t pte = pa & KVM_PTE_ADDR_MASK;
-- 
2.32.0.605.g8dce9f2422-goog

