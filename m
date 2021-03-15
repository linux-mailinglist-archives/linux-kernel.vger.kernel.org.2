Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7D633BEEF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 15:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239535AbhCOOvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 10:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236538AbhCOOgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 10:36:48 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6785C061763
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:36:26 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id t19so21287832qta.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8Wu35nI9NrZ39nGmxEHJAPybX2/9EPADxzWT2BkY6VI=;
        b=vwuAyzI86+G3j7zKlEAShCQ2hWkD+us794GFCz0kwntMa/wxau82zdlYF/AyBMPiEX
         qXuYhVGNeu31KSAzkCAPiBkCbr9mbg++iohF9DdjqlAGvFgBSivBzrsJANoTmLMlXpGh
         uXEaF50tpOzk2udI1ZdI0xdqmpNrDNnrdZ/757TH6scuUq3HQhknieeKTlFKzjTSprRi
         kzo+yW6bCT4vY46P2u8jbw7JJ9U/acg5BVWy30aNeXxt7C6G93dS2XRxQUB0pf1NapAx
         pF3zfOWKftDACj+0ZPKAMh871jiydKApVqkEBLSG29mF/6SvTpOsrKj+yIGT6lM5uwJ3
         V6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8Wu35nI9NrZ39nGmxEHJAPybX2/9EPADxzWT2BkY6VI=;
        b=cG7AWQEu+gOOv9lgskzIBlRWOWHkSPzGSn67jGAXcUEjmpqieaiicdwk68KcIhD3q4
         1FlQ0BcA1cD834MYIZ8VugX3k1Wn7q6Md/5ZGidPUwNRhUp8j+Sd4t6vIPoBYFTn0ax0
         LeXZzmjVdz0I+I13FK78MIaVTpoPvEdjJExvygBEra1lEZx1cTaKKFhRsibUGD0l1scQ
         N+AOoFYh86ftiuZCfR/UIIerOhSIhZjazCWqdrcSe9hUHnke9q3nNdonV+5ZUdCl77BR
         WXD8HTSUxmYz/y4AJMcZJLa3bNiFQHhlkKtruhuNHj2xUqTEaZAAlXN/3j0/7LzSDu/B
         UsTA==
X-Gm-Message-State: AOAM530zcbDhEOogaJyw4RpTMs/oVH4n3pj7erTf3BQd8RCau6SxbXZ0
        GXut0dAjLxgFYonHQioWF8ih45czJqPQ
X-Google-Smtp-Source: ABdhPJx3ThzoZ/ywxDwQ1LYp9JCm0vwbDmjxcr2Vfv6kbcYID94PC676GkcIaBk9K2bGSixyGZs/gkRiuu3m
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a0c:bdaf:: with SMTP id
 n47mr24598896qvg.48.1615818985957; Mon, 15 Mar 2021 07:36:25 -0700 (PDT)
Date:   Mon, 15 Mar 2021 14:35:22 +0000
In-Reply-To: <20210315143536.214621-1-qperret@google.com>
Message-Id: <20210315143536.214621-23-qperret@google.com>
Mime-Version: 1.0
References: <20210315143536.214621-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v5 22/36] KVM: arm64: Refactor kvm_arm_setup_stage2()
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

In order to re-use some of the stage 2 setup code at EL2, factor parts
of kvm_arm_setup_stage2() out into separate functions.

No functional change intended.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_pgtable.h | 26 +++++++++++++++++
 arch/arm64/kvm/hyp/pgtable.c         | 32 +++++++++++++++++++++
 arch/arm64/kvm/reset.c               | 42 +++-------------------------
 3 files changed, 62 insertions(+), 38 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 7945ec87eaec..9cdc198ea6b4 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -13,6 +13,16 @@
 
 #define KVM_PGTABLE_MAX_LEVELS		4U
 
+static inline u64 kvm_get_parange(u64 mmfr0)
+{
+	u64 parange = cpuid_feature_extract_unsigned_field(mmfr0,
+				ID_AA64MMFR0_PARANGE_SHIFT);
+	if (parange > ID_AA64MMFR0_PARANGE_MAX)
+		parange = ID_AA64MMFR0_PARANGE_MAX;
+
+	return parange;
+}
+
 typedef u64 kvm_pte_t;
 
 /**
@@ -159,6 +169,22 @@ void kvm_pgtable_hyp_destroy(struct kvm_pgtable *pgt);
 int kvm_pgtable_hyp_map(struct kvm_pgtable *pgt, u64 addr, u64 size, u64 phys,
 			enum kvm_pgtable_prot prot);
 
+/**
+ * kvm_get_vtcr() - Helper to construct VTCR_EL2
+ * @mmfr0:	Sanitized value of SYS_ID_AA64MMFR0_EL1 register.
+ * @mmfr1:	Sanitized value of SYS_ID_AA64MMFR1_EL1 register.
+ * @phys_shfit:	Value to set in VTCR_EL2.T0SZ.
+ *
+ * The VTCR value is common across all the physical CPUs on the system.
+ * We use system wide sanitised values to fill in different fields,
+ * except for Hardware Management of Access Flags. HA Flag is set
+ * unconditionally on all CPUs, as it is safe to run with or without
+ * the feature and the bit is RES0 on CPUs that don't support it.
+ *
+ * Return: VTCR_EL2 value
+ */
+u64 kvm_get_vtcr(u64 mmfr0, u64 mmfr1, u32 phys_shift);
+
 /**
  * kvm_pgtable_stage2_init() - Initialise a guest stage-2 page-table.
  * @pgt:	Uninitialised page-table structure to initialise.
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 3d79c8094cdd..296675e5600d 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -9,6 +9,7 @@
 
 #include <linux/bitfield.h>
 #include <asm/kvm_pgtable.h>
+#include <asm/stage2_pgtable.h>
 
 #define KVM_PTE_VALID			BIT(0)
 
@@ -449,6 +450,37 @@ struct stage2_map_data {
 	struct kvm_pgtable_mm_ops	*mm_ops;
 };
 
+u64 kvm_get_vtcr(u64 mmfr0, u64 mmfr1, u32 phys_shift)
+{
+	u64 vtcr = VTCR_EL2_FLAGS;
+	u8 lvls;
+
+	vtcr |= kvm_get_parange(mmfr0) << VTCR_EL2_PS_SHIFT;
+	vtcr |= VTCR_EL2_T0SZ(phys_shift);
+	/*
+	 * Use a minimum 2 level page table to prevent splitting
+	 * host PMD huge pages at stage2.
+	 */
+	lvls = stage2_pgtable_levels(phys_shift);
+	if (lvls < 2)
+		lvls = 2;
+	vtcr |= VTCR_EL2_LVLS_TO_SL0(lvls);
+
+	/*
+	 * Enable the Hardware Access Flag management, unconditionally
+	 * on all CPUs. The features is RES0 on CPUs without the support
+	 * and must be ignored by the CPUs.
+	 */
+	vtcr |= VTCR_EL2_HA;
+
+	/* Set the vmid bits */
+	vtcr |= (get_vmid_bits(mmfr1) == 16) ?
+		VTCR_EL2_VS_16BIT :
+		VTCR_EL2_VS_8BIT;
+
+	return vtcr;
+}
+
 static int stage2_map_set_prot_attr(enum kvm_pgtable_prot prot,
 				    struct stage2_map_data *data)
 {
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 47f3f035f3ea..6aae118c960a 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -332,19 +332,10 @@ int kvm_set_ipa_limit(void)
 	return 0;
 }
 
-/*
- * Configure the VTCR_EL2 for this VM. The VTCR value is common
- * across all the physical CPUs on the system. We use system wide
- * sanitised values to fill in different fields, except for Hardware
- * Management of Access Flags. HA Flag is set unconditionally on
- * all CPUs, as it is safe to run with or without the feature and
- * the bit is RES0 on CPUs that don't support it.
- */
 int kvm_arm_setup_stage2(struct kvm *kvm, unsigned long type)
 {
-	u64 vtcr = VTCR_EL2_FLAGS, mmfr0;
-	u32 parange, phys_shift;
-	u8 lvls;
+	u64 mmfr0, mmfr1;
+	u32 phys_shift;
 
 	if (type & ~KVM_VM_TYPE_ARM_IPA_SIZE_MASK)
 		return -EINVAL;
@@ -359,33 +350,8 @@ int kvm_arm_setup_stage2(struct kvm *kvm, unsigned long type)
 	}
 
 	mmfr0 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
-	parange = cpuid_feature_extract_unsigned_field(mmfr0,
-				ID_AA64MMFR0_PARANGE_SHIFT);
-	if (parange > ID_AA64MMFR0_PARANGE_MAX)
-		parange = ID_AA64MMFR0_PARANGE_MAX;
-	vtcr |= parange << VTCR_EL2_PS_SHIFT;
-
-	vtcr |= VTCR_EL2_T0SZ(phys_shift);
-	/*
-	 * Use a minimum 2 level page table to prevent splitting
-	 * host PMD huge pages at stage2.
-	 */
-	lvls = stage2_pgtable_levels(phys_shift);
-	if (lvls < 2)
-		lvls = 2;
-	vtcr |= VTCR_EL2_LVLS_TO_SL0(lvls);
-
-	/*
-	 * Enable the Hardware Access Flag management, unconditionally
-	 * on all CPUs. The features is RES0 on CPUs without the support
-	 * and must be ignored by the CPUs.
-	 */
-	vtcr |= VTCR_EL2_HA;
+	mmfr1 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR1_EL1);
+	kvm->arch.vtcr = kvm_get_vtcr(mmfr0, mmfr1, phys_shift);
 
-	/* Set the vmid bits */
-	vtcr |= (kvm_get_vmid_bits() == 16) ?
-		VTCR_EL2_VS_16BIT :
-		VTCR_EL2_VS_8BIT;
-	kvm->arch.vtcr = vtcr;
 	return 0;
 }
-- 
2.31.0.rc2.261.g7f71774620-goog

