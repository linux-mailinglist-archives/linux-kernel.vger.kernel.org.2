Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9068433461E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 19:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbhCJR7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbhCJR6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:58:39 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9E1C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:58:38 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id y5so8318571wrp.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ukntJyqlY8URVrIATiFSUwM/7ndF4QPoRdbFD1D8cLg=;
        b=lDk0OHk/md/iMsmkAy5iConC2JErXeKcb17H5xQgrPoesMToSTbLM6aPWft+KddUDv
         xRHMLfzHCwXB02tqj2157yByCFQq6A9y3T4I41Q3Blpg3fBKOx3HaKymOpG/gAIsJi/K
         iCY7fu7KiB8H1v+pMNSvapgYjEXAkH67GLVwTq1pMBR1BOSROfw0SkCSoPtGnYtn5HNI
         JJVW//6uDYJwmlyVR8IReX82QnF5sXJ4Nkr7eNLYnv5XgTw7Uv+t+fbEhByMYyWIfgzc
         pUhXvPwLK5BSrgo17ecInjt6ijW1YaBAxL7Bdx2E/dleEuzvha1lQ1eYzLTtGlxDHV1H
         2pig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ukntJyqlY8URVrIATiFSUwM/7ndF4QPoRdbFD1D8cLg=;
        b=ofdoaF5p1MXpges63IVQuVK/m+j3nS9DCYOdlL8JrTRDk82nDHbmD1ok+xaQwUPZs+
         0iFNL1Lqdu6lc+1E7/w5X2E4jSxsYExqX1WZUqt+34XO/c7A3LdBohtQJ777UgZaj1b/
         tO6zf7xSVKm1x+8VX+zhq6C0/K/eKD0yjBV17D7F1OkVuOgs1+r0vT0i7WBQtWSFW0bu
         m3ghYU0aDWxYo45NNZMFs21ZRS6iKCeOsqdCAj8w24bt/9QLUNm7TRKJ1Mf6YmnHxCYS
         p/gNf+hSU4a9Q3FAez+TLmNwPvU0rQ2rS989Xdana9PD58AaF7TChklkc8XrwayZ2Tvx
         yWQg==
X-Gm-Message-State: AOAM532F24cs8I6ZmgwpSRTthanO08IRZ6CTGd6qORCPRcqC89DK4TPo
        HdQGVi3lBMFDU47jf7JTDwOw+1EeeEGc
X-Google-Smtp-Source: ABdhPJwb2As/znXn4RytVDQMc+kTRchy4s+1YPQC255pRPsVjgsDHstfFQUtsKt7jJ+dLTWNx3JlUPzmMAjj
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a1c:3c8b:: with SMTP id
 j133mr4505584wma.164.1615399117543; Wed, 10 Mar 2021 09:58:37 -0800 (PST)
Date:   Wed, 10 Mar 2021 17:57:37 +0000
In-Reply-To: <20210310175751.3320106-1-qperret@google.com>
Message-Id: <20210310175751.3320106-21-qperret@google.com>
Mime-Version: 1.0
References: <20210310175751.3320106-1-qperret@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v4 20/34] KVM: arm64: Set host stage 2 using kvm_nvhe_init_params
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
index 7d62211109d9..d474eec606a3 100644
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
index a2b8b6a84cbd..a50ad9e9fc05 100644
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

