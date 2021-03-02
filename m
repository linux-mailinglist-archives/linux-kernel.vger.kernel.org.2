Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C1E32A831
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579942AbhCBRVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 12:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448551AbhCBPFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:05:40 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B502C0698C8
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 07:00:52 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id m68so1801728qkd.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 07:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ApvDaxD9yFwcIV9MjcPOXencqrrzEHGgE5T6Doqk/4k=;
        b=KCiWLWckSZhRksnbN+vPqoiKRuDDlpJlOZ2KnY4D1ROtlsSCjGjvEnWtF5KX3i5wB9
         D7esZug4LltwGDArJAgy2/yrZU8133mHtcE3lKZJeHKIdqVXk7i+RWlgdOACK+Asazl+
         Fe9tsBQPqxprXWKZiwE9J0q6VIAXPKhXDqCxIb1C9WiDrRwJWUQNLUeHdtXVHvSP3RNg
         ktgl1D8M2Wcp2D9QcID1r3N7NCM7NpWVKiIohxDMHW5DPnlz5BpwioehESslhVGAm8ko
         onl5BIbG4EQQI212mLhZMffJVmesufaK0Su51qyXqUE485Yq1+zOr6hMIxiLETxVjfBT
         y8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ApvDaxD9yFwcIV9MjcPOXencqrrzEHGgE5T6Doqk/4k=;
        b=GVDgJ99uMrZ1BwQzMVB0O9+ODsoWwnrg9EQVXMJW8zvEqopBXJQUJ9+PKccS4AQay6
         OsdWa1AaWIo0dcjGvC4WhSUbiyuntUcs25FdGOJR49Qsbx2ORix8zP7XVzwgRvUShqP6
         lAy6byWyZ47KjTtvxUsFqWgREIKGaN9olBw/UKM9MLanVwuVvqkWOphUiTgOjsxZiQ/R
         ngiYFhSC92BmE9yFngP35bpmOYaxf5nJS2ZOyVljBBAfPFbttV/d+nrJ2/65DDn5N/9C
         SpYa0Q6lqIkPJJVY7dPDTXLJ1CQwl9Jph+h7pYzpJKYH7hm0O8to/UBQTAHTKdpw9BEA
         wsPQ==
X-Gm-Message-State: AOAM533csUNbptKUv4xfrHRHDkyBxqw8PK+DAztARMUr9V4Aum2kc2qe
        M1QKHsvgzg1UV89x/ZR80n4Gxg/Jhcw4
X-Google-Smtp-Source: ABdhPJwb78ZNM9QdASSl2yzPONyu+s67Xr0FkvQfsmdjTmj9GHmOdx/2Jrt01F3tfTfL7Ro1dIeICSZU6baw
Sender: "qperret via sendgmr" <qperret@r2d2-qp.c.googlers.com>
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a0c:f505:: with SMTP id
 j5mr4042437qvm.61.1614697251211; Tue, 02 Mar 2021 07:00:51 -0800 (PST)
Date:   Tue,  2 Mar 2021 14:59:50 +0000
In-Reply-To: <20210302150002.3685113-1-qperret@google.com>
Message-Id: <20210302150002.3685113-21-qperret@google.com>
Mime-Version: 1.0
References: <20210302150002.3685113-1-qperret@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v3 20/32] KVM: arm64: Refactor kvm_arm_setup_stage2()
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

In order to re-use some of the stage 2 setup code at EL2, factor parts
of kvm_arm_setup_stage2() out into separate functions.

No functional change intended.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_pgtable.h | 26 +++++++++++++++++
 arch/arm64/kvm/hyp/pgtable.c         | 32 +++++++++++++++++++++
 arch/arm64/kvm/reset.c               | 42 +++-------------------------
 3 files changed, 62 insertions(+), 38 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index a8255d55c168..21e0985d2e00 100644
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
2.30.1.766.gb4fecdf3b7-goog

