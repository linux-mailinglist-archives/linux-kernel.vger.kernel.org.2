Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC248341958
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhCSKDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbhCSKCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:02:37 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A28C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:02:37 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id z5so3733842qvo.16
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bZ8QVp5ixtjA5tReGxHcoiwTVjDvDK+j6iIQFg05zx0=;
        b=lvH1byc1Cd6HT6bjrY1RJloeQ66Ce2bK1HSCxKPnz/4Mua7KS64Bl9uyzU3ddr1XoP
         GaZl9y7TmUkkNSLz/7auWo2ZSIaNPXJ23FOFjJfT0psquyUoOSqFzVGT9eD8BMJisdAD
         cVo19O3oBSyPn40zUiTo248vEW3tg/HBfSNo/iqcKQJVgJhqcG07w5O0l6Ae+/lN24tp
         4AdzFvv6a6DE6J/JdOqXTpGMLdlHoyv3AX1b1rc8mXUS60QHbnjwN2fu5k+DSAjSk20Q
         d3dGLbZ4xOM4hjKASYjFxl2tFSkd9cuEqA3Hov3+Dc1Yx+a/54xwWc1tfCBI9cbyxVfC
         IReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bZ8QVp5ixtjA5tReGxHcoiwTVjDvDK+j6iIQFg05zx0=;
        b=iAER7DwJ4lEg8vl3uITGTHjPbO+fPNbRXSuSz/JgnQrNWFJCTczXKYwg6Q7LSi4FrG
         TI46+Ui5qqlnjr9vkcaifY7kHtneqBUrx3u/ivngv1ybxuttX9gl7y2RSsGxtMTIupgZ
         RzB380EhQD/+HoRoaZ29hJsItZIFFTVc34q2VWJH2GyV0LIBTZxO3givo0/0mPdmzguQ
         n8/thegV3Apm7RHOYSgmuYPK9aAsukmiSANIv9FJ5Vub8ckJOsP+DRj8LWn8V4eLMoQm
         6YMCOzQCgJVnG4JYF1aN3aUIFg7psCCW3egwGtoHAmYsICKOZvrOLrT5FL4qiwrvXIKN
         ZHrA==
X-Gm-Message-State: AOAM531/wTirRhLgzS/KJvAOm1XocKCLEs88GtF3iUlXly1GdvHZk+ZA
        Yp6BWi/skz9eUSf6oUlKmJIzaHkoG1jE
X-Google-Smtp-Source: ABdhPJxLn9zT9mjGydiPBirLozDSkVbHuYdWhbsPXf1djuQ4+LIawp9F1rOQObWn6dBB22fGbk4ch6tL9Mlu
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a05:6214:248f:: with SMTP id
 gi15mr8582389qvb.3.1616148156306; Fri, 19 Mar 2021 03:02:36 -0700 (PDT)
Date:   Fri, 19 Mar 2021 10:01:30 +0000
In-Reply-To: <20210319100146.1149909-1-qperret@google.com>
Message-Id: <20210319100146.1149909-23-qperret@google.com>
Mime-Version: 1.0
References: <20210319100146.1149909-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v6 22/38] KVM: arm64: Refactor kvm_arm_setup_stage2()
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
index ea95bbc6ba80..4e15ccafd640 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -9,6 +9,7 @@
 
 #include <linux/bitfield.h>
 #include <asm/kvm_pgtable.h>
+#include <asm/stage2_pgtable.h>
 
 #define KVM_PTE_VALID			BIT(0)
 
@@ -450,6 +451,37 @@ struct stage2_map_data {
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
index 67f30953d6d0..86d94f616a1e 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -329,19 +329,10 @@ int kvm_set_ipa_limit(void)
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
@@ -361,33 +352,8 @@ int kvm_arm_setup_stage2(struct kvm *kvm, unsigned long type)
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

