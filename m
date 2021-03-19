Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B962341956
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhCSKDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhCSKCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:02:31 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB317C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:02:30 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id h21so33658537qkl.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=egb02c7V9fvdN7WOXzwFb5kKzAOfcqS5h587DWzcb1I=;
        b=RHzxQVC7PH0LASuJE6U3fv++yW5YHh8BJCOwMVgSyTDZQFMzMQvrM7TpUSeKOT+Nnu
         TGk4thOV33wh5AfReIMRUKsd8Zca+cuku8eMOaJNPj7xHz7/Z2ejyA8xxkB6JDZ/79ud
         3bOMqu3ibXrt2O4F3R+mUBLNVJjYE5cTuyvaz4DRrwmHLFP7XlK5sKr8YOyEoXdeHzqz
         x1z6IxJ1fINSyUYVdeGIFAsDHC/iZEwNLUGNVxaptnk6ZuTbnBYrARoCi5ZQNZwPMtoK
         a2nLj4yuXlwk4j9G2v3LdE2ri9DYCPkHH2PcMi1YjOZ3JyY7845lgbcbe4Npw/pbIdtW
         0ifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=egb02c7V9fvdN7WOXzwFb5kKzAOfcqS5h587DWzcb1I=;
        b=W+/Oo6EFSsdI2ejyK2FABkKbED3WE/wonMocHNHwkfI1xeREJUaHQEeWSOdsnztCnV
         4iJ1iIFj9APL1+2r8BdDLXpsQzgvzvLAq7y7HjpfDXE7IGN2rsRP5+vP9JkQvJ9g1Hqk
         gFgSepT983A9qYjuISI6I8lWiAsahBilBwTWqfp+RkMEHR7YWqX96goxrSear/pL6Epv
         FvZ3PE34OE86NKjkdmwitrzhQvP3iW+PkMh7pUpsLzsl/KbniLankvjLGdK3YZD9S9+/
         WAoXxlJ0fRl/7YsIJaEaLVk+SGLBPOTj9oabHxN9buifdfI/18xRKscLz5FOxc7izqWV
         aqvQ==
X-Gm-Message-State: AOAM530eEiUW/m9aKTaEemze+GKZqxAbG4GmdrLB3I4LMhKPy0KnofV8
        +PibiaiYwVagLckS7TTk1Czy127c3d6D
X-Google-Smtp-Source: ABdhPJz0+lRse/fC/9bfjvhPpWRqFXSdRhXcvHkUB+NIzOTvxstqkUj+p5UmowzmUqVZALblAELLxYV022ha
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a0c:bd82:: with SMTP id
 n2mr8548505qvg.62.1616148150010; Fri, 19 Mar 2021 03:02:30 -0700 (PDT)
Date:   Fri, 19 Mar 2021 10:01:27 +0000
In-Reply-To: <20210319100146.1149909-1-qperret@google.com>
Message-Id: <20210319100146.1149909-20-qperret@google.com>
Mime-Version: 1.0
References: <20210319100146.1149909-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v6 19/38] KVM: arm64: Use kvm_arch for stage 2 pgtable
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

In order to make use of the stage 2 pgtable code for the host stage 2,
use struct kvm_arch in lieu of struct kvm as the host will have the
former but not the latter.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_pgtable.h | 5 +++--
 arch/arm64/kvm/hyp/pgtable.c         | 6 +++---
 arch/arm64/kvm/mmu.c                 | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index bf7a3cc49420..7945ec87eaec 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -162,12 +162,13 @@ int kvm_pgtable_hyp_map(struct kvm_pgtable *pgt, u64 addr, u64 size, u64 phys,
 /**
  * kvm_pgtable_stage2_init() - Initialise a guest stage-2 page-table.
  * @pgt:	Uninitialised page-table structure to initialise.
- * @kvm:	KVM structure representing the guest virtual machine.
+ * @arch:	Arch-specific KVM structure representing the guest virtual
+ *		machine.
  * @mm_ops:	Memory management callbacks.
  *
  * Return: 0 on success, negative error code on failure.
  */
-int kvm_pgtable_stage2_init(struct kvm_pgtable *pgt, struct kvm *kvm,
+int kvm_pgtable_stage2_init(struct kvm_pgtable *pgt, struct kvm_arch *arch,
 			    struct kvm_pgtable_mm_ops *mm_ops);
 
 /**
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 82aca35a22f6..ea95bbc6ba80 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -880,11 +880,11 @@ int kvm_pgtable_stage2_flush(struct kvm_pgtable *pgt, u64 addr, u64 size)
 	return kvm_pgtable_walk(pgt, addr, size, &walker);
 }
 
-int kvm_pgtable_stage2_init(struct kvm_pgtable *pgt, struct kvm *kvm,
+int kvm_pgtable_stage2_init(struct kvm_pgtable *pgt, struct kvm_arch *arch,
 			    struct kvm_pgtable_mm_ops *mm_ops)
 {
 	size_t pgd_sz;
-	u64 vtcr = kvm->arch.vtcr;
+	u64 vtcr = arch->vtcr;
 	u32 ia_bits = VTCR_EL2_IPA(vtcr);
 	u32 sl0 = FIELD_GET(VTCR_EL2_SL0_MASK, vtcr);
 	u32 start_level = VTCR_EL2_TGRAN_SL0_BASE - sl0;
@@ -897,7 +897,7 @@ int kvm_pgtable_stage2_init(struct kvm_pgtable *pgt, struct kvm *kvm,
 	pgt->ia_bits		= ia_bits;
 	pgt->start_level	= start_level;
 	pgt->mm_ops		= mm_ops;
-	pgt->mmu		= &kvm->arch.mmu;
+	pgt->mmu		= &arch->mmu;
 
 	/* Ensure zeroed PGD pages are visible to the hardware walker */
 	dsb(ishst);
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index de0ad79d2c90..d6eb1fb21232 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -457,7 +457,7 @@ int kvm_init_stage2_mmu(struct kvm *kvm, struct kvm_s2_mmu *mmu)
 	if (!pgt)
 		return -ENOMEM;
 
-	err = kvm_pgtable_stage2_init(pgt, kvm, &kvm_s2_mm_ops);
+	err = kvm_pgtable_stage2_init(pgt, &kvm->arch, &kvm_s2_mm_ops);
 	if (err)
 		goto out_free_pgtable;
 
-- 
2.31.0.rc2.261.g7f71774620-goog

