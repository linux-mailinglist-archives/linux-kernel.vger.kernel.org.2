Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37BA833BEEA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 15:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbhCOOv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 10:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236542AbhCOOfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 10:35:50 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB00C061764
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:35:50 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id n17so15207681wrq.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CWD0ZTykbS9rpgPcDzjldFEhYHHZjk+W/M1Qg3Ptvcw=;
        b=YH68EwOClBXGIJmeGqCUN2dhjlTkG1F/UlBsPGBdkrfbjGJ/wKGnavp/Cs02ZJyOnA
         i9zS8UvlY5ht/Sq8FBKuH8o7kQzDd9aRtAZB0T6BuYdPfO2/PZ5iLEWx3SDEdYDHSyOh
         dczI07hP20xwCKm4zmlPWwLc2zRwazuu0pxdK0MlOIAasdPOq29Fld+MgcxnMs/WHnHO
         HOSy4YvbCExvOeq9JGAP8qvzGB6+CrW/eN35hN4MDI0unThGS3JFrIFcZiM6TXLYw1F5
         q7IyUQGmMGC0Mo9hAE3MU6bekn5puwnNhVM6fJSQlGmCLzTdiwBtuBi4J5gRMFdsuId4
         wIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CWD0ZTykbS9rpgPcDzjldFEhYHHZjk+W/M1Qg3Ptvcw=;
        b=GiD6ovHYCTb4NLsvb5tuNacXsE4FXWnJP5cYwRLp3lcFoZ7QwGDOsvXc7mgm+RSRGP
         rhiPAtcG0a+b5Y/YoQV99MSp7pUbODGvSrcjqKB+wxvjztZTKLnQZE3aNhk6d6+sAHu5
         w5Gfd7m9dzqmWoZeePgwNomzotlPw7SfyZhUiDXbI9o8UzM41qdiSTdlUpBGj8p7HsWM
         AExIEbQ6vEWg8I73IhK5aZUGHAQdk+RlOZJPrKbpaEmlQ2zDFDYDjcIgyVmqCXFDXGfm
         2zLXx/NkQClKdaSSX6E74ArVjeUln2bQ9dWFko205Di+5+V8kgP5aaCriZZ1Upi/E89E
         6r+g==
X-Gm-Message-State: AOAM531ZrMYknNvr/0Ufy8hDBbh62lDs7lEZoQ/vjwkMIAyBbkok/FWx
        zJSnNVrVxsXvqoEUAe/zOIpyyByelyLo
X-Google-Smtp-Source: ABdhPJxyely57bJXbfq5qywc89TBRX65VoRvNM5+Je7YF6yjHB3oFwlqb826w0urpEOUPJE9/f/45AdrETx6
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a1c:a504:: with SMTP id
 o4mr12766wme.174.1615818948988; Mon, 15 Mar 2021 07:35:48 -0700 (PDT)
Date:   Mon, 15 Mar 2021 14:35:04 +0000
In-Reply-To: <20210315143536.214621-1-qperret@google.com>
Message-Id: <20210315143536.214621-5-qperret@google.com>
Mime-Version: 1.0
References: <20210315143536.214621-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v5 04/36] KVM: arm64: Initialize kvm_nvhe_init_params early
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

Move the initialization of kvm_nvhe_init_params in a dedicated function
that is run early, and only once during KVM init, rather than every time
the KVM vectors are set and reset.

This also opens the opportunity for the hypervisor to change the init
structs during boot, hence simplifying the replacement of host-provided
page-table by the one the hypervisor will create for itself.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/arm.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index fc4c95dd2d26..2d1e7ef69c04 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1383,22 +1383,18 @@ static int kvm_init_vector_slots(void)
 	return 0;
 }
 
-static void cpu_init_hyp_mode(void)
+static void cpu_prepare_hyp_mode(int cpu)
 {
-	struct kvm_nvhe_init_params *params = this_cpu_ptr_nvhe_sym(kvm_init_params);
-	struct arm_smccc_res res;
+	struct kvm_nvhe_init_params *params = per_cpu_ptr_nvhe_sym(kvm_init_params, cpu);
 	unsigned long tcr;
 
-	/* Switch from the HYP stub to our own HYP init vector */
-	__hyp_set_vectors(kvm_get_idmap_vector());
-
 	/*
 	 * Calculate the raw per-cpu offset without a translation from the
 	 * kernel's mapping to the linear mapping, and store it in tpidr_el2
 	 * so that we can use adr_l to access per-cpu variables in EL2.
 	 * Also drop the KASAN tag which gets in the way...
 	 */
-	params->tpidr_el2 = (unsigned long)kasan_reset_tag(this_cpu_ptr_nvhe_sym(__per_cpu_start)) -
+	params->tpidr_el2 = (unsigned long)kasan_reset_tag(per_cpu_ptr_nvhe_sym(__per_cpu_start, cpu)) -
 			    (unsigned long)kvm_ksym_ref(CHOOSE_NVHE_SYM(__per_cpu_start));
 
 	params->mair_el2 = read_sysreg(mair_el1);
@@ -1422,7 +1418,7 @@ static void cpu_init_hyp_mode(void)
 	tcr |= (idmap_t0sz & GENMASK(TCR_TxSZ_WIDTH - 1, 0)) << TCR_T0SZ_OFFSET;
 	params->tcr_el2 = tcr;
 
-	params->stack_hyp_va = kern_hyp_va(__this_cpu_read(kvm_arm_hyp_stack_page) + PAGE_SIZE);
+	params->stack_hyp_va = kern_hyp_va(per_cpu(kvm_arm_hyp_stack_page, cpu) + PAGE_SIZE);
 	params->pgd_pa = kvm_mmu_get_httbr();
 
 	/*
@@ -1430,6 +1426,15 @@ static void cpu_init_hyp_mode(void)
 	 * be read while the MMU is off.
 	 */
 	kvm_flush_dcache_to_poc(params, sizeof(*params));
+}
+
+static void cpu_init_hyp_mode(void)
+{
+	struct kvm_nvhe_init_params *params;
+	struct arm_smccc_res res;
+
+	/* Switch from the HYP stub to our own HYP init vector */
+	__hyp_set_vectors(kvm_get_idmap_vector());
 
 	/*
 	 * Call initialization code, and switch to the full blown HYP code.
@@ -1438,6 +1443,7 @@ static void cpu_init_hyp_mode(void)
 	 * cpus_have_const_cap() wrapper.
 	 */
 	BUG_ON(!system_capabilities_finalized());
+	params = this_cpu_ptr_nvhe_sym(kvm_init_params);
 	arm_smccc_1_1_hvc(KVM_HOST_SMCCC_FUNC(__kvm_hyp_init), virt_to_phys(params), &res);
 	WARN_ON(res.a0 != SMCCC_RET_SUCCESS);
 
@@ -1785,19 +1791,19 @@ static int init_hyp_mode(void)
 		}
 	}
 
-	/*
-	 * Map Hyp percpu pages
-	 */
 	for_each_possible_cpu(cpu) {
 		char *percpu_begin = (char *)kvm_arm_hyp_percpu_base[cpu];
 		char *percpu_end = percpu_begin + nvhe_percpu_size();
 
+		/* Map Hyp percpu pages */
 		err = create_hyp_mappings(percpu_begin, percpu_end, PAGE_HYP);
-
 		if (err) {
 			kvm_err("Cannot map hyp percpu region\n");
 			goto out_err;
 		}
+
+		/* Prepare the CPU initialization parameters */
+		cpu_prepare_hyp_mode(cpu);
 	}
 
 	if (is_protected_kvm_enabled()) {
-- 
2.31.0.rc2.261.g7f71774620-goog

