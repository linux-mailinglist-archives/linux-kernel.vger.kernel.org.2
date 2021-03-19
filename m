Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D7E341959
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhCSKDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbhCSKCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:02:36 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3265C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:02:35 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id c7so12699296wml.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=X4e6yqN5vEM6ig+lsACBvXLz9YG8MQ5drnugDp/WjOE=;
        b=L2PYNSw/ngaYLU3t3NCsL7XXxNbaPgAlx9F44HdhNJBT+GTFmKV7hKSh9FGTtzSkIA
         azkAh+WNGCYNVfyNkBVEeKIC38Lmsz59+IpYIuU8szokpDyixG1hOtPxhgsm1SBJKLRb
         Rl5jG6hhTZ6wWzokHkoww/VzazI8poanIu/ZZJosqAnKz12FMQeZ2URHZ+p91Z2ulknw
         JLtYjzoQOmo0OC6FHy+cQQGBKNh8byKGKTk2ZMBK+9NaO0My43DETWJ6AsCKtYlBO4Ys
         yYEpZ9OMYjKLxRs2HPz2cYUKhKX86+8/xTiV4JL2dOrgSqP/lZCK3Z2MN85d5d8wUrhM
         0rEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=X4e6yqN5vEM6ig+lsACBvXLz9YG8MQ5drnugDp/WjOE=;
        b=S8qO8Nc+IObGqxWzROdozM/y4gnAc9MUsQdGh25IudoiM4MhZttw23Of6G9/swO6pb
         K52ck/c/3N+bIzwnuDww0zclTTSl3zZJ4g+GPYXkSgKUSzos5/cCDxvv23owMpJE/3r+
         QDKxtJuq4H8x3RdxVYedJ4Z093ANuZLSm5nqUIAASKHpNDg4VMfjopomwmIl21Bk4PnK
         OpVvfyjYKKTaj557QyczhEUiGKOviQM6o3Lm8wgfYzwBLWXkL22IYx7ffiTL++5hxCdh
         km9DI5nr16UpMU9d+KghFVEjLDm8yJeS81krNAB/41gauRYwqE5glU12icWsfb8yfHqr
         qpbQ==
X-Gm-Message-State: AOAM5315BBtqUIoNTObmkNZ4xy2tWc+EpKV9awI/3Atd/GoP4Iw0ob0v
        sp7hhjScZq0RkFnLCY9hAxZRh/TzonGh
X-Google-Smtp-Source: ABdhPJxPNWwcgcTByHoYrYF3W80lhBdvd5qLXFmSvuqb4PmhFGrJuyidxS7+Vn/9Koy7nSm7V9FunK8POnT2
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a1c:6243:: with SMTP id
 w64mr1313293wmb.0.1616148154115; Fri, 19 Mar 2021 03:02:34 -0700 (PDT)
Date:   Fri, 19 Mar 2021 10:01:29 +0000
In-Reply-To: <20210319100146.1149909-1-qperret@google.com>
Message-Id: <20210319100146.1149909-22-qperret@google.com>
Mime-Version: 1.0
References: <20210319100146.1149909-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v6 21/38] KVM: arm64: Set host stage 2 using kvm_nvhe_init_params
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
index ebe7007b820b..08f63c09cd11 100644
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
index d93ea0b82491..a6b5ba195ca9 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1418,6 +1418,11 @@ static void cpu_prepare_hyp_mode(int cpu)
 
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
index 557fb79b29cf..60d51515153e 100644
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
index f6d542ecf6a7..99323563022a 100644
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
 
 	cptr = CPTR_EL2_DEFAULT;
 	if (vcpu_has_sve(vcpu) && (vcpu->arch.flags & KVM_ARM64_FP_ENABLED))
-- 
2.31.0.rc2.261.g7f71774620-goog

