Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2FC232A866
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346728AbhCBReh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 12:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444522AbhCBPFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:05:22 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F9BC0698C7
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 07:00:50 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id b7so13325356qtj.16
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 07:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Mj/u+lI3QsG0AfvrUV/jHTPuQYjw+9cw0HbYqsdheKs=;
        b=swqPzUzuAnnTJJB2GB+K+3W4L+H7WEAr5B7fKqcoNpqxJCf6ac3/k3HwRvJxFQt76h
         g/Zk7MBBYHULmVjMDun6ZSftD/nPxKajm3eRzVHHZgg7VtMW8jffRUgqxgiuu0RV9dKz
         U5R0fiHsFtkp3OwYT3/hO7iTBdtx64ARXixWDEQO/DS9h42F8AwerJfgyBH0YDYUrHIA
         YsADDv1nhohi+P4YqppfSPPNiJjHxnY7dZt0jyfj8wjNzNROWh6Q6z75geCtykKd36am
         IBn2myIfZHkFpF1JXec2Lgt0mlPOKDhoSFIfuzR677xFTc9x5/SS+eK63zPcfRz2yKqZ
         w+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Mj/u+lI3QsG0AfvrUV/jHTPuQYjw+9cw0HbYqsdheKs=;
        b=R/I02ervU5gAT+T3ZRAs2k/QuGdkvlk7pr8V0vtLSOp47gUWuz6V9HqDABrVGwNXsE
         8P49I8HXxpdIWJuYZ7vACvrCH/Qhb0kNNtN6G/bQj6xP+E/BpKcDTpaIyTXz2OYK7KZU
         Pk2pyjHcLHV7Xb8tdSjJcsjqR/Ujv1qp290wTpCl4n4t0QDahby9K/kBniT2xW9spIHV
         g57JL31/aNqqD3HS+BHddPBkQYbGS7GNGkK0Il+XALfb1gAn0iY/Tk9Hg8riNm9DYROz
         I4BeeyZbLVhhRaqHQX+/Ld4voWM4eyfm7+V8pgfxomkfQbpDBRhxSQYvp281SCiAiqWD
         cimA==
X-Gm-Message-State: AOAM533y5F43zsJfEWdQSRG3Xxo2KPQy4qLmFWgGme+sE//oyFTomj2y
        uEjZn84DbxSGirfAvHye3v+kjh7y3Py4
X-Google-Smtp-Source: ABdhPJzgyoA/MqucA9uvkne0CTz79JaHIGOrbq0Qqc+8hD0/Fm3YGIiA29J7VVM7LEhkUxid/JWZUc7n8Z4m
Sender: "qperret via sendgmr" <qperret@r2d2-qp.c.googlers.com>
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:ad4:4f28:: with SMTP id
 fc8mr17683863qvb.10.1614697249099; Tue, 02 Mar 2021 07:00:49 -0800 (PST)
Date:   Tue,  2 Mar 2021 14:59:49 +0000
In-Reply-To: <20210302150002.3685113-1-qperret@google.com>
Message-Id: <20210302150002.3685113-20-qperret@google.com>
Mime-Version: 1.0
References: <20210302150002.3685113-1-qperret@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v3 19/32] KVM: arm64: Set host stage 2 using kvm_nvhe_init_params
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

Move the registers relevant to host stage 2 enablement to
kvm_nvhe_init_params to prepare the ground for enabling it in later
patches.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_asm.h   |  3 +++
 arch/arm64/kernel/asm-offsets.c    |  3 +++
 arch/arm64/kvm/arm.c               |  5 +++++
 arch/arm64/kvm/hyp/nvhe/hyp-init.S | 14 +++++++++-----
 arch/arm64/kvm/hyp/nvhe/switch.c   |  5 +----
 5 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index db20a9477870..6dce860f8bca 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -158,6 +158,9 @@ struct kvm_nvhe_init_params {
 	unsigned long tpidr_el2;
 	unsigned long stack_hyp_va;
 	phys_addr_t pgd_pa;
+	unsigned long hcr_el2;
+	unsigned long vttbr;
+	unsigned long vtcr;
 };
 
 /* Translate a kernel address @ptr into its equivalent linear mapping */
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index a36e2fc330d4..8930b42f6418 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -120,6 +120,9 @@ int main(void)
   DEFINE(NVHE_INIT_TPIDR_EL2,	offsetof(struct kvm_nvhe_init_params, tpidr_el2));
   DEFINE(NVHE_INIT_STACK_HYP_VA,	offsetof(struct kvm_nvhe_init_params, stack_hyp_va));
   DEFINE(NVHE_INIT_PGD_PA,	offsetof(struct kvm_nvhe_init_params, pgd_pa));
+  DEFINE(NVHE_INIT_HCR_EL2,	offsetof(struct kvm_nvhe_init_params, hcr_el2));
+  DEFINE(NVHE_INIT_VTTBR,	offsetof(struct kvm_nvhe_init_params, vttbr));
+  DEFINE(NVHE_INIT_VTCR,	offsetof(struct kvm_nvhe_init_params, vtcr));
 #endif
 #ifdef CONFIG_CPU_PM
   DEFINE(CPU_CTX_SP,		offsetof(struct cpu_suspend_ctx, sp));
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 5a97abdc3ba6..b6a818f88051 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1413,6 +1413,11 @@ static void cpu_prepare_hyp_mode(int cpu)
 
 	params->stack_hyp_va = kern_hyp_va(per_cpu(kvm_arm_hyp_stack_page, cpu) + PAGE_SIZE);
 	params->pgd_pa = kvm_mmu_get_httbr();
+	if (is_protected_kvm_enabled())
+		params->hcr_el2 = HCR_HOST_NVHE_PROTECTED_FLAGS;
+	else
+		params->hcr_el2 = HCR_HOST_NVHE_FLAGS;
+	params->vttbr = params->vtcr = 0;
 
 	/*
 	 * Flush the init params from the data cache because the struct will
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
index bc56ea92b812..f312672d895e 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
@@ -83,11 +83,6 @@ SYM_CODE_END(__kvm_hyp_init)
  * x0: struct kvm_nvhe_init_params PA
  */
 SYM_CODE_START_LOCAL(___kvm_hyp_init)
-alternative_if ARM64_KVM_PROTECTED_MODE
-	mov_q	x1, HCR_HOST_NVHE_PROTECTED_FLAGS
-	msr	hcr_el2, x1
-alternative_else_nop_endif
-
 	ldr	x1, [x0, #NVHE_INIT_TPIDR_EL2]
 	msr	tpidr_el2, x1
 
@@ -97,6 +92,15 @@ alternative_else_nop_endif
 	ldr	x1, [x0, #NVHE_INIT_MAIR_EL2]
 	msr	mair_el2, x1
 
+	ldr	x1, [x0, #NVHE_INIT_HCR_EL2]
+	msr	hcr_el2, x1
+
+	ldr	x1, [x0, #NVHE_INIT_VTTBR]
+	msr	vttbr_el2, x1
+
+	ldr	x1, [x0, #NVHE_INIT_VTCR]
+	msr	vtcr_el2, x1
+
 	ldr	x1, [x0, #NVHE_INIT_PGD_PA]
 	phys_to_ttbr x2, x1
 alternative_if ARM64_HAS_CNP
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index f3d0e9eca56c..979a76cdf9fb 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -97,10 +97,7 @@ static void __deactivate_traps(struct kvm_vcpu *vcpu)
 	mdcr_el2 |= MDCR_EL2_E2PB_MASK << MDCR_EL2_E2PB_SHIFT;
 
 	write_sysreg(mdcr_el2, mdcr_el2);
-	if (is_protected_kvm_enabled())
-		write_sysreg(HCR_HOST_NVHE_PROTECTED_FLAGS, hcr_el2);
-	else
-		write_sysreg(HCR_HOST_NVHE_FLAGS, hcr_el2);
+	write_sysreg(this_cpu_ptr(&kvm_init_params)->hcr_el2, hcr_el2);
 	write_sysreg(CPTR_EL2_DEFAULT, cptr_el2);
 	write_sysreg(__kvm_hyp_host_vector, vbar_el2);
 }
-- 
2.30.1.766.gb4fecdf3b7-goog

