Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D098033BEF2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 15:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239683AbhCOOv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 10:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbhCOOgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 10:36:48 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B47C061762
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:36:21 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id p15so15045507wre.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=C6KpCcTRnCYarFzZrDiCs6UZvyZciG+7JjV9Q7PoyaI=;
        b=P814LMHE708YU1dGW/jDEo5VsnhvkFROtTZHgzQNY1Dn3LMnbt32+SJl7Wvc11N4up
         KnFYEFSsvsuZb1t/D0wp7r9YQ8NCqrAGclgG+p9d/gHcnIti24WYqZeWVu6fgLaeAhvH
         Yi0jCxJBjK3Ny7DuCEEYRuO/8ioArjzAp1AZVNsiExg4e/8QIcJwp3/gVdT1OLCRMkt/
         BMfe3DsEe1ClC3dVp1Lt8ZquDiLSV2FsBK5cXyaEf56tTD+0BRnlbGDX4Vb2FnA4KpZ5
         nQgq6JwqPh6hD3Dnu0ihNSqkPoHf+/p/BpFdBm/7ka8HllP5cIFThKuX8918YhF2Ezcw
         cDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=C6KpCcTRnCYarFzZrDiCs6UZvyZciG+7JjV9Q7PoyaI=;
        b=Y5xwNXgUY+7GFcMZPH5u7XRNpxKp7lYuenM49QhAMPZNAfEDF3FrJVV4ziFUM/K0V9
         0e81fEqtaTHiMHaOBv48FKYdWIUb0emg12xnGojXpHK+x7omWCqGaUSwnVHSaO81tJtL
         k/9JIL2lkaLop7qVs0lDLTO1jFDWcMn1+uAdxsb926iLTWd0AoWmB1YlbLJGzs88M6i/
         JxnOFm7z65wn+rnjRxYH7NSztFn7VkqSoIBgfqjSuSHZwuYyolizX4pigOyKZXHih2iq
         F5QbBBefox3ee6ckrsz19h+CzVoYMglcdN78WzYVLHHF/GEhaebO2eA8AK+XFcgRKgdX
         0iwA==
X-Gm-Message-State: AOAM530Qg/S/DL5vqKOCziAYxfSVZxr14PlHZBq7Q2PqlG7AZwKosCe0
        M1Sy1558a6xJoLLPVyuxq7W7Lp+pSdKo
X-Google-Smtp-Source: ABdhPJzRBtldTOkH0W/vDm3F+7uze08V/P4VTcnguwv+nWgiCeLo1XU4pLBls5abZRNCUe1W8S9/XRsfRz92
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a1c:9a09:: with SMTP id
 c9mr15248wme.172.1615818979871; Mon, 15 Mar 2021 07:36:19 -0700 (PDT)
Date:   Mon, 15 Mar 2021 14:35:19 +0000
In-Reply-To: <20210315143536.214621-1-qperret@google.com>
Message-Id: <20210315143536.214621-20-qperret@google.com>
Mime-Version: 1.0
References: <20210315143536.214621-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v5 19/36] KVM: arm64: Use kvm_arch for stage 2 pgtable
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
index 7ce0969203e8..3d79c8094cdd 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -879,11 +879,11 @@ int kvm_pgtable_stage2_flush(struct kvm_pgtable *pgt, u64 addr, u64 size)
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
@@ -896,7 +896,7 @@ int kvm_pgtable_stage2_init(struct kvm_pgtable *pgt, struct kvm *kvm,
 	pgt->ia_bits		= ia_bits;
 	pgt->start_level	= start_level;
 	pgt->mm_ops		= mm_ops;
-	pgt->mmu		= &kvm->arch.mmu;
+	pgt->mmu		= &arch->mmu;
 
 	/* Ensure zeroed PGD pages are visible to the hardware walker */
 	dsb(ishst);
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 9d331bf262d2..41f9c03cbcc3 100644
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

