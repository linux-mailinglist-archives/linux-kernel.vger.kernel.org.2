Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3380B32A873
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349897AbhCBRhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 12:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384561AbhCBPFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:05:21 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FF7C0698C5
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 07:00:46 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id x9so7363096wro.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 07:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=G2AeCN7EWhkuYtFbkPhDKNEy1oVSwJAjORcxRM9VGLM=;
        b=Dt0TxCXfs9c8jH2bVodVvIJerD5ufsP7ZFcR78FzQli/GcMwnUQb9f1H+QfiLX46BM
         2Fb6lkOenRdyIPSYRLBFiuqS9jrfJxP3AY2xLec7qqciaO5yu+6Simfe8Mx9bfqQmGqz
         6znfOSv6M9SiQhinpKMc1WKEI0hAgIcSppjPBroVtDfipQDXbG7fAZNBsRLkK7pzwkr6
         C21ukzmfaq6LTMD814VkT42lxaZvxsN5wPoYRFXyus1F/Yi0LAthE+VMNbfcNW2LbVSb
         ms8jbMf49WD8yLYKISSizdbQgNBbKlpR2ugbE8R0HcQnaEk0BBl2KMImZCWPE3WpvvLw
         uUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=G2AeCN7EWhkuYtFbkPhDKNEy1oVSwJAjORcxRM9VGLM=;
        b=F0Kvys7sRlVMTVqxaqO17reaY63PTEgWVvJdLHm7kdJFetix0rEoyWUOPpexs5pPEc
         qV0x1sQoWIPmXgu08N7BZ8Jk9aNF4rb0lZvnINwjicI0S8Gv+UgN9tfSl7ztW/Qxrw8B
         V8L6JQiYaqlfFGeb3eATdmHnxwf7qBz5kBhEoyiZ9iZPcEDdxBRn6mr16Qm956nHJT/r
         t+RzVDp9oZJNKvF770ZWLIvb1UYlX9d6K9s2+tawpI6cWhQ73ew2eFL54vP8oyJ23s5L
         Ijpgssv8WfUT4Lao/8JyJlUubgaaHmjYRf5gRcKw6jnSdd0rMhqolQvRBseJPvuPnWH9
         mhnQ==
X-Gm-Message-State: AOAM5303eAyQcggxh6NerPQLWbBv9EtE9VOoGYOmhJRC34ArXaMSm04i
        A6O1uNud6uufySoBPjuamborClMQ0KNA
X-Google-Smtp-Source: ABdhPJwLj20ogsXve2nNaQuzCTevuLCR5AMDfnsGA+66q9RbQn2Lw/suoS7gkshS8KR9yQywFM1C2SmNTxIY
Sender: "qperret via sendgmr" <qperret@r2d2-qp.c.googlers.com>
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a1c:8041:: with SMTP id
 b62mr4675280wmd.0.1614697244902; Tue, 02 Mar 2021 07:00:44 -0800 (PST)
Date:   Tue,  2 Mar 2021 14:59:47 +0000
In-Reply-To: <20210302150002.3685113-1-qperret@google.com>
Message-Id: <20210302150002.3685113-18-qperret@google.com>
Mime-Version: 1.0
References: <20210302150002.3685113-1-qperret@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v3 17/32] KVM: arm64: Use kvm_arch for stage 2 pgtable
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
index 7898610fbeeb..a8255d55c168 100644
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
2.30.1.766.gb4fecdf3b7-goog

