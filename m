Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBFE334616
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 19:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbhCJR66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbhCJR60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:58:26 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A135AC061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:58:25 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id r18so2972399wmq.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=84bkslXA7Qi7zlX0xHNbjR4XGFTrfSQqHB0l+SkjRTk=;
        b=gWR4E2H56ggbHXScQX04OGikwUKGFnpT1gmE6DUsaiqo17dy/goaVT6bwUgnhoi2Ju
         l6LWaN0AfBgHJvRU3Ntr0R6mbn6chazZBSXWjI/zmceN+GqIiziZZG6WvehBBHjFFiCv
         ff9Sb8VsJ6LT0Kj7avPebY6x8I2r8IJSx0TSinGSZuQBatEs2GvxWIim6kNPaBAilhzc
         6wISeQvXokT2A2HYnczpuZZ3DMpgom1eOj/dEnrcQ2uXdttitkZONhv0pPSGLyhCFNNJ
         2IpQR0s3Uwh8m+aS8s26mFq9vTzaNVZO59IeMkJaiD7fJ0Ial468WcZluMzWA4tW56/3
         EcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=84bkslXA7Qi7zlX0xHNbjR4XGFTrfSQqHB0l+SkjRTk=;
        b=DGP8TjkQjrjTtOBWXIhhwD+8m+faSwjw37JuUyVheOIBN3YJbfd8im3ol436fFFc6i
         4bZOZ/RdsP/9SNFL9lMuFD4XGTATI0BjROoB5q1d6VClhPkq9/ieZ8DFLY0hvff8dzmI
         G5WXw/BTBO9/xNTXDf0bIxHVKZwdlUI/G5EUZyS4jEeNtBP1hIeRdz5U9ezljMCLQDlY
         IWJyIP6b/iuzrJ3OtlPeEUqZs9dsUGcqa/wrYF9whWQ13lqczgj6Twd0sqbCZ3lOdL2P
         9gBqb6MncpwrfQo8o3+pNURoQnjVpNeITynsfqkUGxmWCra+0sBgGBrzQEIYCjlU2/7c
         /n2A==
X-Gm-Message-State: AOAM532H6PC7wK2PLEhYdQ7ekxaUMaBwz7RN43iSJwI5AUskrmEzql7J
        j6n78S35eIDrtyNjDOEcojbBgCKU4yHw
X-Google-Smtp-Source: ABdhPJya6ohuYr2xnAIymmnPbC5dgEguUfV3trhqlVeC84z+zmtstjGngwQdmVgPcn0lHtJOrOlTur1n8Dx9
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a5d:4ec5:: with SMTP id
 s5mr4826061wrv.168.1615399104184; Wed, 10 Mar 2021 09:58:24 -0800 (PST)
Date:   Wed, 10 Mar 2021 17:57:31 +0000
In-Reply-To: <20210310175751.3320106-1-qperret@google.com>
Message-Id: <20210310175751.3320106-15-qperret@google.com>
Mime-Version: 1.0
References: <20210310175751.3320106-1-qperret@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v4 14/34] KVM: arm64: Factor out vector address calculation
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, qperret@google.com, robh+dt@kernel.org,
        ardb@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to re-map the guest vectors at EL2 when pKVM is enabled,
refactor __kvm_vector_slot2idx() and kvm_init_vector_slot() to move all
the address calculation logic in a static inline function.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_mmu.h | 8 ++++++++
 arch/arm64/kvm/arm.c             | 9 +--------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 90873851f677..5c42ec023cc7 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -168,6 +168,14 @@ phys_addr_t kvm_mmu_get_httbr(void);
 phys_addr_t kvm_get_idmap_vector(void);
 int kvm_mmu_init(void);
 
+static inline void *__kvm_vector_slot2addr(void *base,
+					   enum arm64_hyp_spectre_vector slot)
+{
+	int idx = slot - (slot != HYP_VECTOR_DIRECT);
+
+	return base + (idx * SZ_2K);
+}
+
 struct kvm;
 
 #define kvm_flush_dcache_to_poc(a,l)	__flush_dcache_area((a), (l))
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 3f8bcf8db036..26e573cdede3 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1345,16 +1345,9 @@ static unsigned long nvhe_percpu_order(void)
 /* A lookup table holding the hypervisor VA for each vector slot */
 static void *hyp_spectre_vector_selector[BP_HARDEN_EL2_SLOTS];
 
-static int __kvm_vector_slot2idx(enum arm64_hyp_spectre_vector slot)
-{
-	return slot - (slot != HYP_VECTOR_DIRECT);
-}
-
 static void kvm_init_vector_slot(void *base, enum arm64_hyp_spectre_vector slot)
 {
-	int idx = __kvm_vector_slot2idx(slot);
-
-	hyp_spectre_vector_selector[slot] = base + (idx * SZ_2K);
+	hyp_spectre_vector_selector[slot] = __kvm_vector_slot2addr(base, slot);
 }
 
 static int kvm_init_vector_slots(void)
-- 
2.30.1.766.gb4fecdf3b7-goog

